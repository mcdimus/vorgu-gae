package ttu.vorgu2.hw1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ttu.vorgu2.hw1.dao.Dao;

public class ServletUpdatePerson extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3746107819063707686L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String web = req.getParameter("web");
		String id = req.getParameter("id");
		String password = req.getParameter("password");
		String repPassword = req.getParameter("reppassword");
		String firstname = req.getParameter("firstname");
		String lastname = req.getParameter("lastname");
		String phonenumber = req.getParameter("phonenumber");
		if (password.length() != 0 && !password.equals(repPassword)) {
			if (web != null && web.equals("admin")) {
				resp.sendRedirect("/admin.jsp?passcheck");
			} else {
				resp.sendRedirect("/user.jsp?passcheck");
			}
		} else {
			Dao.INSTANCE.updatePerson(id, password, firstname, lastname,
					phonenumber);
			if (web != null && web.equals("admin")) {
				resp.sendRedirect("/admin.jsp");
			} else {
				resp.sendRedirect("/user.jsp");
			}
		}
	}

}
