<%@ page language="java" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?v=1.0" />

<div class="home-header-container">
	<div class="home-header">	    
   	    <div class="auth-buttons">
			<!-- 로그인 하지 않은 상태 -->
			<c:if test="${member == null}">
				<div class="header-icon">
					<img src="/resources/images/potato_icon.png" alt="icon" width="33px"> 
					<img src="/resources/images/innerpotato_icon.png" alt="icon" width="33px"> 
					<img src="/resources/images/potato_icon.png" alt="icon" width="33px">
				</div>
				<div class="auth-button" onclick="location.href='/member/login'">
					<img src="/resources/images/login.png" alt="login"> 
					<div>로그인</div>
				</div>
				<div class="auth-button" onclick="location.href='/member/join'">
					<img src="/resources/images/register.png" alt="join"> 
					<div>회원가입</div>
				</div>
			</c:if>

			<!-- 로그인한 상태 -->
			<c:if test="${member != null}">
				<div class="header-icon"> 
					<img src="/resources/images/potato_icon.png" alt="icon" width="33px"> 
					<img src="/resources/images/innerpotato_icon.png" alt="icon" width="33px"> 
					<img src="/resources/images/potato_icon.png" alt="icon" width="33px">
				</div>	
				<div class="auth-button" onclick="location.href='/member/mypage.do'">
					<img src="/resources/images/mypage.png" alt="mypage">
					<div>나의정보</div>
				</div>
				<div class="auth-button" onclick="location.href='/calendar'">
					<img src="/resources/images/calendar.png" alt="calendar">
					<div>리뷰캘린더</div>
				</div>
				<div class="auth-button" onclick="location.href='/member/logout'" id="auth-button-logout">
					<img src="/resources/images/logout.png" alt="logout"> 
					<div>로그아웃</div>
				</div>
			</c:if>
		</div>
	</div>
</div>