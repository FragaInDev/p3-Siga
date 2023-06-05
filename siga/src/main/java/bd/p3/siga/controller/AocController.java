package bd.p3.siga.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AocController {

    @RequestMapping(name = "aoc", value = "/aoc", method = RequestMethod.GET)
    public ModelAndView init(ModelMap model) {
        return new ModelAndView("aoc");
    }
}