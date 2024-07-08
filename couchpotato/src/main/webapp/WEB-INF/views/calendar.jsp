<%@ page contentType="text/html;charset=UTF-8" language="java"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>my information</title>
	<link rel="stylesheet" href="/resources/css/calendar.css?v=1.0" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" />
	<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/locale/ko.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
</head>
<body>
    <%@ include file="common/header.jsp" %>
    
    <div class="calendar-container">
    
    		<!-- 왼쪽 -->
    		<div class="left-calendar"> 
	    			<!-- 이름, 이미지 -->
	    			<div class="profile-section">
	    					<img src="/resources/images/gamja_profile.png" alt="profile image" class="profile-img">
	    					<div class="prifile-name"> ${totalReviews.USERNAME} </div>
	    			</div>
	    		
	    			<!-- 각종 클릭 버튼 -->
				    <div class="buttons-section">	
				    	 <div class="button-row">
					    		<!--  1 -->
					    		<div class="circle-btn">
					    			<a href="/follwer">0</a>
					    			<span>팔로워</span>
					    		</div>
								
								<!-- 2 -->
								<div class="circle-btn">
									<a href="/following">0</a>
					    			<span>팔로잉</span>
								</div>
		
					    		<!-- 3 -->
					    		<div class="circle-btn" onclick="location.href='/usersearch'" id="user-btn">
					    			<div>
					    				<img src="/resources/images/usersearch.png" width="25px" alt="user-search">
					    			</div>
					    			<span>사용자 검색</span>
					    		</div>
								
								<!-- 4 -->
								<div class="circle-btn" id="reviewlist-btn">
									<a href="/myreviewlist"> ${totalReviews.TOTAL_REVIEWS} </a>
					    			<span>리뷰 리스트</span>
								</div>
						</div>
				    </div>
		    </div>
		    
		    
		    <!-- 오른쪽 : 캘린더 -->
		    <div class="right-calendar">
		    	<div id="calendar">
		    	</div>
		    </div>
    </div>

	<!-- 모달창 include -->
	<%@ include file="calendar_modal.jsp" %>
 
 
    
    <script type="text/javascript">
    $(document).ready(function() {
        	// event 배열에 값을 추가
 	        const events = [];
        	
        	<c:forEach var="review" items="${reviewsByDate}" varStatus="reviewStatus">
				events.push( {  
					title: '${review.REVIEW_TOTAL_COUNT}',
					start: '${review.REVIEW_CREATE_AT}'
				})
			</c:forEach> 
        	

            $('#calendar').fullCalendar({
            	locale: 'ko',
           	    contentHeight: 'auto',
                header: {
                    left: 'title',
                    center: '',
                    right: 'prev, next'
                },
                viewRender : function(view, element){
                	var date = view.intervalStart; // 현재 뷰 시작 날짜
                	var title = date.format('YYYY년 MM월');  // 시작 날짜 포맷
                	$('.fc-left').html('<h5>' + title + '</h5>')
                },
                events: events, 
                eventClick: function(calEvent, jsEvent, view) {
                    // 이벤트를 클릭했을 때: calEvent.start(현재 이벤트의 날짜)
                    var clickedDate = calEvent.start.format('YYYY-MM-DD');
                
                    contentsDetailsByDate(clickedDate); // 특정 날짜에 대한 영화 정보 가져오기
                }
            }); // end fullCalendar
            
            
            // 모달창 닫기
            var modal = document.getElementById("myModal");
            var close_span = document.getElementsByClassName("close")[0];
            
            close_span.onclick = function(){
            	modal.style.display = "none";
            }
            
            window.onclick = function(event) {
            	if(event.target == modal) {
            		modal.style.display = "none";
            	}
            }
 
    }); // end document
        
        
        
    function contentsDetailsByDate(clickedDate) {
        $.ajax({
            url: '/getcontentdetail',  // db에서 영화 정보 가져오는 URL
            type: 'GET',  // 요청 방식
            data: { date: clickedDate },
            success: function(detailData) { 
            	console.log(detailData); // detailData 출력
            	
                // JSON 데이터 파싱
                var resultHtml = '';
                
                detailData.forEach(function(data) {  // 반복문
                    resultHtml +=
                        '<div class="review-item">' +
                            '<img src="/resources/images/gamja_profile.png" alt="Movie Thumbnail" class="review-img">' +
                            '<div class="review-contents">' +
                                '<div class="review-title-rate">' + 
                                    '<div class="review-title">' + data.content_name + '</div>' +
                                    '<div class="review-rating">' + data.rating + '</div>' +
                                '</div>'+
                                '<div class="review-text">' + data.review_text + '</div>' +          
                            '</div>' +
                            '<div class="review-edit-time">' +
                                '<div class="button-group">' +
                                    '<button class="edit-btn" onclick="location.href=\'/modifyreview\'">수정</button>' +
                                    '<button class="delete-btn" onclick="deleteReview(\'' + data.content_name + '\', \'' + data.review_create_at + '\')">삭제</button>' +
                                '</div>' +
                                '<div class="review-time">' + data.review_create_at + '</div>' +
                            '</div>' +
                        '</div>';
                });
                
                // 모달 바디에 결과 HTML 삽입
                $('#modal-body').html(resultHtml);
                // 모달 표시
                $('#myModal').css('display', 'block');
            },
            error: function(xhr, status, error){
                alert('영화 정보를 불러오는 데 실패했습니다.');
            }
        });
    }
    
    
    function deleteReview(contentName, reviewCreateAt) {    
    	
    	// JavaScript 객체
    	const obj = {  
						content_name: contentName,
						review_create_at: reviewCreateAt
					}
    	$.ajax({
    		url: '/deletereview',  // 삭제 요청을 보낼 url
    		type: 'POST',  // 요청 방식
			contentType: 'application/json',  // 요청 데이터의 MIME 타입 
			data: JSON.stringify(obj),   // 객체를 json 문자열로 반환
			success: function(response) {
				alert(response.message);  // 서버에서 받은 메시지 출력
				if (response.redirectUrl) {
				    window.location.href = response.redirectUrl;  // 리디렉션 URL로 이동
				}
			},
    		error: function(xhr, status, error) {
    			alert('리뷰 삭제에 실패하였습니다');
    		}
    	})
    }
    
    </script>
</body>
</html>
