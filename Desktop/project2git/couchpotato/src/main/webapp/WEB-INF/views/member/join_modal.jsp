<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/join_modal.css?v=1.0" />

<div id="joinModal" class="modal join-modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <div class="wrapper">
            <form id="join_form" method="post">
                <div class="wrap">
                    <div class="subject">
						<img src="${pageContext.request.contextPath}/resources/images/reviewregister.png" width="28px">
						<span>MEMBER REGISTER</span>
					</div>
                    <div class="join_id_wrap">
                        <input class="join_id_input" name="user_id" placeholder="아이디">
                        <span class="id_input_re_1">사용 가능한 아이디입니다.</span>
                        <span class="id_input_re_2">사용중인 아이디입니다</span>
                        <span class="final_id_ck">아이디를 입력해주세요.</span>
                    </div>
                    <div class="join_pw_wrap">
                        <input type="password" class="join_pw_input" name="password" placeholder="비밀번호">
                        <span class="final_pw_ck">비밀번호를 입력해주세요.</span>
                    </div>
                    <div class="pwck_wrap">
                        <input type="password" class="pwck_input" placeholder="비밀번호 확인">
                        <span class="final_pwck_ck">비밀번호 확인란을 입력해주세요.</span>
                        <span class="pwck_input_re_1">비밀번호가 일치합니다</span>
                        <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
                    </div>
                    <div class="user_wrap">
                        <input class="user_input" name="username" placeholder="이름">
                        <span class="final_name_ck">이름을 입력해주세요.</span>
                    </div>
                    <div class="mail_wrap">
                        <input class="mail_input" name="email" placeholder="이메일">
                        <span class="email_input_re_1">사용 가능한 이메일입니다.</span>
                        <span class="email_input_re_2">사용중인 이메일입니다</span>
                        <span class="final_mail_ck">이메일을 입력해주세요.</span>
                    </div>
                    <div class="birth_wrap">
                        <input type="date" class="birth_input" name="date_of_birth">
                        <span class="final_birth_ck">생년월일을 선택해 주세요</span>
                    </div>
                    <input type="hidden" name="profile_picture_url" value="">
                    <div class="join_button_wrap">
                        <input type="button" class="join_button" value="가입하기">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 회원가입 모달 열기
        var joinModal = document.getElementById("joinModal");
        var joinBtn = document.getElementById("joinButton");
        var joinSpan = joinModal.getElementsByClassName("close")[0];

        joinBtn.onclick = function() {
            joinModal.style.display = "flex";
        }

        // 회원가입 모달 닫기
        joinSpan.onclick = function() {
            joinModal.style.display = "none";
            resetForm();
        }

        // 모달 밖 클릭 시 닫기
        window.onclick = function(event) {
            if (event.target == joinModal) {
                joinModal.style.display = "none";
                resetForm();
            } else if (event.target == loginModal) {
                loginModal.style.display = "none";
                resetForm();
            }
        }

        // 입력값 초기화 함수
        function resetForm() {
            document.getElementById("join_form").reset();
            $('.id_input_re_1, .id_input_re_2, .email_input_re_1, .email_input_re_2, .final_id_ck, .final_pw_ck, .final_pwck_ck, .pwck_input_re_1, .pwck_input_re_2, .final_name_ck, .final_mail_ck, .final_birth_ck').css('display', 'none');
        }

        // 초기 상태에서 모든 문구 숨기기
        $('.id_input_re_1, .id_input_re_2, .email_input_re_1, .email_input_re_2, .final_id_ck, .final_pw_ck, .final_pwck_ck, .pwck_input_re_1, .pwck_input_re_2, .final_name_ck, .final_mail_ck, .final_birth_ck').css('display', 'none');

        // 회원가입 버튼 클릭 메서드
        $(".join_button").click(function() {
            /* 입력값 변수 */
            var id = $('.join_id_input').val(); // id입력란
            var pw = $('.join_pw_input').val(); // 비밀번호 입력란
            var pwck = $('.pwck_input').val(); // 비밀번호 확인 입력란
            var name = $('.user_input').val(); // 이름 입력란
            var mail = $('.mail_input').val(); // 이메일 입력란
            var birth = $('.birth_input').val(); // 생년월일 입력란

            /* 아이디 유효성 검사 */
            if (id == "") {
                $('.final_id_ck').css('display', 'block');
                idCheck = false;
            } else {
                $('.final_id_ck').css('display', 'none');
                idCheck = true;
            }

            /* 비밀번호 유효성 검사 */
            if (pw == "") {
                $('.final_pw_ck').css('display', 'block');
                pwCheck = false;
            } else {
                $('.final_pw_ck').css('display', 'none');
                pwCheck = true;
            }

            /* 비밀번호 확인 유효성 검사 */
            if (pwck == "") {
                $('.final_pwck_ck').css('display', 'block');
                pwckCheck = false;
            } else {
                $('.final_pwck_ck').css('display', 'none');
                pwckCheck = true;
            }

            /* 이름 유효성 검사 */
            if (name == "") {
                $('.final_name_ck').css('display', 'block');
                nameCheck = false;
            } else {
                $('.final_name_ck').css('display', 'none');
                nameCheck = true;
            }

            /* 이메일 유효성 검사 */
            if (mail == "") {
                $('.final_mail_ck').css('display', 'block');
                mailCheck = false;
            } else {
                $('.final_mail_ck').css('display', 'none');
                mailCheck = true;
            }

            /* 생년월일 유효성 검사 */
            if (birth == "") {
                $('.final_birth_ck').css('display', 'block');
                birthCheck = false;
            } else {
                $('.final_birth_ck').css('display', 'none');
                birthCheck = true;
            }

            /* 최종 유효성 검사 */
            if (idCheck && idckCheck && pwCheck && pwckCheck && pwckcorCheck && nameCheck && mailCheck && birthCheck) {
                $("#join_form").attr("action", "/member/join");
                $("#join_form").submit();
            }

            return false;
        });

        // 아이디 중복검사
        $('.join_id_input').on("propertychange change keyup paste input", function() {
            var user_id = $('.join_id_input').val(); // .id_input에 입력되는 값

            if (user_id == "") {
                $('.id_input_re_1, .id_input_re_2').css('display', 'none');
                return;
            }

            var data = {
                user_id: user_id
            }; // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

            $.ajax({
                type: "post",
                url: "/member/user_idChk",
                data: data,
                success: function(result) {
                    if (result != 'fail') {
                        $('.id_input_re_1').css("display", "inline-block");
                        $('.id_input_re_2').css("display", "none");
                        idckCheck = true;
                    } else {
                        $('.id_input_re_2').css("display", "inline-block");
                        $('.id_input_re_1').css("display", "none");
                        idckCheck = false;
                    }
                }
            });
        });

        // 비밀번호 확인 일치 유효성 검사
        $('.pwck_input').on("propertychange change keyup paste input", function() {
            var pw = $('.join_pw_input').val();
            var pwck = $('.pwck_input').val();
            $('.final_pwck_ck').css('display', 'none');

            if (pw == pwck) {
                $('.pwck_input_re_1').css('display', 'block');
                $('.pwck_input_re_2').css('display', 'none');
                pwckcorCheck = true;
            } else {
                $('.pwck_input_re_1').css('display', 'none');
                $('.pwck_input_re_2').css('display', 'block');
                pwckcorCheck = false;
            }
        });
    });

    // 이메일 중복검사
    $('.mail_input').on("propertychange change keyup paste input", function() {
        var email = $('.mail_input').val(); // email에 입력되는 값

        if (email == "") {
            $('.email_input_re_1, .email_input_re_2').css('display', 'none');
            return;
        }

        var data = {
            email: email
        }; // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

        $.ajax({
            type: "post",
            url: "/member/emailChk",
            data: data,
            success: function(result) {
                if (result != 'fail') {
                    $('.email_input_re_1').css("display", "inline-block");
                    $('.email_input_re_2').css("display", "none");
                    emailCheck = true;
                } else {
                    $('.email_input_re_2').css("display", "inline-block");
                    $('.email_input_re_1').css("display", "none");
                    emailCheck = false;
                }
            }
        });
    });
</script>