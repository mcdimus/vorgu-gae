<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="ttu.vorgu2.hw1.dao.Dao, java.util.List,
	ttu.vorgu2.hw1.model.Person"%>

<%
	if (request.getParameter("logout") != null) {
		session.setAttribute("id", null);
	}
	String geoloc = request.getParameter("geo_loc");
	String userName = "";
	String successReg = request.getParameter("register");
	boolean loginFailed = false;
	if (request.getParameter("username") != null) {
		userName = request.getParameter("username");
		Dao dao = Dao.INSTANCE;
		String password = request.getParameter("password");
		Person person = dao.login(userName, password);
		if (person != null) {
			session.setAttribute("id", userName);
			if (userName.equals("admin")) {
				response.sendRedirect("/admin.jsp");
			} else {
				response.sendRedirect("/user.jsp");
			}
		} else {
			loginFailed = true;
		}
	}	
%>

<!DOCTYPE html>
<html>
<head>
	<title>Cheers!</title>
	<link rel="stylesheet" type="text/css" href="css/main.css" />
	<meta charset=UTF-8">
	<script type="text/javascript">
	<%
	if (loginFailed) {
		%>alert("Wrong name and/or password!");<%
	} else if (geoloc != null) {
		boolean geoLoc = Boolean.parseBoolean(geoloc);
		if (geoLoc) {
		%>alert("Geolocation service failed.");<%
		} else {
		%>alert("Your browser doesn't support geolocation.");<%	
		}
	} else if(successReg != null) { 
		%>alert("Successful registration!");<% 
	} 
	%>
	</script>
</head>
<body>
	<div style="width: 100%;">
		<div class="topLine">
			<div style="float: left;" class="headline">
				Login to Google Map App
			</div>
			<div style="float: right;">
				<a href="register.jsp">Register!</a>
			</div>
		</div>
	</div>

	<div class="login">
		<form action="" method="post" accept-charset="utf-8">
			<table class="wborder">
				<tr>
					<td><label for="username">Username</label></td>
					<td><input type="text" name="username" id="username" 
						value="<%=userName%>" /></td>
				</tr>
				<tr>
					<td><label for="password">Password</label></td>
					<td><input type="password" name="password" id="password"
						/></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="Login" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>