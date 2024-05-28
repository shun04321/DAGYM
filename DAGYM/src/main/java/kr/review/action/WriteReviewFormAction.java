package kr.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.history.dao.HistoryDAO;
import kr.history.vo.HistoryVO;

public class WriteReviewFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 확인하기
		HttpSession session = request.getSession();
		Integer mem_num = (Integer) session.getAttribute("user_num");
		
		if(mem_num==null) {
			return "redirect:/member/loginForm.do";
		}
				
		//수강 완료 여부 확인하기 -> 수강후기 작성 버튼을 <a>태그에 작성하여 get방식으로 sch_num 넘겨주기		
		int sch_num = Integer.parseInt(request.getParameter("sch_num"));
		
		HistoryDAO dao = HistoryDAO.getInstance();
		HistoryVO history = dao.getHistory(sch_num);
		
		if(history.getHis_status()!=2) {
			return "redirect:/history/히스토리목록보는 페이지";
		}
		
		request.setAttribute("history", history);
		
		return "/WEB-INF/views/review/writeReviewForm.jsp";
	
	}
}
