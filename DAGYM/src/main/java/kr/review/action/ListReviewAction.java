
package kr.review.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.review.dao.ReviewDAO;
import kr.review.vo.ReviewVO;
import kr.util.PagingUtil;

public class ListReviewAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
			
		//현재 페이지 번호 받아오기
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		//검색유형, 검색어, 정렬기준 받아오기
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		String keyfield2 = request.getParameter("keyfield2");
		
		//해당되는 전체 페이지 번호 받아오기
		ReviewDAO dao = ReviewDAO.getInstance();
		int count = 0;
		if(user_num==null) {
			count = dao.getReviewCount(null, null,3);
		}else {
			MemberDAO memDAO = MemberDAO.getInstance();
			MemberVO member = memDAO.getMember(user_num);
			count = dao.getReviewCount(null, null,member.getMem_auth()); 
		}
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,"listReview.do");
		
		//수강후기 목록 받아오기
		List<ReviewVO> list = null;	
		if(count > 0) {
			if(user_num==null) {
				list = dao.getListReview(page.getStartRow(), page.getEndRow(), keyfield, keyword,keyfield2,3);
			}else {
				MemberDAO memDAO = MemberDAO.getInstance();
				MemberVO member = memDAO.getMember(user_num);
				list = dao.getListReview(page.getStartRow(), page.getEndRow(), keyfield, keyword,keyfield2,member.getMem_auth());
			}
			
		}
		
		request.setAttribute("user_num", user_num);
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		return "/WEB-INF/views/review/listReview.jsp";
	}

}
