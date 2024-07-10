package com.test.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.test.model.MemberVO;

import java.sql.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MemberMapperTests {

    @Autowired
    private MemberMapper membermapper; // MemberMapper.java 인터페이스 의존성 주입

//    // 회원가입 쿼리 테스트 메서드
//    @Test
//    public void memberJoin() throws Exception {
//        MemberVO member = new MemberVO();
//
//
//        // MemberVO 객체의 필드 설정
//        member.setUser_id("new_user");
//        member.setPassword("password123");
//        member.setUsername("김삼식");
//        member.setEmail("newuser@example.com");
//        member.setProfile_picture_url("http://example.com/profile.jpg");
//        member.setDate_of_birth(Date.valueOf("2000-01-01")); // java.sql.Date 사용
//
//        membermapper.memberJoin(member); // 쿼리 메서드 실행
//    }
    
	// 아이디 중복검사
//	@Test
//	public void user_idChk() throws Exception{
//		String id = "test";	// 존재하는 아이디
//		String id2 = "test123";	// 존재하지 않는 아이디
//		membermapper.idCheck(id);
//		membermapper.idCheck(id2);
//	}
	
	
	@Test
	public void memberLogin() throws Exception {
		
		MemberVO member = new MemberVO(); 	// MemberVO 변수 선언 및 초기화
		
//		/* 올바른 아이디 비번 입력 경우 */
//		member.setUser_id("김호영");
//		member.setPassword("test");
		
		/* 올바르지 않은 아이디 비번 입력 경우 */
		member.setUser_id("test123");
		member.setPassword("test123");
		
		membermapper.memberLogin(member);
		System.out.println("결과 값 : " + membermapper.memberLogin(member));
		
	}
}