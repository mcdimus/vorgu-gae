package ttu.vorgu2.hw1;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ttu.vorgu2.hw1.dao.Dao;
import ttu.vorgu2.hw1.model.Person;

public class ServletSetCoords extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 23449491411349606L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		OutputStream pw = resp.getOutputStream();
		ObjectOutputStream out = new ObjectOutputStream(pw);

		Message message = null;

		String id = req.getParameter("id");
		Double latitude = Double.parseDouble(req.getParameter("latitude"));
		Double longitude = Double.parseDouble(req.getParameter("longitude"));
		List<Person> persons = Dao.INSTANCE.setCoordsToPerson(id, latitude,
				longitude);
		message = new Message(true, "default", persons);
		out.writeObject(message);
		out.flush();
		out.close();

	}
}
