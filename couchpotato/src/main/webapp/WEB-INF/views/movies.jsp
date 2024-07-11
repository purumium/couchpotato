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
<style>
        .pagination {
            margin-top: 20px; /* 페이지네이션과 위쪽 간격 설정 */
            text-align: center; /* 페이지네이션을 가운데 정렬 */
        }

        .pagination a, .pagination span {
            display: inline-block;
            padding: 5px 10px;
            margin: 0 2px;
            border: 1px solid #ddd;
            color: #555;
            text-decoration: none;
        }

        .pagination a:hover {
            background-color: #f5f5f5;
        }

        .pagination .current {
            font-weight: bold;
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
        }
    </style>
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
</script>
</head>
<body>
	<div class="container">
		<h2>Movies List</h2>

		<form action="${pageContext.request.contextPath}/movies" method="get"
			class="search-form">
			<input type="text" name="query" class="search-input"
				value="${param.query}" placeholder="Enter movie title..."> <input
				type="hidden" name="page" value="1">
			<!-- hidden input field for page number -->
			<button type="submit" class="search-button">Search</button>
		</form>

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
					<th></th>
					<th>Title</th>
					<th>Type</th>
					<th>Overview</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${movies}" var="mm">
					<c:if test="${not mm.mediatype.equals('person')}">
						<tr>
							<td><img
								src="https://image.tmdb.org/t/p/w200/${mm.posterpath}"
								style="height: 150px;" alt="Poster"></td>
							<td><a
								href="${pageContext.request.contextPath}/movie/detail/${mm.mediatype}/${mm.id}">
									${mm.mediatype.equals('tv') ? mm.name : mm.title} </a></td>
							<td>${mm.mediatype}</td>
							<td>${mm.overview}</td>
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
