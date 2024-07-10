package com.kosa.service;

import java.util.List;

import com.kosa.dto.ReviewDTO;

public interface ReviewService {
	List<ReviewDTO> selectReviews(ReviewDTO reviewDTO);
	public boolean checkReviewExists(ReviewDTO reviewDTO); 
    public void saveReview(ReviewDTO review);
}
