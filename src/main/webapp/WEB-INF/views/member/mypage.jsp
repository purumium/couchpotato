<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	<div class="calendar-container">

	<div class="mypage-container">
		<div class="outer-div">
			<div class="left-div">
				<div class="profile-img-wrap">
					<img
						src="<c:choose>
                                <c:when test="${not empty member.profile_picture_url}">
                                    ${member.profile_picture_url}
                                </c:when>
                                <c:otherwise>
                                    /resources/images/default-profile.png
                                </c:otherwise>
                              </c:choose>"
						alt="Profile Picture" class="profile-img">
					<button class="edit-btn">수정</button>
				</div>
				<div class="profile-info">
					<p class="username">${member.username}</p>
					<p class="email">${member.email}</p>
				</div>
			</div>
			<div class="right-div">
				<div class="user-details">
					<p class="user-id">#${member.user_id}</p>
					<p class="date-of-birth">${member.date_of_birth}</p>
				</div>
				<div class="buttons-section">
					<div class="circle-btn" id="following-btn">
						<div>${following_count}</div>
						<span>팔로잉</span>
					</div>
					
					<div class="circle-btn" id="follower-btn">
						<div>${follower_count}</div>
						<span>팔로워</span>
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
		<div class="profile-actions">
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
								class="w3-button w3-ripple w3-margin-top w3-round">비밀번호
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
								class="w3-button w3-ripple w3-margin-top w3-round">회원탈퇴</button>
						</p>
					</form>
				</div>
			</div>
		</div>

		<div id="profileUpdateModal" class="profileUpdateModal">
			<div class="profileUpdateModal-content">
				<span class="profileUpdateModal-close">&times;</span>
				<form action="/member/profile/upload" method="POST"
					name="myPage-form" enctype="multipart/form-data">
					<div class="profile-btn-area">
						<input type="file" name="file" id="input-image" accept="image/*">
						<button type="submit" class="register-btn">등록하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>

	<script>
		$(document).ready(function() {
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

			$("#deleteForm").submit(function(event) {
				if (!confirm('정말로 탈퇴하시겠습니까?')) {
					event.preventDefault();
					return false;
				}
				return true;
			});

			$(".edit-btn").click(function() {
				$("#profileUpdateModal").css("display", "block");
			});

			$(".profileUpdateModal-close").click(function() {
				$("#profileUpdateModal").css("display", "none");
			});

			$(window).click(function(event) {
				if (event.target.id == "profileUpdateModal") {
					$("#profileUpdateModal").css("display", "none");
				}
			});
		});
	</script>
</body>
</html>