$(document).ready(function(){
	/*----------댓글 등록----------*/
	$('#answer_form').submit(function(){
		if($('#answer_content').val().trim() == ''){
			alert('답변 내용을 입력하세요');
			$('#answer_content').val('').focus();
			return false;
		}
		alert('정상적으로 답변이 등록되었습니다');
	});
	
	/*----------댓글 수정----------*/
	$(document).on('click','#update_answer_btn', function(){//수정 버튼 클릭시
		//댓글번호
		//기존 댓글의 text를 읽어옴
		let answerContent = $(this).closest('#answer-div').find('p').text().replace(/<br>/gi,'\n');
		//댓글 수정을 위한 form 생성
		let modifyUI = '<form id="mre_form">';
		modifyUI += '<input type="hidden" name="re_num" id="mre_num" value="' + $(this).attr("data-num") + '">';
		modifyUI += '<input type="hidden" name="qab_ref" id="mre_num" value="' + $(this).attr("data-qnum") + '">';
		modifyUI += '<div class="align-right">'
		modifyUI += '<input type="submit" value="수정"> ';
		modifyUI += '<input type="button" value="취소" class="re-reset">';
		modifyUI += '</div>'
		modifyUI += '<textarea rows="3" cols="55" name="mre_content" id="mre_content" class="rep_content">'+answerContent+'</textarea>';
		modifyUI += '<div id="mre_second" class="align-right">';
		modifyUI += '</div>';
		modifyUI += '</form>';
		
		//기존 댓글 내용을 수정 폼으로 대체
        $('#answer-div').html(modifyUI);
    });//end of update click
    
    
    
    //댓글 수정 submit 진행
	$(document).on('submit', '#mre_form', function(event){
	  if($('#mre_content').val().trim()==''){
		  alert('내용을 입력하세요');
		  $('#mre_content').val('').focus();
			return false;
	  }
	  
	  //폼에 입력한 데이터 반환
	  let form_data = $(this).serialize();
	
	  //AJAX 요청
	  $.ajax({
	      url:'adminUpdateAnswer.do',
	      type:'post',
	      data:form_data,
	      dataType:'json',
	      success: function(param) {
	          if(param.result == 'logout') {
	              alert('로그인이 필요합니다.');
	              window.location.href = '${pageContext.request.contextPath}/member/loginForm.do';
	          }else if (param.result == 'success') {
	             alert('답변이 수정되었습니다');
	             $('#mre_form').parent().find('p').html($('#mre_content').val().replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/\n/g,'<br>'));
	             location.reload();
	          }else if (param.result == 'wrongAccess') {
	             alert('권한이 없습니다.');
	          }else {
	             alert('댓글 수정 오류 발생');
	          }
	      },
	      error: function() {
	          alert('네트워크 오류 발생');
	      }
	  });
	  	//기본 이벤트 제거
		event.preventDefault();
	});//end of update submit
	
	// 수정 폼 취소 버튼 클릭 시 원래 상태로 복원
	$(document).on('click', '.re-reset', function(){
	    location.reload();
	});
	
	
	/*----------댓글 삭제----------*/
	$(document).on('click','#delete_answer_btn', function(){
		let qab_num = $(this).attr('data-num');
		let qab_ref = $(this).attr('data-qnum');
		//AJAX 요청
	 	$.ajax({
	      url:'adminDeleteAnswer.do',
	      type:'post',
	      data:{qab_num:qab_num,qab_ref:qab_ref},
	      dataType:'json',
	      success: function(param) {
	          if(param.result == 'logout') {
	              alert('로그인이 필요합니다.');
	              window.location.href = '${pageContext.request.contextPath}/member/loginForm.do';
	          }else if (param.result == 'success') {
	             alert('답변이 삭제되었습니다');
	             location.reload();
	          }else if (param.result == 'wrongAccess') {
	             alert('권한이 없습니다.');
	          }else {
	             alert('댓글 수정 오류 발생');
	          }
	      },
	      error: function() {
	          alert('네트워크 오류 발생');
	      }
	  	});
	});//end of delete
});//end of document