package eu.openreq.qt.qthulhu.data;

import com.google.gson.JsonElement;
import com.google.gson.JsonNull;

public class HelperFunctions
{

    /**
     * Builds a unique id based on the issue key.
     * These can have up to 10 digits and are probably going into 11 digits soon, therefore we are using long instead of int
     * @param key the key, ex. QTWB-10
     * @return a unique long to identify an issue for vis.js
     */
    public static long calculateUniqueID(String key)
    {
        int n = key.indexOf("-");

        String project = key.substring(0, n);
        int projectId = ProjectIDs.getProjectID(project);

        //we are using regex here because UH's services sometimes mock issues and then the key is funny
        String StringNodeId = key.substring(n + 1).replaceAll("[^0-9]", "");
        StringNodeId = projectId + StringNodeId;
        return Long.parseLong(StringNodeId);
    }

    /**
     * This method cleans strings (description, comment, summary, title, etc.) of
     *
     * @param issueDesc the text that should be cleaned
     * @return the cleaned text
     */
    public static String cleanText(JsonElement issueDesc)
    {
        if (issueDesc == null)
        {
            return "none";
        }
        if (!issueDesc.equals(JsonNull.INSTANCE))
        {
            //TODO: This can be done easier, I assume
            String text = issueDesc.getAsString().replaceAll("[\\r\\n]+", "");
            text = text.replace("'", "");
            text = text.replace("\r\n", "");
            text = text.replace("\r", "");
            text = text.replace("\n", "");
            text = text.replace("\"", "");
            text = text.replace("?", "? ");
            text = text.replace("!", "! ");
            text = text.replace(".", ". ");
            text = text.replace("\\", "");
            text = text.replace("[", "");
            text = text.replace("]", "");
            return text;
        }
        //sometimes there are nulls where there should be some text for the front end
        else
        {
            return "none";
        }
    }
}
