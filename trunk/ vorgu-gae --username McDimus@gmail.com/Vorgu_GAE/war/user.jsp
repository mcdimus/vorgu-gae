<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List, ttu.vorgu2.hw1.model.Group,
	ttu.vorgu2.hw1.model.Person, ttu.vorgu2.hw1.dao.Dao"%>

<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect("/");
	}
	Dao dao = Dao.INSTANCE;
	List<Group> groups = dao.getGroups();
	Person user = dao.checkPerson((String) session.getAttribute("id"));
	String userGroup = user.getGroup();
%>

<!DOCTYPE html>
<html>
<head>
	<title>Welcome!</title>
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
	if (request.getParameter("passcheck") != null) {
		%>alert("Update failed: passwords do not match!");<%
	}
	%>
 		function initialize() {
	    	var myOptions = {
	      		zoom: 8,
	      		mapTypeId: google.maps.MapTypeId.ROADMAP
	    	};
	    	var map = new google.maps.Map(document.getElementById("map_canvas"),
	        	myOptions);
	        var initialLocation, infowindow;
			var browserSupportFlag =  new Boolean();
			  
			// Try W3C Geolocation
  			if(navigator.geolocation) {
    			browserSupportFlag = true;
    			navigator.geolocation.getCurrentPosition(function(position) {
      				initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
      				map.setCenter(initialLocation);
      				infowindow = new google.maps.InfoWindow({
             			map: map,
              			position: initialLocation,
              			content: 'You are here'
            		});
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
    			alert(message + "You will be placed at the last known location");
    			
    			var options = {
          			map: map,
         			position: initialLocation,
              		content: 'Where the hell are you?'
        		};
				
				infowindow = new google.maps.InfoWindow(options);
    			map.setCenter(initialLocation);
  			}
  		}
	</script>
</head>
<body onload="initialize()">
	<div style="width: 100%; height: 100%">
		<div class="line"></div>
		<div class="topLine">
			<div style="float: left;" class="headline">
				<%=user.getUsername()%>
				[<%=user.getGroup()%>] @ 
				<%=user.getLatitude()%>, 
				<%=user.getLongitude()%>
			</div>
			<div style="float: right;">
				<a href="/?logout">Logout</a>
			</div>
		</div>
		<hr />
		<form action="/update" method="post" accept-charset="utf-8">
			<table class="wborder">
				<tr>
					<th colspan="2">Edit your profile:</th>
				</tr>	
				<tr>
					<td><label for="password">Password</label></td>
					<td><input type="password" name="password" id="password"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="reppassword">Repeat password</label></td>
					<td><input type="password" name="reppassword" id="reppassword"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="firstname">Firstname</label></td>
					<td><input type="text" name="firstname" id="firstname"
						size="50" value="<%=user.getFirstname()%>" /></td>
				</tr>
				<tr>
					<td><label for="lastname">Lastname</label></td>
					<td><input type="text" name="lastname" id="lastname"
						size="50" value="<%=user.getLastname()%>" /></td>
				</tr>
				<tr>
					<td><label for="phonenumber">Phone number</label></td>
					<td><input type="text" name="phonenumber" id="phonenumber"
						size="50" value="<%=user.getPhonenumber()%>" /></td>
				</tr>
				<tr>	
					<td colspan="2">
						<input type="hidden" name="id"
							value="<%=user.getId()%>" /> 
						<input type="submit" name="submit"
							value="Update" />
					</td>
				</tr>
			</table>
		</form>
		<hr />
		<form action="/new_group" method="post" accept-charset="utf-8">
			<table class="wborder">
				<tr>
					<th colspan="2">Create new group</th>
				</tr>
				<tr>
					<td><label for="gname">Name</label></td>
					<td><input type="text" name="groupname" id="groupname"
						size="50" /></td>
				</tr>
				<tr>
					<td><label for="description">Description</label></td>
					<td><input type="text" name="description" id="description"
						size="50" /></td>
				</tr>
				<tr>
					<td>
						<input type="hidden" name="web"
							value="user" />
						<input type="hidden" name="creator"
							value="<%=user.getUsername()%>" />
						<input type="hidden" name="id"
							value="<%=user.getId()%>" />
						<input type="submit" name="submit"
							value="Create" />
					</td>
					<td>
						<i style="font-size:x-small">
							Note: You will automatically join your newly created group.
						</i>
					</td>
				</tr>
			</table>
		</form>
		<hr />
		<form action="/join_group" method="post">
			<table class="wborder">
				<tr>
					<th colspan="3">Current group</th>
				</tr>
				<tr>
					<td>Name</td>
					<td colspan="2"><%=userGroup%></td>
				</tr>
				<tr>
					<td>Description</td>
					<td colspan="2"><%=userGroup%></td>
				</tr>
				<tr>
					<td>Owner</td>
					<td><%=userGroup%></td>
					<td><a href="">Delete_link(if owned)</a></td>
				</tr>
				<tr>
					<td><label for="groupname">Join a group</label></td>
					<td>
						<select name="groupname" id="gname">
							<%
								for (Group group : groups) {
									if (!group.getName().equals(userGroup)) { %>
							<option value="<%=group.getName()%>">
								<%=group.getName()%>
							</option>
								<%	}
								}	%>
						</select>
					</td>
					<td align="right">
						<input type="hidden" name="web"
							value="user" /> 
						<input type="hidden" name="id"
							value="<%=user.getId()%>" /> 
						<input type="submit" name="submit"
							value="Join" />
					</td>
				</tr>
			</table>
		</form>
		<div id="map_canvas"></div>

</body>
</html>