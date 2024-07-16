<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/login_modal.css?v=1.0" />

<div id="loginModal" class="login-modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <div class="wrapper">
            <form id="login_form" method="post" style="margin-top: 35px;">
                <div class="logo_wrap">
                    <img src="${pageContext.request.contextPath}/resources/images/leanonlogo.png" alt="couchpotato 로그인" class="logo_image">
                </div>
                <div class="login_wrap">
                    <div class="id_wrap">
                        <div class="id_input_box">
                            <input class="id_input" name="user_id" placeholder="아이디" autocomplete="username">
                        </div>
                    </div>
                    <div class="pw_wrap">
                        <div class="pw_input_box">
                            <input class="pw_input" type="password" name="password" placeholder="비밀번호" autocomplete="current-password">
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
</div>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 로그인 모달 열기
        var loginModal = document.getElementById("loginModal");
        var loginBtn = document.getElementById("loginButton");
        var loginSpan = loginModal.getElementsByClassName("close")[0];

        loginBtn.onclick = function() {
            loginModal.style.display = "flex";
        }

        // 로그인 모달 닫기
        loginSpan.onclick = function() {
            loginModal.style.display = "none";
        }

        // 모달 밖 클릭 시 닫기
        window.onclick = function(event) {
            if (event.target == loginModal) {
                loginModal.style.display = "none";
            }
        }

        // 로그인 버튼 클릭 메서드
        $(".login_button").click(function() {
            /* 로그인 메서드 서버 요청 */
            $("#login_form").attr("action", "/member/login");
            $("#login_form").submit();
        });
    });
</script>

<c:if test="${not empty msg}">
    <script>
        $(document).ready(function() {
            alert('${msg}');
        });
    </script>
</c:if>