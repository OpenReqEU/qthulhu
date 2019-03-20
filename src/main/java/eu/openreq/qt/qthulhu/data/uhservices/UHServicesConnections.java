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
public class UHServicesConnections
{
    /**
     * This fetches the data contained in a JSON that follows the OpenReq JSON format standard
     *
     * @param issueKey the issue key of the issue you want information of
     * @return the JSON with the information
     * @throws HttpClientErrorException rethrow errors caused by user input
     * @throws HttpServerErrorException rethrow errors caused by user input
     */
    public static JsonObject fetchTransitiveClosure(String issueKey) throws HttpClientErrorException, HttpServerErrorException
    {
        RestTemplate template = new RestTemplate();
        //gets transitive Closure (means the whole issue link map of an specified issue)
//        String transitiveClosureURL = "https://localhost:9203/getTransitiveClosureOfARequirement?requirementId=" + issueKey;
        String transitiveClosureURL = "http://217.172.12.199:9203/getTransitiveClosureOfRequirement?requirementId=" + issueKey;
        String requirement;
        try
        {
            requirement = template.getForObject(transitiveClosureURL, String.class);
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

    /**
     * This fetches the data contained in a JSON that follows the OpenReq JSON format standard
     *
     * @param issueKey   the issue key of the issue you want information of
     * @param maxResults the number of results
     * @return the JSON with the information
     * @throws HttpClientErrorException rethrow errors caused by user input
     * @throws HttpServerErrorException rethrow errors caused by user input
     */
    public static JsonObject fetchTopProposedLinks(String issueKey, int maxResults) throws HttpClientErrorException, HttpServerErrorException
    {
        RestTemplate template = new RestTemplate();
//        String topProposedLinksURL = "http://localhost:9203/getTopProposedDependenciesOfRequirement?requirementId=" + issueKey + "&maxResults=" + maxResults;
        String topProposedLinksURL = "http://217.172.12.199:9203/getTopProposedDependenciesOfRequirement?requirementId=" + issueKey + "&maxResults=" + maxResults;
        String proposedLinks;
        try
        {
            proposedLinks = template.getForObject(topProposedLinksURL, String.class);
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
        return gson.fromJson(proposedLinks, JsonElement.class).getAsJsonObject();
    }

    public static String sendUpdatedProposedLinks(String updatedProposedLinks) throws HttpClientErrorException, HttpServerErrorException
    {
        RestTemplate template = new RestTemplate();
        String updateProposedDependenciesURL = "http://217.172.12.199:9203/updateProposedDependencies";
        String response;
        System.out.println("1");

        try
        {
            System.out.println("2");
            response = template.postForObject(updateProposedDependenciesURL, updatedProposedLinks, String.class);
            System.out.println("3");
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
        System.out.println("4");
        System.out.println(response);
        return response;
    }

        /**
         * This fetches the data contained in a JSON that follows the OpenReq JSON format standard
         *
         * @param issueKey the issue key of the issue you want information of
         * @return the JSON with the information
         * @throws HttpClientErrorException rethrow errors caused by user input
         * @throws HttpServerErrorException rethrow errors caused by user input
         */
        public static JsonObject fetchConsistencyCheck (String issueKey) throws
        HttpClientErrorException, HttpServerErrorException
        {
            RestTemplate template = new RestTemplate();
//            String consistencyCheckURL = "http://localhost:9203/getConsistencyCheckForRequirement?requirementId=" + issueKey;
            String consistencyCheckURL = "http://217.172.12.199:9203/getConsistencyCheckForRequirement?requirementId=" + issueKey;
            String consistencyCheck;
            try
            {
                consistencyCheck = template.getForObject(consistencyCheckURL, String.class);
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
            return gson.fromJson(consistencyCheck, JsonElement.class).getAsJsonObject();
        }
    }
