<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	
	<!-- 캐시 제어 설정 -->
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />

	<c:if test="${not empty msg}">
		<script>
	        $(document).ready(function() {
	            alert('${msg}');
	        });
	    </script>
	</c:if>
</head>
<body>
	
	<%@ include file="../common/header.jsp" %>
	
	<div class="wrapper">
	    <div class="wrap">
	        <form id="login_form" method="post">
	            <div class="logo_wrap">
	                <span>couchpotato 로그인</span>
	            </div>
	            <div class="login_wrap"> 
	                <div class="id_wrap">
	                    <div class="id_input_box">
	                        <input class="id_input" name="user_id">
	                    </div>
	                </div>
	                <div class="pw_wrap">
	                    <div class="pw_input_box">
	                        <input class="pw_input" type="password" name="password">
	                    </div>
	                </div>
	                
	                <c:if test="${result == 0}">
	                    <div class="login_warn">ID 또는 PW를 잘못 입력하셨습니다.</div>
	                </c:if>
	                
	                <div class="login_button_wrap">
	                    <input type="button" class="login_button" value="로그인">
	                </div>            
	            </div>
	        </form>
	    </div>
	</div>

	<script>
	    /* 로그인 버튼 클릭 메서드 */
	    $(".login_button").click(function() {
	        /* 로그인 메서드 서버 요청 */
	        $("#login_form").attr("action", "/member/login");
	        $("#login_form").submit();
	    });
	</script>

</body>
</html>