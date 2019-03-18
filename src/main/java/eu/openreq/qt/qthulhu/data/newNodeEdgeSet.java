package eu.openreq.qt.qthulhu.data;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.util.HashMap;

import static eu.openreq.qt.qthulhu.data.HelperFunctions.calculateUniqueID;
import static eu.openreq.qt.qthulhu.data.HelperFunctions.cleanText;

public class newNodeEdgeSet
{
    //there is no layer 0 in the JSON which would be the issues that were searched for
    private static HashMap<String, Integer> _layer;
    //contains all the pairs of issue key and unique int id
    private static HashMap<String, Long> _idSet;

    //builds and returns the node and edge set of one or multiple issues
    public static JsonObject buildNodeEdgeSet(JsonObject issueData)
    {
        _layer = new HashMap<String, Integer>();
        _idSet = new HashMap<String, Long>();
        int maxLayer = 0;

        JsonObject layers = issueData.getAsJsonObject("layers");
        for (int i = 0; i < 6; i++)
        {
            if (!(layers.get(Integer.toString(i)) == null))
            {
                JsonArray currentLayer = layers.get(Integer.toString(i)).getAsJsonArray();
                //System.out.println(currentLayer);
                for (int j = 0; j < currentLayer.size(); j++)
                {
                    String key = currentLayer.get(j).getAsString();
                    long nodeId = calculateUniqueID(key);

                    _idSet.put(key, nodeId);
                    _layer.put(key, i);
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
            depth.add("nodes", new JsonArray());
            depth.add("edges", new JsonArray());
            String idName = Integer.toString(i);
            depthNodeEdgeSet.add(idName, depth);
        }
        depthNodeEdgeSet.add("nodes", new JsonArray());
        depthNodeEdgeSet = buildNodes(reqs, depthNodeEdgeSet);
        depthNodeEdgeSet = buildEdges(deps, depthNodeEdgeSet);

        return depthNodeEdgeSet;
    }

    private static JsonObject buildNodes(JsonArray reqs, JsonObject depthNodeEdgeSet)
    {
        for (int i = 0; i < reqs.size(); i++)
        {
            JsonObject currentReq = reqs.get(i).getAsJsonObject();
            String reqKey = currentReq.get("id").getAsString();
            int reqLayer = _layer.get(reqKey);
            if (!reqKey.contains("mock"))
            {
                long nodeId = calculateUniqueID(reqKey);

                currentReq.addProperty("nodeid", nodeId);

                //get title of issue if it has one
                String nameCleaned = "no name";
                if (currentReq.has("name"))
                {
                    JsonElement name = currentReq.get("name");

                    nameCleaned = cleanText(name);

                    currentReq.remove("name");
                }
                currentReq.addProperty("name", nameCleaned);

                //add layer information to issue data
                currentReq.addProperty("depth", reqLayer);

                //get additional information like status, etc
                JsonArray parts = currentReq.getAsJsonArray("requirementParts");

                if (parts.size() == 0)
                {
                    JsonObject resolution = new JsonObject();
                    resolution.addProperty("name", "Resolution");
                    resolution.addProperty("text", "unknown");
                    JsonObject platforms = new JsonObject();
                    platforms.addProperty("name", "Platforms");
                    platforms.addProperty("text", "unknown");
                    JsonObject versions = new JsonObject();
                    versions.addProperty("name", "Versions");
                    versions.addProperty("text", "unknown");
                    JsonObject labels = new JsonObject();
                    labels.addProperty("name", "Labels");
                    labels.addProperty("text", "unknown");
                    JsonObject environment = new JsonObject();
                    environment.addProperty("name", "Environment");
                    environment.addProperty("text", "unknown");
                    JsonObject status = new JsonObject();
                    status.addProperty("name", "Status");
                    status.addProperty("text", "unknown");
                    JsonObject fixVersion = new JsonObject();
                    fixVersion.addProperty("name", "FixVersion");
                    fixVersion.addProperty("text", "unknown");
                    JsonObject components = new JsonObject();
                    components.addProperty("name", "Components");
                    components.addProperty("text", "unknown");
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
                currentReq.remove("requirementParts");

                JsonObject depth = depthNodeEdgeSet.get(Integer.toString(reqLayer)).getAsJsonObject();
                JsonArray depthNodes = depth.getAsJsonArray("nodes");
                depthNodes.add(currentReq);

                JsonArray nodes = depthNodeEdgeSet.getAsJsonArray("nodes");
                nodes.add(currentReq);
            }
        }
        return depthNodeEdgeSet;
    }

    private static JsonObject buildEdges(JsonArray deps, JsonObject depthNodeEdgeSet)
    {
        for(int i = 0; i < deps.size(); i++)
        {
            JsonObject currentDep = deps.get(i).getAsJsonObject();
            String fromKey =currentDep.get("fromid").getAsString();
            String toKey = currentDep.get("toid").getAsString();

            int fromLayer = _layer.get(fromKey);
            int toLayer = _layer.get(toKey);

            int depLayer = Math.max(fromLayer, toLayer);

            JsonObject depth = depthNodeEdgeSet.get(Integer.toString(depLayer)).getAsJsonObject();
            JsonArray depthEdges = depth.getAsJsonArray("edges");

            if(!fromKey.contains("mock") && !toKey.contains("mock"))
            {
                currentDep.addProperty("node_fromid", _idSet.get(fromKey));
                currentDep.addProperty("node_toid", _idSet.get(toKey));
                currentDep.addProperty("depth", depLayer);
                depthEdges.add(currentDep);
            }
        }
        return depthNodeEdgeSet;
    }
}
