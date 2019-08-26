package eu.openreq.qt.qthulhu.controller;

import com.google.gson.JsonObject;
import eu.openreq.qt.qthulhu.MainApp;
import eu.openreq.qt.qthulhu.data.HelperFunctions;
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

    @Autowired
    NetworkController target;

    @Before
    public void setup() {
        mockMvc = MockMvcBuilders.standaloneSetup(target).build();
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
    public void calcUniqueIdTest()
    {
        long uniqueID = HelperFunctions.calculateUniqueID("QTWB-30");
        assertTrue("Wrong ID", uniqueID == 1144130 );
    }

    @Test
    public void cleanTextTest()
    {
        JsonObject testJsonText = new JsonObject();
        testJsonText.addProperty("description",  "This is\r\n a\r text description!!!?.");
        String cleanText = HelperFunctions.cleanText(testJsonText.get("description"));
        assertTrue("Wrong Text", cleanText.equals("This is a text description! ! ! ? . ") );
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
