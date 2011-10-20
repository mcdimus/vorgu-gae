package ttu.vorgu2.hw1;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ttu.vorgu2.hw1.dao.Dao;

public class ServletRegister extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 455135588086809137L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		OutputStream pw = resp.getOutputStream();
		ObjectOutputStream out = new ObjectOutputStream(pw);

		Message message = null;

		String username = checkNull(req.getParameter("username"));
		String password = checkNull(req.getParameter("password"));
		String firstname = checkNull(req.getParameter("firstname"));
		String lastname = checkNull(req.getParameter("lastname"));
		String phonenumber = checkNull(req.getParameter("phonenumber"));
		String group = checkNull(req.getParameter("group"));
		double latitude = 0;
		double longitude = 0;
		if (req.getParameter("longitude") != null && req.getParameter("latitude") != null) {
			longitude = Double.parseDouble(req.getParameter("longitude"));
			latitude = Double.parseDouble(req.getParameter("latitude"));
		}

		Dao.INSTANCE.addPerson(username, password, firstname, lastname,
				phonenumber, group, longitude, latitude);
		if (req.getParameter("web") != null && req.getParameter("web").equals("true")) {
			resp.sendRedirect("/admin.jsp");
		} else {
			message = new Message(true);
			out.writeObject(message);
			out.flush();
			out.close();
		}
	}

	private String checkNull(String s) {
		if (s == null) {
			return "";
		}
		return s;
	}

}
