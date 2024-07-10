package com.kosa.service;

import java.util.List;

import com.kosa.dto.FollowDTO;
import com.kosa.dto.UserFollowDTO;

public interface FollowService {

	
	//전체 인간수
	public List<UserFollowDTO> user_list(int user_number);
	
	//내가 팔로우 한 인간 수 
	public int getfollowings(int user_number) throws Exception;
	
	//내가 팔로우 한 인간 리스트
	public List<UserFollowDTO> getfollow_list(int user_number) throws Exception;
	
	//나를 팔로잉하는 인간 수 
	public int getfollowers(int user_number)throws Exception;

	//나를 팔로잉하는 인간 수 
	public List<UserFollowDTO> getfollowing_list(int user_number) throws Exception;
	
	//팔로우체크 
	public int checkFollowStatus(UserFollowDTO ufdto);

	//특정사용자 팔로우 하기
	public int getfollow(UserFollowDTO ufdto)throws Exception;

	//특정사용자 언팔로우 
	public int getunfollow(UserFollowDTO ufdto) throws Exception;


	




	
}
