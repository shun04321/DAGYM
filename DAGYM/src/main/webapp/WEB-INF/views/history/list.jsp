<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PT 목록</title>
<style>
    #fc-dom-1 {
        margin-right: 100px;
    }
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('his_calendar');

    // 현재 로그인한 사용자의 ID를 JavaScript 변수에 저장
    var currentUserId = '${sessionScope.user_id}';

    var calendar = new FullCalendar.Calendar(calendarEl, {
        selectable: true,
        width: 'auto',
        height: 'auto',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth'
        },
        initialView: 'dayGridMonth',
        /* events: [
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
        ], */
        eventDidMount: function(info) {
            // 등록한 사람의 ID와 현재 사용자의 ID가 다르면 배경색을 빨간색으로 설정
            if (info.event.extendedProps.mem_id !== currentUserId) {
                info.el.style.backgroundColor = 'red';
            }
            // 테두리 없애기
            info.el.style.border = 'none';
        },
        dateClick: function(info) {
            var today = new Date();
            var clickedDate = new Date(info.dateStr);
            
            // 클릭된 날짜가 오늘 이전인지 확인
            if (clickedDate <= today.setDate(today.getDate() - 1)) {
                alert('오늘 이후로 PT 신청할 수 있습니다.');
                window.location.reload();
            } else {
                var dateStr = info.dateStr;
                var url = '${pageContext.request.contextPath}/history/historyEnrollForm.do?his_date=' + dateStr;
                window.location.href = url;
            }
        },
        eventClick: function(info) {
            // 현재 사용자가 등록한 일정만 클릭 가능
            if (info.event.extendedProps.mem_id === currentUserId) {
                if (confirm('PT 신청하시겠습니까?')) {
                	var url = '${pageContext.request.contextPath}/history/historyEnrollForm.do?his_date=' + dateStr;
                    window.location.href = url;

                }
            }
        }
    });

    calendar.render();
});
</script>
</head>
<body>
<div class="page-main">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="content-main">
        <h2 align="center">PT 등록</h2>

        <div id="his_calendar"></div>

        <input type="hidden" value="" name="date" id="date" maxlength="30">
    </div>
</div>
</body>
</html>