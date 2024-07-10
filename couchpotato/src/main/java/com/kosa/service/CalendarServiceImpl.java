package com.kosa.service;

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
	public List<CalendarDTO> getAllReviewList(String userId) {
		List<CalendarDTO> list = null;
		try {
			list = mapper.getAllReviewList(userId);
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


}
