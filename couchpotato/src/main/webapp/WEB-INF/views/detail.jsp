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
<style>
.review-container {
	border: 1px solid #ddd;
	padding: 10px;
	margin: 10px 0;
}

.hidden {
	display: none;
}
</style>
<style>
.starpoint_wrap {
	display: inline-block;
}

.starpoint_box {
	position: relative;
	background:
		url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 0
		no-repeat;
	font-size: 0;
}

.starpoint_box .starpoint_bg {
	display: block;
	position: absolute;
	top: 0;
	left: 0;
	height: 18px;
	background:
		url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0
		-20px no-repeat;
	pointer-events: none;
}

.starpoint_box .label_star {
	display: inline-block;
	width: 10px;
	height: 18px;
	box-sizing: border-box;
}

.starpoint_box .star_radio {
	opacity: 0;
	width: 0;
	height: 0;
	position: absolute;
}

.starpoint_box .star_radio:nth-of-type(1):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(1):checked ~ .starpoint_bg {
	width: 10%;
}

.starpoint_box .star_radio:nth-of-type(2):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(2):checked ~ .starpoint_bg {
	width: 20%;
}

.starpoint_box .star_radio:nth-of-type(3):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(3):checked ~ .starpoint_bg {
	width: 30%;
}

.starpoint_box .star_radio:nth-of-type(4):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(4):checked ~ .starpoint_bg {
	width: 40%;
}

.starpoint_box .star_radio:nth-of-type(5):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(5):checked ~ .starpoint_bg {
	width: 50%;
}

.starpoint_box .star_radio:nth-of-type(6):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(6):checked ~ .starpoint_bg {
	width: 60%;
}

.starpoint_box .star_radio:nth-of-type(7):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(7):checked ~ .starpoint_bg {
	width: 70%;
}

.starpoint_box .star_radio:nth-of-type(8):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(8):checked ~ .starpoint_bg {
	width: 80%;
}

.starpoint_box .star_radio:nth-of-type(9):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(9):checked ~ .starpoint_bg {
	width: 90%;
}

.starpoint_box .star_radio:nth-of-type(10):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(10):checked ~ .starpoint_bg {
	width: 100%;
}

.blind {
	position: absolute;
	clip: rect(0, 0, 0, 0);
	margin: -1px;
	width: 1px;
	height: 1px;
	overflow: hidden;
}
</style>
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

            if (seasonsToggle) {  // seasonsToggle이 존재하는지 확인
                var seasonList = document.getElementById("seasonList");

                seasonsToggle.addEventListener("click", function() {
                    if (seasonList.style.display === "none") {
                        seasonList.style.display = "block";
                    } else {
                        seasonList.style.display = "none";
                    }
                });
            } else {
                
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

	<div class="container">
		<%
			if (posterPath != null && !posterPath.isEmpty()) {
		%>
		<div class="poster">
			<img src="https://image.tmdb.org/t/p/w500/<%=posterPath%>"
				alt="Poster" style="width: 300px; border-radius: 8px;">
		</div>
		<%
			} else {
		%>
		<p>No poster available</p>
		<%
			}
		%>
		<div class="details">
			<div class="info-box">
				<p>
					제목:
					<%=title%></p>
			</div>
			<div class="info-box">
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
			</div>
			<div class="info-box">
				<p>
					줄거리:
					<%=overview%></p>
			</div>

			<%
				String stt = (String) request.getAttribute("ott");

					if (!stt.equals("") || stt != null) {
			%>
			<div class="info-box">
				<p>시청 가능: ${ott}</p>
			</div>
			<%
				}
			%>
			<!--<img src="/resources/images/kino.jpg" alt="OTT 이미지"
                    style="width: 20px; height: 20px; margin-right: 5px;">  -->

			<!-- <p>데이터: ${tvShowDetails}</p> -->
			<!-- 시즌 정보 출력 -->

		</div>
	</div>
	<div class="button-container">
		<button id="btnOpenModal">리뷰 작성</button>
	</div>
	<br>
	<%
		if (seasons != null) {
	%>
	<div class="container">
		<div class="info-box">
			<button id="toggleSeasons">시즌 정보</button>
			<ul id="seasonList" style="display: none;">
				<%
					for (Map<String, Object> season : seasons) {
				%>
				<li style="display: flex; align-items: center;"><img
					src="https://image.tmdb.org/t/p/w500/<%=season.get("poster_path")%>"
					alt="Poster"
					style="width: 150px; height: auto; margin-right: 10px;">
					<div>
						<strong>시즌 이름:</strong>
						<%=season.get("name")%><br> <strong>방영일:</strong>
						<%=season.get("air_date") != null ? season.get("air_date") : "미정"%><br>
						<strong>에피소드 수:</strong>
						<%=season.get("episode_count")%><br> <strong>평균 평점:</strong>
						<%=season.get("vote_average")%><br> <strong>시즌 설명:</strong>
						<%=season.get("overview")%><br> <br>
					</div></li>
				<br>
				<%
					}
				%>
			</ul>
		</div>
	</div>
	<%
		}
	%>
	<br>

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
			<span class="close" id="closespan">&times;</span>
			<h3>리뷰 작성</h3>
			<form id="reviewForm">
				<div class="form-group">
					<label for="review">리뷰 내용:</label>
					<textarea id="review" name="review" required></textarea>
				</div>
				<div class="form-group" style="display: none;">
					<label for="review2">이미지경로:</label>
					<textarea id="review2" name="review2" required><%=posterPath%></textarea>
				</div>
				<div class="form-group" style="display: none;">
					<label for="review3">제목:</label>
					<textarea id="review3" name="review3" required><%=title%></textarea>
				</div>
				<div class="form-group" style="display: none;">
					<label for="review4">타입:</label>
					<textarea id="review4" name="review3" required><%=mediatype%></textarea>
				</div>
				<div class="form-group">
					<label>별점:</label>
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
