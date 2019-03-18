package eu.openreq.qt.qthulhu.data;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.util.HashMap;
import java.util.HashSet;

import static eu.openreq.qt.qthulhu.data.HelperFunctions.calculateUniqueID;
import static eu.openreq.qt.qthulhu.data.HelperFunctions.cleanText;

/**
 * this class uses the JSON output of uhservices to construct a set of nodes and edges
 * that are suitable for the front-end
 */

//TODO: refactor everything
//TODO: find out which nodes are "new/proposed" via the similarity detection

public class NodeEdgeSet
{
    //there is no layer 0 in the JSON which would be the issues that were searched for
    private static HashMap<String, Integer> _layer;
    //contains all the pairs of issue key and unique int id
    private static HashMap<String, Long> _idSet;

    //builds and returns the node and edge set of one or multiple issues
    public static JsonObject buildNodeEdgeSet(JsonArray issueData, String[] issueArray)
    {
        System.out.println(issueData);
        _layer = new HashMap<>();
        _idSet = new HashMap<>();

        //create a layer 0
        for (String issueID : issueArray)
        {
            _layer.put(issueID, 0);
        }
        buildLayers(issueData);

        //build the node and edge Set
        HashMap<String, JsonObject> nodeSet = buildNodes(issueData);
        HashSet<JsonObject> edgeSet = buildEdges(issueData);
        JsonObject nodeEdgeSet = new JsonObject();

        //TODO: There must be a more elegant solution
        //transforming the data from hashset / hashmap to a JSON array
        JsonArray nodes = new JsonArray();
        for (JsonObject node : nodeSet.values())
        {
            nodes.add(node);
        }

        JsonArray edges = new JsonArray();
        for (JsonObject edge : edgeSet)
        {
            edges.add(edge);
        }

        nodeEdgeSet.add("nodes", nodes);
        nodeEdgeSet.add("edges", edges);

        int maxLayer = getMaxLayer();
        nodeEdgeSet.addProperty("max_layer", maxLayer);

        return nodeEdgeSet;
    }

    /**
     * find the maximum layer given a issue link network, cannot be higher than 5
     *
     * @return maximum layer
     */
    private static int getMaxLayer()
    {
        //if there is no network the layer is 0
        int maxLayer = 0;
        for (String key : _layer.keySet())
        {
            if (_layer.get(key) > maxLayer)
            {
                maxLayer = _layer.get(key);
            }
        }
        return maxLayer;
    }

    /**
     * This method builds a correct layer set which contains all the information which issue is in which layer
     * Particularly important if the user enters an array of issues.
     */
    private static void buildLayers(JsonArray issueData)
    {
        for (int i = 0; i < issueData.size(); i++)
        {
            //user layer information to create _layers because there can be multiple issues
            JsonObject dataJSON = issueData.get(i).getAsJsonObject();
            JsonObject layers = dataJSON.getAsJsonObject("layers");
            //to access a specific layer in the JSON
            String currDepth = "1";
            //add _layer information to node issue JSONs
            while (layers.has(currDepth))
            {
                JsonArray currLayer = layers.getAsJsonArray(currDepth);
                int currDepthInt = Integer.parseInt(currDepth);
                for (int k = 0; k < currLayer.size(); k++)
                {
                    String key = currLayer.get(k).getAsString();

                    if (!_layer.containsKey(key))
                    {
                        _layer.put(key, currDepthInt);
                    }
                    //if there is a shorter way connecting issues in the issue link network
                    else if (_layer.containsKey(key) && _layer.get(key) > currDepthInt)
                    {
                        _layer.put(key, currDepthInt);
                    }
                }
                currDepth = Integer.toString(++currDepthInt);
            }
        }
    }

    /**
     * This builds the node set that contains only unique items
     *
     * @param issueData the unprocessed data
     * @return the nodeset with unique items
     */
    private static HashMap<String, JsonObject> buildNodes(JsonArray issueData)
    {
        //since we do not have unique integer ids which we need for vis.js,
        //we map issue keys to generated unique integers
        HashMap<String, JsonObject> nodeSet = new HashMap<>();

        //go through all issues the user searched for
        for (int i = 0; i < issueData.size(); i++)
        {
            JsonObject dataJSON = issueData.get(i).getAsJsonObject();
            //get the requirements which are our nodes
            JsonArray reqs = dataJSON.getAsJsonArray("requirements");
            //go through all requirements and add nodes to the hasmap
            for (int j = 0; j < reqs.size(); j++)
            {
                JsonObject currentReq = reqs.get(j).getAsJsonObject();

                //get a unique integer id for vis.js
                String key = currentReq.get("id").getAsString();
                if(!key.contains("mock"))
                {
                    long nodeId = calculateUniqueID(key);

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
                    currentReq.addProperty("layer", _layer.get(key));

                    //get additional information like status, etc
                    JsonArray parts = currentReq.getAsJsonArray("requirementParts");

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

                    _idSet.put(key, nodeId);
                    nodeSet.put(key, currentReq);
                }
            }
        }
        return nodeSet;
    }

    /**
     * This class transforms the dependencies in a vis.js friendly edge dataset
     *
     * @param issueData all the information
     * @return a set of unique edges with information necessary for vis.js
     */
    //TODO: Does it make sense to give edges unique ids to prevent multiple edges between two nodes?
    private static HashSet<JsonObject> buildEdges(JsonArray issueData)
    {
        HashSet<JsonObject> edgeSet = new HashSet<>();

        //go through all issues that the user searched for
        for (int i = 0; i < issueData.size(); i++)
        {
            JsonObject dataJSON = issueData.get(i).getAsJsonObject();
            //get the dependencies
            JsonArray deps = dataJSON.getAsJsonArray("dependencies");
            //go through all dependencies and add edge to hashset
            for (int j = 0; j < deps.size(); j++)
            {
                JsonObject currentDep = deps.get(j).getAsJsonObject();
                String fromKey = currentDep.get("fromid").getAsString();
                String toKey = currentDep.get("toid").getAsString();
                if(!fromKey.contains("mock") && !toKey.contains("mock"))
                {
                    currentDep.addProperty("node_fromid", _idSet.get(fromKey));
                    currentDep.addProperty("node_toid", _idSet.get(toKey));
                    edgeSet.add(currentDep);
                }
            }
        }
        return edgeSet;
    }

}