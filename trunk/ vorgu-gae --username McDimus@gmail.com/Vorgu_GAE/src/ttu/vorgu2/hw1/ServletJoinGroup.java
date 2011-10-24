package ttu.vorgu2.hw1;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ttu.vorgu2.hw1.dao.Dao;

public class ServletJoinGroup extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7658279628888386985L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		OutputStream pw = resp.getOutputStream();
		ObjectOutputStream out = new ObjectOutputStream(pw);

		Message message = null;
		
		String web = req.getParameter("web");
		String id = req.getParameter("id");
		String groupname = req.getParameter("groupname");

		Dao.INSTANCE.setGroupToPerson(id, groupname);
		if (web != null && web.equals("user")) {
			resp.sendRedirect("/user.jsp");
		} else {
			message = new Message(true);
			out.writeObject(message);
			out.flush();
			out.close();
		}

	}
}
