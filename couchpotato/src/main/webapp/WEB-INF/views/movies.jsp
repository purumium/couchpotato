<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.kosa.dto.MovieDTO"%>
<html>
<head>
<title>Movies Search Results</title>
<style>
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

.search-form {
	margin-bottom: 20px;
}

.search-input {
	padding: 8px;
	width: 300px;
}

.search-button {
	padding: 8px;
}
</style>
</head>
<body>
	<h2>Search Results</h2>
	<table>
		<thead>
			<tr>
				<th>Title</th>
				<th>type</th>
				<th>Overview</th>
			</tr>
		</thead>
		<tbody>
			<%
				List<MovieDTO> movies = (List<MovieDTO>) request.getAttribute("movies");
				if (movies != null) {
					for (int i = 0; i < movies.size(); i++) {
						MovieDTO mm = movies.get(i);
			%>
			<tr>
				<%if(!mm.getMediatype().equals("person")){
					%>
					<td><a
					href="<%="movie/detail/" + mm.getMediatype() + "/" + mm.getId()%>">
						<%=mm.getMediatype().equals("tv") ? mm.getName() : mm.getTitle()%>
					</a></td>
					<td><%=mm.getMediatype()%></td>
					<td><%=mm.getOverview()%></td>
					<%
				}%>
				
			</tr>
			<%
				}
				}
			%>
		</tbody>
	</table>
</body>
</html>
