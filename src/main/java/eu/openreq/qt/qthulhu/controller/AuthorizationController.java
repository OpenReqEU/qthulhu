package eu.openreq.qt.qthulhu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import static eu.openreq.qt.qthulhu.data.uhservices.UHServicesConnections.*;

@Controller
@RequestMapping("/authorize")
public class AuthorizationController
{
    @RequestMapping(value = "/getAddress", method = RequestMethod.GET)
    public @ResponseBody
    String getJiraAuthorizationAddress()
    {
        return fetchJiraAuthAddress();
    }

    @RequestMapping(value = "/verifyAuth", method = RequestMethod.POST)
    public @ResponseBody
    String verifyJiraAuthorization(@RequestBody String token)
    {
        return doVerifyJiraAuthorization(token);
    }
}
