package eu.openreq.qt.qthulhu.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import eu.openreq.qt.qthulhu.data.newNodeEdgeSet;
import eu.openreq.qt.qthulhu.data.uhservices.LayerDepthChecker;
import eu.openreq.qt.qthulhu.data.uhservices.UHServicesConnections;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.servlet.ModelAndView;
// TODO: all code requires un_CLARA_fication

/**
 * This class controlls the behaviour of the web application
 */
@Controller
public class NetworkController
{

    /**
     * This is the main page you see if you go to https://api.openreq.eu/openreq-issue-link-map/
     *
     * @return the index view jsp
     */
    @RequestMapping("/")
    public ModelAndView index()
    {
        return new ModelAndView("index", HttpStatus.OK);
    }

    /**
     * This is the controller that is used if you get redirected to the page via Qt's JIRA.
     * Collects the issue link network data
     *
     * @param issue the issue key from the JIRA view page
     * @return view and model that contains the necessary information
     */
    @GetMapping("/issue/{issue}")
    public @ResponseBody
    ModelAndView issueByIssueKey(@PathVariable String issue)
    {
        //here the default value is 1, since currently the user in JIRA cannot set a layerdepth in JIRA
        int depth = 1;

        //checks if the layer specified by the user is between 1 and max_layer of the corresponding
        //issue link network
        depth = LayerDepthChecker.checkForValidLayerDepth(depth, 0);

        //issues are saved in uppercase in the database, lowercase does not return anything
        issue = issue.toUpperCase();

        try
        {
            //fetch issue data from mallikas (Database of UH)
            JsonObject issueData = UHServicesConnections.fetchTransitiveClosure(issue);

            //in case the issue is not contained in mallikas
            if (issueData.equals(new JsonArray()))
            {
                ModelAndView model = new ModelAndView("error", HttpStatus.NOT_FOUND);
                model.addObject("issue", issue);
                return model;
            }

            //to getNodeEdgeSet method only accepts arrays
            JsonObject nodeEdgeSet = newNodeEdgeSet.buildNodeEdgeSet(issueData);


            //add objects to model
            ModelAndView model = new ModelAndView("issueID", HttpStatus.OK);
            model.addObject("issue", issue);
            model.addObject("depth", depth);
            model.addObject("nodeEdgeSet", nodeEdgeSet);
            model.addObject("maxDepth", nodeEdgeSet.get("max_depth").getAsInt());
            return model;
        }
        catch (HttpClientErrorException e)
        {
            //in case something goes wrong
            ModelAndView model = new ModelAndView("error", HttpStatus.NOT_FOUND);
            model.addObject("issue", issue);
            return model;
        }
    }

    /**
     * Creates a new issue network depending on the inputs.
     * Then adds all information to the model which is then redirected to the corresponding jsp
     *
     * @param issue issuekey
     * @param depth amount of layers
     * @return view and model that contains the necessary information
     */
    @RequestMapping(value = "/issue", method = RequestMethod.POST)
    public ModelAndView issue(@RequestParam("issue") String issue, @RequestParam("depth") Integer depth)
    {
        //Check if layerDepth had an input, if not use default value of 1
        depth = LayerDepthChecker.checkForValidLayerDepth(depth, 0);

        //split the string
        issue = issue.toUpperCase();

        try
        {
            //put all the fetched information into on Array
            JsonObject issueData = new JsonObject();

            JsonObject issueJSON = UHServicesConnections.fetchTransitiveClosure(issue);
            //work around since the endpoint accepts all strings
            if (issueJSON.getAsJsonArray("requirements").size() != 0)
            {
                issueData = issueJSON;
            }

            // this is a workaround since the qtcontroller accepts all strings.
            if (issueData.equals(new JsonObject()))
            {
                ModelAndView model = new ModelAndView("error", HttpStatus.NOT_FOUND);
                model.addObject("issue", issue);
                return model;
            }

            //System.out.println(issueData);

            JsonObject nodeEdgeSet = newNodeEdgeSet.buildNodeEdgeSet(issueData);

            //add objects to model
            ModelAndView model = new ModelAndView("issue", HttpStatus.OK);
            model.addObject("issue", issue);
            model.addObject("depth", depth);
            model.addObject("nodeEdgeSet", nodeEdgeSet);
            model.addObject("maxDepth", nodeEdgeSet.get("max_depth").getAsInt());
            return model;
        }
        catch (HttpClientErrorException e)
        {
            //in case something goes wrong
            ModelAndView model = new ModelAndView("error", HttpStatus.NOT_FOUND);
            model.addObject("issue", issue);
            return model;
        }
    }


    /**
     * Example page
     *
     * @return view and model that contains example information
     */
    @RequestMapping(value = "/example", method = RequestMethod.POST)
    public ModelAndView example(@RequestParam("issues") String issues, @RequestParam("layerDepth") Integer layerDepth)
    {
        if (layerDepth > 2)
        {
            layerDepth = 2;
        }

        ModelAndView model = new ModelAndView("example", HttpStatus.OK);
        model.addObject("issue", issues);
        model.addObject("layerDepth", layerDepth);
        model.addObject("maxLayer", 2);
        return model;
    }
}

//
//
// #### GRAVEYARD ####
//all old methods
//
//    /**
//     * Creates a new issue network depending on the inputs.
//     * Then adds all information to the model which is then redirected to the corresponding jsp
//     *
//     * @param issues      issuekeys
//     * @param layerDepth  amount of layers
//     * @param layerChange increasing / decreasing layers (only important for add/remove)
//     * @return view and model that contains the necessary information
//     */
//    @RequestMapping(value = "/issue", method = RequestMethod.POST)
//    public ModelAndView issue(@RequestParam("issues") String issues, @RequestParam("layerDepth") Integer layerDepth, @RequestParam("layerChange") Integer layerChange)
//    {
//        //Check if layerDepth had an input, if not use default value of 1
//        layerDepth = LayerDepthChecker.checkForValidLayerDepth(layerDepth, layerChange);
//
//        //split the string
//        issues = issues.toUpperCase();
//
//        //if multiple issue keys were entered they are splitted
//        String[] issueKeyArray = issues.split(",");
//        for (int i = 0; i < issueKeyArray.length; i++)
//        {
//            issueKeyArray[i] = issueKeyArray[i].trim().toUpperCase();
//        }
//
//        try
//        {
//            //put all the fetched information into on Array
//            JsonArray issueData = new JsonArray();
//            for (String issueKey : issueKeyArray)
//            {
//                JsonObject issueJSON = UHServicesConnections.fetchTransitiveClosure(issueKey);
//                //work around since the endpoint accepts all strings
//                if (issueJSON.getAsJsonArray("requirements").size() != 0)
//                {
//                    issueData.add(issueJSON);
//                }
//            }
//            // this is a workaround since the qtcontroller accepts all strings.
//            if (issueData.equals(new JsonArray()))
//            {
//                ModelAndView model = new ModelAndView("error", HttpStatus.NOT_FOUND);
//                model.addObject("issue", issues);
//                return model;
//            }
//            JsonObject nodeEdgeSet = NodeEdgeSet.buildNodeEdgeSet(issueData, issueKeyArray);
//
//            //add objects to model
//            ModelAndView model = new ModelAndView("issue", HttpStatus.OK);
//            model.addObject("issue", issues);
//            model.addObject("layerDepth", layerDepth);
//            model.addObject("nodeEdgeSet", nodeEdgeSet);
//            model.addObject("maxLayer", nodeEdgeSet.get("max_layer").getAsInt());
//            return model;
//        }
//        catch (HttpClientErrorException e)
//        {
//            //in case something goes wrong
//            ModelAndView model = new ModelAndView("error", HttpStatus.NOT_FOUND);
//            model.addObject("issue", issues);
//            return model;
//        }
//    }
//
//    @RequestMapping(value = "/issueold", method = RequestMethod.POST)
//    public ModelAndView issueold(@RequestParam("issues") String issues, @RequestParam("layerDepth") Integer layerDepth, @RequestParam("layerChange") Integer layerChange)
//    {
//        //Check if layerDepth had an input, if not use default value of 1
//        layerDepth = LayerDepthMilla.checkForValidLayerDepth(layerDepth, layerChange);
//
//        //split the string
//        issues = issues.toUpperCase();
//
//        String[] issueArray = issues.split(",");
//        for (int i = 0; i < issueArray.length; i++)
//        {
//            issueArray[i] = issueArray[i].trim().toUpperCase();
//        }
//        //get Neighbous aka Node Set
//        try
//        {
//            HashSet<String> neighbours = new HashSet<>();
//            for (String issue : issueArray)
//            {
//                neighbours = NodeSetRecursiveMilla.getNeighboursOfIssue(issue, neighbours, 1, layerDepth);
//            }
//            //get all nodes and edges that are incident with the node set
//
//            JsonArray issueJSONs = NodeEdgeSetMilla.getNodeEdgeSetData(neighbours);
//            JsonObject nodeEdgeSet = NodeEdgeSetMilla.getNodeEdgeSet(issueJSONs);
//
//            //add objects to model
//            ModelAndView model = new ModelAndView("issueold", HttpStatus.OK);
//            model.addObject("issue", issues);
//            model.addObject("layerDepth", layerDepth);
//            model.addObject("nodeEdgeSet", nodeEdgeSet);
//            return model;
//        } catch (HttpClientErrorException e)
//        {
//            ModelAndView model = new ModelAndView("error", HttpStatus.NOT_FOUND);
//            model.addObject("issue", issues);
//            return model;
//        }
//    }
//}
//    @PostMapping("/issue")
//    public ModelAndView issue(@RequestParam("issue") String issue, @RequestParam("layerDepth") Integer layerDepth, @RequestParam("layerChange") Integer layerChange) throws IOException {
//        //Check if layerDepth had an input, if not use default value of 2
//        layerDepth = LayerDepthMilla.checkForValidLayerDepth(layerDepth, layerChange);
//
//        //get Neighbous aka Node Set
//        HashSet<String> neighbours = new HashSet<String>();
//        neighbours = NodeSetRecursiveMilla.getNeighboursOfIssue(issue, neighbours, 1, layerDepth);
//
//        //get all nodes and edges that are incident with the node set
//        JsonArray issueJSONs = NodeEdgeSetMilla.getNodeEdgeSetData(neighbours);
//        JsonObject nodeEdgeSet = NodeEdgeSetMilla.getNodeEdgeSet(issueJSONs);
//
//        //add objects to model
//        ModelAndView model = new ModelAndView("issue", HttpStatus.OK);
//        model.addObject("issue", issue);
//        model.addObject("layerDepth", layerDepth);
//        model.addObject("nodeEdgeSet", nodeEdgeSet);
//        return model;
//    }
//    @RequestMapping("/")
//    public ModelAndView index() throws UnirestException, IOException {
//fetches the projects from JIRA
//        String requestURL = "https://bugreports.qt.io/rest/api/2/project";
//        OkHttpClient client = new OkHttpClient();
//        Run run = new Run();
//        String responseJSON = run.run(requestURL, client);
//        Gson gson = new Gson();
//        JsonArray projectsJSON = gson.fromJson(responseJSON, JsonElement.class).getAsJsonArray();
//
//        Set<String> projectNames = new HashSet<String>();
//        int numOfProjects = projectsJSON.size();
//
//        for (int i = 0; i < numOfProjects; i++) {
//            JsonObject jsonElement = projectsJSON.get(i).getAsJsonObject();
//            String key = jsonElement.get("key").getAsString();
//            projectNames.add(key);
//        }
//
//        ModelAndView model = new ModelAndView("index", HttpStatus.OK);
//        model.addObject("projectNames", projectNames);
//        return model;
//    }

//    @PostMapping("/issuejira")
//    public ModelAndView issuejira(@RequestParam("issue") String issue) throws IOException {
//
//        JsonArray issueSubgraph = IssueSubGraph.getSubgraph(issue);
//        JsonObject nodeAndEdgeSet = NodeEdgeSetJIRA.getNodesAndEdges(issueSubgraph);
//
//        //add objects to model
//        ModelAndView model = new ModelAndView("issuejira", HttpStatus.OK);
//        model.addObject("issue", issue);
//        model.addObject("issueSubGraph", issueSubgraph);
//        model.addObject("nodeandedges", nodeAndEdgeSet);
//        return model;
//    }

//    @PostMapping("/projectdepmilla")
//    public ModelAndView projectdepmilla(@RequestParam("project") String project) throws IOException {
//
//        JsonObject projectJson = FetchDataFromMilla.fetchProjectData(project);
//        JsonObject nodeEdgeSet = NodeEdgeSetProject.getNodeEdgeSet(projectJson, project);
//
//        //add objects to model
//        ModelAndView model = new ModelAndView();
//        model.addObject("project", project);
//        model.addObject("nodeEdgeSet", nodeEdgeSet);
//        return model;
//    }

//        String url = "https://bugreports.qt.io/rest/api/2/project";
//        HttpResponse<JsonNode> jsonResponse = Unirest.get(url).asJson();
//        JsonNode jsonBody = jsonResponse.getBody();
//        JSONObject jsonObject = new JSONObject("{ data: " + jsonBody.toString() + " }");
//        System.out.println(jsonBody);
//        System.out.println(jsonObject);
//
//        Set<String> projectNames = new HashSet<String>();
//
//
//        Iterator<?> keys = jsonObject.keys();
//        while (keys.hasNext()) {
//            String jsonKey = (String) keys.next();
//            JSONArray jsonArray = jsonObject.getJSONArray("data");
//            for (int i = 0; i < jsonArray.length(); i++) {
//                JSONObject jsonElement = jsonArray.getJSONObject(i);
//                String expand = jsonElement.getString("expand");
////                String self = jsonElement.getString("self");
////                String id = jsonElement.getString("id");
//                String key = jsonElement.getString("key");
////                String name = jsonElement.getString("name");
////                String avatarUrls = jsonElement.getString("avatarUrls");
////                String projectCategory = jsonElement.getString("projectCategory");
////                String projectTypeKey = jsonElement.getString("projectTypeKey");
//                projectNames.add(key);
//            }
//        }

//    @PostMapping("/project")
//    public ModelAndView project(@RequestParam("project") String project) throws IOException {
//        //fetches all issues from a project and their links
//        JsonArray projectIssues = ProjectInsideDependencies.collectProjectIssues(project);
//        //transform the issueJSONs into a node and edgeset for easier processing
//        JsonObject nodeAndEdgeSet = NodeEdgeSetJIRA.getNodesAndEdges(projectIssues);
//
//        //add objects to model
//        ModelAndView model = new ModelAndView();
//        model.addObject("project", project);
//        model.addObject("projectissues", projectIssues);
//        model.addObject("nodeandedges", nodeAndEdgeSet);
//        return model;
//    }

//    @PostMapping("/projectdepjira")
//    public ModelAndView projectdepjira(@RequestParam("project") String project) throws IOException {
//        //fetches all issues from a project and their links
//        JsonArray projectIssues = ProjectDependenciesJIRA.getProjectDependenciesJIRA(project);
//        JsonObject nodeEdgeSet = NodeEdgeSetJIRA.getNodesAndEdges(projectIssues);
//        System.out.println(nodeEdgeSet);
//        //transform the issueJSONs into a node and edgeset for easier processing
//        //add objects to model
//        ModelAndView model = new ModelAndView();
//        model.addObject("project", project);
//        model.addObject("projectissues", projectIssues);
//        model.addObject("nodeEdgeSet", nodeEdgeSet);
//
//        return model;
//    }