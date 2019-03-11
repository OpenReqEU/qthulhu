package eu.openreq.qt.qthulhu.data.uhservices;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

/**
 * This class manages the requests to UH's services
 */
public class FetchDataFromUH
{
    /**
     * This fetches the data contained in a JSON that follows the OpenReq JSON format standard
     *
     * @param issueKey the issue key of the issue you want information of
     * @return the JSON with the information
     * @throws HttpClientErrorException rethrow errors cause by user input
     * @throws HttpServerErrorException rethrow errors cause by user input
     */
    public static JsonObject fetchData(String issueKey) throws HttpClientErrorException, HttpServerErrorException
    {
        RestTemplate template = new RestTemplate();
        //gets transitive Closure (means the whole issue network of an specified issue)
        //String transitiveClosureURL = "https://api.openreq.eu/milla/getTransitiveClosureOfARequirement?requirementId=";
        String transitiveClosureURL = "http://217.172.12.199:9203/getTransitiveClosureOfARequirement?requirementId=";
        String requirement;
        try
        {
            requirement = template.postForObject(transitiveClosureURL, issueKey, String.class);
        }
        catch (HttpClientErrorException e)
        {
            System.out.println("Error " + e);
            throw (e);
        }
        catch (HttpServerErrorException e)
        {
            throw (e);
        }
        Gson gson = new Gson();
        return gson.fromJson(requirement, JsonElement.class).getAsJsonObject();
    }
}
