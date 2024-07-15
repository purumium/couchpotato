package com.kosa.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.dao.CalendarMapper;
import com.kosa.dto.CalendarDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j  
@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarMapper mapper;


	@Override
	public  Map<String, Object> getTotalReviewsByUser(String userId) {
		Map<String, Object> list = null;
		try {
			list = mapper.getTotalReviewsByUser(userId);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return list;
	}

	
	@Override
	public List<Map<String, Object>> getReviewByDate(String userId) {
		List<Map<String, Object>> list = null;
		try {
			list = mapper.getReviewByDate(userId);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return list;
	}
	
	
	@Override
	public List<CalendarDTO> getContentDetailByDate(CalendarDTO calDto) {
		List<CalendarDTO> list = null;
		try {
			list = mapper.getContentDetailByDate(calDto);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return list;
	}

	@Override
	public int deleteReview(Map<String, String> review) {
		int count = 0;
		try {
			count = mapper.deleteReview(review);		
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return count;
	}
	

	@Override
	public int modifyReview(CalendarDTO calDto) {
		int count = 0;
		try {
			count = mapper.modifyReview(calDto);		
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return count;
	}


	@Override
	public Map<String, List<CalendarDTO>> getAllReviewListByMonth(String userId) {
		Map<String, List<CalendarDTO>> reviewsByMonth = new LinkedHashMap<>();
		
		try {
			List<CalendarDTO> allReviews = mapper.getAllReviewListByMonth(userId);
			 
		    for (CalendarDTO review : allReviews) {
		    	// 1개의 리뷰 데이터에서 month를 가지고 와서
				String month = review.getReview_month();
				
				// month 키가 없으면, 새로운 arrayList를 생성하여 map에 추가
				if(!reviewsByMonth.containsKey(month)) {
					reviewsByMonth.put(month, new ArrayList<CalendarDTO>());
				}
				
				// map안에 있는 ArrayList<CalendarDTO>에 review 데이터를 추가
				List<CalendarDTO> list = reviewsByMonth.get(month); // 새로 생성된 arraylist
				list.add(review);	
			}
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return reviewsByMonth;
	}


}
