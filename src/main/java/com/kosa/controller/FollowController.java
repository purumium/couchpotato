package com.kosa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.dto.MemberDTO;
import com.kosa.dto.UserFollowDTO;
import com.kosa.service.FollowService;

@Controller
public class FollowController {

	@Autowired
	FollowService service;

	@GetMapping(value = "/test")
	public String test(Model model, HttpSession session) throws Exception {
		MemberDTO loginMember = (MemberDTO) session.getAttribute("member");
		int user_number = loginMember.getUser_number();
		String loginMemberId = loginMember.getUser_id().toString();
		System.out.println(user_number); // 13
		System.out.println(loginMemberId); // test
//		model.addAttribute("loginMemberId", loginMemberId);

		// 본인 제외 전체 사용자 리스트 가져오기--ㅇ
		List<UserFollowDTO> user_list = service.user_list(user_number);
		System.out.println("--전체 리스트 가져오기" + user_list);

		// 내가 팔로우한 사람의 수
		int follow_count = service.getfollowings(user_number);
		System.out.println("--내가 팔로우 한 사람의 수" + follow_count);

		// 내가 팔로우 한 사람 리스트
		List<UserFollowDTO> follow_list = service.getfollow_list(user_number);
		System.out.println("--내가 팔로우 한 사람 리스트" + follow_list);

		// 나를 팔로우한 사람의 수
		int following_count = service.getfollowers(user_number);
		System.out.println("--나를 팔로우 한 사람의 수" + following_count);

		// 나를 팔로우 한 사람 리스트
		List<UserFollowDTO> following_list = service.getfollowing_list(user_number);
		System.out.println("--나를 팔로우 한 사람 리스트" + following_list);

		return "test";
	}

	// 특정 사용자를 제외한 전체 리스트 가져오기
	@GetMapping(value = "/user_list")
	public String user_list(Model model, @RequestParam int user_number) throws Exception {
		// 전체 사용자 리스트 가져오기
		List<UserFollowDTO> user_list = service.user_list(user_number);
		System.out.println("user_list 나의 고유번호" + user_number);
		System.out.println("user_list 나를 제외한 리스트 : " + user_list);
		model.addAttribute("user_list", user_list);

		// 맞팔 확인
		for (UserFollowDTO user : user_list) {
			UserFollowDTO ufdto = new UserFollowDTO();
			ufdto.setFollower_id(user_number);
			ufdto.setFollowing_id(user.getUser_number()); // Set following_id to each user in the list

			int followStatus = service.checkFollowStatus(ufdto);
			if (followStatus == 1) {
				System.out.println("Already following user: " + user.getUser_number());
			} else {
				System.out.println("Not following user: " + user.getUser_number());
			}
		}
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

	// 내가 팔로우 한 리스트
	@GetMapping(value = "/follow_list")
	public String follow_list(Model model, @RequestParam int user_number) throws Exception {

		List<UserFollowDTO> follow_list = service.getfollow_list(user_number);
		System.out.println("나의 고유번호" + user_number);
		System.out.println("내가 팔로우 한 리스트 follow_list : " + follow_list);
		model.addAttribute("follow_list", follow_list);

		return "follow";
	}

	// 나를 팔로잉한 사람의 수
	@GetMapping(value = "/test2")
	private String follow_count(Model model, @RequestParam int user_number) throws Exception {
		user_number = 15;
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
		System.out.println("나를 팔로잉 한 리스트 following_list : " + following_list);
		model.addAttribute("following_list", following_list);

		return "follow";
	}

	// JSON 데이터 반환
	@GetMapping(value = "/follow_list_json")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getFollowList(HttpSession session) throws Exception {
		
		MemberDTO loginMember = (MemberDTO) session.getAttribute("member");
		int user_number = loginMember.getUser_number();
		String loginMemberId = loginMember.getUser_id().toString();
		System.out.println(user_number); // 13
		System.out.println(loginMemberId); // test
		
		Map<String, Object> response = new HashMap<>();

		List<UserFollowDTO> follow_list = service.getfollow_list(user_number);
		List<UserFollowDTO> following_list = service.getfollowing_list(user_number);
		List<UserFollowDTO> user_list = service.user_list(user_number);

		response.put("follow_list", follow_list); // 내가 팔로우 하는 사람
		response.put("following_list", following_list); // 내가 팔로우를 당함
		response.put("user_list", user_list);
		response.put("uid",user_number);
		return ResponseEntity.ok(response);
	}

	// 팔로우 추가 및 취소
	@PostMapping(value = "/isfollow")
	@ResponseBody
	public ResponseEntity<String> isFollow(@RequestBody Map<String, Integer> requestBody) throws Exception {
		int user_number = requestBody.get("user_number");
		int follower_id = requestBody.get("follower_id");
		int following_id = requestBody.get("following_id");

		UserFollowDTO ufdto = new UserFollowDTO();
		ufdto.setFollower_id(follower_id);
		ufdto.setFollowing_id(following_id);
		ufdto.setUser_number(user_number);

		System.out.println("isfollow follower_id: " + follower_id);
		System.out.println("isfollow following_id: " + following_id);
		System.out.println("isfollow user_number: " + user_number);

		// 맞팔 확인
		int followStatus = service.checkFollowStatus(ufdto);

		System.out.println("ufdto" + ufdto);

		if (followStatus == 1) {
			// 팔로우 상태면 언팔로우
			service.getunfollow(ufdto);
			return ResponseEntity.ok("unfollow");
		} else {
			// 팔로우 상태가 아니면 팔로우
			service.getfollow(ufdto);
			return ResponseEntity.ok("follow");
		}
	}

	// 팔로우
	@PostMapping(value = "/follow")
	@ResponseBody
	public ResponseEntity<String> follow(@RequestBody Map<String, Integer> requestBody) throws Exception {
		int user_number = requestBody.get("user_number");
		int follower_id = requestBody.get("follower_id");
		int following_id = requestBody.get("following_id");

		// following_id가 0인 경우 잘못된 요청으로 간주
		if (following_id == 0) {
			return ResponseEntity.badRequest().body("Invalid following_id");
		}

		UserFollowDTO ufdto = new UserFollowDTO();
		ufdto.setFollower_id(follower_id);
		ufdto.setFollowing_id(following_id);
		ufdto.setUser_number(user_number);

		System.out.println("follow에 있는 정보" + "user_number : " + user_number + ", follower_id : " + follower_id
				+ ", following_id : " + following_id);

		service.getfollow(ufdto);
		return ResponseEntity.ok("follow");
	}

	// 팔로우 취소
	@PostMapping(value = "/unfollow")
	@ResponseBody
	public ResponseEntity<String> unfollow(@RequestBody Map<String, Integer> requestBody) throws Exception {
		int user_number = requestBody.get("user_number");
		int follower_id = requestBody.get("follower_id");
		int following_id = requestBody.get("following_id");

		System.out.println("unfollow에 있는 정보 user_number : " + user_number + ", follower_id : " + follower_id
				+ ", following_id : " + following_id);

		// following_id가 0인 경우 잘못된 요청으로 간주
		if (following_id == 0) {
			return ResponseEntity.badRequest().body("Invalid following_id");
		}

		UserFollowDTO ufdto = new UserFollowDTO();
		ufdto.setFollower_id(follower_id);
		ufdto.setFollowing_id(following_id);
		ufdto.setUser_number(user_number);

		System.out.println("unfollow 요청 수신됨 - user_number: " + user_number + ", follower_id: " + follower_id
				+ ", following_id: " + following_id);

		service.getunfollow(ufdto);
		return ResponseEntity.ok("unfollow");
	}

}// class
