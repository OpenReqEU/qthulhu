package eu.openreq.qt.qthulhu.controller;

import com.google.gson.JsonObject;
import eu.openreq.qt.qthulhu.data.NodeEdgeSetBuilder;
import eu.openreq.qt.qthulhu.data.uhservices.LayerDepthChecker;
import eu.openreq.qt.qthulhu.data.uhservices.UHServicesConnections;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.servlet.ModelAndView;

import javax.websocket.server.PathParam;
// TODO: all code requires un_CLARA_fication

/**
 * This class controlls the behaviour of the web application
 */
@Controller
public class NetworkController {


    /**
     * This is the main page you see if you go to https://api.openreq.eu/openreq-issue-link-map/
     *
     * @return the index view jsp
     */
    @RequestMapping("/")
    public ModelAndView index() {
        return new ModelAndView("index", HttpStatus.OK);
    }

    /**
     * This is the controller that is used if you get redirected to the page via Qt's JIRA.
     * Collects the issue link network data
     *
     * @param issue the issue key from the JIRA view page
     * @param depth the depth that will be displayed
     * @return view and model that contains the necessary information
     */
    @GetMapping("/issue/{issue}")
    public @ResponseBody
    ModelAndView issueByIssueKey(@PathVariable String issue, @PathParam("depth") Integer depth) {
        //checks if the layer specified by the user is between 1 and max_layer of the corresponding
        //issue link network
        depth = LayerDepthChecker.checkForValidLayerDepth(depth, 0);

        //issues are saved in uppercase in the database, lowercase does not return anything
        issue = issue.toUpperCase();

        try {
            //fetch issue data from mallikas (Database of UH)
            JsonObject issueData = UHServicesConnections.fetchTransitiveClosure(issue);

            //in case the issue is not contained in mallikas
            if (issueData.getAsJsonArray("requirements").size() == 0) {
                ModelAndView model = new ModelAndView("error", HttpStatus.NOT_FOUND);
                model.addObject("issue", issue);
                return model;
            }

            //to getNodeEdgeSet method only accepts arrays; false = not proposed
            JsonObject nodeEdgeSet = NodeEdgeSetBuilder.buildNodeEdgeSet(issueData, issue, false);

            //add objects to model
            ModelAndView model = new ModelAndView("issueid", HttpStatus.OK);
            model.addObject("issue", issue);
            model.addObject("depth", depth);
            model.addObject("nodeEdgeSet", nodeEdgeSet);
            model.addObject("maxDepth", nodeEdgeSet.get("max_depth").getAsInt());
            return model;
        } catch (HttpClientErrorException e) {
            //in case something goes wrong
            ModelAndView model = new ModelAndView("error", HttpStatus.NOT_FOUND);
            model.addObject("issue", issue);
            return model;
        }
    }
}