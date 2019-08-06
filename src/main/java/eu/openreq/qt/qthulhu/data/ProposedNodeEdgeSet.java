package eu.openreq.qt.qthulhu.data;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.util.HashMap;

import static eu.openreq.qt.qthulhu.data.HelperFunctions.calculateUniqueID;
import static eu.openreq.qt.qthulhu.data.HelperFunctions.cleanText;

public class ProposedNodeEdgeSet
{
    //contains all the pairs of issue key and unique int id
    private static HashMap<String, Long> idSet;

    //Sonarqube...
    private final static String nodesAsString = "nodes";
    //Constructor due to Sonarqube complains
    private ProposedNodeEdgeSet() {

    }
    //builds and returns the node and edge set of one or multiple issues
    public static JsonObject buildNodeEdgeSet(JsonObject issueData, String issue)
    {
        idSet = new HashMap<>();

        JsonArray reqs = issueData.getAsJsonArray("requirements");
        for (int i = 0; i < reqs.size(); i++)
        {
            JsonObject currentReq = reqs.get(i).getAsJsonObject();
            String key = currentReq.get("id").getAsString();
            long nodeId = calculateUniqueID(key);

            idSet.put(key, nodeId);
        }

        JsonArray deps = issueData.getAsJsonArray("dependencies");
        JsonObject proposedNodeEdgeSet = buildProposedNodeEdgeSet(reqs, deps);
        JsonArray proposedReqs = proposedNodeEdgeSet.getAsJsonArray(nodesAsString);
        for (int i = 0; i < proposedReqs.size(); i++)
        {
            JsonObject currentNode = proposedReqs.get(i).getAsJsonObject();
            if (currentNode.get("id").getAsString().equals(issue))
            {
                proposedReqs.remove(i);
            }
        }

        return proposedNodeEdgeSet;
    }

    private static JsonObject buildProposedNodeEdgeSet(JsonArray reqs, JsonArray deps)
    {
        JsonObject proposedNodeEdgeSet = new JsonObject();
        proposedNodeEdgeSet.add(nodesAsString, new JsonArray());
        proposedNodeEdgeSet.add("edges", new JsonArray());
        proposedNodeEdgeSet = buildNodes(reqs, proposedNodeEdgeSet);
        proposedNodeEdgeSet = buildEdges(deps, proposedNodeEdgeSet);

        return proposedNodeEdgeSet;
    }

    //TODO: use method from NewNodeEdgeSet
    private static JsonObject buildNodes(JsonArray reqs, JsonObject proposedNodeEdgeSet)
    {
        for (int i = 0; i < reqs.size(); i++)
        {
            JsonObject currentReq = reqs.get(i).getAsJsonObject();
            String reqKey = currentReq.get("id").getAsString();
            if (currentReq.has("name") && !reqKey.contains("mock"))
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

                //get additional information like status, etc
                JsonArray parts = currentReq.getAsJsonArray("requirementParts");

                if (parts.size() == 0)
                {
                    JsonObject resolution = new JsonObject();
                    resolution.addProperty("name", "Resolution");
                    resolution.addProperty("text", "unknown");
                    parts.add(resolution);
                    JsonObject platforms = new JsonObject();
                    platforms.addProperty("name", "Platforms");
                    platforms.addProperty("text", "unknown");
                    parts.add(platforms);
                    JsonObject versions = new JsonObject();
                    versions.addProperty("name", "Versions");
                    versions.addProperty("text", "unknown");
                    parts.add(versions);
                    JsonObject labels = new JsonObject();
                    labels.addProperty("name", "Labels");
                    labels.addProperty("text", "unknown");
                    parts.add(labels);
                    JsonObject environment = new JsonObject();
                    environment.addProperty("name", "Environment");
                    environment.addProperty("text", "unknown");
                    parts.add(environment);
                    JsonObject status = new JsonObject();
                    status.addProperty("name", "Status");
                    status.addProperty("text", "unknown");
                    parts.add(status);
                    JsonObject fixVersion = new JsonObject();
                    fixVersion.addProperty("name", "FixVersion");
                    fixVersion.addProperty("text", "unknown");
                    parts.add(fixVersion);
                    JsonObject components = new JsonObject();
                    components.addProperty("name", "Components");
                    components.addProperty("text", "unknown");
                    parts.add(components);
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

                JsonArray nodes = proposedNodeEdgeSet.getAsJsonArray(nodesAsString);
                nodes.add(currentReq);
            }
            else if (!currentReq.has("name"))
            {
                long nodeId = calculateUniqueID(reqKey);

                currentReq.addProperty("nodeid", nodeId);

                //get title of issue if it has one
                String nameCleaned = "confidential";
                currentReq.addProperty("name", nameCleaned);

                currentReq.add("requirementParts", new JsonArray());

                //get additional information like status, etc
                JsonArray parts = currentReq.getAsJsonArray("requirementParts");

                JsonObject resolution = new JsonObject();
                resolution.addProperty("name", "Resolution");
                resolution.addProperty("text", "confidential");
                parts.add(resolution);
                JsonObject platforms = new JsonObject();
                platforms.addProperty("name", "Platforms");
                platforms.addProperty("text", "confidential");
                parts.add(platforms);
                JsonObject versions = new JsonObject();
                versions.addProperty("name", "Versions");
                versions.addProperty("text", "confidential");
                parts.add(versions);
                JsonObject labels = new JsonObject();
                labels.addProperty("name", "Labels");
                labels.addProperty("text", "confidential");
                parts.add(labels);
                JsonObject environment = new JsonObject();
                environment.addProperty("name", "Environment");
                environment.addProperty("text", "confidential");
                parts.add(environment);
                JsonObject status = new JsonObject();
                status.addProperty("name", "Status");
                status.addProperty("text", "confidential");
                parts.add(status);
                JsonObject fixVersion = new JsonObject();
                fixVersion.addProperty("name", "FixVersion");
                fixVersion.addProperty("text", "confidential");
                parts.add(fixVersion);
                JsonObject components = new JsonObject();
                components.addProperty("name", "Components");
                components.addProperty("text", "confidential");
                parts.add(components);

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

                JsonArray nodes = proposedNodeEdgeSet.getAsJsonArray(nodesAsString);
                nodes.add(currentReq);
            }
            else if (reqKey.contains("mock"))
            {
                long nodeId = calculateUniqueID(reqKey);

                currentReq.addProperty("nodeid", nodeId);

                //get title of issue if it has one
                String nameCleaned = "not in DB";
                currentReq.addProperty("name", nameCleaned);

                currentReq.add("requirementParts", new JsonArray());

                //get additional information like status, etc
                JsonArray parts = currentReq.getAsJsonArray("requirementParts");

                JsonObject resolution = new JsonObject();
                resolution.addProperty("name", "Resolution");
                resolution.addProperty("text", "not in DB");
                parts.add(resolution);
                JsonObject platforms = new JsonObject();
                platforms.addProperty("name", "Platforms");
                platforms.addProperty("text", "not in DB");
                parts.add(platforms);
                JsonObject versions = new JsonObject();
                versions.addProperty("name", "Versions");
                versions.addProperty("text", "not in DB");
                parts.add(versions);
                JsonObject labels = new JsonObject();
                labels.addProperty("name", "Labels");
                labels.addProperty("text", "not in DB");
                parts.add(labels);
                JsonObject environment = new JsonObject();
                environment.addProperty("name", "Environment");
                environment.addProperty("text", "not in DB");
                parts.add(environment);
                JsonObject status = new JsonObject();
                status.addProperty("name", "Status");
                status.addProperty("text", "not in DB");
                parts.add(status);
                JsonObject fixVersion = new JsonObject();
                fixVersion.addProperty("name", "FixVersion");
                fixVersion.addProperty("text", "not in DB");
                parts.add(fixVersion);
                JsonObject components = new JsonObject();
                components.addProperty("name", "Components");
                components.addProperty("text", "not in DB");
                parts.add(components);

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

                JsonArray nodes = proposedNodeEdgeSet.getAsJsonArray(nodesAsString);
                nodes.add(currentReq);
            }
        }
        return proposedNodeEdgeSet;
    }

    //TODO: use method from NewNodeEdgeSet
    private static JsonObject buildEdges(JsonArray deps, JsonObject proposedNodeEdgeSet)
    {
        for (int i = 0; i < deps.size(); i++)
        {
            JsonObject currentDep = deps.get(i).getAsJsonObject();
            String fromKey = currentDep.get("fromid").getAsString();
            String toKey = currentDep.get("toid").getAsString();

            JsonArray edges = proposedNodeEdgeSet.getAsJsonArray("edges");

            if (!fromKey.contains("mock") && !toKey.contains("mock"))
            {
                currentDep.addProperty("node_fromid", idSet.get(fromKey));
                currentDep.addProperty("node_toid", idSet.get(toKey));
                edges.add(currentDep);
            }
        }
        return proposedNodeEdgeSet;
    }
}
