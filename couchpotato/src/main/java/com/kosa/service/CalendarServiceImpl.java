package com.kosa.service;

import java.util.List;
import java.util.Map;

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


}
