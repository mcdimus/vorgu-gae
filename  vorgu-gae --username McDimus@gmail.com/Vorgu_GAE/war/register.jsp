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
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<script type="text/javascript"
    	src="http://maps.googleapis.com/maps/api/js?sensor=true">
	</script>
	<script type="text/javascript"
    	src="http://code.google.com/apis/gears/gears_init.js">
	</script>
	<script type="text/javascript">
 		function initialize() {
			var browserSupportFlag =  new Boolean();
			  
			// Try W3C Geolocation (Preferred)
  			if(navigator.geolocation) {
    			browserSupportFlag = true;
    			navigator.geolocation.getCurrentPosition(function(position) {
      				document.getElementById('latitude').innerText = position.coords.latitude;
					document.getElementById('longitude').innerText = position.coords.longitude;
    			}, function() {
      				handleNoGeolocation(browserSupportFlag);
    			});
  			// Try Google Gears Geolocation
  			} else if (google.gears) {
    			browserSupportFlag = true;
    			var geo = google.gears.factory.create('beta.geolocation');
    			geo.getCurrentPosition(function(position) {
      				document.getElementById('longitude').innerText = position.coords.latitude;
					document.getElementById('longitude').innerText = position.coords.longitude;
    			}, function() {
      				handleNoGeoLocation(browserSupportFlag);
    			});
  			// Browser doesn't support Geolocation
  			} else {
    			browserSupportFlag = false;
    			handleNoGeolocation(browserSupportFlag);
  			}
  
  			function handleNoGeolocation(errorFlag) {
    			if (errorFlag == true) {
      				location.assign("?geo_loc=true");
    			} else {
      				alert("?geo_loc=false");
    			}
  			}
  		}
	</script>
</head>
<body onload="initialize()">
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
	<div class="main">
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
					<td><label>Your current position:</label></td>
				</tr>
				<tr>
					<td><label for="latitude">Latitude</label></td>
					<td><input type="text" name="latitude" id="latitude"
						disabled="disabled" size="65" /></td>
				</tr>
				<tr>
					<td><label for="longitude">Longitude</label></td>
					<td><input type="text" name="longitude" id="longitude"
						disabled="disabled" size="65" /></td>
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