<%@ page contentType="text/html;charset=UTF-8" language="java"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>review list</title>
	<script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
</head>
<body>
    <%@ include file="common/header.jsp" %>
    
    <h2>My Review List</h2>
    <ul>
        <c:forEach var="review" items="${allReviewList}">
            <li>${review.content_name} - ${review.review_text} - ${review.rating} 
                -${review.review_create_at} - ${review.content_image_url}
            </li>
        </c:forEach>
    </ul>
 
</body>
</html>