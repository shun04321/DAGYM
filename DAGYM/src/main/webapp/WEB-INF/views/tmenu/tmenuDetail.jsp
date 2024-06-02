<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MENU</title>
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
                        <h2>Menu</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Mypage</a>
                            <span>Menu</span>
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
                    		<span>Menu</span>
                            <h2>메뉴상세</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<div class="align-center">
						<h2>${tmenu.tme_name}</h2>
					</div>
					<br>
					<div style="overflow: auto;">
						<div class="align-left" style="width:600px; float: left;">
							<img src="${pageContext.request.contextPath}/upload/${tmenu.tme_photo}" width="600px">
						</div >
						<div class="align-right" style="width:300px; float: right;">
							<h2>음식정보</h2>
							<ul>
								<li>칼로리 : ${tmenu.tme_kcal} Kcal</li>
								<li>탄수화물 : ${tmenu.tme_crabs} g</li>
								<li>단백질 : ${tmenu.tme_protein} g</li>
								<li>지방: ${tmenu.tme_lipid} g</li>
							</ul>
						</div>
						<div class="align-right content-text" style="width:300px; float: right;">
							${tmenu.tme_content}
						</div>
						<br>
						<div id="output"></div>
					</div>
					<div class="align-right">
						<div>
							 <input type="button" value="수정" onclick="location.href='tmenuModifyForm.do?tme_num=${tmenu.tme_num}'">
							 <input type="button" value="삭제" onclick="location.href='tmenuDelete.do?tme_num=${tmenu.tme_num}'">
							 <input type="button" value="목록" onclick="location.href='tmenuList.do'">
						</div>
					</div>
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