<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List, ttu.vorgu2.hw1.model.Group,
	ttu.vorgu2.hw1.dao.Dao, ttu.vorgu2.hw1.model.Person"%>

<%		
		Dao dao = Dao.INSTANCE;
		List<Group> groups = dao.getGroups();
%>

<!DOCTYPE html>
<html>
<head>
	<title>Signup</title>
	<link rel="stylesheet" type="text/css" href="css/main.css" />
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<script type="text/javascript"
    	src="http://maps.googleapis.com/maps/api/js?sensor=true">
	</script>
	<script type="text/javascript"
    	src="http://code.google.com/apis/gears/gears_init.js">
	</script>
	<script type="text/javascript">
	<%
		String userName = "", firstName = "", lastName = "", phoneNumber = "",
			userGroup = "";
		double latitude = 60, longitude = 105;
		if(request.getParameter("username") != null) {
			userName = request.getParameter("username");
			String password = request.getParameter("password");
			String repPassword = request.getParameter("reppassword");
			firstName = request.getParameter("firstname");
			lastName = request.getParameter("lastname");
			phoneNumber = request.getParameter("phonenumber");
			userGroup = request.getParameter("group");
			if (request.getParameter("latitude").length() != 0
				&& request.getParameter("longitude").length() != 0) {
				latitude = Double.parseDouble(request.getParameter(
					"latitude"));
				longitude = Double.parseDouble(request.getParameter(
					"longitude"));
			}
			if (userName.length() == 0 || password.length() == 0
				|| repPassword.length() == 0) {
			%>alert("Fields with '*' marks should be filled!");<%
			} else if (!password.equals(repPassword)) {
			%>alert("The passwords do not match!");<%
			} else if (dao.checkPerson(userName) != null) {
			%>alert("Such username already exists! Please choose another one ...");<%
			} else {
				dao.addPerson(userName, password, firstName, lastName,
					phoneNumber, userGroup, longitude, latitude);
				response.sendRedirect("/?register");
			}
		}
	%>
 		function initialize() {
			var browserSupportFlag =  new Boolean();
			  
			// Try W3C GeoLocation
  			if(navigator.geolocation) {
    			browserSupportFlag = true;
    			navigator.geolocation.getCurrentPosition(function(position) {
      				document.getElementById('latitude').value = position.coords.latitude;
					document.getElementById('longitude').value = position.coords.longitude;
    			}, function() {
      				handleNoGeolocation(browserSupportFlag);
    			});
  			} else {
    			browserSupportFlag = false;
    			handleNoGeolocation(browserSupportFlag);
  			}
  
  			function handleNoGeolocation(errorFlag) {
  				var message = "";
    			if (errorFlag == true) {
      				message = "Geolocation service failed. ";
    			} else {
      				message = "Your browser doesn't support geolocation. ";
    			}
    			alert(message + "You will be placed in Siberia.");
  			}
  		}
	</script>
</head>
<body onload="initialize()">
	<div style="width: 100%;">
		<div class="topLine">
			<div style="float: left;" class="headline">
				Register new user
			</div>
			<div style="float: right;">
				<a href="/">Back</a>
			</div>
		</div>
	</div>
	<hr />
	<div class="main">
		<form action="" method="post" accept-charset="utf-8">
			<table class="wborder">
				<tr>
					<td><label for="username">Username *</label></td>
					<td><input type="text" name="username" id="username"
						size="50" value="<%=userName%>" /></td>
				</tr>
				<tr>
					<td><label for="password">Password *</label></td>
					<td><input type="password" name="password" id="password"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="reppassword">Repeat password *</label></td>
					<td><input type="password" name="reppassword" id="reppassword"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="firstname">Firstname</label></td>
					<td><input type="text" name="firstname" id="firstname"
						size="50" value="<%=firstName%>" /></td>
				</tr>
				<tr>
					<td><label for="lastname">Lastname</label></td>
					<td><input type="text" name="lastname" id="lastname"
						size="50" value="<%=lastName%>" /></td>
				</tr>
				<tr>
					<td><label for="phonenumber">Phone number</label></td>
					<td><input type="text" name="phonenumber" id="phonenumber"
						size="50" value="<%=phoneNumber%>" /></td>
				</tr>
				<tr>
					<td><label for="group">Group</label></td>
					<td>
						<select name="group" id="group">
							<option value="">Choose one...</option>
							<%
								for (Group group : groups) {
									if (userGroup.equals(group.getName())) { %>
							<option selected value="<%=group.getName()%>">
								<%=group.getName()%>
							</option>
								<%	} else { %>
							<option value="<%=group.getName()%>">
								<%=group.getName()%>
							</option>
							<%		}
								}
							%>
						</select>
					</td>
				</tr>
				<tr>	
					<td><input type="hidden" name="longitude" id="longitude" />
						<input type="hidden" name="latitude" id="latitude" />
						<input type="submit" name="submit"
							value="Create new user" />
					</td>
					<td colspan="2">
						<i style="font-size:x-small">
							Note 1: fields marked with '*' should be filled.
						</i>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>