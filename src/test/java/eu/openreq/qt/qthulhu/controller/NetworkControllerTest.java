package eu.openreq.qt.qthulhu.controller;

import eu.openreq.qt.qthulhu.MainApp;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

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
    public void basicTest() throws Exception {
        mockMvc.perform(get("/")).andExpect(status().isOk());
//                .andDo(print());

//                .andExpect(view().name("index"));
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
