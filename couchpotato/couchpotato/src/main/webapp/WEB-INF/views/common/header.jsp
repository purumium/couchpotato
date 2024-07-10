<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?v=1.0" />

<div class="header-container">
	<div class="header">
	    <div class="logo">
	        <img src="${pageContext.request.contextPath}/resources/images/logo_wild.png" alt="logo">
	        <img src="${pageContext.request.contextPath}/resources/images/logo_font.png" alt="logo">
	    </div>
	    
	    <div class="search-bar">
	        <img src="/resources/images/search.svg" alt="search" class="search-icon">
	        <input type="text" placeholder="검색">
	        <button type="button" class="search-clear-btn">x</button>
	    </div>
	    
	    <div class="auth-buttons">
	        <div class="auth-button" onclick="location.href='/login'">
	            <img src="/resources/images/login.png" alt="search">
	            <span>로그인</span>
	        </div>
	        <div class="auth-button" onclick="location.href='/register'">
	            <img src="/resources/images/register.png" alt="search">
	            <span>회원가입</span>
	        </div>
	        <div class="auth-button" onclick="location.href='/calendar'">
	            <img src="/resources/images/calendar.png" alt="calendar">
	            <div>리뷰 캘린더</div>
	        </div>
            <div class="auth-button" onclick="location.href='/logout'" id="auth-button-logout">
	            <img src="/resources/images/logout.png" alt="logout">
	            <span>로그아웃</span>
	        </div>
	    </div>
	</div>
</div>