<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.IOException"%>
<%@ page import="com.fasterxml.jackson.core.type.TypeReference"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/detail.css">
<title>TV Show Details</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function refreshDiv(divId) {
    fetch(window.location.href)
        .then(response => response.text())
        .then(data => {
            var tempDiv = document.createElement('div');
            tempDiv.innerHTML = data;
            var newDiv = tempDiv.querySelector('#' + divId);
            var targetDiv = document.getElementById(divId);
            if (newDiv && targetDiv) {
                targetDiv.innerHTML = newDiv.innerHTML;
            } else {
                console.error('Failed to refresh div');
            }
        })
        .catch(error => console.error('Error:', error));
}

        document.addEventListener("DOMContentLoaded", function() {
            var modal = document.getElementById("myModal");
            var btn = document.getElementById("btnOpenModal");
            var span = document.getElementById("closespan");

            btn.onclick = function() {
            	if(${user_number}==-1){
            		alert("로그인 해주세요");
            	}else{
            		modal.style.display = "block";
            	}
                
            }

            span.onclick = function() {
                modal.style.display = "none";
            }

            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }

            document.getElementById("reviewForm").onsubmit = function(event) {
                event.preventDefault();
                var reviewContent = document.getElementById("review").value;

                var posterPath = document.getElementById("review2").value;
                var contentname = document.getElementById("review3").value;
                var type = document.getElementById("review4").value;
                
                if (document.getElementById("review").value === "" || document.getElementById("review").value === null) {
                    alert("리뷰를 작성해주세요");
                } else if (!document.querySelector('input[name="starpoint"]:checked')) {
                    alert("별점을 체크 해주세요");
                } else {
                    var rating = parseFloat(document.querySelector('input[name="starpoint"]:checked').value, 10);
                    fetch('/review/save', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            userNumber: ${user_number},
                            reviewContent: reviewContent,
                            contentId : ${id},
                            contentType : type,
                            rating: rating,
                            imgurl: posterPath,
                            contentName: contentname
                        })
                    })
                    .then(response => response.text())
                    .then(data => {
                        if (data === "success") {
                        	refreshDiv('refresh');
                            alert("저장 성공")
                        } else if(data ==="already"){
                            alert("이미 리뷰를 작성하였습니다")
                        }else{
                        	alert("저장 실패")
                        }
                        modal.style.display = "none";
                        document.getElementById("review").value = "";
                        var starRadios = document.querySelectorAll('input[name="rating"]');
                        starRadios.forEach(radio => {
                            radio.checked = false;
                        });
                    })
                    .catch(error => console.error('Error:', error));
                }
            }
        });
        
        document.addEventListener("DOMContentLoaded", function() {
            var seasonsToggle = document.getElementById("toggleSeasons");
            var seasonContainer = document.querySelector(".season-container");

            seasonsToggle.onclick = function() {
                if (seasonContainer.style.display === "none" || seasonContainer.style.display === "") {
                    seasonContainer.style.display = "block";
                } else {
                    seasonContainer.style.display = "none";
                }
            }
        });
        
        //유저 아이디 필터링	
        $(document).ready(function() {
            $('#filter-button').click(function() {
                $('.review-container').each(function() {
                	var useridFromServer = document.getElementById('userIdContainer').getAttribute('data-userid');
                    var userIdText = $(this).find('.user-id').text().trim();
                    // 'userId: '를 제거하고 실제 userId 값만 추출
                    var userId = userIdText.replace('userId: ', '').trim();
                    if (userId !== useridFromServer) {
                        $(this).addClass('hidden');
                    } else {
                        $(this).removeClass('hidden');
                    }
                });
            });
            $('#reset-button').click(function() {
                $('.review-container').removeClass('hidden');
            });
        });
       
    </script>
</head>
<body>
	<%@ include file="common/header.jsp" %>

	<div id="userIdContainer" data-userid="${loginMemberId}"
		style="display: none;">
		<!-- userid를 data- 속성으로 저장 -->
		<p>${loginMemberId}</p>
	</div>


	<%
		ObjectMapper mapper = new ObjectMapper();
		String tvShowDetailsJson = (String) request.getAttribute("tvShowDetails");

		try {
			Map<String, Object> tvShowDetails = mapper.readValue(tvShowDetailsJson,
					new TypeReference<Map<String, Object>>() {
					});

			String posterPath = (String) tvShowDetails.get("poster_path");
			Double voteAverage = (Double) tvShowDetails.get("vote_average");
			String overview = (String) tvShowDetails.get("overview");
			ArrayList<Map<String, Object>> seasons = (ArrayList<Map<String, Object>>) tvShowDetails.get("seasons");
			String title = "";
			String mediatype = (String) request.getAttribute("mediatype");
			if (mediatype.equals("tv")) {
				title = (String) tvShowDetails.get("name");
			} else {
				title = (String) tvShowDetails.get("title");
			}
	%>

	<div class="total-container">
		<div class="container">
			<div class="poster">
			    <% if (posterPath != null && !posterPath.isEmpty()) { %>
			        <img src="https://image.tmdb.org/t/p/w500/<%= posterPath %>" alt="Poster">
			    <% } else { %>
			        <img src="<%= request.getContextPath() %>/resources/images/noimg.png" alt="Poster">
			    <% } %>
			</div>
	    
		    <div class="rignt-total">
			    <div class="details">
			        <div class="info-box">
			            <div><%= title %></div>
			        </div>
			        <div class="info-box2">
			            <span> 평균 평점 </span>
			            <% if (voteAverage != null) { %>
			            <p> <%= voteAverage %> </p>
			            <img src="<%= request.getContextPath() %>/resources/images/rating_star.png" width="20px"> 
			            <% } else { %>
			            <p> 평점 정보 없음 </p>
			            <% } %>
			        </div>
			        <div class="info-box3">
			            <p><%= overview %></p>
			        </div>
			        <div class="info-box4">
			            <span> 감상 가능한 곳 </span>
			            <% 
			                String stt = (String) request.getAttribute("ott");
			                if (stt != null && !stt.isEmpty()) { 
			            %>
			            <div>${ott}</div>
			            <% } else { %>
			            <div> 정보 없음 </div>
			            <% } %>
			        </div>
		        </div>
		        
		       	            
		        <%
					if (seasons != null) {
				%>
				<div class="detail-button-container">	
						<div class="container">
							<div class="info-box5">
								<button id="toggleSeasons">시즌 정보</button>
							</div>
						</div>
				        <button id="btnOpenModal">
				             <img src="<%= request.getContextPath() %>/resources/images/check.png" width="14px">
				             <span>리뷰 작성</span>
				        </button>
			     </div>
				<% } else { %> 
		        <button id="btnOpenModal">
	                <img src="<%= request.getContextPath() %>/resources/images/check.png" width="14px">
	                <span>리뷰 작성</span>
	            </button> 
			    <% } %>       
			</div>
		</div>
	</div>
	
		
	<div class="season-container" style="display: none;">
	    <div class="season-content">
	        <ul id="seasonList">
	            <% for (Map<String, Object> season : seasons) { %>
	            <li class="season-item">
	                <% 
	                String seasonPosterPath = (String) season.get("poster_path");
	                if (seasonPosterPath != null && !seasonPosterPath.isEmpty()) { %>
	                    <img src="https://image.tmdb.org/t/p/w500/<%=seasonPosterPath%>" alt="Poster">
	                <% } else { %>
	                    <img src="<%= request.getContextPath() %>/resources/images/noimg.png" alt="Poster">
	                <% } %>
	                
	                <div class="items">
	                    <div class="item">
	                        <span>시즌 이름</span> 
	                        <span><%=season.get("name")%> </span>
	                    </div>
	                    <div class="item">
	                        <span>방영일</span> 
	                        <span><%=season.get("air_date") != null ? season.get("air_date") : "미정"%> </span>
	                    </div>
	                    <div class="item">
	                        <span>에피소드 수</span> 
	                        <span><%=season.get("episode_count")%> </span>
	                    </div>
	                    <div class="item">
	                        <span>평균 평점</span> 
	                        <span><%=season.get("vote_average")%> </span>
	                    </div>
	                </div>
	            </li>
	            <% } %>
	        </ul>
	    </div>
	</div>


	<div>
		<div id="refresh">
			<c:if test="${not empty selectreviews}">
				<c:if test="${loginMemberId != 'null'}">
					<button id="reset-button">전체 리뷰</button>
					<button id="filter-button">내 리뷰 보기</button>
				</c:if>
				<div class="container2">
					<c:forEach var="review" items="${selectreviews}">
						<div class="review-container">
							<p>
								<span class="user-id">userId: ${review.userId}</span><br>
								rating: ${review.rating}<br> reviewContent:
								${review.reviewContent}
							</p>
						</div>
					</c:forEach>
				</div>
			</c:if>
		</div>
	</div>


	<div id="myModal" class="modal">
		<div class="modal-content">
			<div class="title">
				<img src="<%= request.getContextPath() %>/resources/images/modify.png" width="25px;"> 
				<span>REGISTER REVIEW</span> 
			</div>
			<form id="reviewForm">
				<div class="form-info">
					<div class="form-group" >
						<label for="review3">
							<img src="<%= request.getContextPath() %>/resources/images/reviewregister.png" width="10px;"> 콘텐츠명 
						</label>
						<input id="review3" name="review3" value="<%=title%>" disabled>
					</div>
					<div class="form-group">
						<label for="review">
							<img src="<%= request.getContextPath() %>/resources/images/reviewregister.png" width="10px;"> 리뷰내용
						</label>
						<textarea id="review" name="review" required></textarea>
					</div>
					<div class="form-group" style="display: none;">
						<label for="review2">이미지경로:</label>
						<textarea id="review2" name="review2" required><%=posterPath%></textarea>
					</div>
					<div class="form-group" style="display: none;">
						<label for="review4">타입:</label>
						<textarea id="review4" name="review3" required><%=mediatype%></textarea>
					</div>
					<div class="form-group">
						<label>별점</label>
						<div class="starpoint_wrap">
							<div class="starpoint_box">
								<label for="starpoint_1" class="label_star" title="0.5"><span
									class="blind">0.5점</span></label> <label for="starpoint_2"
									class="label_star" title="1"><span class="blind">1점</span></label>
								<label for="starpoint_3" class="label_star" title="1.5"><span
									class="blind">1.5점</span></label> <label for="starpoint_4"
									class="label_star" title="2"><span class="blind">2점</span></label>
								<label for="starpoint_5" class="label_star" title="2.5"><span
									class="blind">2.5점</span></label> <label for="starpoint_6"
									class="label_star" title="3"><span class="blind">3점</span></label>
								<label for="starpoint_7" class="label_star" title="3.5"><span
									class="blind">3.5점</span></label> <label for="starpoint_8"
									class="label_star" title="4"><span class="blind">4점</span></label>
								<label for="starpoint_9" class="label_star" title="4.5"><span
									class="blind">4.5점</span></label> <label for="starpoint_10"
									class="label_star" title="5"><span class="blind">5점</span></label>
								<input type="radio" name="starpoint" id="starpoint_1"
									class="star_radio" value=0.5> <input type="radio"
									name="starpoint" id="starpoint_2" class="star_radio" value=1.0>
								<input type="radio" name="starpoint" id="starpoint_3"
									class="star_radio" value=1.5> <input type="radio"
									name="starpoint" id="starpoint_4" class="star_radio" value=2.0>
								<input type="radio" name="starpoint" id="starpoint_5"
									class="star_radio" value=2.5> <input type="radio"
									name="starpoint" id="starpoint_6" class="star_radio" value=3.0>
								<input type="radio" name="starpoint" id="starpoint_7"
									class="star_radio" value=3.5> <input type="radio"
									name="starpoint" id="starpoint_8" class="star_radio" value=4.0>
								<input type="radio" name="starpoint" id="starpoint_9"
									class="star_radio" value=4.5> <input type="radio"
									name="starpoint" id="starpoint_10" class="star_radio" value=5.0>
								<span class="starpoint_bg"></span>
							</div>
						</div>
					</div> 
				<div class="form-btn">
					<button type="submit" class="btn-save">저장</button>
					<button type="button" class="btn-save" id="closespan"> 취소</button>
				</div>
			</form>
		</div>
	</div>

	<%
		} catch (IOException e) {
			e.printStackTrace();
			// 예외 처리 로직 추가
		}
	%>

</body>
</html>