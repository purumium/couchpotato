package com.kosa.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kosa.dto.ReviewDTO;
import com.kosa.service.ReviewService;

@RestController
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @PostMapping("/review/save")
    public String saveReview(@RequestBody ReviewDTO review) {
        try {
        	ReviewDTO reviewDTO = new ReviewDTO();
            reviewDTO.setUserNumber(review.getUserNumber());
            reviewDTO.setContentId(review.getContentId());
        	boolean reviewExists = reviewService.checkReviewExists(reviewDTO);

        	if(reviewExists) {
        		return "already";
        	}else {
        		reviewService.saveReview(review);
                return "success";
        	}
            
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
}