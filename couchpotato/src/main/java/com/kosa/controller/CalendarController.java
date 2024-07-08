package com.kosa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.kosa.service.CalendarService;

@Controller
public class CalendarController {

	@Autowired
	private CalendarService calendarService;

	String userId = "user1"; // user1의 ID
	
	
	// 캘린더를 띄웠을 때의 첫 화면: 리뷰 총 개수, 이름, 날짜별로 작성한 리뷰 개수 
	@GetMapping("/calendar")
	public String viewCalendar(Model model) {
		// 1. 내가 review를 작성한 것이 총 몇 개인지와 유저 이름에 대한 정보
		Map<String, Object> totalReviews = calendarService.getTotalReviewsByUser(userId);
		
        // 2. 각 날짜 별로 몇 개의 review를 작성했는지에 대한 정보(count 개수, 날짜 정보 가지고 오기)
        List<Map<String, Object>> reviewsByDate = calendarService.getReviewByDate(userId);
        
        model.addAttribute("reviewsByDate", reviewsByDate);
        model.addAttribute("totalReviews", totalReviews);
        
		return "calendar";  // calendar.jsp로 이동
	}
	
	
	// 전체 리뷰를 가지고 옴
	@GetMapping("/myreviewlist")
	public String getAllReviewList(Model model) {
	    List<CalendarDTO> allReviewList = calendarService.getAllReviewList(userId);
	    
	    model.addAttribute("allReviewList", allReviewList);
	    return "allReviewList"; // reviewlist.jsp를 반환
	}
	
	
	// 각 날짜에 맞는 상세 리뷰 정보
	@GetMapping("/getcontentdetail")
	@ResponseBody
	public List<CalendarDTO> getContentDetail(@RequestParam("date") String reviewCreateAt) {
		System.out.println("가져올 리뷰 날짜 정보 : " + reviewCreateAt);
		
		// userid와 리뷰 날짜를 넘겨서 콘텐츠 상세 정보 가지고 오기
		CalendarDTO calDto = new CalendarDTO();
		calDto.setUser_id(userId);
		calDto.setReview_create_at(reviewCreateAt);
		
	    List<CalendarDTO> calendarlist = calendarService.getContentDetailByDate(calDto);
	    
	    for (CalendarDTO c : calendarlist) {
			System.out.println(c.getContent_name() + ", " + c.getRating());
		}
	    
	    return calendarlist; // JSON 형태로 반환됨
	}
	
	@PostMapping("/deletereview")
	@ResponseBody
	public ResponseEntity<Map<String, String>> deleteReview(@RequestBody Map<String, String> review) {
		// 영화 이름, 리뷰 날짜 넘겨서 삭제하기
		review.put("user_id", userId);
		
		int count = calendarService.deleteReview(review);

		Map<String, String> response = new HashMap<>();
	    if(count > 0) {
	        response.put("message", "리뷰가 성공적으로 삭제 되었습니다.");
	        response.put("redirectUrl", "/calendar");
	        return ResponseEntity.ok(response);
		} else {
	        response.put("message", "리뷰 삭제에 실패하였습니다!");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}
	
}