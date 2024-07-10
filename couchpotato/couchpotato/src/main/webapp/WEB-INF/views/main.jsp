<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>couchpotato</title>
<link rel="stylesheet" href="resources/css/main.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<!-- 캐시 제어 설정 -->
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
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
    <div class="wrap">
        <!-- 로그인 하지 않은 상태 -->
        <c:if test="${member == null}">
            <div class="login_button">
                <a href="/member/login">로그인</a>
            </div>
            <span><a href="/member/join">회원가입</a></span>
        </c:if>

        <!-- 로그인한 상태 -->
        <c:if test="${member != null}">
            <div class="login_success_area">
                <a href="/member/logout">로그아웃</a> <span><a href="/member/mypage.do">마이페이지(${member.user_id})</a></span>
            </div>
        </c:if>
    </div>
</div>

</body>
</html>