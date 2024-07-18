<%@ page language="java" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar_follow_modal.css?v=1.0" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 내 친구 캘린더 보기 -->
<div id="followCalendar-Modal" class="followCalendar-modal">
    <div class="followCalendar-modal-content">
        <div class="followCalendar-modal-header">
            <div class="followCalendar-modal-header-title">
                <img id="friend-profile-img" 
                	 src="/resources/images/popcornpotato.png" width="50px;">
                <div class="friend-title">
	                <span class="friend-name"> </span> 
	                <span class="friend-name2">의 리뷰 캘린더</span>
                </div>
            </div>
            <span id="close-follow-modal" class="followCalendar-close">&times;</span>
        </div>
        <div id="followCalendar-modal-body" class="followCalendar-modal-body">
            <div id="friendCalendar"></div>
        </div>
    </div>
</div>


<!-- 내 친구의 컨텐츠 보기 -->
<div id="followContent-Modal" class="followContent-Modal">
	<div class="followContent-modal-content">
        <div class="followContent-modal-header">
        	<div class="followContent-modal-header-title" >
				<img src="resources/images/camera.png" width="36px;">        	
        		<span>REVIEWS BY DATE</span> 
       		</div>
            <span id="followContent-close">&times;</span>
        </div>
		<div id="followContent-modal-body" class="followContent-modal-body">
		</div>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function() {
    	   // 친구 캘린더 열기
           $('.following-calendar-btn').click(function() {
               var userId = $(this).data('userid');
               var username = $(this).data('username');
               
               console.log("유저의 유저의 이름 : " + userId + ", " + username);
               
               // 이름
               $('.friend-name').text(username);         
               
               // 모달창 열림
               $('#followCalendar-Modal').css('display', 'block');
               
               loadFriendCalendar(userId); 
           });

           
    	   // 친구 캘린더 닫기
           $('#close-follow-modal').click(function() {
               $('#followCalendar-Modal').css('display', 'none');
               location.reload();
           });
    	   
    	   
           // 친구 캘린더 - 컨텐츠 모달 닫기
           $('#followContent-close').click(function() {
               $('#followContent-Modal').css('display', 'none');
           });
     });
	

    function loadFriendCalendar(userId) {
        $('#friendCalendar').fullCalendar({
				header : {
					left : 'title',
					center : '',
					right : 'prev, next'
				},
				viewRender : function(view, element) {
					var date = view.intervalStart; // 현재 뷰 시작 날짜
					var title = date.format('YYYY년 MM월'); // 시작 날짜 포맷
					$('.fc-left').html('<h6>' + title + '</h6>')
				},
            	events: function(start, end, timezone, callback) {
					$.ajax({
					       url: '/getFriendCalendarByDate', 
					       data: { followUserId: userId },
					       dataType: 'json',
					       success: function(freindReviewsByDate) {
					    	   console.log("친구의 데이터 : " + freindReviewsByDate);
					    	   
					           var events = [];
					           
					           freindReviewsByDate.forEach(function(friend) {
					               events.push({
					                   title: friend.REVIEW_TOTAL_COUNT,
					                   start: friend.REVIEW_CREATE_AT,
					                   followUserId: userId
					               });
					           });
					       			
					   		callback(events);
					       }
					});
            	},
	            eventClick : function(calEvent, jsEvent, view) {
					// 이벤트를 클릭했을 때: calEvent.start(현재 이벤트의 날짜)
					var clickedDate = calEvent.start.format('YYYY-MM-DD');
					var clickedUserId = calEvent.followUserId; // 이벤트에서 userId를 가져옴
	
					friendContentsDetailsByDate(clickedDate, clickedUserId); // 특정 날짜에 대한 영화 정보 가져오기
				} 
        });
    }
    
    
    function friendContentsDetailsByDate(clickedDate, clickedUserId) {
		$.ajax({
			url : '/getfriendcontentdetail', // db에서 영화 정보 가져오는 URL
			type : 'GET', // 요청 방식
			data : {
				date : clickedDate,
				userId : clickedUserId
			},
			success : function(detailData) {
				// JSON 데이터 파싱
				var resultHtml = '';
				
				console.log(detailData);
				
				detailData.forEach(function(data) {
					// 
					resultHtml += '<div class="follow-review-item">'
							            + '<img src="https://image.tmdb.org/t/p/w300/' + data.content_image_url + '" alt="Movie Thumbnail" class="follow-review-img">'
							            + '<div class="follow-review-contents">'
							                + '<div class="follow-review-title-rate">'
							                    + '<div class="follow-review-title">'
							                        + '<a href="/movie/detail/' + data.content_type + '/' + data.content_id + '">'
							                        + data.content_name + '</a>'
							                    + '</div>'
							                    + '<div class="follow-review-rating">'
							                        + '<img src="resources/images/rating_star.png" width="10px;">'
							                        + data.rating
							                    + '</div>'
							                + '</div>' // follow-review-title-rate 닫기
						                    + '<div class="follow-review-create-at">'
						                        + data.review_create_at
						                    + '</div>'
							            + '</div>' // follow-review-contents 닫기
							      + '</div>'; // follow-review-item 닫기
                   console.log(resultHtml);
	            });
	            $('#followContent-modal-body').html(resultHtml);
	            
	            $('#followContent-Modal').css('display', 'block');
				
			},	
			error : function(xhr, status, error) {
				alert('영화 정보를 불러오는 데 실패했습니다.');
			}
		});
	}
    
	
	

    
</script>