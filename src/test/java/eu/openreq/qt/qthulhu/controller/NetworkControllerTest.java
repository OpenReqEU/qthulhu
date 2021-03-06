package eu.openreq.qt.qthulhu.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import eu.openreq.qt.qthulhu.MainApp;
import eu.openreq.qt.qthulhu.data.HelperFunctions;
import eu.openreq.qt.qthulhu.data.uhservices.LayerDepthChecker;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.junit.Assert.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes=MainApp.class)
@SpringBootTest
public class NetworkControllerTest
{
    private MockMvc mockMvc;
    private MockMvc mockMillaMvc;

    @Autowired
    NetworkController target;

    @Autowired
    MillaController targetMilla;

    @Before
    public void setup() {
        mockMvc = MockMvcBuilders.standaloneSetup(target).build();
        mockMillaMvc = MockMvcBuilders.standaloneSetup(targetMilla).build();
    }

    @Test
    public void indexURLTest() throws Exception {
        mockMvc.perform(get("/")).andExpect(status().isOk());
//                .andDo(print());

//                .andExpect(view().name("index"));
    }

    @Test
    public void issueURLTest() throws Exception {
        mockMvc.perform(get("/issue")).andExpect(status().is4xxClientError());
//                .andDo(print());

//                .andExpect(view().name("index"));
    }

    @Test
    public void issueURLwithIDTest() throws Exception
    {
        mockMvc.perform(get("/issue/QTWB-30")).andExpect(status().isOk());
    }

    @Test
    public void issueURLwithIDandDepthTest() throws Exception
    {
        mockMvc.perform(get("/issue/QTWB-30?issue=QTWB-30&depth=6")).andExpect(status().isOk());
    }

    @Test
    public void issueWrongKeyTest() throws Exception
    {
        mockMvc.perform(get("/issue/NOTAVALIDKEY-999")).andExpect(status().is4xxClientError());
    }

    @Test
    public void depDetectionTest() throws Exception
    {
        mockMillaMvc.perform(get("/milla/getTopProposedDependenciesOfRequirement?requirementId=QTWB-30&maxResults=5")).andExpect(status().isOk());
    }

    @Test
    public void consistCheckerTest() throws Exception
    {
        mockMillaMvc.perform(get("/milla/getConsistencyCheckForRequirement?requirementId=QTWB-30")).andExpect(status().isOk());
    }

    @Test
    public void checkTooLowLayerTest()
    {
        assertTrue("should be 1", LayerDepthChecker.checkForValidLayerDepth(-1,1) == 1);
    }

    @Test
    public void checkTooHighLayerTest()
    {
        assertTrue("should be 5", LayerDepthChecker.checkForValidLayerDepth(56,1) == 5);
    }

    @Test
    public void checknullLayerTest()
    {
        assertTrue("should be 1", LayerDepthChecker.checkForValidLayerDepth(null,3) == 1);
    }

    @Test
    public void checkCorrectLayerTest()
    {
        assertTrue("should be 3", LayerDepthChecker.checkForValidLayerDepth(4,-1) == 3);
    }

    @Test
    public void calcUniqueIdQTWBTest()
    {

        long uniqueID = HelperFunctions.calculateUniqueID("QTWB-30");
        assertTrue("Wrong ID", uniqueID == 1144130);
        uniqueID = HelperFunctions.calculateUniqueID("QBS-30");
        assertTrue("Wrong ID", uniqueID == 1062030);
        uniqueID = HelperFunctions.calculateUniqueID("QTBUG-30");
        assertTrue("Wrong ID", uniqueID == 1051030);
        uniqueID = HelperFunctions.calculateUniqueID("QT3DS-30");
        assertTrue("Wrong ID", uniqueID == 1154030);
        uniqueID = HelperFunctions.calculateUniqueID("AUTOSUITE-30");
        assertTrue("Wrong ID", uniqueID == 1144030);
        uniqueID = HelperFunctions.calculateUniqueID("QTJIRA-30");
        assertTrue("Wrong ID", uniqueID == 1053030);
        uniqueID = HelperFunctions.calculateUniqueID("QTCREATORBUG-30");
        assertTrue("Wrong ID", uniqueID == 1051230);
        uniqueID = HelperFunctions.calculateUniqueID("QDS-30");
        assertTrue("Wrong ID", uniqueID == 1174030);
        uniqueID = HelperFunctions.calculateUniqueID("PYSIDE-30");
        assertTrue("Wrong ID", uniqueID == 1084030);
        uniqueID = HelperFunctions.calculateUniqueID("QTIFW-30");
        assertTrue("Wrong ID", uniqueID == 1063030);
        uniqueID = HelperFunctions.calculateUniqueID("QTMOBILITY-30");
        assertTrue("Wrong ID", uniqueID == 1054030);
        uniqueID = HelperFunctions.calculateUniqueID("QTPLAYGROUND-30");
        assertTrue("Wrong ID", uniqueID == 1084130);
        uniqueID = HelperFunctions.calculateUniqueID("QTWEBSITE-30");
        assertTrue("Wrong ID", uniqueID == 1055030);
        uniqueID = HelperFunctions.calculateUniqueID("QTQAINFRA-30");
        assertTrue("Wrong ID", uniqueID == 1060030);
        uniqueID = HelperFunctions.calculateUniqueID("QTCOMPONENTS-30");
        assertTrue("Wrong ID", uniqueID == 1057030);
        uniqueID = HelperFunctions.calculateUniqueID("QSR-30");
        assertTrue("Wrong ID", uniqueID == 1174130);
        uniqueID = HelperFunctions.calculateUniqueID("QTSOLBUG-30");
        assertTrue("Wrong ID", uniqueID == 1051330);
        uniqueID = HelperFunctions.calculateUniqueID("QTVSADDINBUG-30");
        assertTrue("Wrong ID", uniqueID == 1058030);
        uniqueID = HelperFunctions.calculateUniqueID("QTWEBKIT-30");
        assertTrue("Wrong ID", uniqueID == 1053130);
        uniqueID = HelperFunctions.calculateUniqueID("QTSYSADM-30");
        assertTrue("Wrong ID", uniqueID == 1094030);
        uniqueID = HelperFunctions.calculateUniqueID("TEST-30");
        assertTrue("Wrong ID", uniqueID == 1000030);
    }

    @Test
    public void cleanTextTest()
    {
        JsonObject testJsonText = new JsonObject();
        testJsonText.addProperty("description",  "This is\r\n a\r text description!!!?.");
        String cleanText = HelperFunctions.cleanText(testJsonText.get("description"));
        assertTrue("Wrong Text", cleanText.equals("This is a text description! ! ! ? . ") );
    }

    @Test
    public void cleanEmptyTextTest()
    {
        JsonObject testJsonText = new JsonObject();
        String cleanText = HelperFunctions.cleanText(testJsonText.get("description"));
        System.out.println(cleanText);
        assertTrue("Wrong Text", cleanText.equals("none") );
    }

    @Test
    public void checkFillPartsTest()
    {
        JsonArray parts = new JsonArray();
        HelperFunctions.fillParts(parts, "placeholder");
        assertTrue("Still empty", !parts.equals(null));
    }


//    @Test
//    public void givenGreetURI_whenMockMVC_thenVerifyResponse() {
//        MvcResult mvcResult = this.mockMvc.perform(get("/greet"))
//                .andDo(print()).andExpect(status().isOk())
//                .andExpect(jsonPath("$.message").value("Hello World!!!"))
//                .andReturn();
//
//        Assert.assertEquals("application/json;charset=UTF-8",
//                mvcResult.getResponse().getContentType());
//    }
}
