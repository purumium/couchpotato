package com.kosa.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kosa.dto.MemberDTO;
import com.kosa.service.MemberService;

import java.io.File;
import java.io.IOException;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @Autowired
    private MemberService memberservice;

    @Autowired
    private BCryptPasswordEncoder pwEncoder;

    // 회원가입 페이지 이동
    @RequestMapping(value = "join", method = RequestMethod.GET)
    public void joinGET() {
        logger.info("회원가입 페이지 진입");
    }

    /* 회원가입 */
    @RequestMapping(value = "/join", method = RequestMethod.POST)
    public String joinPOST(MemberDTO member, RedirectAttributes rttr) throws Exception {
        String rawPw = member.getPassword();
        if (rawPw == null || rawPw.isEmpty()) {
            rttr.addFlashAttribute("msg", "비밀번호를 입력하세요.");
            return "redirect:/member/join";
        }
        String encodePw = pwEncoder.encode(rawPw);
        member.setPassword(encodePw);

        memberservice.memberJoin(member);

        rttr.addFlashAttribute("msg", "회원가입이 완료되었습니다.");
        return "redirect:/main";
    }

    // 로그인 페이지 이동
    @RequestMapping(value = "login", method = RequestMethod.GET)
    public void loginGET() {
        logger.info("로그인 페이지 진입");
    }

    // 아이디 중복 검사
    @RequestMapping(value = "/user_idChk", method = RequestMethod.POST)
    @ResponseBody
    public String user_idChkPOST(String user_id) throws Exception {
        logger.info("user_idChk() 진입");

        int result = memberservice.idCheck(user_id);
        logger.info("결과값 = " + result);

        if (result != 0) {
            return "fail"; // 중복 아이디가 존재
        } else {
            return "success"; // 중복 아이디 X
        }
    } // user_idChkPOST() 종료

    /* 로그인 */
    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String loginPOST(HttpServletRequest request, MemberDTO member, RedirectAttributes rttr) throws Exception {
        HttpSession session = request.getSession();
        String rawPw = member.getPassword();
        if (rawPw == null || rawPw.isEmpty()) {
            rttr.addFlashAttribute("msg", "비밀번호를 입력하세요.");
            return "redirect:/member/login";
        }
        String encodePw = "";

        MemberDTO loginVo = memberservice.memberLogin(member); // 제출한 아이디와 일치하는 아이디가 있는지

        if (loginVo != null) { // 일치하는 아이디 존재시
            encodePw = loginVo.getPassword(); // 데이터베이스에 저장된 인코딩된 비밀번호

            if (pwEncoder.matches(rawPw, encodePw)) { // 비밀번호 일치여부 판단
                loginVo.setPassword(encodePw); // 인코딩된 비밀번호 정보 저장
                session.setAttribute("member", loginVo); // session에 사용자의 정보 저장
                rttr.addFlashAttribute("msg", "로그인 성공");
                return "redirect:/main"; // 메인페이지 이동
            } else {
                rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
                return "redirect:/member/login"; // 로그인 페이지 이동
            }
        } else { // 일치하는 아이디가 존재하지 않을 시 (로그인 실패)
            rttr.addFlashAttribute("msg", "아이디가 존재하지 않습니다.");
            return "redirect:/member/login"; // 로그인 페이지 이동
        }
    }

    // 로그아웃
    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public String logoutMainGET(HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr) throws Exception {
        logger.info("logoutMainGET 메서드 진입");
        HttpSession session = request.getSession();
        session.invalidate();
        
        // 캐시 제어 헤더 설정
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        
        rttr.addFlashAttribute("msg", "로그아웃되었습니다.");
        return "redirect:/main";
    }

    // 마이페이지 이동
    @RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
    public String mypage(HttpSession session, RedirectAttributes rttr) throws Exception {
        logger.info("마이페이지 진입");
        
        MemberDTO loginMember = (MemberDTO) session.getAttribute("member");
        if (loginMember == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }

        // 로그인한 사용자의 정보를 다시 가져와 세션에 업데이트
        MemberDTO member = memberservice.getMemberById(loginMember.getUser_id());
        session.setAttribute("member", member);
        
        return "/member/mypage";
    }

    // 프로필 사진 업로드
    @PostMapping("/profile/upload")
    public String uploadProfilePicture(@RequestParam("file") MultipartFile file, HttpSession session, RedirectAttributes rttr) throws Exception {
        if (file.isEmpty()) {
            rttr.addFlashAttribute("msg", "파일을 선택하세요.");
            return "redirect:/member/mypage.do";
        }

        MemberDTO loginMember = (MemberDTO) session.getAttribute("member");
        if (loginMember == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }

        try {
            String originalFilename = file.getOriginalFilename();
            String uploadDir = "C:/Users/KOSA/Desktop/project_2/upload"; // 서버의 절대 경로
            String filePath = uploadDir + File.separator + originalFilename;
            File dest = new File(filePath);
            file.transferTo(dest);

            // 웹 경로 저장
            String webPath = "/upload/" + originalFilename;
            loginMember.setProfile_picture_url(webPath);
            memberservice.updateMypage(loginMember);

            // 세션을 업데이트된 멤버 정보로 갱신
            session.setAttribute("member", loginMember);
            rttr.addFlashAttribute("msg", "사진이 등록되었습니다.");

        } catch (IOException e) {
            e.printStackTrace();
            rttr.addFlashAttribute("msg", "사진 등록에 실패했습니다.");
        }

        return "redirect:/member/mypage.do";
    }

    // 비밀번호 변경
    @RequestMapping(value = "/update_pw", method = RequestMethod.POST)
    public String updatePasswordPOST(HttpServletRequest request, RedirectAttributes rttr) throws Exception {
        HttpSession session = request.getSession();
        String oldPw = request.getParameter("old_pw");
        String newPw = request.getParameter("pw");
        MemberDTO sessionMember = (MemberDTO) session.getAttribute("member");

        // Null 또는 빈 문자열 확인
        if (oldPw == null || oldPw.isEmpty() || newPw == null || newPw.isEmpty()) {
            rttr.addFlashAttribute("msg", "모든 필드를 입력하세요.");
            return "redirect:/member/mypage.do";
        }

        // 세션에 회원 정보가 존재하는지 확인
        if (sessionMember == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }

        String encodePw = sessionMember.getPassword();

        // 비밀번호 비교 및 로그 출력
        logger.info("기존 비밀번호: " + oldPw);
        logger.info("인코딩된 비밀번호: " + encodePw);
        logger.info("새 비밀번호: " + newPw);

        // 인코딩된 비밀번호가 null인지 확인
        if (encodePw == null || encodePw.isEmpty()) {
            rttr.addFlashAttribute("msg", "세션의 비밀번호가 비어 있습니다.");
            return "redirect:/member/mypage.do";
        }

        // 비밀번호 일치 여부 판단
        if (pwEncoder.matches(oldPw, encodePw)) {
            String encodeNewPw = pwEncoder.encode(newPw);
            sessionMember.setPassword(encodeNewPw);
            memberservice.updatePassword(sessionMember);
            rttr.addFlashAttribute("msg", "비밀번호가 성공적으로 변경되었습니다.");
            return "redirect:/member/mypage.do";
        } else {
            rttr.addFlashAttribute("msg", "현재 비밀번호가 일치하지 않습니다.");
            return "redirect:/member/mypage.do";
        }
    }

    // 회원 탈퇴
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String memberDelete(HttpServletRequest request, RedirectAttributes rttr) throws Exception {
        HttpSession session = request.getSession();
        String userId = request.getParameter("user_id");
        String password = request.getParameter("password");

        // 로그인한 회원 정보
        MemberDTO sessionMember = (MemberDTO) session.getAttribute("member");

        // 세션에 저장된 비밀번호 가져오기
        String encodePw = sessionMember.getPassword();

        // 비밀번호 일치 여부 판단
        if (pwEncoder.matches(password, encodePw)) {
            // 데이터베이스에서 회원 삭제
            memberservice.memberDelete(sessionMember);
            session.invalidate(); // 회원 삭제 후 로그아웃
            rttr.addFlashAttribute("msg", "회원탈퇴 완료"); // 탈퇴 완료 메시지 추가
            return "redirect:/main";
        } else {
            rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
            return "redirect:/member/mypage.do";
        }
    }
}