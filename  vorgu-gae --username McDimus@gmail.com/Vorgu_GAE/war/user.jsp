<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="ttu.vorgu2.hw1.model.Group"%>
<%@ page import="ttu.vorgu2.hw1.model.Person"%>
<%@ page import="ttu.vorgu2.hw1.dao.Dao"%>

<!DOCTYPE html>


<%@page import="java.util.ArrayList"%>

<html>
<head>
<title>Users</title>
<link rel="stylesheet" type="text/css" href="css/main.css" />
<meta charset="utf-8">
</head>
<body>
	<%
	
		// create instance of data access object (DAO)
		Dao dao = Dao.INSTANCE;

		// 		UserService userService = UserServiceFactory.getUserService();
		// 		User user = userService.getCurrentUser();

		// 		String url = userService.createLoginURL(request.getRequestURI());
		// 		String urlLinktext = "Login";
		List<Person> persons = new ArrayList<Person>();
		List<Group> groups = new ArrayList<Group>();

		// 		if (user != null) {
		// 			url = userService.createLogoutURL(request.getRequestURI());
		// 			urlLinktext = "Logout";
		persons = dao.getPersons();
		groups = dao.getGroups();
		// 		}
	%>
	<div style="width: 100%;">
		<div class="line"></div>
		<div class="topLine">
			<div style="float: left;">
				<img src="images/todo.png" width="25%" height="25%" />
			</div>
			<div style="float: left;" class="headline">$USER_NAME HERE</div>
			<div style="float: right;">
				<a href="">CHANGE USER INFO???</a>
			</div>
		</div>

	<p>$CURRENT_GROUP HERE</p>

		<div style="clear: both;"></div>
		There are a total number of
		<%=groups.size()%>
		groups.

		<table>
			<tr>
				<th>Name</th>
				<th>Description</th>
				<th>Creator</th>
				<th>Creation date</th>
			</tr>

			<%
				for (Group group : groups) {
			%>
			<tr>
				<td><%=group.getName()%></td>
				<td><%=group.getDescription()%></td>
				<td><%=group.getCreator()%></td>
				<td><%=group.getCreationDate()%></td>
				<%-- 			<td><a class="done" href="/join?id=<%=group.getId()%>">Join</a></td> --%>

			</tr>
			<%
				}
			%>

		</table>
		
		<div style="border: 5px solid #00FF00; position: absolute; right: 50px;
			top:70px; width: 400px; height: 400px;">MAP HERE</div>
		<div style="position: absolute; left: 50px;
			top:200px;">JOIN A GROUP HERE</div>

</body>
</html>