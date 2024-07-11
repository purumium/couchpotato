<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.kosa.dto.MovieDTO"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/movies.css">
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
</script>
</head>
<body>

	<div class="container">
		<h2>Movies List</h2>

		<!-- Search form -->
		<form action="${pageContext.request.contextPath}/movies" method="get"
			class="search-form">
			<input type="text" name="query" class="search-input"
				value="${param.query}" placeholder="Enter movie title...">
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
	</div>
</body>
</html>
