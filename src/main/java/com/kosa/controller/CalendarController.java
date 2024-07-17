package com.kosa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.dto.CalendarDTO;
import com.kosa.dto.MemberDTO;
import com.kosa.service.CalendarService;
import com.kosa.service.FollowService;

@Controller
public class CalendarController {

	@Autowired
	private CalendarService calendarService;
	
	@Autowired
	private FollowService followService;

	// 캘린더를 띄웠을 때의 첫 화면: 리뷰 총 개수, 이름, 날짜별로 작성한 리뷰 개수 
	@GetMapping("/calendar")
	public String viewCalendar(Model model, HttpSession session) throws Exception {
		MemberDTO loginMember = (MemberDTO)session.getAttribute("member");
		
		if (loginMember == null) { // 세션에 member 속성이 없으면 로그인 페이지로 리다이렉트
		        return "redirect:/";
		    }
		
		String userId = loginMember.getUser_id();	
		int userNumber = loginMember.getUser_number();
		
		// 1. 내가 review를 작성한 것이 총 몇 개인지와 유저 이름에 대한 정보
		Map<String, Object> totalReviews = calendarService.getTotalReviewsByUser(userId);
	    if (totalReviews == null) {
	        totalReviews = new HashMap<>();
	        totalReviews.put("TOTAL_REVIEWS", 0); // 리뷰가 없을 때 기본값 설정
	    }
		
        // 2. 각 날짜 별로 몇 개의 review를 작성했는지에 대한 정보(count 개수, 날짜 정보 가지고 오기)
        List<Map<String, Object>> reviewsByDate = calendarService.getReviewByDate(userId);
        
        // 3. 팔로우, 팔로잉 총 정보
        int follower_count = followService.getfollowers(userNumber);
        int following_count = followService.getfollowings(userNumber);

        System.out.println("userNumber : " + userNumber);
        System.out.println(userNumber + ") 내가 팔로우 하는사람 몇 명? : " + follower_count);
		System.out.println(userNumber+ ") 나를 팔로우 하는사람 몇 명? : " + following_count);

		model.addAttribute("follower_count", follower_count);
		model.addAttribute("following_count", following_count);
        
        model.addAttribute("loginMember", loginMember);
        model.addAttribute("reviewsByDate", reviewsByDate);
        model.addAttribute("totalReviews", totalReviews);
        
		return "calendar";  // calendar.jsp로 이동
		
	}
	
	
	// 월별로 전체 리뷰를 가지고 옴
	@GetMapping("/myreviewlistbymonth")
	public String getAllReviewbymonth(Model model, HttpSession session) {
		String userId = ( (MemberDTO)session.getAttribute("member") ).getUser_id();
		Map<String, List<CalendarDTO>> reviewsByMonth = calendarService.getAllReviewListByMonth(userId);

	    model.addAttribute("reviewsByMonth", reviewsByMonth);
	    
	    return "allReviewList"; // allReviewList.jsp를 반환
	}
	
	
	
	// 각 날짜에 맞는 상세 리뷰 정보
	@GetMapping("/getcontentdetail")
	@ResponseBody
	public List<CalendarDTO> getContentDetail(@RequestParam("date") String reviewCreateAt, HttpSession session) {
		// userid와 리뷰 날짜를 넘겨서 콘텐츠 상세 정보 가지고 오기
		String userId = ( (MemberDTO)session.getAttribute("member") ).getUser_id();
		
		CalendarDTO calDto = new CalendarDTO();
		calDto.setUser_id(userId);
		calDto.setReview_create_at(reviewCreateAt);
		
	    List<CalendarDTO> calendarlist = calendarService.getContentDetailByDate(calDto);
	    
	    System.out.println("유저 아이디 : " + userId);
		System.out.println("------- 가져온 날짜별 상세 정보 -----");
	    for (CalendarDTO c : calendarlist) {
			System.out.println(c.getContent_name() + ", " + c.getRating() + ", " + c.getReview_count_byname() );
		}
	    
	    return calendarlist; // JSON 형태로 반환됨
	}
	
	
	
	@PostMapping("/deletereview")
	@ResponseBody
	public ResponseEntity<Map<String, String>> deleteReview(@RequestBody Map<String, String> review, HttpSession session) {
		String userId = ( (MemberDTO)session.getAttribute("member") ).getUser_id();
		// 영화 이름, 리뷰 날짜 넘겨서 삭제하기
		review.put("user_id", userId);
		
		int count = calendarService.deleteReview(review);

		Map<String, String> response = new HashMap<>();
	    if(count > 0) {
	        response.put("message", "리뷰가 성공적으로 삭제 되었습니다.");
	        response.put("review_create_at", review.get("review_create_at"));  // 삭제 후 다시 화면 업데이트
	        
	        return ResponseEntity.ok(response);
		} else {
	        response.put("message", "리뷰 삭제에 실패하였습니다!");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}
	
	
	@PostMapping("/modifyreview")
	@ResponseBody
	public ResponseEntity<Map<String, String>> modifyReview(@RequestBody CalendarDTO calDto, HttpSession session) {
		String userId = ( (MemberDTO)session.getAttribute("member") ).getUser_id();
		// 영화 리뷰 수정하기
		calDto.setUser_id(userId);

		int count = calendarService.modifyReview(calDto);
		
		Map<String, String> response = new HashMap<>();
		if(count > 0) {
	        response.put("message", "리뷰가 성공적으로 수정 되었습니다.");
	        response.put("review_create_at", calDto.getReview_create_at());  // 수정 후 다시 화면 업데이트
		
	        return ResponseEntity.ok(response);
		} else {
			response.put("message", "리뷰 삭제에 실패하였습니다!");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}

	}
	
	

	
}