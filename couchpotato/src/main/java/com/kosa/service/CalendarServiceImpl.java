package com.kosa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.dao.CalendarMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j  
@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarMapper mapper;

	@Override
	public void getList() throws Exception {
		try {
			mapper.getList();
		} catch (Exception e) {
//			log.info(e.getMessage());
			throw e;
		}
	}


}
