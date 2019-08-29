package eu.openreq.qt.qthulhu.data.uhservices;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import eu.openreq.qt.qthulhu.Property;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;



/**
 * This class manages the requests to UH's services
 */
public class UHServicesConnections
{
    private UHServicesConnections()
    {

    }
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
        String transitiveClosureURL = Property.TRANSITIVE_CLOSURE_URL + issueKey;


        String requirement;
        try
        {
            requirement = template.getForObject(transitiveClosureURL, String.class);
        }
        catch (HttpClientErrorException e)
        {
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
        String topProposedLinksURL = Property.TOP_PROPOSED_LINKS_URL + issueKey + "&maxResults=" + maxResults;


        String proposedLinks;
        try
        {
            proposedLinks = template.getForObject(topProposedLinksURL, String.class);
        }
        catch (Exception e)
        {
            throw (e);
        }
        Gson gson = new Gson();
        return gson.fromJson(proposedLinks, JsonElement.class).getAsJsonObject();
    }

    public static String sendUpdatedProposedLinks(String updatedProposedLinks) throws HttpClientErrorException, HttpServerErrorException
    {
        RestTemplate template = new RestTemplate();

        String response;

        try
        {
            response = template.postForObject(Property.UPDATE_PROPOSED_DEPENDENCIES_URL, updatedProposedLinks, String.class);
        }
        catch (Exception e)
        {
            throw (e);
        }
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
            String consistencyCheckURL = Property.CONSISTENCY_CHECK_URL + issueKey;

            String consistencyCheck;
            try
            {
                consistencyCheck = template.getForObject(consistencyCheckURL, String.class);
            }
            catch (Exception e)
            {
                throw (e);
            }
            Gson gson = new Gson();
            return gson.fromJson(consistencyCheck, JsonElement.class).getAsJsonObject();
        }

        public static String fetchJiraAuthAddress() throws
                HttpClientErrorException, HttpServerErrorException
        {
            RestTemplate template = new RestTemplate();
            String URL = Property.JIRA_AUTHORIZATION_ADDRESS;

            String response;
            try
            {
                response = template.getForObject(URL, String.class);
            }
            catch (Exception e)
            {
                throw (e);
            }
            return response;
        }

        public static String doVerifyJiraAuthorization(String token)  throws
                HttpClientErrorException, HttpServerErrorException
        {
            RestTemplate template = new RestTemplate();
            String URL = Property.VERIFY_AUTH_ADDRESS;

            String response;
            try
            {
                response = template.postForObject(URL, token, String.class);
            }
            catch (Exception e)
            {
                throw (e);
            }
            return response;
        }
    }
