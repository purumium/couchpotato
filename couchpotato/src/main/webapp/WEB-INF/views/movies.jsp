<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.kosa.dto.MovieDTO"%>
<!DOCTYPE html>
<html>
<head>
<title>Movies List</title>
<style>
/* Global styles */
body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

.container {
	width: 80%;
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

/* Header styles */
h2 {
	text-align: center;
	color: #333;
}

/* Search form styles */
.search-form {
	margin-bottom: 20px;
	text-align: center;
}

.search-input {
	padding: 10px;
	width: 300px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 16px;
}

.search-button {
	padding: 10px 20px;
	border: none;
	background-color: #5cb85c;
	color: white;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
}

.search-button:hover {
	background-color: #4cae4c;
}

/* Filter button styles */
.filter-buttons {
	text-align: center;
	margin-bottom: 20px;
}

.filter-buttons button {
	padding: 10px 20px;
	margin: 0 10px;
	border: none;
	background-color: #337ab7;
	color: white;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
}

.filter-buttons button:hover {
	background-color: #23527c;
}

/* Table styles */
table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	border: 1px solid #ddd;
	padding: 12px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
	color: #333;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

tr:hover {
	background-color: #f1f1f1;
}

/* Link styles */
a {
	color: #337ab7;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}
</style>
<script>
window.onpageshow = function (event){
	if(event.persisted){
		window.location.href = '${pageContext.request.contextPath}/';
	}
}

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
