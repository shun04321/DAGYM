package kr.qaboard.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.qaboard.dao.QABoardDAO;
import kr.qaboard.vo.QABoardVO;

public class AdminDeleteAnswerAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		int qab_num = Integer.parseInt(request.getParameter("qab_num"));//댓글번호
		int qab_ref = Integer.parseInt(request.getParameter("qab_ref"));//댓글의 게시글 번호
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		//로그인 체크
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		QABoardDAO dao = QABoardDAO.getInstance();
		QABoardVO db_reply = dao.getAdminBoard(qab_ref);
		
		if(user_num==null) {
			mapAjax.put("result", "logout");
		}else if(user_auth < 8) {
			mapAjax.put("result", "wrongAccess");
		}else if(user_num!=null && user_num==db_reply.getMem_num()) {
			dao.deleteAdminBoard(qab_num);
			mapAjax.put("result", "success");
		}else {
			mapAjax.put("result", "wrongAccess");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
