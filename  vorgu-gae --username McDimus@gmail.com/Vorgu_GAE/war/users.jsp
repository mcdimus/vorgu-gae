<%-- <%@ page contentType="text/html;charset=UTF-8" language="java"%> --%>
<%-- <%@ page import="java.util.List"%> --%>
<%-- <%@ page import="com.google.appengine.api.users.User"%> --%>
<%-- <%@ page import="com.google.appengine.api.users.UserService"%> --%>
<%-- <%@ page import="com.google.appengine.api.users.UserServiceFactory"%> --%>
<%-- <%@ page import="ttu.vorgu2.hw1.model.Group"%> --%>
<%-- <%@ page import="ttu.vorgu2.hw1.model.Person"%> --%>
<%-- <%@ page import="ttu.vorgu2.hw1.dao.Dao"%> --%>

<!-- <!DOCTYPE html> -->


<%-- <%@page import="java.util.ArrayList"%> --%>

<!-- <html> -->
<!-- <head> -->
<!-- <title>Users</title> -->
<!-- <link rel="stylesheet" type="text/css" href="css/main.css" /> -->
<!-- <meta charset="utf-8"> -->
<!-- </head> -->
<!-- <body> -->
<%-- 	<% --%>
// 		// create instance of data access object (DAO)
// 		Dao dao = Dao.INSTANCE;

// 		UserService userService = UserServiceFactory.getUserService();
// 		User user = userService.getCurrentUser();

// 		String url = userService.createLoginURL(request.getRequestURI());
// 		String urlLinktext = "Login";
// 		List<Person> persons = new ArrayList<Person>();

// 		if (user != null) {
// 			url = userService.createLogoutURL(request.getRequestURI());
// 			urlLinktext = "Logout";
// 			persons = dao.getPersons();
// 		}
<%-- 	%> --%>
<!-- 	<div style="width: 100%;"> -->
<!-- 		<div class="line"></div> -->
<!-- 		<div class="topLine"> -->
<!-- 			<div style="float: left;"> -->
<!-- 				<img src="images/todo.png" width="25%" height="25%" /> -->
<!-- 			</div> -->
<!-- 			<div style="float: left;" class="headline">Users</div> -->
<!-- 			<div style="float: right;"> -->
<%-- 				<a href="<%=url%>"><%=urlLinktext%></a> --%>
<%-- 				<%=(user == null ? "" : user.getNickname())%></div> --%>
<!-- 		</div> -->
<!-- 	</div> -->

<!-- 	<div style="clear: both;"></div> -->
<!-- 	There are a total number of -->
<%-- 	<%=persons.size()%> --%>
<!-- 	registered users. -->

<!-- 	<table> -->
<!-- 		<tr> -->
<!-- 			<th>Name</th> -->
<!-- 			<th>Phone number</th> -->
<!-- 			<th>Group</th> -->
<!-- 		</tr> -->

<%-- 		<% --%>
// 			for (Person person : persons) {
<%-- 		%> --%>
<!-- 		<tr> -->
<%-- 			<td><%=person.getName()%></td> --%>
<%-- 			<td><%=person.getPhoneNumber()%></td> --%>
<%-- 			<td><%=person.getGroup()%></td> --%>

<%-- 			<% --%>
// 				if (person.getName().equals(user.getNickname())) {
<%-- 			%> --%>
<%-- 			<td><a class="done" href="/delete_person?id=<%=person.getId()%>">Delete</a></td> --%>
<%-- 			<% --%>
// 				}
<%-- 			%> --%>
<!-- 		</tr> -->
<%-- 		<% --%>
// 			}
<%-- 		%> --%>

<!-- 	</table> -->


<!-- 	<hr /> -->

<!-- 	<div class="main"> -->

<!-- 		<div class="headline">New group</div> -->

<%-- 		<% --%>
// 			if (user != null) {
// 				List<Group> groups = dao.getGroups();
<%-- 		%> --%>

<!-- 		<form action="/new_person" method="post" accept-charset="utf-8"> -->
<!-- 			<table> -->
<!-- 				<tr> -->
<!-- 					<td><label for="name">Name</label></td> -->
<!-- 					<td><input type="text" name="name" id="name" size="65" -->
<%-- 						value="<%=user.getNickname()%>" /></td> --%>
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td><label for="phone">Phone number</label></td> -->
<!-- 					<td><input type="text" name="phone" id="phone" size="65" /></td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td><label for="group">Group</label></td> -->
<!-- 					<td><select name="group" id="group"> -->
<!-- 							<option>Choose one...</option> -->
<%-- 							<% --%>
// 								for (Group group : groups) {
<%-- 							%> --%>
<%-- 							<option value="<%=group.getName()%>"><%=group.getName()%></option> --%>
<%-- 							<% --%>
// 								}
<%-- 							%> --%>
<!-- 					</select></td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td colspan="2" align="right"><input type="submit" -->
<!-- 						value="Create" /></td> -->
<!-- 				</tr> -->
<!-- 			</table> -->
<!-- 		</form> -->

<%-- 		<% --%>
// 			} else {
<%-- 		%> --%>

<!-- 		Please login with your Google account -->

<%-- 		<% --%>
// 			}
<%-- 		%> --%>
<!-- 	</div> -->
<!-- </body> -->
<!-- </html> -->