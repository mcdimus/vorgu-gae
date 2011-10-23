package ttu.vorgu2.hw1;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ttu.vorgu2.hw1.dao.Dao;
import ttu.vorgu2.hw1.model.Group;
import ttu.vorgu2.hw1.model.Person;

public class ServletLogin extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8606895851054325137L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		OutputStream pw = resp.getOutputStream();
		ObjectOutputStream out = new ObjectOutputStream(pw);

		Message message = null;

		// TODO: Login from web
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		Person person = Dao.INSTANCE.login(username, password);
		if (person != null) {
			List<Group> groups = Dao.INSTANCE.getGroups();
			List<String> groupNames = new ArrayList<String>();
			for (int i = 0; i < groups.size(); i++) {
				groupNames.add(groups.get(i).getName());
			}
			message = new Message(true, person.getId(), person.getGroup(),
					groupNames);
		} else {
			message = new Message(false);
		}
		out.writeObject(message);
		out.flush();
		out.close();
	}
}
