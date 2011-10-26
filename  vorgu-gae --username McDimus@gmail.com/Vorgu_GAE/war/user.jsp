<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List, ttu.vorgu2.hw1.model.Group,
	ttu.vorgu2.hw1.model.Person, ttu.vorgu2.hw1.dao.Dao,
	ttu.vorgu2.hw1.SerializablePerson"%>

<%
	Dao dao = Dao.INSTANCE;
	if (session.getAttribute("name") == null) {
		response.sendRedirect("/");
	}
	if (request.getParameter("updategroup") != null) {
		if (request.getParameter("deletegroup") != null) {
			dao.deleteGroup(request.getParameter("id"));
		} else {
			dao.updateGroup(request.getParameter("id"),
				request.getParameter("groupname"),
				request.getParameter("description"),
				request.getParameter("creator"));
		}
	} else if (request.getParameter("updatecoords") != null) {
		dao.setCoordsToPerson(request.getParameter("id"),
			Double.parseDouble(request.getParameter("latitude")) * Math.pow(10, 6),
			Double.parseDouble(request.getParameter("longitude")) * Math.pow(10, 6));
	}
	// Current person-user.
	List<Group> groups = dao.getGroups();
	Person person = dao.checkPerson((String) session.getAttribute("name"));
	// Getting Group object associated with the person.
	Group g = dao.checkGroup(person.getGroup());
	String userGroup = "";
	if (g == null) {
		userGroup = "None";
	} else {
		userGroup = g.getName();
	}
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
	<script type="text/javascript">
	<%
	if (request.getParameter("updateperson") != null) {
		String id = request.getParameter("id"),
			password = request.getParameter("password"),
			reppassword = request.getParameter("reppassword"),
			firstname = request.getParameter("firstname"),
			lastname = request.getParameter("lastname"),
			phonenumber = request.getParameter("phonenumber");
		double latitude = person.getLatitude(), 
			longitude = person.getLongitude();
		if (password.length() != 0 || reppassword.length() != 0) {
			if (!password.equals(reppassword)) {
		%>alert("Update failed: passwords do not match!");<%
			} else {
				dao.updatePerson(id, person.getUsername(), password,
					firstname, lastname, phonenumber, person.getGroup(),
					latitude, longitude);
			}
		} else {
				dao.updatePerson(id, person.getUsername(), person.getPassword(),
					firstname, lastname, phonenumber, person.getGroup(),
					latitude, longitude);
		}				
	} else if (request.getParameter("groupcheck") != null) {
		%>alert("Such group already exists OR group name is empty!");<%
	}
	%>
 		function initialize() {
	    	var myOptions = {
	      		zoom: 6,
	      		mapTypeId: google.maps.MapTypeId.ROADMAP,
	      		center: new google.maps.LatLng(<%=person.getLatitude()
	      			/ Math.pow(10, 6)%>, <%=person.getLongitude()
	      			/ Math.pow(10, 6)%>)
	    	};
	    	var map = new google.maps.Map(document.getElementById("map_canvas"),
	        	myOptions), position = null;
			var browserSupportFlag = new Boolean();
            var image = "mappingred.png";
   			var geocoder = new google.maps.Geocoder(), place = "";
			// Try W3C Geolocation
  			if(navigator.geolocation) {
    			browserSupportFlag = true;
    			navigator.geolocation.getCurrentPosition(function(position) {	
    				document.getElementById('latitude').value =
    					position.coords.latitude;
    				document.getElementById('longitude').value =
    					position.coords.longitude; 
			<%	
				// creating markers array with the users from the group
				List<SerializablePerson> friends = dao.setCoordsToPerson(
					String.valueOf(person.getId()), person.getLatitude(),
					person.getLongitude());
				for (int i = 0; i < friends.size(); i++) {
					SerializablePerson friend = friends.get(i);
					if (friend.getUsername().equals(person.getUsername())) {
						%>image = "mappingreen.png";<%
					} else {
						%>image = "mappinred.png";<%
					}
			%>
					position = new google.maps.LatLng(<%=friend.getLatitude()
						/ Math.pow(10, 6)%>,
			            <%=friend.getLongitude() / Math.pow(10, 6)%>);
					var marker<%=i%> = new google.maps.Marker({
						position: position,
					    map: map, 
					   	title:'<%=friend.getUsername()%>',
					    icon: image
					});
					infowindow<%=i%> = new google.maps.InfoWindow({
		            	map: map,
		            	content: '<%=friend.getUsername()%>'
		           	});
   					geocoder.geocode({'latLng': position}, function(results, status) {
						if (status == google.maps.GeocoderStatus.OK) {
					    	infowindow<%=i%>.setContent("<%=friend.getFirstname() + " '"
					      		+ friend.getUsername() + "' "
					      		+ friend.getLastname()%><br />" 
					      		+ results[0].formatted_address);
					    } else {
					   		alert("Geocode was not successful for the"
					   		+ " following reason: " + status);
					    }
					});
					google.maps.event.addListener(marker<%=i%>, 'click', function () {
						infowindow<%=i%>.open(map, this); });
			      	<%
				}
			%>
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
  			}
  		}
	</script>
</head>
<body onload="initialize()">
	<div class="topLine">
		<div style="float: left;" class="headline">
			<%=person.getUsername()%>
			[<%=userGroup%>] @ 
			<%=person.getLatitude() / Math.pow(10, 6)%>, 
			<%=person.getLongitude() / Math.pow(10, 6)%>
		</div>
		<div style="float: right;">
			<a href="/?logout">Logout</a>
		</div>
	</div>
	<hr />
	<form action="" method="post" accept-charset="utf-8" 
		style="font-size:small">
		<b>Your new location: </b>
		<input type="hidden" name="id" value="<%=person.getId()%>" />
		<input type="hidden" name="updatecoords" value="updatecoords" /> 
		<input type="text" name="latitude"  id="latitude"
			value="<%=person.getLatitude()%>" readonly="readonly" />
		<input type="text" name="longitude" id="longitude"
			value="<%=person.getLongitude()%>" readonly="readonly" />
		<input type="submit" name="submit"
			value="Update coordinates" />
		</form>
	<hr />
	<form action="" method="post" accept-charset="utf-8">
		<table class="wborder">
			<tr>
				<th colspan="2">Edit your profile</th>
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
					size="50" value="<%=person.getFirstname()%>" /></td>
			</tr>
			<tr>
				<td><label for="lastname">Lastname</label></td>
				<td><input type="text" name="lastname" id="lastname"
					size="50" value="<%=person.getLastname()%>" /></td>
			</tr>
			<tr>
				<td><label for="phonenumber">Phone number</label></td>
				<td><input type="text" name="phonenumber" id="phonenumber"
					size="50" value="<%=person.getPhonenumber()%>" /></td>
			</tr>
			<tr>	
				<td colspan="2">
					<input type="hidden" name="updateperson"
						value="updateperson" /> 
					<input type="hidden" name="id"
						value="<%=person.getId()%>" /> 
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
				<td><label for="groupname">Name</label></td>
				<td><input type="text" name="groupname"
					size="50" /></td>
			</tr>
			<tr>
				<td><label for="description">Description</label></td>
				<td><input type="text" name="description"
					size="50" /></td>
			</tr>
			<tr>
				<td>
				<input type="hidden" name="web"
						value="user" />
					<input type="hidden" name="creator"
						value="<%=person.getUsername()%>" />
					<input type="hidden" name="id"
						value="<%=person.getId()%>" />
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
	<%
		if (g != null) {
			String readOnly = "readonly='readonly'",
			disabled = "disabled='disabled'";
			if (g.getCreator().equals(person.getUsername())) {
				readOnly = "";
				disabled = "";
			}
	%>
	<form action="" method="post" accept-charset="utf-8">
		<table class="wborder">
			<tr>
				<th colspan="2">Current group</th>
			</tr>
			<tr>
				<td><label for="groupname">Name</label></td>
				<td>
					<input type="text" name="groupname"
						value="<%=g.getName()%>" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td>Members:</td>
				<td>
	<%
		for (int i = 0; i < friends.size(); i++) {
			SerializablePerson friend = friends.get(i);
			%><%=friend.getUsername() + ", "%><%
		}
	%>
				</td>
			</tr>
			<tr>
				<td><label for="creator">Creator</label></td>
				<td>
					<input type="text" name="creator"
						value="<%=g.getCreator()%>" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td><label for="description">Description</label></td>
				<td>
					<input type="text" name="description"
						value="<%=g.getDescription()%>" <%=readOnly%> />
				</td>
			</tr>
			<tr>
				<td>
					<input type="hidden" name="updategroup"
						value="updategroup" />
					<input type="hidden" name="id"
						value="<%=g.getId()%>" />
					<input type="submit" name="submit"
						value="Update group" <%=disabled%> />
				</td>
				<td>
					<input type="checkbox" name="deletegroup"
						value="deletegroup" <%=disabled%> /> Delete group
				</td>
			</tr>
			</table>
	</form>
	<%
		} else {
	%>
		<table class="wborder">
			<tr>
				<th>Current group</th>
			</tr>
			<tr>
				<td>None</td>
			</tr>
		</table>
	<%
		}
	%>
	<hr />
	<form action="/join_group" method="post">
		<table class="wborder">
			<tr>
				<th colspan="2">Join a group</th>
			</tr>
			<tr>
				<td>
					<select name="groupname">
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
						value="<%=person.getId()%>" /> 
					<input type="submit" name="submit"
						value="Join" />
				</td>
			</tr>
		</table>
	</form>
	<div id="map_canvas"></div>
</body>
</html>