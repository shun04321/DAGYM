<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Exercise</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb-text">
                        <h2>Exercise</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">MyPage</a>
                            <span>Exercise</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
  <section class="team-section team-page spad">
      <div class="container">
          <div class="row">
          	 <div class="col-lg-12">
          		<div class="team-title">
                		<div class="section-title">
                    		<span>Exercise</span>
                            <h2>${mem_name}님의 인바디</h2>
                    	</div>
                 </div>	
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->		
					<form id="search_form" action="ExerciseList.do" method="get">
						<input type="hidden" id="client_num" value="${param.client_num}" name="client_num">
						<ul class="search">
						<li>
						<select name = "keyfield">
							<option value="1"<c:if test="${param.keyfield ==1}">selected</c:if>>날짜</option>
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
						<c:if test="${user_auth==2}">
						<input type="button" value="등록" onclick="location.href='inbodyMain.do'">
						</c:if>
						<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
						</div>
						<c:if test="${count==0 }">
							<div class="result-display">
								표시할 게시물이 없습니다.
							</div>
						</c:if>
						<c:if test="${count>0 }">
							<table>
								<tr>
									<th>운동번호</th>
									<th>측정일자</th>
									<th>운동부위</th>
									<th>운동상세</th>
									<th>운동시간</th>
									<th>삭제</th>
								</tr>
								<c:forEach var="exercise" items="${list}">
									<tr>
									<td><a href="exerciseDetail.do?exe_date=${exercise.exe_date}&client_num=${param.client_num}">${exercise.exe_num}</a></td>
									<td>
									<div class="align-center">
									<input type="button" value="삭제" onclick="location.href='deleteExercise.do?exe_num=${exercise.exe_num}'">
									</div>
									</td>
									</tr>
								</c:forEach>
							
							</table>
							<div class="align-center">${page}</div>
						</c:if>
					<!-- content 끝 -->
					
					</div>
				</div>
			</div>
	      </div>
	  </section>
  	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<jsp:include page="/WEB-INF/views/common/js_plugins.jsp"/>

</body>	
</html>