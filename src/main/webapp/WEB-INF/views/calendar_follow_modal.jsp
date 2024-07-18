<%@ page language="java" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar_follow_modal.css?v=1.0" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 내 친구 캘린더 보기 -->
<div id="followCalendar-Modal" class="followCalendar-modal">
    <div class="followCalendar-modal-content">
        <div class="followCalendar-modal-header">
            <div class="followCalendar-modal-header-title">
                <img src="${pageContext.request.contextPath}/resources/images/camera.png" width="36px;">
                <span>내 친구의 캘린더</span>
            </div>
            <span id="close-follow-modal" class="followCalendar-close">&times;</span>
        </div>
        <div id="followCalendar-modal-body" class="followCalendar-modal-body">
            <div id="friendCalendar"></div>
        </div>
    </div>
</div>


<script type="text/javascript">
	$(document).ready(function() {
    	   // 친구 캘린더 열기
           $('#following-list-btn').click(function() {
               var userId = $(this).data('userid');
               
        	   console.log("친구 캘린더 열기 " + userId);
               $('#followCalendar-Modal').css('display', 'block');

               loadFriendCalendar(userId); 
           });

           
    	   // 친구 캘린더 닫기
           $('#close-follow-modal').click(function() {
               $('#followCalendar-Modal').css('display', 'none');
           });

    	   
           function loadFriendCalendar(userId) {
               $('#friendCalendar').fullCalendar({
					contentHeight : 'auto',
					header : {
						left : 'title',
						center : '',
						right : 'prev, next'
					},
					viewRender : function(view, element) {
						var date = view.intervalStart; // 현재 뷰 시작 날짜
						var title = date.format('YYYY년 MM월'); // 시작 날짜 포맷
						$('.fc-left').html('<h5>' + title + '</h5>')
					},
                   events: function(start, end, timezone, callback) {
                	   $.ajax({
                           url: '/getFriendCalendarByDate', 
                           data: { userId: userId },
                           dataType: 'json',
                           success: function(freindReviewsByDate) {
                               var events = [];
                               
                               freindReviewsByDate.forEach(function(friend) {
                                   events.push({
                                       title: friend.REVIEW_TOTAL_COUNT,
                                       start: friend.REVIEW_CREATE_AT
                                   });
                               });
		                   			
	                   		   callback(events);
                           }
                       });
                   },
                   eventClick : function(calEvent, jsEvent, view) {
	   					// 이벤트를 클릭했을 때: calEvent.start(현재 이벤트의 날짜)
	   					var clickedDate = calEvent.start.format('YYYY-MM-DD');
	
	   					contentsDetailsByDate(clickedDate); // 특정 날짜에 대한 영화 정보 가져오기
   				   } 
               });
           }
     });
</script>