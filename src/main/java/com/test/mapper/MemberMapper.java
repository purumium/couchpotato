package com.test.mapper;

import com.test.model.MemberVO;

public interface MemberMapper {

    // 회원가입
    public void memberJoin(MemberVO member);

    // 아이디 중복 검사
    public int idCheck(String user_id);

    // 로그인
    public MemberVO memberLogin(MemberVO member);

    // 회원정보 수정
    public void updateMypage(MemberVO member);

    // 비밀번호 변경
    public void updatePassword(MemberVO member);

    // 회원 탈퇴
    public void memberDelete(MemberVO member);
}