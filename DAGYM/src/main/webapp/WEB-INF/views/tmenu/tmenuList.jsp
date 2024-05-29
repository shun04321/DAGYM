<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 메뉴 목록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">	
<script type="text/javascript">
window.onload=function(){
	const myform= document.getElementById('search_form');
	
	myform.onsubmit=function(){
		const keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){
			alert('검색어를 입력하세요');
			keyword.value='';
			keyword.focus();
			return false;
		}
	}
}
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>오늘의 메뉴 목록</h2>
		<form id = "search_form" action = "tmenuList.do" method="get">
		<ul class="search">
		<li>
		<select name = "keyfield">
			<option value="1"<c:if test="${param.keyfield ==1}">selected</c:if>>메뉴이름</option>
		</select>
		</li>
		<li>
			<input type="search" size = "16" name="keyword" id = "keyword" value="${param.keyword}">
		</li>
		<li>
			<input type="submit" value="검색">
		</li>
		</ul>
			
		</form>
		
		
		<div class= "list-space align-right">
		<input type="button" value="글쓰기" onclick="location.href='tmenuWriteForm.do'">
		<input type="button" value="목록" onclick="location.href='tmenuList.do'">
		<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
		<c:if test="${count==0 }">
			<div class="result-display">
				표시할 게시물이 없습니다.
			</div>
		</c:if>
		<c:if test="${count>0}">
			<table>
				<tr>
					<th>메뉴번호</th>
					<th>메뉴이름</th>
					<th>칼로리</th>
					<th>식사분류</th>
				</tr>
				<c:forEach var = "tmenu" items="${list}">
					<tr>
					<td>${tmenu.tme_num}</td>
					<td><a href="tmenuDetail.do?tme_num=${tmenu.tme_num}">${tmenu.tme_name}</a></td>
					<td>${tmenu.tme_kcal}</td>
					<c:choose>
						<c:when test="${tmenu.tme_type ==0}">
						<td>아침</td>
						</c:when>
						<c:when test="${tmenu.tme_type ==1}">
						<td>점심</td>
						</c:when>
						<c:when test="${tmenu.tme_type ==2}">
						<td>저녁</td>
						</c:when>
						<c:when test="${tmenu.tme_type ==3}">
						<td>간식</td>
						</c:when>
						<c:otherwise>
						<td>검색용 메뉴</td>
						</c:otherwise>
					</c:choose>
					</tr>
				
				</c:forEach>
			
			</table>
			<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>

</body>
</html>