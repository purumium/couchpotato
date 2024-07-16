<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.kosa.dto.MovieDTO"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/movies.css">
<title>Movies List</title>
<script>
	// 필터링 함수
	function filterMediaType(type) {
		var rows = document.querySelectorAll("tbody tr");

		rows
				.forEach(function(row) {
					var mediatypeCell = row.querySelector("td:nth-child(3)").textContent
							.trim().toLowerCase();
					if (type === 'all' || mediatypeCell === type) {
						row.style.display = '';
					} else {
						row.style.display = 'none';
					}
				});
	}
	
	document.addEventListener("DOMContentLoaded", function() {
	    var overviews = document.querySelectorAll('.overview');
	    overviews.forEach(function(overview) {
	        var fullText = overview.innerText;
	        var maxLength = 250; // 최대 텍스트 길이

	        if (fullText.length > maxLength) {
	            var truncatedText = fullText.substring(0, maxLength);
	            overview.innerText = truncatedText + '...';
	        }
	    });
	});
	
	
</script>
</head>
<body>
	<%@ include file="common/header.jsp" %>
	
	<div class="container">

		<!-- Filter buttons -->
		<div class="filter-buttons">
			<button onclick="filterMediaType('all')">All</button>
			<button onclick="filterMediaType('movie')">Movies</button>
			<button onclick="filterMediaType('tv')">TV Shows</button>
		</div>



		<!-- Movies table -->
		<table>
			<thead>
				<tr>
					<th>포스터</th>
					<th>콘텐츠명</th>
					<th>유형</th>
					<th>줄거리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${movies}" var="mm">
					<c:if test="${not mm.mediatype.equals('person')}">
						<tr>
							<td>
							<c:choose>
	                            <c:when test="${mm.posterpath != null && not empty mm.posterpath}">
	                                    <img src="https://image.tmdb.org/t/p/w200/${mm.posterpath}" style="height: 150px;" alt="Poster">
	                                </c:when>
	                                <c:otherwise>
	                                    <img src="${pageContext.request.contextPath}/resources/images/noimg.png" style="height: 150px;" alt="Poster">
	                                </c:otherwise>
	                            </c:choose>
							</td>
							<td>
								<a
									href="${pageContext.request.contextPath}/movie/detail/${mm.mediatype}/${mm.id}">
									${mm.mediatype.equals('tv') ? mm.name : mm.title} </a>
								<span class="type">${mm.mediatype}</span>
							</td>
							<td>${mm.mediatype}</td>
							<td class="overview">${mm.overview}</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<!-- 페이징 -->
<div class="pagination">
    <c:choose>
        <c:when test="${totalpage <= 5}">
            <c:forEach var="page" begin="1" end="${totalpage}">
                <a href="${pageContext.request.contextPath}/movies?query=${param.query}&page=${page}" class="${param.page == page ? 'current' : ''}">${page}</a>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <c:if test="${param.page > 3}">
                <a href="${pageContext.request.contextPath}/movies?query=${param.query}&page=1">1</a>
                <span>...</span>
            </c:if>
            
            <c:set var="startPage" value="${param.page - 2}" />
            <c:set var="endPage" value="${param.page + 2}" />
            
            <c:if test="${startPage < 1}">
                <c:set var="startPage" value="1" />
                <c:set var="endPage" value="5" />
            </c:if>
            
            <c:if test="${endPage > totalpage}">
                <c:set var="endPage" value="${totalpage}" />
                <c:set var="startPage" value="${totalpage - 4}" />
            </c:if>
            
            <c:forEach var="page" begin="${startPage}" end="${endPage}">
                <a href="${pageContext.request.contextPath}/movies?query=${param.query}&page=${page}" class="${param.page == page ? 'current' : ''}">${page}</a>
            </c:forEach>
            
            <c:if test="${endPage < totalpage - 1}">
                <span>...</span>
            </c:if>
            <c:if test="${endPage < totalpage}">
                <a href="${pageContext.request.contextPath}/movies?query=${param.query}&page=${totalpage}" class="${param.page == totalpage ? 'current' : ''}">${totalpage}</a>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>


	</div>
</body>
</html>
