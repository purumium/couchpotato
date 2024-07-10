package com.test.service;

import com.test.model.MemberVO;

public interface MemberService {
    public void memberJoin(MemberVO member) throws Exception;
    public int idCheck(String user_id) throws Exception;
    public MemberVO memberLogin(MemberVO member) throws Exception;
    public void updateMypage(MemberVO member) throws Exception;
    public void updatePassword(MemberVO member) throws Exception;
    public void memberDelete(MemberVO member) throws Exception;
}