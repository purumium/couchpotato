
package com.kosa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.dao.MemberMapper;
import com.kosa.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    MemberMapper memberMapper;

    @Override
    public void memberJoin(MemberDTO member) throws Exception {
        memberMapper.memberJoin(member);
    }

    @Override
    public int idCheck(String user_id) throws Exception {
        return memberMapper.idCheck(user_id);
    }
    
    @Override
    public int emailCheck(String email) throws Exception {
    	return memberMapper.emailCheck(email);
    }
    
    @Override
    public MemberDTO memberLogin(MemberDTO member) throws Exception {
        return memberMapper.memberLogin(member);
    }

    @Override
    public void updateMypage(MemberDTO member) throws Exception {
        memberMapper.updateMypage(member);
    }

    @Override
    public void updatePassword(MemberDTO member) throws Exception {
        memberMapper.updatePassword(member);
    }

    @Override
    public void memberDelete(MemberDTO member) throws Exception {
        memberMapper.memberDelete(member);
    }

    @Override
    public MemberDTO getMemberById(String user_id) throws Exception {
    	MemberDTO member = memberMapper.getMemberById(user_id);
        if (member.getProfile_picture_url() == null || member.getProfile_picture_url().isEmpty()) {
            member.setProfile_picture_url("/resources/images/nullProfile.png");
        }
        return member;
    }
}
