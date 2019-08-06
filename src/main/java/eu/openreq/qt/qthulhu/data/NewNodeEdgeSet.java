package eu.openreq.qt.qthulhu.data;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.util.HashMap;

import static eu.openreq.qt.qthulhu.data.HelperFunctions.calculateUniqueID;
import static eu.openreq.qt.qthulhu.data.HelperFunctions.cleanText;

public class NewNodeEdgeSet
{
    //there is no layer 0 in the JSON which would be the issues that were searched for
    private static HashMap<String, Integer> layerMap;
    //contains all the pairs of issue key and unique int id
    private static HashMap<String, Long> idMap;
    //Sonarqube complain...
    private static String nodesAsString = "nodes";

    // Constructor due to Sonarqube complains
    private NewNodeEdgeSet() {

    }
    //builds and returns the node and edge set of one or multiple issues
    public static JsonObject buildNodeEdgeSet(JsonObject issueData)
    {
        layerMap = new HashMap<>();
        idMap = new HashMap<>();
        int maxLayer = 0;

        JsonObject layers = issueData.getAsJsonObject("layers");
        for (int i = 0; i < 6; i++)
        {
            if ((layers.get(Integer.toString(i)) != null))
            {
                JsonArray currentLayer = layers.get(Integer.toString(i)).getAsJsonArray();
                for (int j = 0; j < currentLayer.size(); j++)
                {
                    String key = currentLayer.get(j).getAsString();
                    long nodeId = calculateUniqueID(key);

                    idMap.put(key, nodeId);
                    layerMap.put(key, i);
                }
                maxLayer = i;
            }
        }

        JsonArray reqs = issueData.getAsJsonArray("requirements");
        JsonArray deps = issueData.getAsJsonArray("dependencies");
        JsonObject depthNodeEdgeSet = buildDepthNodeEdgeSet(reqs, deps);
        depthNodeEdgeSet.addProperty("max_depth", maxLayer);

        return depthNodeEdgeSet;
    }

    private static JsonObject buildDepthNodeEdgeSet(JsonArray reqs, JsonArray deps)
    {
        JsonObject depthNodeEdgeSet = new JsonObject();
        for (int i = 0; i < 6; i++)
        {
            JsonObject depth = new JsonObject();
            depth.add(nodesAsString, new JsonArray());
            depth.add("edges", new JsonArray());
            String idName = Integer.toString(i);
            depthNodeEdgeSet.add(idName, depth);
        }
        depthNodeEdgeSet.add(nodesAsString, new JsonArray());
        depthNodeEdgeSet = buildNodes(reqs, depthNodeEdgeSet);
        depthNodeEdgeSet = buildEdges(deps, depthNodeEdgeSet);

        return depthNodeEdgeSet;
    }

    private static JsonObject buildNodes(JsonArray reqs, JsonObject depthNodeEdgeSet)
    {
        String placeholder;
        //for Sonarqube...
        String reqString = "requirementParts";
        for (int i = 0; i < reqs.size(); i++)
        {
            JsonObject currentReq = reqs.get(i).getAsJsonObject();
            String reqKey = currentReq.get("id").getAsString();
            int reqLayer = layerMap.get(reqKey);

            long nodeId = calculateUniqueID(reqKey);
            currentReq.addProperty("nodeid", nodeId);

            String nameCleaned;
            if (currentReq.has("name") && !reqKey.contains("mock"))
            {
                //get title of issue if it has one
                JsonElement name = currentReq.get("name");
                nameCleaned = cleanText(name);
                currentReq.remove("name");
                placeholder = "unknown";
            }
            else
            {
                currentReq.add(reqString, new JsonArray());
                if (reqKey.contains("mock")) //mocks are placeholder and not real issues
                {
                    placeholder = nameCleaned = "not in DB";
                }
                else // no name - means it's a private issue
                {
                    placeholder = nameCleaned = "confidential";
                }
            }
            // add the correct name to the requirement
            currentReq.addProperty("name", nameCleaned);

            //add layer information to issue data
            currentReq.addProperty("depth", reqLayer);

            //get additional information like status, etc
            JsonArray parts = currentReq.getAsJsonArray(reqString);

            if (parts.size() == 0)
            {
                parts = fillParts(parts, placeholder);
            }
            for (int k = 0; k < parts.size(); k++)
            {
                JsonObject part = parts.get(k).getAsJsonObject();
                JsonElement name = part.get("name");
                String nameAsString = name.getAsString().toLowerCase();
                JsonElement text = part.get("text");
                String textCleaned = cleanText(text);
                currentReq.addProperty(nameAsString, textCleaned);
            }
            currentReq.remove(reqString);

            JsonObject depth = depthNodeEdgeSet.get(Integer.toString(reqLayer)).getAsJsonObject();
            JsonArray depthNodes = depth.getAsJsonArray(nodesAsString);
            depthNodes.add(currentReq);

            JsonArray nodes = depthNodeEdgeSet.getAsJsonArray(nodesAsString);
            nodes.add(currentReq);
        }
        return depthNodeEdgeSet;
    }

    private static JsonObject buildEdges(JsonArray deps, JsonObject depthNodeEdgeSet)
    {
        for (int i = 0; i < deps.size(); i++)
        {
            JsonObject currentDep = deps.get(i).getAsJsonObject();
            String fromKey = currentDep.get("fromid").getAsString();
            String toKey = currentDep.get("toid").getAsString();

            if (layerMap.containsKey(fromKey) && layerMap.containsKey(toKey))
            {
                int fromLayer = layerMap.get(fromKey);
                int toLayer = layerMap.get(toKey);
                int depLayer = Math.max(fromLayer, toLayer);

                JsonObject depth = depthNodeEdgeSet.get(Integer.toString(depLayer)).getAsJsonObject();
                JsonArray depthEdges = depth.getAsJsonArray("edges");


                    currentDep.addProperty("node_fromid", idMap.get(fromKey));
                    currentDep.addProperty("node_toid", idMap.get(toKey));
                    currentDep.addProperty("depth", depLayer);
                    depthEdges.add(currentDep);

            }
        }
        return depthNodeEdgeSet;
    }

    private static JsonArray fillParts(JsonArray parts, String fillPlaceholder)
    {
        JsonObject resolution = new JsonObject();
        resolution.addProperty("name", "Resolution");
        resolution.addProperty("text", fillPlaceholder);
        parts.add(resolution);
        JsonObject platforms = new JsonObject();
        platforms.addProperty("name", "Platforms");
        platforms.addProperty("text", fillPlaceholder);
        parts.add(platforms);
        JsonObject versions = new JsonObject();
        versions.addProperty("name", "Versions");
        versions.addProperty("text", fillPlaceholder);
        parts.add(versions);
        JsonObject labels = new JsonObject();
        labels.addProperty("name", "Labels");
        labels.addProperty("text", fillPlaceholder);
        parts.add(labels);
        JsonObject environment = new JsonObject();
        environment.addProperty("name", "Environment");
        environment.addProperty("text", fillPlaceholder);
        parts.add(environment);
        JsonObject status = new JsonObject();
        status.addProperty("name", "Status");
        status.addProperty("text", fillPlaceholder);
        parts.add(status);
        JsonObject fixVersion = new JsonObject();
        fixVersion.addProperty("name", "FixVersion");
        fixVersion.addProperty("text", fillPlaceholder);
        parts.add(fixVersion);
        JsonObject components = new JsonObject();
        components.addProperty("name", "Components");
        components.addProperty("text", fillPlaceholder);
        parts.add(components);

        return parts;
    }

}
