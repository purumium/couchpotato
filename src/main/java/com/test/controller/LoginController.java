package com.test.controller;

import java.io.IOException;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    //@Autowired
    //private GoogleConnectionFactory googleConnectionFactory;

    //@Autowired
    //private OAuth2Parameters googleOAuth2Parameters;

    // 메인 페이지 이동
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String mainPageGET(Model model) {
        logger.info("메인 페이지 진입");
		return "main";

        // 구글 로그인 URL 생성
       // OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
       // String googleUrl = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

        // URL을 모델에 추가
       // model.addAttribute("google_url", googleUrl);

       // return "main";
    }

    // 구글 로그인 첫 화면 요청 메소드
    //@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
    //public String login(HttpSession session) {
    //    return "redirect:/main";
    //}

    // 구글 Callback 호출 메소드
    //@RequestMapping(value = "/login/oauth2/code/google", method = { RequestMethod.GET, RequestMethod.POST })
    //public String googleCallback(Model model, @RequestParam String code) throws IOException {
    //    System.out.println("여기는 googleCallback");

     //   return "googleSuccess";
    }
