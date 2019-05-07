package eu.openreq.qt.qthulhu.controller;

import com.google.gson.JsonObject;
import eu.openreq.qt.qthulhu.data.uhservices.UHServicesConnections;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import static eu.openreq.qt.qthulhu.data.proposedNodeEdgeSet.buildNodeEdgeSet;
import static eu.openreq.qt.qthulhu.data.uhservices.UHServicesConnections.fetchConsistencyCheck;
import static eu.openreq.qt.qthulhu.data.uhservices.UHServicesConnections.fetchTopProposedLinks;

@Controller
@RequestMapping("/milla")
public class MillaController
{
    @GetMapping(value = "/getTopProposedDependenciesOfRequirement")
    public @ResponseBody
    String getTopProposedLinksOfRequirement(@RequestParam(name="requirementId") String requirementId, @RequestParam(name="maxResults") Integer maxResults)
    {
        System.out.println("Milla controller getTopProposedLinksOfRequirement");
        JsonObject topProposedLinks = fetchTopProposedLinks(requirementId, maxResults);
        topProposedLinks = buildNodeEdgeSet(topProposedLinks, requirementId);
        return topProposedLinks.toString();
    }

    @GetMapping(value = "/getConsistencyCheckForRequirement")
    public @ResponseBody
    String getConsistencyCheckOfRequirement(@RequestParam("requirementId") String requirementId)
    {
        JsonObject consistencyCheckJSON = fetchConsistencyCheck(requirementId);
        return consistencyCheckJSON.toString();
    }

    @PostMapping(value = "/sendUpdatedProposedLinks")
    public @ResponseBody
    String sendUpdatedProposedLinks(@RequestBody String updatedProposedLinks)
    {
        String blub = updatedProposedLinks.substring(16, updatedProposedLinks.length()-1);
        return UHServicesConnections.sendUpdatedProposedLinks(blub);
    }
}
