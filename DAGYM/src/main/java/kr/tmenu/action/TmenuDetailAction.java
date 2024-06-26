package kr.tmenu.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.tmenu.dao.TmenuDAO;
import kr.tmenu.vo.TmenuVO;
import kr.util.StringUtil;

public class TmenuDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer tme_num = Integer.parseInt(request.getParameter("tme_num"));
		TmenuDAO dao = TmenuDAO.getInstance();
		TmenuVO tmenu = new TmenuVO();
		tmenu = dao.getTmenuDetail(tme_num);
		tmenu.setTme_content(StringUtil.useBrNoHTML(tmenu.getTme_content()));
		tmenu.setTme_name(StringUtil.useNoHTML(tmenu.getTme_name()));
		
		request.setAttribute("tmenu", tmenu);
		return "/WEB-INF/views/tmenu/tmenuDetail.jsp";
		
	}

}
