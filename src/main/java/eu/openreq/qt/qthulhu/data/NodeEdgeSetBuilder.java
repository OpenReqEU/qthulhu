package eu.openreq.qt.qthulhu.data;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.util.HashMap;

import static eu.openreq.qt.qthulhu.data.HelperFunctions.calculateUniqueID;
import static eu.openreq.qt.qthulhu.data.HelperFunctions.cleanText;

public class NodeEdgeSetBuilder
{
    //there is no layer 0 in the JSON which would be the issues that were searched for
    private static HashMap<String, Integer> layerMap;
    //contains all the pairs of issue key and unique int id
    private static HashMap<String, Long> idMap;

    // Constructor due to Sonarqube complains
    private NodeEdgeSetBuilder() {

    }
    //builds and returns the node and edge set of one or multiple issues
    public static JsonObject buildNodeEdgeSet(JsonObject issueData, String issue, boolean isProposed)
    {
        layerMap = new HashMap<>();
        idMap = new HashMap<>();
        int maxLayer = 0;

        //iterates through all requirements if this is a proposed set
        JsonArray reqs = issueData.getAsJsonArray("requirements");
        if (isProposed)
        {
            for (int i = 0; i < reqs.size(); i++)
            {
                JsonObject currentReq = reqs.get(i).getAsJsonObject();
                String key = currentReq.get("id").getAsString();
                long nodeId = calculateUniqueID(key);

                idMap.put(key, nodeId);
            }
        }
        // iterates through layers if this is not a proposed set
        else
        {
            JsonObject layers = issueData.getAsJsonObject("layers");
            for (int i = 0; i < 6; i++)
            {
                if (layers.get(Integer.toString(i)) != null)
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
        }
        JsonArray deps = issueData.getAsJsonArray("dependencies");
        JsonObject depthNodeEdgeSet = buildDepthNodeEdgeSet(reqs, deps, isProposed);
        depthNodeEdgeSet.addProperty("max_depth", maxLayer);

        //if this is a proposed set the "core" issue itself should not be proposed
        if (isProposed)
        {
            JsonArray proposedReqs = depthNodeEdgeSet.getAsJsonArray("nodes");
            for (int i = 0; i < proposedReqs.size(); i++)
            {
                JsonObject currentNode = proposedReqs.get(i).getAsJsonObject();
                if (currentNode.get("id").getAsString().equals(issue))
                {
                    proposedReqs.remove(i);
                }
            }
        }
        return depthNodeEdgeSet;
    }

    static JsonObject buildDepthNodeEdgeSet(JsonArray reqs, JsonArray deps, boolean isProposed)
    {
        JsonObject depthNodeEdgeSet = new JsonObject();

        if (isProposed) {
            depthNodeEdgeSet.add("edges", new JsonArray());
        }
        else
        {
            for (int i = 0; (i < 6) && !isProposed; i++)
            {
                JsonObject depth = new JsonObject();
                depth.add("nodes", new JsonArray());
                depth.add("edges", new JsonArray());
                String idName = Integer.toString(i);
                depthNodeEdgeSet.add(idName, depth);
            }
        }
        depthNodeEdgeSet.add("nodes", new JsonArray());
        depthNodeEdgeSet = buildNodes(reqs, depthNodeEdgeSet, isProposed);
        depthNodeEdgeSet = buildEdges(deps, depthNodeEdgeSet, isProposed);

        return depthNodeEdgeSet;
    }

    private static JsonObject buildNodes(JsonArray reqs, JsonObject depthNodeEdgeSet, boolean isProposed)
    {
        String placeholder;
        int reqLayer;
        //must be initialized with something
        JsonArray depthNodes = null;
        for (int i = 0; i < reqs.size(); i++)
        {
            JsonObject currentReq = reqs.get(i).getAsJsonObject();
            String reqKey = currentReq.get("id").getAsString();
            long nodeId = calculateUniqueID(reqKey);
            currentReq.addProperty("nodeid", nodeId);

            //add layer information to issue data if it is not a proposed set
            if (!isProposed) {
                reqLayer = layerMap.get(reqKey);
                currentReq.addProperty("depth", reqLayer);

                JsonObject depth = depthNodeEdgeSet.get(Integer.toString(reqLayer)).getAsJsonObject();
                depthNodes = depth.getAsJsonArray("nodes");
            }

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
                currentReq.add("requirementParts", new JsonArray());
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

            //get additional information like status, etc
            JsonArray parts = currentReq.getAsJsonArray("requirementParts");

            if (parts.size() == 0)
            {
                parts = HelperFunctions.fillParts(parts, placeholder);
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

            if (!isProposed) {
                depthNodes.add(currentReq);
            }

            JsonArray nodes = depthNodeEdgeSet.getAsJsonArray("nodes");
            nodes.add(currentReq);
        }
        return depthNodeEdgeSet;
    }

    private static JsonObject buildEdges(JsonArray deps, JsonObject depthNodeEdgeSet, boolean isProposed)
    {
        for (int i = 0; i < deps.size(); i++)
        {
            JsonObject currentDep = deps.get(i).getAsJsonObject();
            String fromKey = currentDep.get("fromid").getAsString();
            String toKey = currentDep.get("toid").getAsString();

            if (!isProposed && layerMap.containsKey(fromKey) && layerMap.containsKey(toKey))
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
            else if (isProposed && !fromKey.contains("mock") && !toKey.contains("mock"))
            {
                JsonArray edges = depthNodeEdgeSet.getAsJsonArray("edges");
                currentDep.addProperty("node_fromid", idMap.get(fromKey));
                currentDep.addProperty("node_toid", idMap.get(toKey));
                edges.add(currentDep);
            }
        }
        return depthNodeEdgeSet;
    }

}
