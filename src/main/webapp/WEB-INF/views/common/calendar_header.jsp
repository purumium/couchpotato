<%@ page language="java" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css?v=1.0" />

<div class="header-container">
	<div class="header">
	    <div class="logo" onclick="location.href='/'">
	        <img src="${pageContext.request.contextPath}/resources/images/logo_wild.png" alt="logo">
	        <img src="${pageContext.request.contextPath}/resources/images/logo_font.png" alt="logo">
    	</div>

		<div class="search-bar">
			<form action="${pageContext.request.contextPath}/movies" method="get">
				<img src="${pageContext.request.contextPath}/resources/images/search_icon.png" alt="search" class="search-icon"> 
				<input type="text" placeholder="검색" name="query" value="${param.query}">
				<button type="submit" class="search-clear-btn">x</button>
			</form>
		</div>

		<div class="auth-buttons">

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
		</div>
	</div>
</div>


