package com.fooding.profile.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fooding.profile.db.ProfileDAO;
import com.fooding.util.Action;
import com.fooding.util.ActionForward;

public class ProfileDuplicateEmailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("\t M : ProfileDuplicateEmail_execute() 호출 ");
		
		int member_id = Integer.parseInt(request.getParameter("member_id"));
		System.out.println("member_id : " + member_id);
		String email = request.getParameter("email");
		System.out.println("email : " + email);
		
		ProfileDAO dao = new ProfileDAO();
		int result = dao.profileEmailDuplicate(member_id, email);
		
		String myEmail = dao.profileMyEmail(member_id);
		if(myEmail.equals(email)) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("현재 등록하신 이메일입니다. 사용 가능합니다.");
			return null;
		}
		
		if(result != 0) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("중복된 이메일입니다.");
			return null;
		}else {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("사용 가능한 이메일입니다.");			
		}
		return null;
	}
}
