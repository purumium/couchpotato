<%@ page language="java" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/follow.css"> <!-- CSS 파일 로드 -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> <!-- jQuery 파일 로드 -->
</
<!-- The Modal -->
<div id="followModal" class="follow-modal">
    <div class="follow-modal-content">
        <div class="follow-header">
            <span id="follow-close" class="follow-close">&times;</span>
        </div>
        <div class="follow-modal-body">
            <div class="tab-container">
                <!-- 탭 버튼을 클릭하면 showSection 함수 호출 -->
                <button class="tab-button" onclick="showSection('follower-section')">팔로워</button>
                <button class="tab-button" onclick="showSection('following-section')">팔로잉</button>
                <button class="tab-button" onclick="showSection('user-section')">사용자 검색</button>
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
    </div>
</div>

<script>
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
	
	
    // 전역 변수로 선언 (현재 로그인한 사용자의 user_number)
    const userNumber = 82;
    let userList = [];
    let followList = [];
    let followingList = [];

    // 섹션 보여주기 함수
    function showSection(sectionId) {
        $('.content-section').hide(); // 모든 섹션 숨기기
        $('#' + sectionId).show(); // 선택한 섹션만 보이기
        loadFollowLists();//내용변경후 보이기
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

                renderFollowLists(followList); // 팔로워 및 팔로잉 리스트 렌더링             
                renderFollowLists2(followingList); // 팔로워 및 팔로잉 리스트 렌더링
                displayUsers(userList); // 사용자 리스트 표시 함수 호출
                console.log("잠와죽겠노 ")
            },
            error: function(xhr, status, error) { // 요청이 실패하면 실행
                alert('팔로워 리스트와 팔로잉 리스트를 가져오는 데 실패했습니다.');
            }
        });
    }

    // 팔로워 리스트 렌더링 함수
    function renderFollowLists(followList) {
        let followerHtml = '';
		console.log("followList"+followList);
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

    }
    
    // 팔로잉 리스트 렌더링 함수
    function renderFollowLists2(followingList) {
        let followingHtml = '';   

        // 팔로잉 리스트 출력
        followingList.forEach(function(following) {
        	 // 현재 사용자가 팔로우하는 사람인지 확인
            let isMutualFollow = followList.some(function(follower) {
                return following.user_number === follower.user_number;
                console.log(isMutualFollow+"isMutualFollow")
            });

            followingHtml += '<div class="following-item">';
            followingHtml += '<div class="following-name">' + following.profile_picture_url + ' (' + following.user_id + ')</div>';
            if (isMutualFollow) {
                // 맞팔 상태인 경우 팔로우 취소 버튼 추가
                followingHtml += '<button class="mutual-follow-btn" onclick="unfollowUser(' + following.follower_id + ', this)">팔로우 취소</button>';
                console.log("맞팔상태")
            } else {
            	 // 맞팔 상태가 아닌 경우 팔로우 버튼 추가
                followingHtml += '<button class="follow-btn" onclick="followUser(' + following.follower_id + ', this)">팔로우</button>';
                console.log("맞팔아님")
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
        users.forEach(function(user) {
            let isFollowing = followingList.some(function(follow) {
                return follow.user_number === user.user_number;
            });

            let isFollower = followList.some(function(following) {
                return following.user_number === user.user_number;
            });
            console.log("전체리스트 불러오기 ")
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
                console.log("팔로우취소후 ")
                $(button).text('팔로우');
                $(button).removeClass('mutual-follow-btn').addClass('follow-btn');
                	console.log("팔로우버튼 바꿀예정 ")
                $(button).attr('onclick', 'followUser(' + following_id + ', this)');

                followList = followList.filter(follow => follow.user_number !== following_id);
                
            },
            error: function(xhr, status, error) {
                alert('팔로우 취소에 실패했습니다.');
            }
        });
    }

//     팔로우 함수
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
                
                // 팔로우 리스트에 추가
                followList.push({ user_number: following_id });
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
