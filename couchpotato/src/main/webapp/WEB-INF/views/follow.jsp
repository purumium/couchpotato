<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Follow List</title>
<!-- jQuery 라이브러리 로드 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    // 팔로우/언팔로우 토글 함수 정의
    function toggleFollow(user_number, following_id, button) {
        $.ajax({
            type: 'POST', // HTTP 요청 방식을 POST로 설정
            url: '${pageContext.request.contextPath}/follow', // 요청 보낼 URL
            data: {
                user_number: user_number, // 전송할 데이터: user_number
                following_id: following_id // 전송할 데이터: following_id
            },
            success: function(response) { // 요청 성공 시 호출되는 함수
                if (response == "follow") { // 응답이 "follow"이면
                    $(button).text('Unfollow'); // 버튼 텍스트를 "Unfollow"로 변경
                } else if (response == "unfollow") { // 응답이 "unfollow"이면
                    $(button).text('Follow'); // 버튼 텍스트를 "Follow"로 변경
                }
            },
            error: function(error) { // 요청 실패 시 호출되는 함수
                console.log("Error: ", error); // 콘솔에 오류 메시지 출력
            }
        });
    }
</script>
</head>
<body>
    <h1>내가 팔로우 한 리스트</h1>
    <ul>
        <!-- follow_list를 반복하여 출력 -->
        <c:forEach var="follow" items="${follow_list}">
            <li>
                <!-- 프로필 사진 URL이 비어 있지 않으면 출력 -->
                <c:if test="${not empty follow.profile_picture_url}">
                    Profile Picture: ${follow.profile_picture_url}<br>
                </c:if>
                <!-- 사용자 번호가 0이 아니면 출력 -->
                <c:if test="${follow.user_number != 0}">
                    User ID: ${follow.user_number}<br>
                </c:if>
                <!-- 팔로워 ID가 0이 아니면 출력 -->
                <c:if test="${follow.follower_id != 0}">
                    Follower ID: ${follow.follower_id}<br>
                </c:if>
                <!-- 팔로우 ID가 0이 아니면 출력 -->
                <c:if test="${follow.following_id != 0}">
                    Follow ID: ${follow.following_id}<br>
                </c:if>
                <!-- 팔로우 상태를 토글하는 버튼 -->
                <button onclick="toggleFollow(${sessionScope.user_number}, ${follow.following_id}, this)">
                    <!-- 팔로우 ID가 팔로잉 ID 값 안에 있으면 Follow 텍스트 출력 -->
                    <c:if test="${not empty follow.following_id and follow.follower_id != 0 and follow.follower_id == follow.following_id}">
                        Following
                    </c:if>
                    <!-- 팔로우 ID에 대해 팔로잉 ID가 없다면 Unfollow 텍스트 출력 -->
                    <c:if test="${not empty follow.following_id and follow.follower_id != follow.following_id}">
                        Unfollow
                    </c:if>
                    <!-- 팔로우 ID가 없을 경우 Follow 텍스트 출력 -->
                    <c:if test="${empty follow.following_id}">
                        Follow
                    </c:if>
                </button>
            </li>
        </c:forEach>
    </ul>

    <h1>나를 팔로우 하는 리스트</h1>
    <ul>
        <!-- following_list를 반복하여 출력 -->
        <c:forEach var="following" items="${following_list}">
            <li>
                <!-- 프로필 사진 URL이 비어 있지 않으면 출력 -->
                <c:if test="${not empty following.profile_picture_url}">
                    Profile Picture: ${following.profile_picture_url}<br>
                </c:if>
                <!-- 사용자 번호가 0이 아니면 출력 -->
                <c:if test="${following.user_number != 0}">
                    User ID: ${following.user_number}<br>
                </c:if>
                <!-- 팔로워 ID가 0이 아니면 출력 -->
                <c:if test="${following.follower_id != 0}">
                    Follower ID: ${following.follower_id}<br>
                </c:if>
                <!-- 팔로우 ID가 0이 아니면 출력 -->
                <c:if test="${following.following_id != 0}">
                    Follow ID: ${following.following_id}<br>
                </c:if>
                <!-- 팔로우 상태를 토글하는 버튼 -->
                <button onclick="toggleFollow(${sessionScope.user_number}, ${following.following_id}, this)">
                    <!-- 팔로우 ID가 팔로잉 ID 값 안에 있으면 Follow 텍스트 출력 -->
                    <c:if test="${not empty following.following_id and following.follower_id != 0 and following.follower_id == following.following_id}">
                        Following
                    </c:if>
                    <!-- 팔로우 ID에 대해 팔로잉 ID가 없다면 Unfollow 텍스트 출력 -->
                    <c:if test="${not empty following.following_id and following.follower_id != following.following_id}">
                        Unfollow
                    </c:if>
                    <!-- 팔로우 ID가 없을 경우 Follow 텍스트 출력 -->
                    <c:if test="${empty following.following_id}">
                        Follow
                    </c:if>
                </button>
            </li>
        </c:forEach>
    </ul>
</body>
</html>
