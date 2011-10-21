package ttu.vorgu2.hw1;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ttu.vorgu2.hw1.dao.Dao;
import ttu.vorgu2.hw1.model.Group;

@SuppressWarnings("serial")
public class ServletCreateGroup extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		OutputStream pw = resp.getOutputStream();
		ObjectOutputStream out = new ObjectOutputStream(pw);

		Message message = null;
		
		String web = req.getParameter("web");
		String creatorId = checkNull(req.getParameter("id"));
		String creator = checkNull(req.getParameter("creator"));
		String name = checkNull(req.getParameter("groupname"));
		String description = checkNull(req.getParameter("description"));

		Dao.INSTANCE.addGroup(creatorId, creator, name, description);

		if (web != null && web.equals("admin")) {
			resp.sendRedirect("/admin.jsp");
		} else if (web != null && web.equals("user")) {
			resp.sendRedirect("/user.jsp");
		} else {
			List<Group> groups = Dao.INSTANCE.getGroups();
			List<String> groupNames = new ArrayList<String>();
			for (int i = 0; i < groups.size(); i++) {
				groupNames.add(groups.get(i).getName());
			}
			message = new Message(true, groupNames);
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