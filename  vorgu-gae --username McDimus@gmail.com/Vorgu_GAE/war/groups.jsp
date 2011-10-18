<%-- <%@ page contentType="text/html;charset=UTF-8" language="java"%> --%>
<%-- <%@ page import="java.util.List"%> --%>
<%-- <%@ page import="com.google.appengine.api.users.User"%> --%>
<%-- <%@ page import="com.google.appengine.api.users.UserService"%> --%>
<%-- <%@ page import="com.google.appengine.api.users.UserServiceFactory"%> --%>
<%-- <%@ page import="ttu.vorgu2.hw1.model.Group"%> --%>
<%-- <%@ page import="ttu.vorgu2.hw1.dao.Dao"%> --%>

<!-- <!DOCTYPE html> -->


<%-- <%@page import="java.util.ArrayList"%> --%>

<!-- <html> -->
<!-- <head> -->
<!-- <title>Groups</title> -->
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
// 		List<Group> groups = new ArrayList<Group>();

// 		if (user != null) {
// 			url = userService.createLogoutURL(request.getRequestURI());
// 			urlLinktext = "Logout";
// 			groups = dao.getGroups();
// 		}
<%-- 	%> --%>
<!-- 	<div style="width: 100%;"> -->
<!-- 		<div class="line"></div> -->
<!-- 		<div class="topLine"> -->
<!-- 			<div style="float: left;"> -->
<!-- 				<img src="images/todo.png" width="25%" height="25%" /> -->
<!-- 			</div> -->
<!-- 			<div style="float: left;" class="headline">Groups</div> -->
<!-- 			<div style="float: right;"> -->
<%-- 				<a href="<%=url%>"><%=urlLinktext%></a> --%>
<%-- 				<%=(user == null ? "" : user.getNickname())%></div> --%>
<!-- 		</div> -->
<!-- 	</div> -->

<!-- 	<div style="clear: both;"></div> -->
<!-- 	You have a total number of -->
<%-- 	<%=groups.size()%> --%>
<!-- 	Groups. -->

<!-- 	<table> -->
<!-- 		<tr> -->
<!-- 			<th>Name</th> -->
<!-- 			<th>Description</th> -->
<!-- 			<th>Creator</th> -->
<!-- 		</tr> -->

<%-- 		<% --%>
// 			for (Group group : groups) {
<%-- 		%> --%>
<!-- 		<tr> -->
<%-- 			<td><%=group.getName()%></td> --%>
<%-- 			<td><%=group.getDescription()%></td> --%>
<%-- 			<td><%=group.getCreator()%></td> --%>
<%-- 			<td><a class="done" href="/join?id=<%=group.getId()%>">Join</a></td> --%>

<%-- 			<% --%>
// 				if (group.getCreator().equals(user.getNickname())) {
<%-- 			%> --%>
<%-- 			<td><a class="done" href="/delete_group?id=<%=group.getId()%>">Delete</a></td> --%>
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
<%-- 		%> --%>

<!-- 		<form action="/new_group" method="post" accept-charset="utf-8"> -->
<!-- 			<table> -->
<!-- 				<tr> -->
<!-- 					<td><label for="name">Name</label></td> -->
<!-- 					<td><input type="text" name="name" id="name" size="65" /></td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td valign="center"><label for="description">Description</label></td> -->
<!-- 					<td><textarea rows="4" cols="50" name="description" -->
<!-- 							id="description"></textarea></td> -->
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