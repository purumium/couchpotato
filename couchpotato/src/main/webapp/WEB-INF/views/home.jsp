<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.kosa.dto.MovieDTO"%>
<%@ page import="com.kosa.dto.MovieRanking"%>

<!DOCTYPE html>
<html>
<head>
<title>Movies Search Results</title>
<link rel="stylesheet" href="/resources/css/home.css?v=1.0" />
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
    headerCell1.innerText = '';
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
    <%@ include file="common/homeheader.jsp" %>

	<div class="home-container">
		<div class="logo-header">
			<div class="home-logo">
		        <img src="${pageContext.request.contextPath}/resources/images/logo_wild.png" alt="logo">
		        <img src="${pageContext.request.contextPath}/resources/images/logo_font.png" alt="logo">
		    </div>
		</div>
	
		<div class="container">
			<form action="${pageContext.request.contextPath}/movies" method="get" class="search-form">
				<img src="/resources/images/search.svg" alt="search" class="search-icon">
		        <input type="text" placeholder="검색" name="query" value="${param.query}">
		        <button type="submit" class="search-button">x</button>
			</form>
		</div>
		<div class="info-total-container">
			<div class="info-container">
				<div class="info-item">
					<div class="info-label">
						<img src="/resources/images/kino.jpg" alt="Label Image"></div> 
					<div class="info-value">통합</div>
				</div>
				<div class="info-item">
					<div class="info-label">
						<img src="/resources/images/netflix.jpg" alt="Label Image"> 
					</div>
					<div class="info-value">넷플릭스</div>
				</div>
				<div class="info-item">
					<div class="info-label">
						<img src="/resources/images/disney.jpg" alt="Label Image"> 
					</div>
					<div class="info-value">디즈니</div>
				</div>
				<div class="info-item">
					<div class="info-label">
						<img src="/resources/images/coupang.jpg" alt="Label Image"> 
					</div>
					<div class="info-value">쿠팡</div>
				</div>
			</div>
			
			<div class="info-container">
				<div class="info-item">
					<div class="info-label">
						<img src="/resources/images/watcha.jpg" alt="Label Image"> 
					</div>
					<div class="info-value">와챠</div>
				</div>
				<div class="info-item">
					<div class="info-label">
						<img src="/resources/images/tving.jpg" alt="Label Image"> 
					</div>
					<div class="info-value">티빙</div>
				</div>
				<div class="info-item">
					<div class="info-label">
						<img src="/resources/images/wave.jpg"alt="Label Image"> 
					</div>
					<div class="info-value">웨이브</div>
				</div>
				<div class="info-item">
					<div class="info-label">
						<img src="/resources/images/movie.png" alt="Label Image" id="exception-img"> 
					</div>
					<div class="info-value">박스오피스</div>
				</div>
			</div>
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
