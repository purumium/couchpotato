<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="common/calendar_header.jsp"%>
<%@ include file="calendar_modal.jsp"%>
<%@ include file="calendar_follow_modal.jsp"%>
<%@ include file="follow.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<title>my information</title>
	<link rel="stylesheet" href="/resources/css/calendar.css?v=1.0" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" />
	<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/locale/ko.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>	
</head>
<body>

	<div class="calendar-container">
		<!-- 왼쪽 -->
		<div class="left-calendar">
			<div class="left-1">
					<div class="profile-section"><!-- 프로필 이미지 -->
							<div>	
								<c:set var="profileImageUrl"  value="${not empty member.profile_picture_url ? 
											member.profile_picture_url : '/resources/images/nullProfile.png'}" />
								<img src="${profileImageUrl}" alt="profile picture" class="profile-img">
			          			</div>
			       			<div class="profile-info">
				                <div class="profile-name">
				                	 <span>${member.username}</span>
				                	 <span>#${member.user_id}</span>
				                </div>
				                <div class="profile-text">${member.email}</div>
				                <div class="profile-text">${member.date_of_birth}</div>
				            </div>
					</div>
					
					<!-- 각종 클릭 버튼 -->
				    <div class="buttons-section">	
					    	 <div class="button-row">
						    		<!--  1 -->
						    		<div class="circle-btn" id="following-btn">
										<div>${following_count}</div> 
										<span>팔로잉</span>
									</div>
									
									<!-- 2 -->
						    		<div class="circle-btn" id="follower-btn">
										<div>${follower_count}</div> 
										<span>팔로워</span>
						    		</div>
			
						    		<!-- 3 -->
						    		<div class="circle-btn" id="user-search-btn">
										<div>
											<img src="/resources/images/usersearch.png" width="30px"
												alt="user-search">
										</div>
										<span>사용자 검색</span>
									</div>
									
									<!-- 4 -->
									<div class="circle-btn" id="reviewlist-btn" onclick="location.href='/myreviewlistbymonth'">
								        <div class="circle-text">${totalReviews.TOTAL_REVIEWS}</div> 
								        <span>리뷰 리스트</span>
						    		</div>
							</div>
				  	</div>
			 </div>
			    
			<div class="left-2">
			    <div class="following-container">
			        <div class="following-calendar-header">
			            <span>내 친구 캘린더 보기</span>
			        </div>
			        
			        <div class="following-list-container">
			            <c:choose>
			                <c:when test="${empty following}">
			                    <div class="following-list-empty">
			                        <img src="/resources/images/nofollow.png" width="200px">
			                    </div>
			                </c:when>
			
			                <c:otherwise>
			                    <c:forEach var="follow" items="${following}">
			                        <div class="following-list-item">
			                            <div class="following-list">
			                                <c:set var="followImageUrl" value="${not empty follow.profile_picture_url ? 
			                                    follow.profile_picture_url : '/resources/images/nullProfile.png'}" />
			                                <img src="${followImageUrl}" alt="follow picture" class="following-img">
			                                <div class="following-list-username">${follow.username}</div>
			                                <div class="following-list-user-id">#${follow.user_id}</div>
			                            </div>
			                            <div class="following-list-btn">
			                                <button type="button" data-userid= "${follow.user_id}" data-username ="${follow.username}" 
			                                		data-userimg ="${follow.profile_picture_url}"
			                                		class="following-calendar-btn"> 캘린더보기
	                                		</button>
			                            </div>
			                        </div>
			                    </c:forEach>
			                </c:otherwise>
			            </c:choose>
			        </div>
			    </div>
			</div>
		</div>
	
	
		<!-- 오른쪽 : 캘린더 -->
		<div class="right-calendar">
			<div id="calendar"></div>
		</div>
	</div>





	<script type="text/javascript">
		$(document).ready(function() {
			// event 배열에 값을 추가
			const events = [];

			<c:forEach var="review" items="${reviewsByDate}" varStatus="reviewStatus">
				events.push({
					title : '${review.REVIEW_TOTAL_COUNT}',
					start : '${review.REVIEW_CREATE_AT}'
				})
			</c:forEach>

			$('#calendar').fullCalendar({
				locale : 'ko',
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
				events : events,
				eventClick : function(calEvent, jsEvent, view) {
					// 이벤트를 클릭했을 때: calEvent.start(현재 이벤트의 날짜)
					var clickedDate = calEvent.start.format('YYYY-MM-DD');

					contentsDetailsByDate(clickedDate); // 특정 날짜에 대한 영화 정보 가져오기
				}
			}); // end fullCalendar

			// 날짜별 상세 리뷰 보는 1번 모달창 닫기
			$('#close').click(function() {
				$('#myModal').css('display', 'none');
				location.reload();
			});

			// 수정하는 2번 모달창 닫기
			$('#cancle-modify-btn').click(function() {
				$('#editModal').css('display', 'none');
			});

			// 리뷰 수정하기: 폼 제출 이벤트에 submitModifiedReview 함수 연결
			$('#editForm').submit(submitModifiedReview)

		}); // end document

		
		function contentsDetailsByDate(clickedDate) {
			$.ajax({
						url : '/getcontentdetail', // db에서 영화 정보 가져오는 URL
						type : 'GET', // 요청 방식
						data : {
							date : clickedDate
						},
						success : function(detailData) {
							// JSON 데이터 파싱
							var resultHtml = '';
							var review_date = '';

							// 조건: 해당 날짜에 데이터가 있는 경우에는 모달에 출력해주고, 데이터가 없을 경우 모달 숨기기 
							if (detailData.length > 0) {
								detailData.forEach(function(data) { // 반복문          
									var reviewCountView = data.review_count_byname >= 2 ? ''
											: 'style="display: none;"';

									resultHtml += '<div class="review-item">'
											+ '<img src="https://image.tmdb.org/t/p/w300/' + data.content_image_url +  ' alt="Movie Thumbnail" class="review-img">'
											+ '<div class="review-contents">'
											+ '<div class="review-title-rate">'
											+	
											'<div class="review-title"> '
											+ '<a href="/movie/detail/' + data.content_type + '/' + data.content_id + '">'
											+ data.content_name
											+ '</a> </div>'
											+ '<div class="review-rating"> <img src="resources/images/rating_star.png" width="8px;">'
											+ data.rating
											+ '</div>'
											+ '<div class="review-count"' + reviewCountView + '> <img src="/resources/images/glass.png">'
											+ data.review_count_byname
											+ '회차 </div>'
											+ '</div>'
											+ '<div class="review-text">'
											+ data.review_text
											+ '</div>'
											+ '</div>'
											+ '<div class="review-edit-time">'
											+ '<div class="button-group">'
											+ ' <button class="edit-btn" onclick="openEditModal(\''
											+ data.content_name
											+ '\', \''
											+ data.review_create_at
											+ '\', \''
											+ data.review_text
											+ '\', \''
											+ data.rating
											+ '\', \''
											+ data.content_id
											+ '\', \''
											+ data.content_type
											+ '\')">수정</button>'
											+ '<button class="delete-btn" onclick="deleteReview(\''
											+ data.content_id
											+ '\', \''
											+ data.content_type
											+ '\', \''
											+ data.review_create_at
											+ '\')">삭제</button>'
											+ '</div>'
											+ '<div class="review-time">'
											+ data.review_create_at
											+ '</div>'
											+ '</div>'
											+ '</div>';
								});

								if (detailData.length > 2) {
									$('.modal-content').css('height', '370px');
									$('.modal-content').css('margin',
											'11% auto');
									$('.modal-body').css('overflow-y', 'auto');
								}

								// 모달 바디에 결과 HTML 삽입
								$('#modal-body').html(resultHtml);
								// 모달 표시
								$('#myModal').css('display', 'block');
								
							} else {
								// 데이터가 없을 경우 모달 숨기기
								$('#myModal').css('display', 'none');
								location.reload(); // 화면 새로고침, calendar.jsp 화면을 다시 불러옴
							}
						},
						error : function(xhr, status, error) {
							alert('영화 정보를 불러오는 데 실패했습니다.');
						}
					});
		}

		
		function deleteReview(contentId, contentType, reviewCreateAt) {
			// JavaScript 객체
			const obj = {
				content_id : contentId,
				content_type : contentType,
				review_create_at : reviewCreateAt
			}

			$.ajax({
				url : '/deletereview', // 삭제 요청을 보낼 url
				type : 'POST', // 요청 방식
				contentType : 'application/json', // 요청 데이터의 MIME 타입 
				data : JSON.stringify(obj), // 객체를 json 문자열로 반환
				success : function(response) {
					alert(response.message); // 서버에서 받은 메시지 출력

					// 삭제가 완료된 후에 리스트를 모달에 표시
					contentsDetailsByDate(response.review_create_at);
				},
				error : function(xhr, status, error) {
					alert('리뷰 삭제에 실패하였습니다');
				}
			})
		}

		
		function openEditModal(contentName, reviewCreateAt, reviewText, rating,
				contentId, contentType) {
			$('#edit_content_id').val(contentId);
			$('#edit_content_type').val(contentType);
			$('#edit_review_create_at').text(reviewCreateAt);
			$('#edit_content_name').text(contentName);
			$('#edit_review_text').val(reviewText);
			$('#edit_rating').val(rating);

			$('#editModal').css('display', 'block');
		}

		function submitModifiedReview(event) {
			event.preventDefault(); // 기본 폼 제출 방지

			const contentId = $('#edit_content_id').val();
			const contentType = $('#edit_content_type').val();
			const reviewText = $('#edit_review_text').val();
			const reviewCreateAt = $('#edit_review_create_at').text();
			const rating = $('#edit_rating').val();

			// 폼 데이터를 담을 자바스크립트 객체 생성
			const modifiedData = {
				content_id : contentId,
				content_type : contentType,
				review_text : reviewText,
				review_create_at : reviewCreateAt,
				rating : rating
			};

			$.ajax({
				url : '/modifyreview',
				type : 'POST',
				contentType : 'application/json',
				data : JSON.stringify(modifiedData),
				success : function(response) {
					alert(response.message);
					// 현재 모달 창 닫기
					$('#editModal').css('display', 'none');

					// 수정된 데이터를 다시 가져와서 모달에 표시
					contentsDetailsByDate(response.review_create_at);
				},
				error : function(xhr, status, error) {
					alert(status)
				}
			});

		}
	</script>
</body>
</html>
