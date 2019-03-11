package eu.openreq.qt.qthulhu.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import eu.openreq.qt.qthulhu.data.uhservices.FetchDataFromUH;

import static org.junit.jupiter.api.Assertions.assertTrue;

class NetworkControllerTest
{
    @org.junit.jupiter.api.Test
    void testTransitiveClosureResponse()
    {
        String issueKey = "QTWB-30";

        JsonObject issueJSON = FetchDataFromUH.fetchData(issueKey);

        JsonArray reqs = issueJSON.getAsJsonArray("requirements");
        JsonArray deps = issueJSON.getAsJsonArray("dependencies");

        assertTrue(reqs.size() > 0);
        assertTrue(deps.size() > 0);
    }
}
