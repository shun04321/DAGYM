<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SCHEDULE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet"	href="${pageContext.request.contextPath}/css/LJY.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('sch_calendar');

    // 현재 로그인한 사용자의 ID를 JavaScript 변수에 저장
    var currentUserId = '${sessionScope.user_id}';

    var calendar = new FullCalendar.Calendar(calendarEl, {
        selectable: true,
        width: 'auto',
        height: 'auto',
        headerToolbar: {
            left: 'prev,next',
            center: 'title',
            right: 'today'
        },
        initialView: 'dayGridMonth',
        events: [
            <c:forEach var="schedule" items="${schedules}">
                <c:set var="formattedTime">
                    <fmt:formatNumber value="${schedule.sch_time}" pattern="00"/>
                </c:set>
                {
                    title: '${formattedTime}시 (${schedule.mem_id})',
                    start: '${schedule.sch_date}', // schDate는 데이터베이스에서 가져온 날짜 필드의 이름입니다.
                    allDay: true,
                    extendedProps: {
                        mem_id: '${schedule.mem_id}', // mem_id를 extendedProps에 저장
                        sch_num: '${schedule.sch_num}' // sch_num을 extendedProps에 저장
                    }
                },
            </c:forEach>
        ],
        eventDidMount: function(info) {
            // 등록한 사람의 ID와 현재 사용자의 ID가 다르면 배경색을 빨간색으로 설정
            /* if (info.event.extendedProps.mem_id !== currentUserId) {
                info.el.style.backgroundColor = 'red';
                info.el.style.cursor = 'default'; // 커서를 기본 화살표로 설정
            } else {
            	// 마우스를 올리면 포인터로 변경
                info.el.style.cursor = 'pointer';
            	
            } */
            // 테두리 없애기
            info.el.style.border = 'none';
        },
        eventMouseEnter: function(info) {
                info.el.style.transform = 'scale(1.1)';
                info.el.style.transition = 'transform 0.2s';	
        },
        eventMouseLeave: function(info) {
            // 마우스가 이벤트에서 벗어나면 다시 원래 크기로 돌아갑니다.
                info.el.style.transform = 'scale(1)';
            
        },
        eventClick: function(info) {
                if (confirm('선택하신 스케줄을 삭제하시겠습니까?')) {
                	var schNum = info.event.extendedProps.sch_num;
                	location.href = 'adminScheduleDeleteForm.do?sch_num=' + schNum;
                }
        }
    });

    calendar.render();
});
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb-text">
                        <h2>Schedule</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">
	                            <c:if test="${user_auth == 8}">MyPage</c:if>
	                            <c:if test="${user_auth == 9}">Trainer</c:if>
                            </a>
                            <span>Schedule</span>
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
                    		<span>Schedule</span>
                            <h2>스케줄 (관리자)</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="class-timetable">
					
					<!-- content 시작 -->
			        <div class="align-right">
			       <%--  <c:if test="${user_auth == 8}">
			        		<input type="button" value="회원 수강내역" onclick="location.href='${pageContext.request.contextPath}/schedule/mylist.do'">
			        	</c:if> --%>
			        </div>
			        <div id="sch_calendar"></div>
			        <input type="hidden" value="" name="date" id="date" maxlength="30">
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
