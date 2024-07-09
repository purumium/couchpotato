package com.kosa.service;


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
    @Transactional
    public void saveReview(ReviewDTO review) {
        reviewMapper.insertReview(review);
    }
}