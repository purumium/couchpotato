package com.kosa.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString // 자동 문자열 반환
@NoArgsConstructor //
@AllArgsConstructor // 매개변수 생성자 자동 생성

public class FollowDTO {

	private int follower_id; //팔로우(하는 유저)
	private int following_id; //팔로잉(당한 유저)
	private LocalDateTime createdAt;//jdbc에서 사용

	private String user_number;//user_number를 가져와서 프로필사진,이름 가져 올 예정
	private String username;
	private String profile_picture_url;
	
	
	
	
}

