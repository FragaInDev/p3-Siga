package bd.p3.siga.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MppcController {

    @RequestMapping(name = "mppc", value = "/mppc", method = RequestMethod.GET)
    public ModelAndView init(ModelMap model) {
        return new ModelAndView("mppc");
    }
}