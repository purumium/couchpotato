package com.kosa.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberDTO {
    private int user_number; // 유저 넘버
    private String user_id; // 아이디
    private String password; // 비번
    private String username; // 이름
    private String email; // 이메일
    private String profile_picture_url; // 프로필 사진 URL
    private Date date_of_birth; // 생년월일 
}