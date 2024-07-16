package com.kosa.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kosa.dto.CalendarDTO;


@Mapper
public interface CalendarMapper {
	
	// getTotalReviewsByUser
	public Map<String, Object> getTotalReviewsByUser(String userId);

	// getReviewByDate
	public List<Map<String, Object>> getReviewByDate(String userId);
	
	// getAllReviewListByMonth
	public List<CalendarDTO> getAllReviewListByMonth(String userId);
	
	// getReviewByDate
	public List<CalendarDTO> getContentDetailByDate(CalendarDTO calDto);

	// deleteReview
	public int deleteReview(Map<String, String> review);

	// modifyReview
	public int modifyReview(CalendarDTO calDto);
}
