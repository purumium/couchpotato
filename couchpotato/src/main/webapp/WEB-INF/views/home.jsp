<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.kosa.dto.MovieDTO"%>
<%@ page import="com.kosa.dto.MovieRanking" %>

<html>
<head>
<title>Movies Search Results</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f2f2f2;
	margin: 0;
	padding: 0;
}

.container {
	display: flex;
	justify-content: center;
	align-items: flex-start;
	height: 20vh;
}

.search-form {
	text-align: center;
	background-color: #ffffff;
	padding: 20px;
	border: 1px solid #dddddd;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 500px;
	margin-top: 20px;
}

.search-input {
	padding: 8px;
	width: calc(100% - 120px);
	margin-right: 8px;
	border: 1px solid #ccc;
	border-radius: 3px;
	font-size: 14px;
}

.search-button {
	padding: 8px 16px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 3px;
	cursor: pointer;
	font-size: 14px;
}

.search-button:hover {
	background-color: #45a049;
}

.info-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
}

.info-item {
	width: 250px;
	margin: 10px;
	padding: 10px;
	background-color: #ffffff;
	border: 1px solid #dddddd;
	border-radius: 5px;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
	flex: 1 0 30%;
	min-width: 250px;
	max-width: 350px;
	cursor: pointer;
}

.info-label {
	font-weight: bold;
}

.info-value {
	margin-top: 5px;
}

.info-label img {
	width: 20px;
	height: 20px;
	vertical-align: middle;
}

.table-container {
	display: none;
	margin-top: 20px;
	margin-left: 400px;
	margin-right: 400px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid #dddddd;
}

th, td {
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}
</style>
<script>

const rankings = ${m_array}



function toggleTable(event) {
    const clickedItem = event.currentTarget;
    const tableContainer = document.querySelector('.table-container');
    const infoValue = clickedItem.querySelector('.info-value').innerText;

    // Remove existing h1 if present
    const existingH1 = document.querySelector('.table-container h1');
    if (existingH1) {
        existingH1.remove();
    }

    // Toggle the display style of the table container
    const displayStyle = tableContainer.style.display;

    if (displayStyle === 'block' && existingH1 && existingH1.innerText === infoValue) {
        tableContainer.style.display = 'none';
    } else {
        tableContainer.style.display = 'block';

        // Create and insert new h1
        const newH1 = document.createElement('h1');
        newH1.innerText = infoValue;
        newH1.style.display='none'
        tableContainer.insertBefore(newH1, tableContainer.firstChild);

        generateTable(infoValue);
    }
}

function generateTable(infoValue) {
	// JSP에서 자바스크립트로 rankings 데이터를 전달합니다.

    
    const tableContainer = document.querySelector('.table-container');
    
    // 기존 테이블이 있다면 제거
    const existingTable = tableContainer.querySelector('table');
    if (existingTable) {
        existingTable.remove();
    }
    console.log("변수의 값은:", infoValue);
    console.log("변수의 값은:", rankings);
    // infoValue에 따라 데이터를 필터링
    const filteredData = rankings.filter(item => item.site === infoValue);

    // 테이블 생성
    const table = document.createElement('table');
    
    // 테이블 헤더 생성 (필요에 따라 수정)
    const thead = document.createElement('thead');
    const headerRow = document.createElement('tr');
    const headerCell1 = document.createElement('th');
    headerCell1.innerText = 'img';
    const headerCell2 = document.createElement('th');
    headerCell2.innerText = 'rank';
    const headerCell3 = document.createElement('th');
    headerCell3.innerText = 'titie';
    headerRow.appendChild(headerCell1);
    headerRow.appendChild(headerCell2);
    headerRow.appendChild(headerCell3);
    thead.appendChild(headerRow);
    table.appendChild(thead);

    // 테이블 바디 생성
    const tbody = document.createElement('tbody');
    filteredData.forEach(item => {
        const row = document.createElement('tr');
        const cell1 = document.createElement('td');
        const img = document.createElement('img');
        img.src = item.imageUrl;
        img.width = 100; // 너비를 100픽셀로 설정
        img.height = 150; // 높이를 100픽셀로 설정
        cell1.appendChild(img);
        const cell2 = document.createElement('td');
        cell2.innerText = item.id;
        const cell3 = document.createElement('td');
        cell3.innerText = item.title;
        row.appendChild(cell1);
        row.appendChild(cell2);
        row.appendChild(cell3);
        tbody.appendChild(row);
    });
    table.appendChild(tbody);

    // 테이블 컨테이너에 테이블 추가
    tableContainer.appendChild(table);
}

document.addEventListener('DOMContentLoaded', () => {
    const infoItems = document.querySelectorAll('.info-item');
    infoItems.forEach(item => {
        item.addEventListener('click', toggleTable);
    });
});
</script>
</head>
<body>

	<div class="container">
		<form action="${pageContext.request.contextPath}/movies" method="get"
			class="search-form">
			<input type="text" name="query" class="search-input"
				value="${param.query}" placeholder="Enter movie title...">
			<button type="submit" class="search-button">Search</button>
		</form>
	</div>
	<div class="info-container">
		<div class="info-item">
			<span class="info-label"><img src="/resources/images/kino.jpg"
				alt="Label Image"></span> <span class="info-value">통합</span>
		</div>
		<div class="info-item">
			<span class="info-label"><img src="/resources/images/netflix.jpg"
				alt="Label Image"> <span class="info-value">넷플릭스</span>
		</div>
		<div class="info-item">
			<span class="info-label"><img src="/resources/images/disney.jpg"
				alt="Label Image"> <span class="info-value">디즈니</span>
		</div>
	</div>
	<div class="info-container">
		<div class="info-item">
			<span class="info-label"><img src="/resources/images/coupang.jpg"
				alt="Label Image"> <span class="info-value">쿠팡</span>
		</div>
		<div class="info-item">
			<span class="info-label"><img src="/resources/images/watcha.jpg"
				alt="Label Image"> <span class="info-value">와챠</span>
		</div>
		<div class="info-item">
			<span class="info-label"><img src="/resources/images/tving.jpg"
				alt="Label Image"> <span class="info-value">티빙</span>
		</div>
	</div>
	<div class="info-container">
		<div class="info-item">
			<span class="info-label"><img src="/resources/images/wave.jpg"
				alt="Label Image"> <span class="info-value">웨이브</span>
		</div>
		<div class="info-item">
			<span class="info-label"><img src="/resources/images/movie.jpg"
				alt="Label Image"> <span class="info-value">박스오피스</span>
		</div>
	</div>
	

    
	<div class="table-container">
		<table>
			<thead>
				<tr>
					<th style="width:10%"></th>
					<th style="width:10%">rank</th>
					<th>title</th>
				</tr>
			</thead>
			<tbody id="table-body">
				<!-- Rows will be added here dynamically -->
			</tbody>
		</table>
	</div>
</body>
</html>
