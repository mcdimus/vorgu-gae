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
	<title>Register</title>
	<link rel="stylesheet" type="text/css" href="css/main.css" />
	<meta charset="utf-8">
</head>
<body>
	<%
		// create instance of data access object (DAO)
		Dao dao = Dao.INSTANCE;
		List<Person> persons = new ArrayList<Person>();
		List<Group> groups = new ArrayList<Group>();
		persons = dao.getPersons();
		groups = dao.getGroups();
	%>
	
	<div style="width: 100%;">
		<div class="topLine">
			<div style="float: left;" class="headline">
				Register new user
			</div>
		</div>
	</div>
	<hr />
	<div class="main" style="border: 1px solid #CCCCCC; width: 565px">
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
					<td><label for="longitude">Longitude</label></td>
					<td><input type="text" name="longitude" id="longitude"
						size="65" /></td>
				</tr>
				<tr>
					<td><label for="latitude">Latitude</label></td>
					<td><input type="text" name="latitude" id="latitude"
						size="65" /></td>
				</tr>
				<tr>
					<td><label for="group">Group</label></td>
					<td><select name="group" id="group">
							<option>Choose one...</option>
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
					<td colspan="2"><input type="hidden" name="web"
						value="user" /> <input type="submit" name="submit"
						value="Create" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>