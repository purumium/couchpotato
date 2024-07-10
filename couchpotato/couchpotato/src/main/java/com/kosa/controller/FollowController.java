package com.kosa.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.dto.UserFollowDTO;
import com.kosa.service.FollowService;

@Controller
public class FollowController {

	private static final Logger log = LoggerFactory.getLogger(FollowController.class);
	 // Logger 인스턴스를 생성하여 로그를 기록할 수 있도록 함
	
	@Autowired
	FollowService service;

//	검색했을 때 인간들 리스트 
	@GetMapping(value = "/user_list")
	public String user_list(Model model, @RequestParam int user_number) throws Exception {

		List<UserFollowDTO> user_list = service.user_list(user_number);
		System.out.println("나의 고유번호" + user_number);
		System.out.println("내가 팔로우 한 리스트 : " + user_list);
		model.addAttribute("user_list", user_list);

		return "follow";
	}

	// 내가 팔로우한 사람의 수
	@GetMapping(value = "/follow_count")
	public String following_count(Model model, @RequestParam int user_number) throws Exception {
		// user_number 파라미터를 받아 해당 사용자가 팔로우하는 사람의 수를 가져옴
		int follow_count = service.getfollowings(user_number);
		System.out.println(user_number + "가 팔로우 하는사람 몇 명? : " + follow_count);

		model.addAttribute("follow_count", follow_count);

		return "follow";// 결과를 follow 페이지에 전달
	}

//	내가 팔로우 한 리스트 
	@GetMapping(value = "/follow_list")
	public String follow_list(Model model, @RequestParam int user_number) throws Exception {

		List<UserFollowDTO> follow_list = service.getfollow_list(user_number);
		System.out.println("나의 고유번호" + user_number);
		System.out.println("내가 팔로우 한 리스트 : " + follow_list);
		model.addAttribute("follow_list", follow_list);

		return "follow";
	}

//	내가 팔로우 한 리스트 
	@GetMapping(value = "/follow_lists")
	public String follow_lists(Model model, @RequestParam int user_number) throws Exception {

		List<UserFollowDTO> follow_list = service.getfollow_list(user_number);
		System.out.println("나의 고유번호" + user_number);
		System.out.println("내가 팔로우 한 리스트 : " + follow_list);
		model.addAttribute("follow_list", follow_list);

		List<UserFollowDTO> following_list = service.getfollowing_list(user_number);
		System.out.println("나의 고유번호" + user_number);
		System.out.println("나를 팔로잉 한 리스트 : " + following_list);
		model.addAttribute("following_list", following_list);

		return "follow";
	}

	// 나를 팔로잉한 사람의 수
	@GetMapping(value = "/following_count")
	private String follow_count(Model model, @RequestParam int user_number) throws Exception {
		int following_count = service.getfollowers(user_number);
		System.out.println(user_number + "를 팔로우 하는사람 몇 명? : " + following_count);

		model.addAttribute("following_count", following_count);

		return "follow";
	}

//	나를 팔로잉 한 인간 리스트 
	@GetMapping(value = "/following_list")
	public String following_list(Model model, @RequestParam int user_number) throws Exception {

		List<UserFollowDTO> following_list = service.getfollowing_list(user_number);
		System.out.println("나의 고유번호" + user_number);
		System.out.println("나를 팔로잉 한 리스트 : " + following_list);
		model.addAttribute("following_list", following_list);

		return "follow";
	}

	// 해당 사용자에 대한 팔로우 실행
	@PostMapping(value = "/follow")
	@ResponseBody
	public String follow(@RequestParam int user_number, @RequestParam int following_id) throws Exception {
	    UserFollowDTO ufdto = new UserFollowDTO();
	    ufdto.setFollower_id(user_number);
	    ufdto.setFollowing_id(following_id);
	    
	    //맞팔확인
	    int followStatus = service.checkFollowStatus(ufdto);
	    if (followStatus > 0) {//팔로우면
	        service.getunfollow(ufdto);//언팔
	        return "unfollow";//언팔반환
	    } else {
	        service.getfollow(ufdto);//언팔상태면
	        return "follow";//팔로우로 반환
	    }
	}


//	 해당 사용자에 대한 팔로우 취소
	@GetMapping(value = "/unfollow")
	public String unfollow(Model model) throws Exception {
		UserFollowDTO fdto = new UserFollowDTO();
		int unfollow = service.getunfollow(fdto);
		System.out.println("팔로우취소 한 인원 : " + unfollow + fdto.getUser_number());

		model.addAttribute("unfollow", unfollow);

		return "follow";
	}

}