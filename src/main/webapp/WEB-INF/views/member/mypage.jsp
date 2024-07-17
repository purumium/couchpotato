<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 캐시 제어 설정 -->
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link rel="stylesheet" href="/resources/css/member/mypage.css?v=1.0" />
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>마이페이지</title>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<%@ include file="../follow.jsp"%>


	<div class="mypage-container">
		<div class="inline-container">
			<div class="section">
				<div>프로필 변경</div>
				<div>
					<form action="/member/profile/upload" method="POST"
						name="myPage-form" enctype="multipart/form-data">
						<div class="profile-btn-area">
							<div class="file-register">
								<input type="file" name="file" id="input-image" accept="image/*">
								<button type="submit" class="register-btn">등록하기</button>
							</div>
							<div>
								<img src="${member.profile_picture_url}" alt="Profile Picture">
							</div>
						</div>
					</form>
				</div>
			</div>


			<div class="section">
				<div>친구 관리</div>
				<div class="buttons-section">
					<div class="button-row">
						<div class="circle-btn" id="follower-btn">
							<div>${follow_count}</div> <span>팔로워</span>
						</div>

						<div class="circle-btn" id="following-btn">
						<div>${following_count}</div> <span>팔로잉</span>
						</div>

						<div class="circle-btn" id="user-search-btn">
							<div>
								<img src="/resources/images/usersearch.png" width="25px"
									alt="user-search">
							</div>
							<span>사용자 검색</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="inline-container">
			<div class="section">
				<div>비밀번호 변경</div>
				<div>
					<form id="pwForm" action="../member/update_pw" method="post">
						<input type="hidden" name="user_id" value="${member.user_id}">
						<p>
							<label>현재 비밀번호</label> <input class="w3-input" id="old_pw"
								name="old_pw" type="password" required>
						</p>
						<p>
							<label>새 비밀번호</label> <input class="w3-input" id="pw" name="pw"
								type="password" required>
						</p>
						<p>
							<label>새 비밀번호 확인</label> <input class="w3-input" type="password"
								id="pw2" required>
						</p>
						<p class="w3-center">
							<button type="submit" id="joinBtn"
								class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">비밀번호
								변경</button>
						</p>
					</form>
				</div>
			</div>

			<div class="section">
				<div>회원 탈퇴</div>
				<div>
					<form id="deleteForm" action="../member/delete" method="post">
						<input type="hidden" name="user_id" value="${member.user_id}">
						<p>
							<label for="password">비밀번호</label> <input class="w3-input"
								id="password" name="password" type="password" required>
						</p>
						<p class="w3-center">
							<button type="submit"
								class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">회원탈퇴</button>
						</p>
					</form>
					<div class="header-icon"></div>
				</div>
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

  $(document).ready(function() {
    // 사용자 검색 버튼
    $('#user-search-btn').click(function() {
        openModal();
        showSection('user-section'); // 사용자 검색 섹션 표시
    });

    // 팔로잉 버튼
    $('#following-btn').click(function() {
        openModal();
        showSection('following-section'); // 팔로잉 섹션 표시
    });

    // 팔로워 버튼
    $('#follower-btn').click(function() {
        openModal();
        showSection('follower-section'); // 팔로워 섹션 표시
    });

    // 모달 닫기 버튼
    $('#follow-close').click(function() {
        closeModal();
    });
    
// 모달 열기
function openModal() {
    $('#followModal').css('display', 'block');
}

// 모달 닫기
function closeModal() {
    $('#followModal').css('display', 'none');
    location.reload();
}
  });

</script>


</body>
</html>