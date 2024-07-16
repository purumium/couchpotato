<%@ page language="java" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?v=1.0" />

<div class="home-header-container">
	<div class="home-header">	    
   	    <div class="auth-buttons">
			<!-- 로그인 하지 않은 상태 -->
			
			<c:if test="${member == null}">
				<div class="auth-button"  id="loginButton">
					<img src="/resources/images/login.png" alt="login" width="29px"> 
					<div>로그인</div>
				</div>
				<div class="auth-button" id="joinButton">
					<img src="/resources/images/register.png" alt="join" width="29px"> 
					<div>회원가입</div>
				</div>
			</c:if>
		

			<!-- 로그인한 상태 -->
			<c:if test="${member != null}">
				<div class="auth-button" onclick="location.href='/member/mypage.do'">
					<img src="/resources/images/mypage.png" alt="mypage" width="28px">
					<div>나의정보</div>
				</div>
				<div class="auth-button" onclick="location.href='/calendar'">
					<img src="/resources/images/calendar.png" alt="calendar" width="29px">
					<div>리뷰캘린더</div>
				</div>
				<div class="auth-button" onclick="location.href='/member/logout'" id="auth-button-logout">
					<img src="/resources/images/logout.png" alt="logout" width="31px"> 
					<div>로그아웃</div>
				</div>
			</c:if>
		</div>
	</div>
</div>

<!-- 로그인 모달 인클루드 -->
<jsp:include page="/WEB-INF/views/member/login_modal.jsp"/>

<!-- 회원가입 모달 인클루드 -->
<jsp:include page="/WEB-INF/views/member/join_modal.jsp"/>

<c:if test="${not empty msg}">
    <script>
        $(document).ready(function() {
            alert('${msg}');
        });
    </script>
</c:if>