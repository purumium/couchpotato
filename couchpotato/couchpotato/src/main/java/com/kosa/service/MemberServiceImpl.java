package com.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.test.mapper.MemberMapper;
import com.test.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    MemberMapper membermapper;

    @Override
    public void memberJoin(MemberVO member) throws Exception {
        membermapper.memberJoin(member);
    }

    @Override
    public int idCheck(String user_id) throws Exception {
        return membermapper.idCheck(user_id);
    }

    @Override
    public MemberVO memberLogin(MemberVO member) throws Exception {
        return membermapper.memberLogin(member);
    }

    @Override
    public void updateMypage(MemberVO member) throws Exception {
        membermapper.updateMypage(member);
    }

    @Override
    public void updatePassword(MemberVO member) throws Exception {
        membermapper.updatePassword(member);
    }

    @Override
    public void memberDelete(MemberVO member) throws Exception {
        membermapper.memberDelete(member);
    }
}