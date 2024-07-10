package com.kosa.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UserFollowDTO {
	
    private int user_number;
    private String user_id;
    private String profile_picture_url;
    
	private int follower_id; //팔로우(하는 유저)
	private int following_id; //팔로잉(당한 유저)
	private LocalDateTime createdAt;//jdbc에서 사용
	
	
	
	
}
