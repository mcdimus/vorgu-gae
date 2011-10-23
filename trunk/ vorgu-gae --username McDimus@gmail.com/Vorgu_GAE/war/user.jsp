<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List, ttu.vorgu2.hw1.model.Group,
	ttu.vorgu2.hw1.model.Person, ttu.vorgu2.hw1.dao.Dao, 
	javax.persistence.EntityManager, javax.persistence.Query,
	ttu.vorgu2.hw1.dao.EMFService"%>

<%
	EntityManager em;
	if (session.getAttribute("id") == null) {
		response.sendRedirect("/");
	}
	if (request.getParameter("updategroup") != null) {
		em = EMFService.get().createEntityManager();
		Group group = em.find(Group.class, Long.parseLong(request.getParameter(
			"id")));
		if (request.getParameter("deletegroup") != null) {
			em.remove(group);
		} else {
			group.setDescription(request.getParameter("description"));
			em.persist(group);
		}
		em.close();
	}
	Dao dao = Dao.INSTANCE;
	List<Group> groups = dao.getGroups();
	Person person = dao.checkPerson((String) session.getAttribute("id"));
	String userGroup;
	Group g = null;
	em = EMFService.get().createEntityManager();
	Query q = em.createQuery("select g from Group g where g.name = :groupName");
	q.setParameter("groupName", person.getGroup());
	List<Group> userGroups = q.getResultList();
	if (userGroups.size() == 1) {
		g = userGroups.get(0);
		userGroup = person.getGroup();
	} else {
		userGroup = "None";
	}
	em.close();
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
	} else if (request.getParameter("groupcheck") != null) {
		%>alert("Such group already exists!");<%
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
    				document.getElementById('latitude').value = position.coords.latitude;
    				document.getElementById('longitude').value = position.coords.longitude;
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
  			}
  		}
	</script>
</head>
<body onload="initialize()">
	<div style="width: 100%; height: 100%">
		<div class="line"></div>
		<div class="topLine">
			<div style="float: left;" class="headline">
				<%=person.getUsername()%>
				[<%=userGroup%>] @ 
				<%=person.getLatitude()%>, 
				<%=person.getLongitude()%>
			</div>
			<div style="float: right;">
				<a href="/?logout">Logout</a>
			</div>
		</div>
		<hr />
		<form action="/set_coords" method="post" accept-charset="utf-8" 
			style="font-size:small">
			<b>Your new location: </b>
			<input type="hidden" name="id" value="<%=person.getId()%>" />
			<input type="hidden" name="web" value="user" /> 
			<input type="text" name="latitude"  id="latitude"
				value="<%=person.getLatitude()%>" readonly="readonly" />
			<input type="text" name="longitude" id="longitude"
				value="<%=person.getLongitude()%>" readonly="readonly" />
			<input type="submit" name="submit"
				value="Update coordinates" />
			</form>
		<hr />
		<form action="/update" method="post" accept-charset="utf-8">
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
					<td><label for="gname">Name</label></td>
					<td><%=g.getName()%></td>
				</tr>
				<tr>
					<td><label for="creator">Creator</label></td>
					<td><%=g.getCreator()%></td>
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