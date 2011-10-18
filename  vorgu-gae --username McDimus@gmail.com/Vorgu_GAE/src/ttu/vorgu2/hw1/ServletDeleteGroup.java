package ttu.vorgu2.hw1;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ttu.vorgu2.hw1.dao.Dao;

public class ServletDeleteGroup extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
		String id = req.getParameter("id");
		Dao.INSTANCE.deleteGroup(Long.parseLong(id));
		resp.sendRedirect("/admin.jsp");
	}
}
