<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강사정보 수정(관리자 전용)</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>[${member.mem_id}]의 회원정보(관리자 전용)</h2>
		<form action="adminTrainer.do" method="post" id="detail_form">
			<input type="hidden" name="mem_num" value="${member.mem_num}">
			<ul>
				<li>
					<label>등급</label>
					<!-- 9가 아닌 경우에는 등급 변경 가능 -->
					<c:if test="${member.mem_auth!=9}">
						<input type="radio" name="auth" value="1"id="auth1" 
							<c:if test="${member.mem_auth == 1}">checked</c:if>>정지
						<input type="radio" name="auth" value="2"id="auth2" 
							<c:if test="${member.mem_auth == 2}">checked</c:if>>일반
							<input type="radio" name="auth" value="8"id="auth8" 
							<c:if test="${member.mem_auth == 8}">checked</c:if>>강사
					</c:if>
					<!-- 9가 아닌 경우에는 등급 변경 불가능 -->
					<c:if test="${member.mem_auth==9}">
						<input type="radio" name="auth" value="9" id="auth3" 
							checked>관리자
					</c:if>
				</li>
			</ul>
			<div class="align-center">
				<!-- 관리자가 아닌 경우에만 수정 버튼 등장 -->
				<c:if test="${member.mem_auth!=9}">
					<input type="submit" value="수정">
				</c:if>
				<input type="button" value="목록"
					onclick="location.href='adminTrainerList.do'">
			</div>
			<ul>
				<li>
					<label>아이디</label>${member.mem_id}
				</li>
				<li>
					<label>이름</label>${member.mem_name}
				</li>
				<li>
					<label>프로필</label>
					<c:if test="${empty member.mem_photo}">
						<img src="${pageContext.request.contextPath}/images/face.png"
							width="50" height="50" class="my-photo">
					</c:if>
					<c:if test="${!empty member.mem_photo}">
						<img src="${pageContext.request.contextPath}/upload/${member.mem_photo}"
							width="50" height="50" class="my-photo">
					</c:if>
				</li>
				<li>
					<label>전화번호</label>${member.mem_phone}
				</li>
				<li>
					<label>이메일</label>${member.mem_email}
				</li>
				<c:if test="${member.mem_gender == 1}">
					<li><label>성별</label>여성</li>
				</c:if>
				<c:if test="${member.mem_gender == 0}">
					<li><label>성별</label>남성</li>
				</c:if>
				<li>
					<label>생일</label>${member.mem_birth}
				</li>
				<li>
					<label>우편번호</label>${member.mem_zipcode}
				</li>
				<li>
					<label>주소</label>${member.mem_address1} ${member.mem_address2}
				</li>		
			</ul>
		</form>
	</div>
</div>
</body>
</html>