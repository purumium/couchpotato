<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="/resources/css/member/join.css?v=1.0">
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<!-- 캐시 제어 설정 -->
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
</head>
<body>

	<%-- Flash 메시지 확인 및 알림 --%>
	<c:if test="${not empty msg}">
		<script>
			$(document).ready(function() {
				alert('${msg}');
			});
		</script>
	</c:if>

	<div class="wrapper">
		<form id="join_form" method="post">
			<div class="wrap">
				<div class="subjecet">
					<span>회원가입</span>
				</div>
				<div class="id_wrap">
					<div class="id_name">아이디</div>
					<div class="id_input_box">
						<input class="id_input" name="user_id">
					</div>
					<span class="id_input_re_1">사용 가능한 아이디입니다.</span> <span
						class="id_input_re_2">사용중인 아이디라서 다른걸로 바꿔주세여</span> <span
						class="final_id_ck">아이디를 입력해주세요.</span>
				</div>
				<div class="pw_wrap">
					<div class="pw_name">비밀번호</div>
					<div class="pw_input_box">
						<input type="password" class="pw_input" name="password">
					</div>
					<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
				</div>
				<div class="pwck_wrap">
					<div class="pwck_name">비밀번호 확인</div>
					<div class="pwck_input_box">
						<input type="password" class="pwck_input">
					</div>
					<span class="final_pwck_ck">비밀번호 확인란을 입력해주세요.</span> <span
						class="pwck_input_re_1">비밀번호가 일치합니다</span> <span
						class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
				</div>
				<div class="user_wrap">
					<div class="user_name">이름</div>
					<div class="user_input_box">
						<input class="user_input" name="username">
					</div>
					<span class="final_name_ck">이름을 입력해주세요.</span>
				</div>
				<div class="mail_wrap">
					<div class="mail_name">이메일</div>
					<div class="mail_input_box">
						<input class="mail_input" name="email">
					</div>
					<span class="final_mail_ck">이메일을 입력해주세요.</span>
				</div>

				<!-- 생년월일 입력 부분 -->
				<div class="birth_wrap">
					<div class="birth_name">생년월일</div>
					<div class="birth_input_box">
						<input type="date" class="birth_input" name="date_of_birth">
					</div>
					<span class="final_birth_ck">생년월일을 선택해 주세요</span>
				</div>

				<!-- 이미지 파일 입력 부분 -->
				<input type="hidden" name="profile_picture_url" value="null">

				<div class="join_button_wrap">
					<input type="button" class="join_button" value="가입하기">
				</div>
			</div>
		</form>
	</div>

	<script>
		var idCheck = false;
		var idckCheck = false; // 아이디 중복 검사
		var pwCheck = false; // 비번
		var pwckCheck = false; // 비번 확인
		var pwckcorCheck = false; // 비번 확인 일치 확인
		var nameCheck = false; // 이름
		var mailCheck = false; // 이메일
		var birthCheck = false; // 생년월일 

		//회원가입 버튼(회원가입 기능 작동)
		$(".join_button").click(
				function() {
					/* 입력값 변수 */
					var id = $('.id_input').val(); // id입력란
					var pw = $('.pw_input').val(); // 비밀번호 입력란
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
					if (pw == "") { // 수정된 부분: 조건문에 할당이 아닌 비교 연산자(==) 사용
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
					if (idCheck && idckCheck && pwCheck && pwckCheck
							&& pwckcorCheck && nameCheck && mailCheck
							&& birthCheck) {
						$("#join_form").attr("action", "/member/join");
						$("#join_form").submit();
					}

					return false;
				});

		//아이디 중복검사
		$('.id_input').on(
				"propertychange change keyup paste input",
				function() {
					var user_id = $('.id_input').val(); // .id_input에 입력되는 값
					var data = {
						user_id : user_id
					}; // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

					if (user_id == "") {
						$('.id_input_re_1').css('display', 'none');
						$('.id_input_re_2').css('display', 'none');
						return;
					}

					$.ajax({
						type : "post",
						url : "/member/user_idChk",
						data : data,
						success : function(result) {
							if (result != 'fail') {
								$('.id_input_re_1').css("display",
										"inline-block");
								$('.id_input_re_2').css("display", "none");
								idckCheck = true;
							} else {
								$('.id_input_re_2').css("display",
										"inline-block");
								$('.id_input_re_1').css("display", "none");
								idckCheck = false; // 수정된 부분: 변수명 오타 수정
							}
						} // SUCCESS 종료
					}); // ajax 종료
				}); // function 종료

		/* 비밀번호 확인 일치 유효성 검사 */
		$('.pwck_input').on("propertychange change keyup paste input",
				function() {
					var pw = $('.pw_input').val();
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

		/* 입력 이메일 형식 유효성 검사
		   function mailFormCheck(email){
		   	
		      var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		      
		      return form.test(email);
		   } 
		 */
	</script>

</body>
</html>