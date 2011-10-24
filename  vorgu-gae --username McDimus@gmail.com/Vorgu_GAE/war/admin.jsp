<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List, ttu.vorgu2.hw1.model.Group,
	ttu.vorgu2.hw1.model.Person, ttu.vorgu2.hw1.dao.Dao"%>
<%
	if (session.getAttribute("name") == null || !session.getAttribute("name")
		.equals("admin")) {
		response.sendRedirect("/");
	}
	// create instance of data access object (DAO)
	Dao dao = Dao.INSTANCE;
	Person admin = dao.checkPerson((String) session.getAttribute("name"));
	// create new person
	if (request.getParameter("createperson") != null) {
		dao.addPerson(request.getParameter("username"),
			request.getParameter("password"),
			request.getParameter("firstname"),
			request.getParameter("lastname"),
			request.getParameter("phonenumber"),
			request.getParameter("group"),
			Double.parseDouble(request.getParameter("latitude")),
			Double.parseDouble(request.getParameter("longitude")));
	// update person
	} else if (request.getParameter("updateperson") != null) {
		dao.updatePerson(request.getParameter("id"),
			request.getParameter("username"),
			request.getParameter("password"),
			request.getParameter("firstname"),
			request.getParameter("lastname"),
			request.getParameter("phonenumber"),
			request.getParameter("group"),
			Double.parseDouble(request.getParameter("latitude")),
			Double.parseDouble(request.getParameter("longitude")));
	// delete group
	} else if (request.getParameter("deleteperson") != null) {
		dao.deletePerson(request.getParameter("id"));
	// create new person
	} else if (request.getParameter("creategroup") != null) {
		dao.addGroup(request.getParameter("id"),
			request.getParameter("creator"),
			request.getParameter("groupname"),
			request.getParameter("description"));
	// update group
	} else if (request.getParameter("updategroup") != null) {
		dao.updateGroup(request.getParameter("id"),
			request.getParameter("groupname"),
			request.getParameter("description"), 
			request.getParameter("creator"));
	// delete group
	} else if (request.getParameter("deletegroup") != null) {
		dao.deleteGroup(request.getParameter("id"));
	}
	List<Person> persons = dao.getPersons();
	List<Group> groups = dao.getGroups();
%>

<!DOCTYPE html>
<html>
<head>
	<title>Admin</title>
	<link rel="stylesheet" type="text/css" href="css/main.css" />
	<meta charset="utf-8">
</head>
<body>
	<div style="width: 100%;">
		<div class="line"></div>
		<div class="topLine">
			<div style="float: left;" class="headline">Admin place</div>
			<div style="float: right;">
				<a href="/?logout">Logout</a>
			</div>
		</div>
		<hr />

		<table class="wborder">
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
				<th colspan="2" />
			</tr>

			<%
				for (Person person : persons) {
			%>
			<form action="" method="post" accept-charset="utf-8">
				<tr>
					<td><input type="text" name="username" size="7"
						value="<%=person.getUsername()%>" /></td>
					<td><input type="text" name="password" size="7"
						value="<%=person.getPassword()%>" /></td>
					<td><input type="text" name="firstname" size="7"
						value="<%=person.getFirstname()%>" /></td>
					<td><input type="text" name="lastname" size="7"
						value="<%=person.getLastname()%>" /></td>
					<td><input type="text" name="phonenumber" size="7"
						value="<%=person.getPhonenumber()%>" /></td>
					<td><input type="text" name="group" size="7"
						value="<%=person.getGroup()%>" /></td>
					<td><input type="text" name="latitude" size="7"
						value="<%=person.getLatitude()%>" /></td>
					<td><input type="text" name="longitude" size="7"
						value="<%=person.getLongitude()%>" /></td>
					<td><%=person.getSignupDate()%></td>
					<td><input type="hidden" name="id"
							value="<%=person.getId()%>" />
						<input type="hidden" name="updateperson"
							value="updateperson" />
						<input type="submit" name="submit"
							value="Update" /></td>
			</form>
					<form action="" method="post" accept-charset="utf-8">
							<td><input type="hidden" name="id"
								value="<%=person.getId()%>" />
								<input type="hidden" name="deleteperson"
									value="deleteperson" />
								<input type="submit" name="submit"
									value="Delete" /></td>
					</form>
				</tr>
			<%
				}
			%>
				<tr>
					<td colspan="11" align="right">
						Total persons: <%=persons.size()%>
					</td>
				</tr>

		</table>
		<hr />

		<table class="wborder">
			<tr>
				<th>Name</th>
				<th>Description</th>
				<th>Creator</th>
				<th>Creation date</th>
				<th colspan="2" />
			</tr>

			<%
				for (Group group : groups) {
			%>
			<tr>
				<form action="" method="post" accept-charset="utf-8">
					<td><input type="text" name="groupname" size="7"
						value="<%=group.getName()%>" /></td>
					<td><input type="text" name="description" size="7"
						value="<%=group.getDescription()%>" /></td>
					<td><input type="text" name="creator" size="7"
						value="<%=group.getCreator()%>" /></td>
					<td><%=group.getCreationDate()%></td>
					<td><input type="hidden" name="id"
								value="<%=group.getId()%>" />
							<input type="hidden" name="updategroup"
								value="updategroup" />
							<input type="submit" name="submit"
								value="Update" /></td>
				</form>
				<form action="" method="post" accept-charset="utf-8">
					<td><input type="hidden" name="id"
							value="<%=group.getId()%>" />
						<input type="hidden" name="deletegroup"
							value="deletegroup" />
						<input type="submit" name="submit"
								value="Delete" /></td>
				</form>
			</tr>
			<%
				}
			%>
				<tr>
					<td colspan="6" align="right">
						Total groups: <%=groups.size()%>
					</td>
				</tr>

		</table>
		<hr />

		<form action="" method="post" accept-charset="utf-8">
			<table class="wborder">
				<tr>
					<th colspan="2">New user</td>
				</tr>
				<tr>
					<td><label for="username">Username</label></td>
					<td><input type="text" name="username" id="username"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="password">Password</label></td>
					<td><input type="password" name="password" id="password"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="firstname">Firstname</label></td>
					<td><input type="text" name="firstname" id="firstname"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="lastname">Lastname</label></td>
					<td><input type="text" name="lastname" id="lastname"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="phonenumber">Phone number</label></td>
					<td><input type="text" name="phonenumber" id="phonenumber"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="latitude">Latitude</label></td>
					<td><input type="text" name="latitude" id="latitude"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="longitude">Longitude</label></td>
					<td><input type="text" name="longitude" id="longitude"
						size="50" /></td>
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
					<td colspan="2" align="right">
						<input type="hidden" name="createperson"
							value="createperson" />
					<input type="submit" name="submit"
						value="Create" /></td>
				</tr>
			</table>
		</form>
		<hr />
			
		<form action="" method="post" accept-charset="utf-8">
			<table class="wborder">
				<tr>
					<th colspan="2">New group</td>
				</tr>
				<tr>
					<td><label for="groupname">Group name</label></td>
					<td><input type="text" name="groupname" id="groupname"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="description">Description</label></td>
					<td><input type="text" name="description" id="description"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="creator">Creator</label></td>
					<td><input type="text" name="creator" id="creator" size="50" /></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="hidden" name="creategroup"
							value="creategroup" />
						<input type="hidden" name="id"
							value="<%=admin.getId()%>" />
						<input type="submit" value="Create" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>