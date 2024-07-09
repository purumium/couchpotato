package com.kosa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kosa.dto.FollowDTO;
import com.kosa.dto.UserFollowDTO;

@Mapper
public interface FollowMapper {

	//전체 사용자 리스트
	public List<UserFollowDTO> user_list(int user_number);

	// 내가 팔로우 카운트
	public int getfollowings(int user_number);

	// 팔로우 리스트
	public List<UserFollowDTO> getfollow_list(int user_number);

	// 나를 팔로잉 카운트
	public int getfollowers(int user_number);

	// 나를 팔로잉 리스트
	public List<UserFollowDTO> getfollowing_list(int user_number);

	//맞팔확인
	public int checkFollowStatus(UserFollowDTO ufdto);

	// 팔로우하기
	public int follow(UserFollowDTO ufdto);
	
	// 특정사용자 언팔로우
	public int unfollow(UserFollowDTO ufdto);


	



}
