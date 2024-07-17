<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    java.util.Date now = new java.util.Date();
    request.setAttribute("now", now);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>total review list</title>
    <link rel="stylesheet" href="/resources/css/reviewlist.css?v=1.0" />
    <script src='https://code.jquery.com/jquery-3.5.1.min.js'></script>
</head>
<body>
    <!-- 헤더 -->
    <%@ include file="common/header.jsp" %>
    
    <!-- body -->
    <div class="reviewlist-main-container">
        <c:choose>
            <c:when test="${empty reviewsByMonth}">
                <div class="review-title">
<!--                     <img src="/resources/images/potato_icon.png" width="20px"> -->
<!--                     <div class="month-title"> -->
<%--                         <fmt:formatDate value="${now}" pattern="yyyy-MM"/> --%>
<!--                     </div> -->
                </div>
                <div class="review-slider">
                	<img src ="/resources/images/noreview.png" width="500px">
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="month" items="${reviewsByMonth}">
                    <div class="review-title">
                        <img src="/resources/images/potato_icon.png" width="20px">
                        <div class="month-title">${month.key}</div> <!-- 월 (YYYY-MM) -->
                    </div>
                    
                    <div class="review-slider">
                        <button class="prev-slide">&lt;</button>
                        
                        <div class="review-container">
                            <div class="review-track">
                                <c:forEach var="review" items="${month.value}">
                                    <div class="review-card">
                                        <div>
                                            <img src="https://image.tmdb.org/t/p/w300${review.content_image_url}"  alt="${review.content_name}">
                                        </div>
                                        <div class="review-info">
                                            <div class="review-info-name">${review.content_name}</div>
                                            <div class="review-info-text">${review.review_text}</div>
                                            <div class="review-in-info">
                                                <div>${review.rating}</div>
                                                <div>${review.review_create_at}</div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <button class="next-slide">&gt;</button>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
        
    <script src="/resources/js/reviewlist.js"></script>
</body>
</html>