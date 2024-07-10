package com.kosa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping(value = "/")
    public String start() { 	
        return "home";
    }
	
	@GetMapping(value = "/follow")
	public String follow() { 	
		return "follow";
	}

}