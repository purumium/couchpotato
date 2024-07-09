<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.IOException"%>
<%@ page import="com.fasterxml.jackson.core.type.TypeReference"%>

<!DOCTYPE html>
<html>
<head>
<title>TV Show Details</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f9;
    color: #333;
    margin: 0;
    padding: 20px;
}

.container {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
    max-width: 1000px;
    margin: 0 auto;
    background-color: #fff;
    padding: 20px 10px; /* 줄인 패딩 */
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.poster {
    margin-right: 20px;
    flex-shrink: 0;
}

.details {
    max-width: 580px; /* 줄인 최대 너비 */
}

.info-box {
    margin-bottom: 20px;
    padding: 15px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #f9f9f9;
}

.details p {
    margin: 0;
    line-height: 1.6;
}

.button-container {
    display: flex;
    justify-content: flex-end;
    max-width: 1000px;
    margin: 20px auto 0 auto;
}

.modal {
    display: none;
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
    margin: 10% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 500px;
    border-radius: 8px;
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

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

.form-group textarea {
    width: 100%;
    height: 100px;
    padding: 10px;
    box-sizing: border-box;
    border-radius: 4px;
    border: 1px solid #ddd;
}

.rating input {
    display: none;
}

.rating label {
    float: right;
    padding: 10px;
    font-size: 24px;
    color: #ddd;
    transition: all 0.3s;
    cursor: pointer;
}

.rating input:checked ~ label, .rating input:hover ~ label {
    color: #ffd700;
}

.btn-save, #btnOpenModal {
    background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn-save:hover, #btnOpenModal:hover {
    background-color: #45a049;
}

h3 {
    margin-top: 0;
}

</style>
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
                            userId: 1234,
                            reviewContent: reviewContent,
                            rating: rating,
                            imgurl: posterPath,
                            contentName: contentname
                        })

                    })
                    .then(response => response.text())
                    .then(data => {
                        if (data === "success") {
                            alert("저장 성공")
                        } else {
                            alert("저장 실패")
                        }
                        modal.style.display = "none";
                    })
                    .catch(error => console.error('Error:', error));
                }
            }
        });
    </script>
</head>
<body>
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
			ArrayList seasons = (ArrayList) tvShowDetails.get("seasons");
			String title = (String) tvShowDetails.get("name");
	%>

	<div class="container">
    <% if (posterPath != null && !posterPath.isEmpty()) { %>
        <div class="poster">
            <img src="https://image.tmdb.org/t/p/w500/<%=posterPath%>" alt="Poster" style="width: 300px; border-radius: 8px;">
        </div>
    <% } else { %>
        <p>No poster available</p>
    <% } %>
    <div class="details">
    	<div class="info-box">
            <p>제목: <%=title%></p>
        </div>
        <div class="info-box">
            <% if (voteAverage != null) { %>
                <p>평균 평점: <%=voteAverage%></p>
            <% } else { %>
                <p>평점 정보 없음</p>
            <% } %>
        </div>
        <div class="info-box">
            <p>줄거리: <%=overview%></p>
        </div>
        <div class="info-box">
            <p>시청 가능: ${ott}</p>
        </div>
        <!-- <p>데이터: ${tvShowDetails}</p> -->
    </div>
</div>
<div class="button-container">
    <button id="btnOpenModal">리뷰 작성</button>
</div>

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
				<div>
					<button type="submit" class="btn-save">저장</button>
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
