package com.kosa.service;

import com.kosa.dto.MemberDTO;

public interface MemberService {
	// 회원가입
	public void memberJoin(MemberDTO member) throws Exception;

	// 아이디 중복 검사
	public int idCheck(String user_id) throws Exception;
	
	// 이메일 중복 검사
	public int emailCheck(String email) throws Exception;

	// 로그인
	public MemberDTO memberLogin(MemberDTO member) throws Exception;

	// 회원정보 수정
	public void updateMypage(MemberDTO member) throws Exception;

	// 비밀번호 변경
	public void updatePassword(MemberDTO member) throws Exception;

	// 회원 탈퇴
	public void memberDelete(MemberDTO member) throws Exception;

	// 회원 정보 조회 (프로필 null)
	public MemberDTO getMemberById(String user_id) throws Exception; // 프로필 사진 없는 users 정보 가져오는 메소드
}