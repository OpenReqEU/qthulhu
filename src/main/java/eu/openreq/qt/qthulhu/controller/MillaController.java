package eu.openreq.qt.qthulhu.controller;

import com.google.gson.JsonObject;
import eu.openreq.qt.qthulhu.data.uhservices.UHServicesConnections;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import static eu.openreq.qt.qthulhu.data.proposedNodeEdgeSet.buildNodeEdgeSet;
import static eu.openreq.qt.qthulhu.data.uhservices.UHServicesConnections.fetchConsistencyCheck;
import static eu.openreq.qt.qthulhu.data.uhservices.UHServicesConnections.fetchTopProposedLinks;

@Controller
public class MillaController
{
    @RequestMapping(value = "/getTopProposedLinksOfRequirement", method = RequestMethod.GET)
    public @ResponseBody
    String getTopProposedLinksOfRequirement(@RequestParam("requirementId") String requirementId, @RequestParam("maxResults") Integer maxResults)
    {
        JsonObject topProposedLinks = fetchTopProposedLinks(requirementId, maxResults);
        topProposedLinks = buildNodeEdgeSet(topProposedLinks, requirementId);
        return topProposedLinks.toString();
    }

    @RequestMapping(value = "/getConsistencyCheckOfRequirement", method = RequestMethod.GET)
    public @ResponseBody
    String getConsistencyCheckOfRequirement(@RequestParam("requirementId") String requirementId)
    {
        JsonObject consistencyCheckJSON = fetchConsistencyCheck(requirementId);
        return consistencyCheckJSON.toString();
    }

    @RequestMapping(value = "/sendUpdatedProposedLinks", method = RequestMethod.POST)
    public @ResponseBody
    String sendUpdatedProposedLinks(@RequestBody String updatedProposedLinks)
    {
        String blub = updatedProposedLinks.substring(16, updatedProposedLinks.length()-1);
        return UHServicesConnections.sendUpdatedProposedLinks(blub);
    }
}
