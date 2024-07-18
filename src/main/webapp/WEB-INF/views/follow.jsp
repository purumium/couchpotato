<%@ page language="java" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/follow.css">
<!-- CSS 파일 로드 -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- jQuery 파일 로드 -->

<div id="followModal" class="follow-modal">
	<div class="follow-modal-content">
		<div class="follow-header">
			<span id="follow-close" class="follow-close">&times;</span>
		</div>
		<div class="follow-modal-body">
			<div class="tab-container">
				<!-- 탭 버튼을 클릭하면 showSection 함수 호출 -->
				<button class="tab-button" data-target="follower-section">팔로잉</button>
				<button class="tab-button" data-target="following-section">팔로워</button>
				<button class="tab-button" data-target="user-section">사용자
					검색</button>
			</div>
			<div class="content-container">
				<div id="follower-section" class="content-section"></div>
				<!-- 팔로워 리스트 섹션 -->
				<div id="following-section" class="content-section"></div>
				<!-- 팔로잉 리스트 섹션 -->
				<div id="user-section" class="content-section">
					<!-- 사용자 검색 박스  -->
					<div class="search-container">
						<input type="text" id="followSearchContainer" placeholder="사용자 검색"
							onkeyup="filterUsers()">
						<!-- 검색 입력 필드 -->
					</div>
					<div id="user-list"></div>
					<!-- 검색 결과를 표시할 요소 -->
				</div>
				<!-- 전체 사용자 리스트 섹션 -->
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {
    // 사용자 검색 버튼
    $('#user-search-btn').click(function() {
        openModal();
        showSection('user-section');
        setActiveTabButton('user-section');
    });

    // 팔로잉 버튼
    $('#following-btn').click(function() {
        openModal();
        showSection('follower-section');
        setActiveTabButton('follower-section');
    });

    // 팔로워 버튼
    $('#follower-btn').click(function() {
        openModal();
        showSection('following-section');
        setActiveTabButton('following-section');
    });
    
    // 모달 열기
    function openModal() {
        $('#followModal').css('display', 'block');
    }

    // 모달 닫기
    function closeModal() {
        $('#followModal').css('display', 'none');
    }

    $('#follow-close').click(function() {
        closeModal();
    });

    $('.tab-button').click(function() {
        setActiveTabButton($(this).data('target'));
    });

    function setActiveTabButton(sectionId) {
        $('.tab-button').removeClass('active');
        $('.tab-button[data-target="' + sectionId + '"]').addClass('active');
        showSection(sectionId);
    }

    function showSection(sectionId) {
        $('.content-section').hide();
        $('#' + sectionId).show();
    }

    let userNumber = 0;
    let userList = [];
    let followList = [];
    let followingList = [];

    function loadFollowLists() {
        $.ajax({
            url: '/follow_list_json',
            type: 'GET',
            data: { user_number: userNumber },
            success: function(response) {
                followList = response.follow_list;
                followingList = response.following_list;
                userList = response.user_list;
                userNumber = response.uid;

                renderFollowLists(followList);
                renderFollowLists2(followingList);
                displayUsers(userList);
            },
            error: function(xhr, status, error) {
                alert('팔로워 리스트와 팔로잉 리스트를 가져오는 데 실패했습니다.');
            }
        });
    }

    function renderFollowLists(followList) {
        let followerHtml = '';
        if (followList.length === 0) {
            followerHtml = '<p class="empty-message">회원님이 팔로우하는 사람들이 여기에 표시됩니다.</p>';
        } else {
            followList.forEach(function(follower) {
                followerHtml += '<div class="user-item">' +
                                    '<div class="user-item-title">' +
                                        (follower.profile_picture_url ? 
                                            '<img src="' + follower.profile_picture_url + '" class="user-item-img">' :
                                            '<img src="/resources/images/nullProfile.png" class="user-item-img">') +
                                        '<span class="user-item-name">' + follower.user_id + '</span>' +
                                    '</div>' +
                                    '<button class="user-item-btn unfollow-btn" data-following-id="' + follower.following_id + '">팔로우 취소</button>' +
                                '</div>';
            });
        }
        $('#follower-section').html(followerHtml);
        bindUnfollowButtons(); // 버튼에 이벤트 바인딩
    }

    function renderFollowLists2(followingList) {
        let followingHtml = '';
        if (followingList.length === 0) {
            followingHtml = '<p class="empty-message">회원님을 팔로우하는 사람들이 여기에 표시됩니다.</p>';
        } else {
            followingList.forEach(function(following) {
                let isMutualFollow = followList.some(function(follower) {
                    return following.user_id === follower.user_id;
                });
                followingHtml += '<div class="user-item">' +
                                    '<div class="user-item-title">' +
                                        (following.profile_picture_url ? 
                                            '<img src="' + following.profile_picture_url + '" class="user-item-img">' :
                                            '<img src="/resources/images/nullProfile.png" class="user-item-img">') +
                                        '<span class="user-item-name">' + following.user_id + '</span>' +
                                    '</div>' +
                                    (isMutualFollow ? 
                                        '<button class="user-item-btn unfollow-btn" data-follower-id="' + following.follower_id + '">팔로우 취소</button>' :
                                        '<button class="user-item-btn follow-btn" data-follower-id="' + following.follower_id + '">팔로우</button>') +
                                '</div>';
            });
        }
        $('#following-section').html(followingHtml);
        bindFollowButtons(); // 버튼에 이벤트 바인딩
    }

    function filterUsers() {
        const searchTerm = $('#followSearchContainer').val().toLowerCase();
        const filteredUsers = userList.filter(user => user.user_id.toLowerCase().includes(searchTerm));
        displayUsers(filteredUsers);
    }

    function displayUsers(users) {
        let userHtml = '';
        if (users.length === 0) {
            userHtml = '<p class="empty-message">couchpotato</p>';
        } else {
            users.forEach(function(user) {
                let isFollowing = followList.some(function(follow) {
                    return follow.user_id === user.user_id;
                });

                userHtml += '<div class="user-item">' +
                                '<div class="user-item-title">' +
                                    (user.profile_picture_url ? 
                                        '<img src="' + user.profile_picture_url + '" class="user-item-img">' :
                                        '<img src="/resources/images/nullProfile.png" class="user-item-img">') +
                                    '<span class="user-item-name">' + user.user_id + '</span>' +
                                '</div>' +
                                (isFollowing ? 
                                    '<button class="user-item-btn unfollow-btn" data-user-number="' + user.user_number + '">팔로우 취소</button>' :
                                    '<button class="user-item-btn follow-btn" data-user-number="' + user.user_number + '">팔로우</button>') +
                            '</div>';
            });
        }
        $('#user-list').html(userHtml);
        bindFollowButtons(); // 버튼에 이벤트 바인딩
        
    }

    function bindUnfollowButtons() {
        $('.unfollow-btn').click(function() {
            const following_id = $(this).data('following-id') || $(this).data('user-number');
            unfollowUser(following_id, this);
        });
    }

    function bindFollowButtons() {
        $('.follow-btn').click(function() {
            const following_id = $(this).data('follower-id') || $(this).data('user-number');
            followUser(following_id, this);
        });
    }

    function unfollowUser(following_id, button) {
        console.log('unfollowUser 호출됨: ', following_id);
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
                console.log('unfollow 성공: ', response);
                alert('팔로우를 취소했습니다.');
                $(button).text('팔로우');
                $(button).removeClass('mutual-follow-btn').addClass('follow-btn');
                $(button).attr('onclick', 'followUser(' + following_id + ', this)');
                followList = followList.filter(follow => follow.user_number !== following_id);
                loadFollowLists(); // 리스트 다시 로드
            },
            error: function(xhr, status, error) {
                console.error('unfollow 실패: ', status, error);
                alert('팔로우 취소에 실패했습니다.');
            }
        });
    }

    function followUser(following_id, button) {
        console.log('followUser 호출됨: ', following_id);
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
                console.log('follow 성공: ', response);
                alert('팔로우했습니다.');
                $(button).text('팔로우 취소');
                $(button).removeClass('follow-btn').addClass('mutual-follow-btn');
                $(button).attr('onclick', 'unfollowUser(' + following_id + ', this)');
                followList.push({ user_number: following_id });
                loadFollowLists(); // 리스트 다시 로드
            },
            error: function(xhr, status, error) {
                console.error('follow 실패: ', status, error);
                if (xhr.status === 409) {
                    alert('이미 팔로우 한 사용자입니다.');
                } else {
                    alert('팔로우에 실패했습니다.');
                }
            }
        });
    }

    // 초기 설정
    loadFollowLists();
});
</script>