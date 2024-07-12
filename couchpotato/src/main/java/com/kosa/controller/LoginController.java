package com.kosa.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    // 메인 페이지 이동
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String mainPageGET(Model model) {
        logger.info("메인 페이지 진입");
        
		return "redirect:/";
    }
}
