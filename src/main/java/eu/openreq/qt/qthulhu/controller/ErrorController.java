package eu.openreq.qt.qthulhu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * This class handles errors returned from the qtcontroller in milla.
 * Currently the qtcontroller POST request /getTransitiveClosureOfARequirement accepts all inputs.
 * A workaround in NetworkController is in place
 */
@Controller
public class ErrorController implements org.springframework.boot.autoconfigure.web.ErrorController
{

    //TODO: This needs to be tested
    @RequestMapping(value = "/error", method = RequestMethod.GET)
    public ModelAndView renderErrorPage(@RequestHeader(value = "HTTP Status Code") String statusCode)
    {

        ModelAndView errorPage;
        String errorMsg = "";
        int httpErrorCode = Integer.parseInt(statusCode);
        String error = "error";

//        TODO: Create error view.jsp for all common errors of milla
        switch (httpErrorCode)
        {
//            case 400:
//            {
////                TODO: Change viewName to corresponding template.
//                errorPage = new ModelAndView(error);
//                break;
//            }
//            case 401:
//            {
////                TODO: Change viewName to corresponding template.
//                errorPage = new ModelAndView(error);
//                break;
//            }
//            case 404:
//            {
////                TODO: Change viewName to corresponding template.
//                errorPage = new ModelAndView(error);
//                break;
//            }
//            case 405:
//            {
////                TODO: Change viewName to corresponding template.
//                errorPage = new ModelAndView(error);
//                break;
//            }
//            case 500:
//            {
////                TODO: Change viewName to corresponding template.
//                errorPage = new ModelAndView(error);
//                break;
//            }
            default:
            {
                errorPage = new ModelAndView(error);
            }
        }
        return errorPage;
    }

    @Override
    public String getErrorPath()
    {
        return "/error";
    }
}
