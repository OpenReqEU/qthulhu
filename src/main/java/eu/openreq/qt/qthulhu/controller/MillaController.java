package eu.openreq.qt.qthulhu.controller;

import com.google.gson.JsonObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import static eu.openreq.qt.qthulhu.data.proposedNodeEdgeSet.buildNodeEdgeSet;
import static eu.openreq.qt.qthulhu.data.uhservices.FetchDataFromUH.fetchConsistencyCheck;
import static eu.openreq.qt.qthulhu.data.uhservices.FetchDataFromUH.fetchTopProposedLinks;

@Controller
public class MillaController
{
    @RequestMapping(value = "/getTopProposedLinksOfRequirement", method = RequestMethod.GET)
    public @ResponseBody String getTopProposedLinksOfRequirement(@RequestParam("requirementId") String requirementId, @RequestParam("maxResults") Integer maxResults)
    {

        JsonObject topProposedLinks = fetchTopProposedLinks(requirementId, maxResults);
        topProposedLinks = buildNodeEdgeSet(topProposedLinks);
        return topProposedLinks.toString();

    }

    @RequestMapping(value = "/getConsistencyCheckOfRequirement", method = RequestMethod.GET)
    public @ResponseBody String getConsistencyCheckOfRequirement(@RequestParam("requirementId") String requirementId)
    {

        JsonObject consistencyCheckJSON = fetchConsistencyCheck(requirementId);
        return consistencyCheckJSON.toString();

    }

}