package com.kosa.service;

import java.util.List;
import java.util.Map;

import com.kosa.dto.CalendarDTO;

public interface CalendarService {

	// getTotalReviewsByUser
	public Map<String, Object> getTotalReviewsByUser(String userId);
	
	// getReviewByDate
	public List<Map<String, Object>> getReviewByDate(String userId);

	// getAllReviewList
	public List<CalendarDTO> getAllReviewList(String userId);
	
	// getContentDetailByDate
	public List<CalendarDTO> getContentDetailByDate(CalendarDTO calDto);

	// deleteReview
	public int deleteReview(Map<String, String> review);

	// modifyReview
	public int modifyReview(CalendarDTO calDto);

	
}
