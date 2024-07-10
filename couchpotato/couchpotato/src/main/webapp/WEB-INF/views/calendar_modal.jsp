<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar_modal.css?v=1.0" />

<!-- 첫번째 모달(해당 날짜의 리뷰 보기) -->
<div id="myModal" class="modal">
	<div class="modal-content">
        <div class="modal-header">
        	<img src=/resources/images/myreviewlist.png class="modal-header-img">
            <span class="close">&times;</span>
        </div>
		<div id="modal-body">
		</div>
	</div>
</div>

<!-- 두번째 모달(수정하는 모달) -->
<div id="editModal" class="modal">
	<div class="modal-content">
        <div class="modal-header">
        	<img src=/resources/images/myreviewlist.png class="modal-header-img">
            <span class="close">&times;</span>
        </div>
		<div id="edit-modal-body">
			<form id="editForm">
				<div class="edit-modal-container">
					<input type="hidden" id="edit_review_create_at" name="review_text">
					<div class="editmodal-btn">
               			<button type="submit" class="editmodal-modify-btn">확인</button>
             		</div>
					<div>
	                	<span class="edit-modal-title"> 콘텐츠명 </span>
	                	<div class="edit-content-name" id="edit_content_name" name="content_name"></div>
                	<div>
                		<span class="edit-modal-title"> 한줄리뷰 </span>
                		<textarea id="edit_review_text" name="review_text"></textarea>
                	</div>
                	<div>
	                	<span class="edit-modal-title"> 리뷰별점 </span>
	                	<input type="number" id="edit_rating" name="rating" min="0" max="5" step="0.5">
                	</div>
				</div>
			</form>
		</div>
	</div>
</div>