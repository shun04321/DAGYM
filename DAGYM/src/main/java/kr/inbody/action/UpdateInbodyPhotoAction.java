	package kr.inbody.action;
	
	import java.util.HashMap;
	import java.util.Map;
	
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	import javax.servlet.http.HttpSession;
	
	import org.codehaus.jackson.map.ObjectMapper;
	
	import kr.controller.Action;
	import kr.inbody.dao.InbodyDAO;
import kr.inbody.vo.InbodyVO;
import kr.util.FileUtil;
	
	public class UpdateInbodyPhotoAction implements Action{
	
		@Override
		public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			Map<String,String> mapAjax = new HashMap<String,String>();
	
			HttpSession session = request.getSession();
			Integer user_num = 
					(Integer)session.getAttribute("user_num");
			Integer user_auth = (Integer)session.getAttribute("user_auth");
			if(user_num==null) {//로그인이 되지 않은 경우
				mapAjax.put("result", "logout");
			}else {//로그인 된 경우
				//전송된 데이터 인코딩 타입 지정
				request.setCharacterEncoding("UTF-8");
				if(user_auth >=8) {
					user_num = Integer.parseInt(request.getParameter("client_num"));
				}
				//파일 삭제 처리
				InbodyDAO inbodydao = InbodyDAO.getInstance();
				String inb_date = request.getParameter("inb_date");
				InbodyVO inbody = inbodydao.getInbody(inb_date, user_num);
				if(inbody != null && inbody.getInb_photo() != null) {
					inbodydao.updateMyInbodyPhoto(inbody.getInb_num());
					FileUtil.removeFile(request, inbody.getInb_photo());
					mapAjax.put("result", "success");
				}else {
					mapAjax.put("result", "fail");
				}
			}
			ObjectMapper mapper = new ObjectMapper();
			String ajaxData = mapper.writeValueAsString(mapAjax);
			
			request.setAttribute("ajaxData", ajaxData);
			return "/WEB-INF/views/common/ajax_view.jsp";
		}
	}