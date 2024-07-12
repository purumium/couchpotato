<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Follow List</title>
    <link rel="stylesheet" href="/resources/css/follow.css"> <!-- CSS 파일 로드 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> <!-- jQuery 파일 로드 -->
</head>
<body>
    <div class="modal">
        <div class="tab-container">
            <!-- 탭 버튼을 클릭하면 showSection 함수 호출 -->
            <button class="tab-button" onclick="showSection('follower-section')">팔로워 리스트</button>
            <button class="tab-button" onclick="showSection('following-section')">팔로잉 리스트</button>
            <button class="tab-button" onclick="showSection('user-section')">전체 사용자 리스트</button>
        </div>
        <div class="content-container">
            <div id="follower-section" class="content-section"></div> <!-- 팔로워 리스트 섹션 -->
            <div id="following-section" class="content-section"></div> <!-- 팔로잉 리스트 섹션 -->
            <div id="user-section" class="content-section">
                <input type="text" id="searchUser" placeholder="사용자 검색" onkeyup="filterUsers()"> <!-- 검색 입력 필드 -->
                <div id="user-list"></div> <!-- 검색 결과를 표시할 요소 -->
            </div> <!-- 전체 사용자 리스트 섹션 -->
        </div>
    </div>
<script>
    // 전역 변수로 선언 (현재 로그인한 사용자의 user_number)
    const userNumber = 8;
    let userList = [];
    let followList = [];
    let followingList = [];

    // 섹션 보여주기 함수
    function showSection(sectionId) {
        $('.content-section').hide(); // 모든 섹션 숨기기
        $('#' + sectionId).show(); // 선택한 섹션만 보이기
    }

    // 문서가 준비되면 실행
    $(document).ready(function() {
        // 초기 섹션 설정 (팔로워 섹션 보이기)
        showSection('follower-section');

        // 팔로워 리스트와 팔로잉 리스트를 가져옴
        loadFollowLists();
    });

    function loadFollowLists() {
        $.ajax({
            url: '/follow_list_json', // 팔로워 리스트와 팔로잉 리스트를 가져오는 요청 (서버에 요청)
            type: 'GET',
            data: { user_number: userNumber }, // 요청 데이터에 user_number 포함
            success: function(response) { // 요청이 성공하면 실행
                followList = response.follow_list; // 응답에서 팔로워 리스트 가져오기
                followingList = response.following_list; // 응답에서 나를 팔로잉한 리스트 가져오기
                userList = response.user_list; // 응답에서 전체 사용자 리스트 가져오기

                renderFollowLists(); // 팔로워 및 팔로잉 리스트 렌더링
                displayUsers(userList); // 사용자 리스트 표시 함수 호출
            },
            error: function(xhr, status, error) { // 요청이 실패하면 실행
                alert('팔로워 리스트와 팔로잉 리스트를 가져오는 데 실패했습니다.');
            }
        });
    }

    // 팔로워 및 팔로잉 리스트 렌더링 함수
    function renderFollowLists() {
        let followerHtml = '';
        let followingHtml = '';

        // 팔로워 리스트 출력
        followList.forEach(function(follower) {
            let isMutualFollow = followingList.some(function(following) {
                return following.user_number === follower.user_number;
            });

            followerHtml += '<div class="follower-item">';
            followerHtml += '<div class="follower-name">' + follower.profile_picture_url + ' (' + follower.user_id + ')</div>';
            if (isMutualFollow) {
                followerHtml += '<button class="mutual-follow-btn" onclick="unfollowUser(' + follower.following_id + ', this)">팔로우 취소</button>';
            } else {
                followerHtml += '<button class="follow-btn" onclick="followUser(' + follower.following_id + ', this)">팔로우</button>';
            }
            followerHtml += '</div>';
        });

        $('#follower-section').html(followerHtml);

        // 팔로잉 리스트 출력
        followingList.forEach(function(following) {
            let isMutualFollow = followList.some(function(follower) {
                return following.user_number === follower.user_number;
            });

            followingHtml += '<div class="following-item">';
            followingHtml += '<div class="following-name">' + following.profile_picture_url + ' (' + following.user_id + ')</div>';
            if (isMutualFollow) {
                followingHtml += '<button class="mutual-follow-btn" onclick="unfollowUser(' + following.follower_id + ', this)">팔로우 취소</button>';
            } else {
                followingHtml += '<button class="follow-btn" onclick="followUser(' + following.follower_id + ', this)">팔로우</button>';
            }
            followingHtml += '</div>';
        });

        $('#following-section').html(followingHtml);
    }

    // 사용자 리스트 필터링 함수
    function filterUsers() {
        const searchTerm = $('#searchUser').val().toLowerCase();
        const filteredUsers = userList.filter(user => user.user_id.toLowerCase().includes(searchTerm));
        displayUsers(filteredUsers);
    }

    // 전체사용자 리스트 표시 함수
    function displayUsers(users) {
        let userHtml = '';
        
        console.log("------ 전체 사용자 리스트 ------- ")
        console.log(users);
        
        users.forEach(function(user) {
            let isFollowing = followingList.some(function(follow) {
                return follow.user_number === user.user_number;
            });

            let isFollower = followList.some(function(following) {
                return following.user_number === user.user_number;
            });

            userHtml += '<div class="user-item">';
            userHtml += '<div class="user-name">' + user.profile_picture_url + ' (' + user.user_id + ')</div>';
            if (isFollowing) {
                userHtml += '<button class="mutual-follow-btn" onclick="unfollowUser(' + user.user_number + ', this)">팔로우 취소</button>';
            } else {
                userHtml += '<button class="follow-btn" onclick="followUser(' + user.user_number + ', this)">팔로우</button>';
            }
            userHtml += '</div>';
        });

        $('#user-list').html(userHtml);
    }

    // 팔로우 취소 함수 (맞팔한 친구 - 팔로우 해제)
    function unfollowUser(following_id, button) {
        const obj = {
            user_number: userNumber,
            follower_id: userNumber,
            following_id: following_id
        };

        $.ajax({
            url: '/unfollow',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(obj),
            success: function(response) {
                alert('팔로우를 취소했습니다.');
                $(button).text('팔로우');
                $(button).removeClass('mutual-follow-btn').addClass('follow-btn');
                $(button).attr('onclick', 'followUser(' + following_id + ', this)');
                // 팔로워 리스트에서 제거
                followList = followList.filter(follow => follow.following_id !== following_id);
                renderFollowLists(); // 팔로워 리스트 다시 렌더링
                loadFollowLists(); // 전체 리스트 다시 불러오기
            },
            error: function(xhr, status, error) {
                alert('팔로우 취소에 실패했습니다.');
            }
        });
    }

    // 팔로우 함수
    function followUser(following_id, button) {
        const obj = {
            user_number: userNumber,
            follower_id: userNumber,
            following_id: following_id
        };

        $.ajax({
            url: '/follow',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(obj),
            success: function(response) {
                alert('팔로우했습니다.');
                $(button).text('팔로우 취소');
                $(button).removeClass('follow-btn').addClass('mutual-follow-btn');
                $(button).attr('onclick', 'unfollowUser(' + following_id + ', this)');
                // 팔로잉 리스트에 추가
                followingList.push({ user_number: following_id });
                renderFollowLists(); // 팔로잉 리스트 다시 렌더링
                loadFollowLists(); // 전체 리스트 다시 불러오기
            },
            error: function(xhr, status, error) {
            	 if (xhr.status === 409) { // 중복된 팔로우 요청의 상태 코드가 409라고 가정
                     alert('이미 팔로우 한 사용자입니다.');
                 } else {
                     alert('팔로우에 실패했습니다.');
                 }
            }
        });
    }
</script>
</body>
</html>
