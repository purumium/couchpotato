<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.kosa.dto.MovieDTO"%>
<%@ page import="com.kosa.dto.MovieRanking" %>

<!DOCTYPE html>
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

/* 모달 창 스타일링 */
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
	background-color: #fefefe;
	margin: 5% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 60%;
	max-width: 600px;
	max-height: 70%;
	overflow-y: auto;
	border-radius: 5px;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover,
.close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
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
const rankings = ${m_array};

function toggleModal(event) {
    const clickedItem = event.currentTarget;
    const modal = document.getElementById('myModal');
    const infoValue = clickedItem.querySelector('.info-value').innerText;

    // Remove existing h1 if present
    const existingH1 = modal.querySelector('h1');
    if (existingH1) {
        existingH1.remove();
    }

    // Create and insert new h1
    const newH1 = document.createElement('h1');
    newH1.innerText = infoValue;
    newH1.style.display = 'none';
    modal.querySelector('.modal-content').insertBefore(newH1, modal.querySelector('.modal-content').firstChild);

    generateTable(infoValue);
    modal.style.display = 'block';
}

function generateTable(infoValue) {
    const modalContent = document.querySelector('.modal-content');
    
    // Remove existing table if present
    const existingTable = modalContent.querySelector('table');
    if (existingTable) {
        existingTable.remove();
    }

    // Filter data based on infoValue
    const filteredData = rankings.filter(item => item.site === infoValue);

    // Create table
    const table = document.createElement('table');
    
    // Create table header
    const thead = document.createElement('thead');
    const headerRow = document.createElement('tr');
    const headerCell1 = document.createElement('th');
    headerCell1.innerText = 'Img';
    const headerCell2 = document.createElement('th');
    headerCell2.innerText = 'Rank';
    const headerCell3 = document.createElement('th');
    headerCell3.innerText = 'Title';
    headerRow.appendChild(headerCell1);
    headerRow.appendChild(headerCell2);
    headerRow.appendChild(headerCell3);
    thead.appendChild(headerRow);
    table.appendChild(thead);

    // Create table body
    const tbody = document.createElement('tbody');
    filteredData.forEach(item => {
        const row = document.createElement('tr');
        const cell1 = document.createElement('td');
        const img = document.createElement('img');
        img.src = item.imageUrl;
        img.width = 100; // Set width to 100 pixels
        img.height = 150; // Set height to 150 pixels
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

    // Append table to modal content
    modalContent.appendChild(table);
}

document.addEventListener('DOMContentLoaded', () => {
    const infoItems = document.querySelectorAll('.info-item');
    infoItems.forEach(item => {
        item.addEventListener('click', toggleModal);
    });

    // Get the modal
    const modal = document.getElementById('myModal');

    // Get the <span> element that closes the modal
    const span = document.getElementsByClassName('close')[0];

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = 'none';
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    }
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

	<!-- The Modal -->
	<div id="myModal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<!-- Table will be added here dynamically -->
		</div>
	</div>

</body>
</html>
