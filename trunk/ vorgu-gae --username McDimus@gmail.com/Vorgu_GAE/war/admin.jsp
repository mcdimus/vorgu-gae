<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="ttu.vorgu2.hw1.model.Group"%>
<%@ page import="ttu.vorgu2.hw1.model.Person"%>
<%@ page import="ttu.vorgu2.hw1.dao.Dao"%>

<%
	/*if (!session.getAttribute("id").equals("admin")) {
		response.sendRedirect("/");
	}*/
%>

<!DOCTYPE html>


<%@page import="java.util.ArrayList"%>

<html>
<head>
	<title>Admin</title>
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
			<div style="float: left;" class="headline">Admin place</div>
			<div style="float: right;">
				<a href="/?logout">Logout</a>
			</div>
		</div>

		<div style="clear: both;"></div>
		There are a total number of
		<%=persons.size()%>
		registered users.

		<table>
			<tr>
				<th>Username</th>
				<th>Password</th>
				<th>Firstname</th>
				<th>Lastname</th>
				<th>Phonenumber</th>
				<th>Group</th>
				<th>Latitude</th>
				<th>Longitude</th>
				<th>Signup date</th>
			</tr>

			<%
				for (Person person : persons) {
			%>
			<tr>
				<td><%=person.getUsername()%></td>
				<td><%=person.getPassword()%></td>
				<td><%=person.getFirstname()%></td>
				<td><%=person.getLastname()%></td>
				<td><%=person.getPhonenumber()%></td>
				<td><%=person.getGroup()%></td>
				<td><%=person.getLatitude()%></td>
				<td><%=person.getLongitude()%></td>
				<td><%=person.getSignupDate()%>
				<td><a class="done"
					href="/delete_person?id=<%=person.getId()%>">Delete</a></td>
				<td><a class="done"
					href="/join_group?id=<%=person.getId()%>&groupname=None">Join none group</a></td>
			</tr>
			<%
				}
			%>

		</table>


		<hr />

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

				<td><a class="done" href="/delete_group?id=<%=group.getId()%>">Delete</a></td>

			</tr>
			<%
				}
			%>

		</table>

		<hr />

		<div class="main">

			<div class="headline">New user</div>

			<form action="/register" method="post" accept-charset="utf-8">
				<table>
					<tr>
						<td><label for="username">Username</label></td>
						<td><input type="text" name="username" id="username"
							size="65" /></td>
					</tr>
					<tr>
						<td><label for="password">Password</label></td>
						<td><input type="password" name="password" id="password"
							size="65" /></td>
					</tr>
					<tr>
						<td><label for="firstname">Firstname</label></td>
						<td><input type="text" name="firstname" id="firstname"
							size="65" /></td>
					</tr>
					<tr>
						<td><label for="lastname">Lastname</label></td>
						<td><input type="text" name="lastname" id="lastname"
							size="65" /></td>
					</tr>
					<tr>
						<td><label for="phonenumber">Phone number</label></td>
						<td><input type="text" name="phonenumber" id="phonenumber"
							size="65" /></td>
					</tr>
					<tr>
						<td><label for="latitude">Latitude</label></td>
						<td><input type="text" name="latitude" id="latitude"
							size="65" /></td>
					</tr>
					<tr>
						<td><label for="longitude">Longitude</label></td>
						<td><input type="text" name="longitude" id="longitude"
							size="65" /></td>
					</tr>
					<tr>
						<td><label for="group">Group</label></td>
						<td><select name="group" id="group">
								<option value="">Choose one...</option>
								<%
									for (Group group : groups) {
								%>
								<option value="<%=group.getName()%>"><%=group.getName()%></option>
								<%
									}
								%>
						</select></td>
					</tr>

					<tr>
						<td colspan="2" align="right"><input type="hidden" name="web"
							value="true" /> <input type="submit" name="submit"
							value="Create" /></td>
					</tr>
				</table>
			</form>

			<hr />

			<div class="headline">New group</div>
			<form action="/new_group" method="post" accept-charset="utf-8">
				<table>
					<tr>
						<td><label for="groupname">Group name</label></td>
						<td><input type="text" name="groupname" id="groupname"
							size="65" /></td>
					</tr>
					<tr>
						<td><label for="description">Description</label></td>
						<td><input type="text" name="description" id="description"
							size="65" /></td>
					</tr>
					<tr>
						<td><label for="creator">Creator</label></td>
						<td><input type="text" name="creator" id="creator" size="65" /></td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<input type="hidden" name="web"
							value="true" />
							<input type="submit" value="Create" />
						</td>
					</tr>
				</table>
			</form>
		</div>
</body>
</html>