<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>캘린더 + 나의 페이지</title>
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" />
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
	<script
		src="/resources/js/calendar.js"></script>
	</head>
<body>
	<header>
		<h1>캘린더</h1>
		<nav>
			<a href="/login">로그인</a> <a href="/signup">회원가입</a>
		</nav>
	</header>
	<div>
		<div style="float: left; width: 20%; padding: 20px;">
			<h2>내 정보</h2>
			<p>팔로워: 0</p>
			<p>팔로잉: 0</p>
			<img src="path/to/default/profile.jpg" alt="Profile Image"
				style="width: 100%;">
		</div>
		<div style="float: left; width: 75%; padding: 20px;">
			<div id="calendar"></div>
		</div>
	</div>
</body>
</html>
