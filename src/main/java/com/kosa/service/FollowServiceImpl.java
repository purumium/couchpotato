package com.kosa.service;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.kosa.dao.FollowMapper;
import com.kosa.dto.UserFollowDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j  
@Service
public class FollowServiceImpl implements FollowService {

	@Autowired
	private FollowMapper mapper;
	private int following_id;
	private int follow_id;


    // 전체 사용자 리스트
    @Override
    public List<UserFollowDTO> user_list(int user_number) {
        List<UserFollowDTO> user_list;
        try {
            user_list = mapper.user_list(user_number);
        } catch (Exception e) {
            log.info(e.getMessage());
            throw e;
        }
        return user_list;
    }
    
    // 내가 팔로우한 사람 수 가져오기
    @Override
    public int getfollowings(int user_number) throws Exception {
        int fcount; 
        try {
            fcount = mapper.getfollowings(user_number);
        } catch (Exception e) {
            log.info(e.getMessage());
            throw e;
        }
        return fcount;
    }

    // 내가 팔로우한 리스트
    @Override
    public List<UserFollowDTO> getfollow_list(int user_number) throws Exception {
        List<UserFollowDTO> follow_list;
        try {
            follow_list = mapper.getfollow_list(user_number);
        } catch (Exception e) {
            log.info(e.getMessage());
            throw e;
        }
        return follow_list;
    }

    // 나를 팔로잉한 사람 수 가져오기
    @Override
    public int getfollowers(int user_number) throws Exception {
        int fcount; 
        try {
            fcount = mapper.getfollowers(user_number);
        } catch (Exception e) {
            log.info(e.getMessage());
            throw e;
        }
        return fcount;
    }

    // 나를 팔로잉한 리스트
    @Override
    public List<UserFollowDTO> getfollowing_list(int user_number) throws Exception {
        List<UserFollowDTO> following_list;
        try {
            following_list = mapper.getfollowing_list(user_number);
        } catch (Exception e) {
            log.info(e.getMessage());
            throw e;
        }
        return following_list;
    }
    
    // 맞팔 확인
    @Override
    public int checkFollowStatus(UserFollowDTO ufdto) {
        int isfollow;
        try {
            isfollow = mapper.checkFollowStatus(ufdto);
        } catch (Exception e) {
            log.info(e.getMessage());
            throw e;
        }
        return isfollow;
    }

    // 팔로우
    @Override
    public int getfollow(UserFollowDTO ufdto) throws Exception {
        int follow;
        try {
            follow = mapper.follow(ufdto);
        } catch (Exception e) {
            log.info(e.getMessage());
            if (e.getCause() instanceof SQLIntegrityConstraintViolationException) {
                throw new ResponseStatusException(HttpStatus.CONFLICT, "이미 팔로우 한 사용자입니다.");
            }
            throw e; // 다른 예외는 그대로 던짐
        }
        return follow;
    }
    

    // 언팔로우
    @Override
    public int getunfollow(UserFollowDTO ufdto) throws Exception {
        int unfollow;
        try {
            unfollow = mapper.unfollow(ufdto);
        } catch (Exception e) {
            log.info(e.getMessage());
            throw e;
        }
        return unfollow;
    }


}
