package com.kosa.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kosa.dto.ReviewDTO;

@Mapper
public interface ReviewMapper {

    public void insertReview(ReviewDTO review);
}
