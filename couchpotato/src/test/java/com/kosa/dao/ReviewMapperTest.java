package com.kosa.dao;

import java.util.List;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kosa.dto.ReviewDTO;
import com.kosa.service.ReviewService;

import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReviewMapperTest {
	@Autowired
    private ReviewService reviewService;
    @Test
    public void testSaveReview() {
    	 
        // 준비 (Arrange)
        ReviewDTO reviewDTO = new ReviewDTO();
        reviewDTO.setUserId(1234);
        reviewDTO.setContentName("Test Content");
        reviewDTO.setReviewContent("This is a test review.");
        reviewDTO.setRating(5);
        reviewDTO.setImgurl("http://example.com/image.jpg");
        
        // 동작 (Act)
        reviewService.saveReview(reviewDTO);


    }
}
