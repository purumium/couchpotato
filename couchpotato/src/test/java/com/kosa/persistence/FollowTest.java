package com.kosa.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kosa.dao.FollowMapper;
import com.kosa.dto.UserFollowDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class FollowTest {

	@Autowired
	private FollowMapper fm;

	@Test
	public void followTest() throws Exception {

		int user_number = 10;
	
		//나를 제외한 인간들 조회
		List<UserFollowDTO> user_list = fm.user_list(user_number);
		System.out.println("user_list 테스트 : " + user_list);		
		
//		내가 팔로우 count
		int follownum = fm.getfollowings(user_number);
		System.out.println("getfollowings 테스트 : " + follownum);
		
		
		//내가 팔로우하는 사람 리스트 조회
		List<UserFollowDTO> follow_list = fm.getfollow_list(user_number); 
		System.out.println("follow_list 테스트 : " + follow_list);		
				
	        
//		나를팔로잉 확인 count
		int followingnum = fm.getfollowers(user_number);
		System.out.println("getfollowers 테스트 : " + followingnum);
		
		
		//나를 팔로잉 하는 사람 리스트 조회
		List<UserFollowDTO> following_list = fm.getfollow_list(user_number); 
		System.out.println("following_list 테스트 : " + following_list);		
				
		
		//맞팔 유무 테스트
//		int following_id = 6;//팔로우 하는사람
//		UserFollowDTO ufdto = new UserFollowDTO();
//		ufdto.setFollower_id(user_number);
//		ufdto.setFollowing_id(following_id);
//		System.out.println("user_number : "+user_number);
//		System.out.println("following_id : "+following_id);
//		
//		int result = fm.checkFollowStatus(ufdto);
//		System.out.println("0이면 해당값 있음, 1이면 해당값 없음 : "+result);
//		if (result == 0) {
//			System.out.println(following_id+"가 "+user_number+"를 "+"팔로우 함(팔로우상태)");
//		}else {
//			System.out.println(following_id+"가 "+user_number+"를 "+"팔로우 하고 있지 않음(언팔상태)");
//		}
		
		
//		 특정 사용자 팔로우 하기 (insert)
		UserFollowDTO ufdto = new UserFollowDTO();
		int following_id = 2;
		ufdto.setFollower_id(user_number);
		ufdto.setFollowing_id(following_id);
		System.out.println("insertFollow에 담겨있는값 : " + ufdto);
		System.out.println("유저아이디"+ufdto.getFollower_id());
		System.out.println("팔로우아이디"+ufdto.getFollowing_id());
		int follow = fm.follow(ufdto);
		System.out.println("follow 완료 : " + follow);		
//		
		
//		특정 사용자 언팔로우 하기 (delete)
//		UserFollowDTO ufdto = new UserFollowDTO();	
//		int following_id = 8;
//
//		ufdto.setFollower_id(user_number);
//		ufdto.setFollowing_id(following_id);
//		
//		System.out.println("insertFollow에 담겨있는값 : " + ufdto);
//		System.out.println("유저아이디"+ufdto.getFollower_id());
//		System.out.println("팔로우아이디"+ufdto.getFollowing_id());
//		
//		int num = fm.unfollow(ufdto);
//		System.out.println("Unfollow 테스트 성공 : "+ num);
//	
		
	}//FollowTest

}//class
