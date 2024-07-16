package com.kosa.dao;

import com.kosa.dto.MemberDTO;

public interface MemberMapper {

	// 회원가입
	public void memberJoin(MemberDTO member);

	// 아이디 중복 검사
	public int idCheck(String user_id);
	
	// 이메일 중복 검사
	public int emailCheck(String email);

	// 로그인
	public MemberDTO memberLogin(MemberDTO member);

	// 회원정보 수정
	public void updateMypage(MemberDTO member);

	// 비밀번호 변경
	public void updatePassword(MemberDTO member);

	// 회원 탈퇴
	public void memberDelete(MemberDTO member);

	// 회원 정보 조회 (프로필 null)
	public MemberDTO getMemberById(String user_id);
}