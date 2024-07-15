<%@ page language="java" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar_modal.css?v=1.0" />

<!-- 첫번째 모달(해당 날짜의 리뷰 보기) -->
<div id="myModal" class="modal">
	<div class="modal-content">
        <div class="modal-header">
        	<div class="modal-header-title" >
				<img src="resources/images/camera.png" width="36px;">        	
        		<span>REVIEWS BY DATE</span> 
       		</div>
            <span id="close">&times;</span>
        </div>
		<div id="modal-body" class="modal-body">
		</div>
	</div>
</div>

<!-- 두번째 모달(수정하는 모달) -->
<div id="editModal" class="modal">
	<div class="edit-modal-content">
        <div class="editmodal-header">
			<img src="resources/images/modify.png" width="25px;">        	
       		<span>MODIFY REVIEWS</span> 
        </div>
		<div id="edit-modal-body">
			<form id="editForm">
				<div class="edit-modal-container">
					<input type="hidden" id="edit_content_id" name="content_id" />
					<input type="hidden" id="edit_content_type" name="content_type" />
					<div class="edit-content-top"> 	
						<span class="edit_review_create_at" id="edit_review_create_at" name="review_create_at"></span>
                	</div>
					<div class="edit-content">
	                	<span class="edit-modal-title"> 
	                		<img src="resources/images/reviewregister.png" width="10px;"> 콘텐츠명 
	                	</span>
	                	<div class="edit-content-name" id="edit_content_name" name="content_name"></div>
                	</div>
                	<div class="edit-content">
                		<span class="edit-modal-title"> 
                			<img src="resources/images/reviewregister.png" width="10px;"> 한줄리뷰
						</span>
                		<textarea id="edit_review_text" name="review_text"></textarea>
                	</div>
                	<div class="edit-content">
	                	<span class="edit-modal-title"> 	
	                		<img src="resources/images/reviewregister.png" width="10px;"> 리뷰별점 </span>
	                	<input type="number" id="edit_rating" name="rating" min="0" max="5" step="0.5">
                	</div>
				</div>
				<div class="editmodal-btn">
            		<button type="submit" class="editmodal-modify-btn">확인</button>
            		<button type="button" class="cancle-modify-btn" id="cancle-modify-btn">취소</button>
          		</div>
			</form>
		</div>
	</div>
</div>