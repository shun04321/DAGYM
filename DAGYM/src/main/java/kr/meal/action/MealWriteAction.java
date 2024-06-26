package kr.meal.action;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.meal.dao.MealDAO;
import kr.meal.vo.MealVO;

public class MealWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			request.setAttribute("notice_msg", "로그인을 해야합니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		String meal_date = request.getParameter("meal_date");
		LocalDate selectedDate = LocalDate.parse(meal_date, DateTimeFormatter.ISO_DATE);
	    LocalDate today = LocalDate.now();
	    System.out.println(selectedDate);
	    if (selectedDate.isAfter(today)) {
	    	request.setAttribute("notice_msg", "오늘 날짜 이후의 식사기록을 작성할 수 없습니다.");
            request.setAttribute("notice_url", request.getContextPath() + "/meal/mealDetail.do");
            return "/WEB-INF/views/common/alert_view.jsp";
	    }
		MealVO meal = new MealVO();
		meal.setMeal_date(meal_date);
		meal.setMem_num(user_num);
		meal.setMeal_time(Integer.parseInt(request.getParameter("meal_time")));
		MealDAO dao = MealDAO.getInstance();
		int tme_num = dao.searchMenuAndSetTmeNum(request.getParameter("menu_name"));
		meal.setTme_num(tme_num);
		dao.insertMeal(meal);
	
		
		request.setAttribute("notice_msg", "음식 등록 완료");
		request.setAttribute("notice_url", request.getContextPath()+"/meal/mealDetail.do");
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
