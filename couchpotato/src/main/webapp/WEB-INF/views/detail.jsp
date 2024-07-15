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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/detail.css">
<title>TV Show Details</title>
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
                modal.style.display = "block";
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
                } else if (!document.querySelector('input[name="rating"]:checked')) {
                    alert("별점을 체크 해주세요");
                } else {
                    var rating = parseInt(document.querySelector('input[name="rating"]:checked').value, 10);
                    fetch('/review/save', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            userNumber: 1,
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
    </script>
</head>
<body>
	<%@ include file="common/header.jsp" %>

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

	
	
	
	<div id ="refresh">
	<c:if test="${not empty selectreviews}">
		<div class="container2">
			<c:forEach var="review" items="${selectreviews}">
				<div class="review-container">
					<p>
						userId: ${review.userId}<br> rating: ${review.rating}<br>
						reviewContent: ${review.reviewContent}
					</p>
				</div>
			</c:forEach>
		</div>
	</c:if>
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
						<label> 
							<img src="<%= request.getContextPath() %>/resources/images/reviewregister.png" width="10px;">별점평가
						</label>
						<div class="rating" style="display: inline-block;">
							<input type="radio" id="star5" name="rating" value="5" /><label
								for="star5">5</label> <input type="radio" id="star4"
								name="rating" value="4" /><label for="star4">4</label> <input
								type="radio" id="star3" name="rating" value="3" /><label
								for="star3">3</label> <input type="radio" id="star2"
								name="rating" value="2" /><label for="star2">2</label> <input
								type="radio" id="star1" name="rating" value="1" /><label
								for="star1">1</label>
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
