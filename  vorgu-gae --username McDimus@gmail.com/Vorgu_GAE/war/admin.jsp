<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List, com.google.appengine.api.users.User,
	ttu.vorgu2.hw1.model.Group, ttu.vorgu2.hw1.model.Person,
	ttu.vorgu2.hw1.dao.Dao, javax.persistence.EntityManager,
	ttu.vorgu2.hw1.dao.EMFService"%>
<%
	EntityManager em;
	if (session.getAttribute("name") == null || !session.getAttribute("name")
		.equals("admin")) {
		response.sendRedirect("/");
	}
	em = EMFService.get().createEntityManager();
	if (request.getParameter("updateperson") != null) {
		Person person = em.find(Person.class, Long.parseLong(request.getParameter(
			"id")));
		person.setUsername(request.getParameter("username"));
		person.setPassword(request.getParameter("password"));
		person.setFirstname(request.getParameter("firstname"));
		person.setLastname(request.getParameter("lastname"));
		person.setPhonenumber(request.getParameter("phonenumber"));
		person.setGroup(request.getParameter("group"));
		person.setLatitude(Double.parseDouble(request.getParameter("latitude")));
		person.setLongitude(Double.parseDouble(request.getParameter("longitude")));
		em.persist(person);
	} else if (request.getParameter("deleteperson") != null) {
		Person person = em.find(Person.class, Long.parseLong(request.getParameter(
			"id")));
		em.remove(person);
	} else if (request.getParameter("updategroup") != null) {
		Group group = em.find(Group.class, Long.parseLong(request.getParameter(
			"id")));
		group.setName(request.getParameter("groupname"));
		group.setDescription(request.getParameter("description"));
		group.setCreator(request.getParameter("creator"));
		em.persist(group);
		
	} else if (request.getParameter("deletegroup") != null) {
		Group group = em.find(Group.class, Long.parseLong(request.getParameter(
			"id")));
		em.remove(group);
	}
	em.close();
%>

<!DOCTYPE html>
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
		Person admin = dao.checkPerson((String) session.getAttribute("name"));
		List<Person> persons = dao.getPersons();
		List<Group> groups = dao.getGroups();
	%>
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

		<div class="main">

			<div class="headline">New user</div>

			<form action="/register" method="post" accept-charset="utf-8">
				<table class="wborder">
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
							value="admin" /> <input type="submit" name="submit"
							value="Create" /></td>
					</tr>
				</table>
			</form>

			<hr />

			<div class="headline">New group</div>
			<form action="/new_group" method="post" accept-charset="utf-8">
				<table class="wborder">
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
							value="admin" />
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