package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class AdminTrainerFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인이 되어있는 상태여야하며, 관리자여야 함
		HttpSession session  = request.getSession();

		session.setAttribute("prevPage", request.getRequestURI());
		
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//관리자 여부 체크
		Integer user_auth = (Integer)session.getAttribute("user_auth");
			//세션에 저장해둔 데이터를 가져옴
		if(user_auth!=9) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		//전송된 데이터 반환
		int mem_num = Integer.parseInt(request.getParameter("mem_num"));
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(mem_num);//한 건의 레코드를 읽어옴
		
		request.setAttribute("member", member);
		
		//JSP 경로 반환
		return "/WEB-INF/views/member/detailTrainerForm.jsp";
	}

}
