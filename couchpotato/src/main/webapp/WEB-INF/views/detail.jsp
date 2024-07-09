<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>

<title>aa</title>

<script>
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
			if( document.getElementById("review").value === "" || document.getElementById("review").value === null){
				alert("리뷰를 작성해주세요");
			}else if(!document.querySelector('input[name="rating"]:checked')){
				alert("별점을 체크 해주세요");
			}else{
				var rating = parseInt(document.querySelector('input[name="rating"]:checked').value, 10);
				fetch('/review/save', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/json'
	                },
	                body: JSON.stringify({
	                	userId : 1234,
	                    reviewContent: reviewContent,
	                    rating: rating,
	                    imgurl: posterPath,
	                    contentName : contentname
	                })
	                		
	            })
	            .then(response => response.text())
	            .then(data => {
	            	if(data==="success"){
	            		alert("저장 성공")
	            	}else{
	            		alert("저장 실패")
	            	}
	                modal.style.display = "none";
	            })
	            .catch(error => console.error('Error:', error));
			}
            
        }
    });
</script>
    
    
<style>
.modal {
	display: none; /* 초기에 숨겨진 상태 */
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.7);
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
</style>
</head>
<body>
	
	<p>Movie ID: ${id}</p>
	<p>media ID: ${mediatype}</p>
	<p>media ID: ${tvShowDetails}</p>


	<%-- JSON 문자열을 Jackson ObjectMapper를 사용하여 Map으로 파싱 --%>
	<%@ page import="java.io.IOException"%>
	<%@ page import="com.fasterxml.jackson.core.type.TypeReference"%>
	<%
		ObjectMapper mapper = new ObjectMapper();
		String tvShowDetailsJson = (String) request.getAttribute("tvShowDetails");

		try {
			// JSON 문자열을 Map으로 파싱
			Map<String, Object> tvShowDetails = mapper.readValue(tvShowDetailsJson,
					new TypeReference<Map<String, Object>>() {
					});

			// poster_path 값을 추출
			String posterPath = (String) tvShowDetails.get("poster_path");
			Double voteAverage = (Double) tvShowDetails.get("vote_average");
			String overview = (String) tvShowDetails.get("overview");
			ArrayList seasons = (ArrayList) tvShowDetails.get("seasons");
			String title = (String) tvShowDetails.get("name");
			
			

	%>

	<%-- poster_path가 null이 아니고 빈 문자열이 아닌 경우 이미지를 표시 --%>
	<%
		if (posterPath != null && !posterPath.isEmpty()) {
	%>
	<img src="https://image.tmdb.org/t/p/w500/<%=posterPath%>" alt="Poster"
		style="width: 300px;">
	<%
		} else {
	%>
	<p>No poster available</p>
	<%
		}
	%>
	<br>
	<%
		if (voteAverage != null) {
	%>
	<p>
		평균 평점:
		<%=voteAverage%></p>
	<%
		} else {
	%>
	<p>평점 정보 없음</p>
	<%
		}
	%>
	<p><%=overview%></p>
	<p>${ott}</p>
	
	<p></p>
	
	<div id="content">
        <c:forEach var="season" items="${seasons}">
            <div class="season">
                <h2>${season.name}</h2>
                <p><strong>Air Date:</strong> <c:out value="${season.air_date != null ? season.air_date : 'N/A'}" /></p>
                <p><strong>Episodes:</strong> ${season.episode_count}</p>
                <p><strong>Overview:</strong> ${season.overview}</p>
                <p><strong>Average Vote:</strong> ${season.vote_average}</p>
                <img src="${season.poster_path}" alt="${season.name} Poster">
            </div>
        </c:forEach>
    </div>
    
    <%-- 버튼이랑 모달 추가--%>
	<button id="btnOpenModal">리뷰 작성</button>

    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close" id="closespan">&times;</span>
            <h3>리뷰 작성</h3>
            <form id="reviewForm">
                <div class="form-group">
                    <label for="review">리뷰 내용:</label>
                    <textarea id="review" name="review" required></textarea>
                </div>
                <div class="form-group" style="display: none;">
                    <label for="review2">리뷰 내용:</label>
                    <textarea id="review2" name="review2" required><%=posterPath%></textarea>
                </div>
                <div class="form-group" style="display: none;">
                    <label for="review3">리뷰 내용:</label>
                    <textarea id="review3" name="review3" required><%=title%></textarea>
                </div>
                <div class="form-group">
                    <label>별점:</label>
                    <div class="rating">
                        <input type="radio" id="star5" name="rating" value="5" /><label for="star5">5</label>
                        <input type="radio" id="star4" name="rating" value="4" /><label for="star4">4</label>
                        <input type="radio" id="star3" name="rating" value="3" /><label for="star3">3</label>
                        <input type="radio" id="star2" name="rating" value="2" /><label for="star2">2</label>
                        <input type="radio" id="star1" name="rating" value="1" /><label for="star1">1</label>
                    </div>
                </div>
                <button type="submit" class="btn-save">저장</button>
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