package com.kosa.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kosa.dao.ReviewMapper;
import com.kosa.dto.ReviewDTO;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewMapper reviewMapper;
    
    @Override
    public boolean checkReviewExists(int userId) {
        int count = reviewMapper.countReviewsByUserId(userId);
        return count > 0;
    }
    
    @Override
    public List<ReviewDTO> selectReviews(ReviewDTO reviewDTO) {
        return reviewMapper.selectReviews(reviewDTO);
    }
    

    @Override
    @Transactional
    public void saveReview(ReviewDTO review) {
        reviewMapper.insertReview(review);
    }
}