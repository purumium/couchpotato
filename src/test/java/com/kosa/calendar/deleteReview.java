package com.kosa.calendar;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kosa.service.CalendarService;

import lombok.extern.log4j.Log4j2;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class deleteReview {
   
    @Autowired
    private CalendarService calendarService;
   
    @Test
    public void testConnection() {          
    	Map<String, String> review = new HashMap<String, String>();
		
		// 영화 이름, 리뷰 날짜 넘겨서 삭제하기
		review.put("user_id", "user1");
		review.put("content_name", "Movie D");
		review.put("review_create_at", "2024-07-07");
		
		int count = calendarService.deleteReview(review);
		System.out.println("count : " + count);  
    }
}