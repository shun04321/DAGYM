<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식사등록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('write_form');
	myForm.onsubmit=function(){
		const title = document.getElementById('menu_name');
		if(title.value.trim()==''){
			alert('메뉴를 입력하세요');
			return false;
		}
	
	}
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);
	const mealDate = urlParams.get('meal_date');
	if (mealDate) {
		document.getElementById('meal_date').value = mealDate;
	}
	const modal = document.querySelector("#modal");
	const btn = document.querySelector("#modal-btn");
	const close = document.querySelector(".close");
	const search = document.querySelector("#search_btn");

	// 모달창 열기
	btn.onclick = function() {
	  modal.style.display = "block";
	}

	// 모달창 닫기
	close.onclick = function() {
	  modal.style.display = "none";
	}
	
	search.onclick = function(){
		$.ajax({
			url:'SearchTmenu.do',
			type:'post',
			data: {tmenu_name:$('#tmenu_name').val()}, // 데이터를 객체로 전달
			dataType:'json',
			success:function(param){
				let tableContent ='<tr><th>메뉴</th><th>칼로리</th>선택<th></th></tr>';
				$(param.tmenuList).each(function(index,item){
					tableContent += '<tr><td>'+item.tme_name+'</td>';
					tableContent +='<td>'+item.tme_kcal+'</td><td><button type="button" onclick="selectMenu(\''+item.tme_name+'\')">선택</button></td></tr>';
				});
				$('#table_menu').html(tableContent);
			},	
			error:function(){
				alert('메뉴검색중 오류 발생');
			}
		});
	}
}

// 메뉴 선택 시 처리 함수
function selectMenu(tme_name) {
	$('#menu_name').val(tme_name);
	$('#modal').hide();
}
const radioButtons = document.querySelectorAll('input[type="radio"]');

//각 라디오 버튼에 대해 이벤트 리스너를 추가합니다.
radioButtons.forEach(radioButton => {
 radioButton.addEventListener('click', function() {
     // 해당 라디오 버튼이 클릭되었을 때의 동작을 여기에 추가합니다.
     console.log('라디오 버튼이 클릭되었습니다.');
 });
});
</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<div class="content-main">
			<h2>식사등록</h2>
			<form id="write_form" action="mealWrite.do" method="post">
				<input type="hidden" id="meal_date" name="meal_date" value="meal_date">
				<h3>${param.meal_date}</h3>
				<ul>
					<li><label for="menu_name">메뉴 검색</label>
					
					<input type="text" name="menu_name" id="menu_name" value="${menu_name}"  readonly>
					<input type="button" id="modal-btn" value="검색">
					</li>
					
					<li>식사분류
					<input type="radio" name="meal_time" value="0" id="meal_time0" checked>아침 
					<input type="radio" name="meal_time" value="1" id="meal_time1">점심 
					<input type="radio" name="meal_time" value="2" id="meal_time2">저녁 
					<input type="radio" name="meal_time" value="3" id="meal_time3">간식
					</li>
				</ul>
				<div class="align-center">
					<input type="submit" value="등록"> <input type="button" value="취소" onclick="location.href='list.do'">
				</div>
			</form>
			<div id="modal" class="dialog">
				<div class="tb">
					<div class="inner" style="max-width:600px;">
						<div class="top">
							<div class="title">메뉴검색</div>
							<a href="#" class="close">닫기</a>
						</div>
						<div class="ct">
							<div align="right">
									<input type="text" size="16" name="tmenu_name" id="tmenu_name" >
									<input type="button" id="search_btn" value="검색">
							</div>
							<table id="table_menu">
								<tr>
									<th>메뉴</th>
									<th>칼로리</th>
									<th>선택</th>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
