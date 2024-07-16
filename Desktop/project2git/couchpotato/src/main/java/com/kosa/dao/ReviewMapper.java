package com.kosa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kosa.dto.ReviewDTO;

@Mapper
public interface ReviewMapper {
	int countReviewsByUserIdAndContentId(ReviewDTO reviewDTO);
	List<ReviewDTO> selectReviews(ReviewDTO reviewDTO);
    public void insertReview(ReviewDTO review);
    int selectUserNumber(String userId);
}
