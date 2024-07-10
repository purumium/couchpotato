<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
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

<h1>마이페이지</h1>

<form action="/member/profile/upload" method="POST" name="myPage-form" enctype="multipart/form-data">
    <div class="profile-btn-area">
        <label for="input-image">프로필 선택</label>
        <input type="file" name="file" id="input-image" accept="image/*">
        <button type="submit">등록하기</button>
    </div>
</form>

<div class="w3-content w3-container w3-margin-top">
    <div class="w3-container w3-card-4">
        <div class="w3-center w3-large w3-margin-top">
            <h3>My Page</h3>
        </div>
        <div>
            <!-- 이미지 경로 수정 -->
            <img src="${member.profile_picture_url}" alt="Profile Picture" width="100" height="100">
            <form id="pwForm" action="../member/update_pw" method="post">    
                <input type="hidden" name="user_id" value="${member.user_id}">
                <p>
                    <label>현재 비밀번호</label>
                    <input class="w3-input" id="old_pw" name="old_pw" type="password" required>
                </p>
                <p>
                    <label>새 비밀번호</label> 
                    <input class="w3-input" id="pw" name="pw" type="password" required>
                </p>
                <p>
                    <label>새 비밀번호 확인</label>
                    <input class="w3-input" type="password" id="pw2" required>
                </p>
                <p class="w3-center">
                    <button type="submit" id="joinBtn" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">비밀번호 변경</button>
                </p>
            </form>
            <br />
            <form id="deleteForm" action="../member/delete" method="post">
                <input type="hidden" name="user_id" value="${member.user_id}">
                <p>
                    <label for="password">비밀번호</label>
                    <input class="w3-input" id="password" name="password" type="password" required>
                </p>
                <p class="w3-center">
                    <button type="submit" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">회원 탈퇴</button>
                </p>
            </form>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // 비밀번호 변경 폼 검사
    $("#pwForm").submit(function(event) {
        const oldPw = $("#old_pw").val();
        const newPw = $("#pw").val();
        const confirmPw = $("#pw2").val();

        if (newPw !== confirmPw) {
            alert("새 비밀번호가 일치하지 않습니다.");
            $("#pw").val("").focus();
            $("#pw2").val("");
            event.preventDefault();
            return false;
        } else if (newPw.length < 3) {
            alert("새 비밀번호는 3자 이상이어야 합니다.");
            $("#pw").val("").focus();
            $("#pw2").val("");
            event.preventDefault();
            return false;
        }

        return true;
    });

    // 회원 탈퇴 폼 검사
    $("#deleteForm").submit(function(event) {
        if (!confirm('정말로 탈퇴하시겠습니까?')) {
            event.preventDefault();
            return false;
        }
        return true;
    });
});
</script>

</body>
</html>