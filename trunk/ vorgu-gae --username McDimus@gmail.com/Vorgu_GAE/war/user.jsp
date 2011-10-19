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
 		function initialize() {
	    	var myOptions = {
	      		zoom: 8,
	      		mapTypeId: google.maps.MapTypeId.ROADMAP
	    	};
	    	var map = new google.maps.Map(document.getElementById("map_canvas"),
	        	myOptions);
	        var initialLocation, infowindow;
			var siberia = new google.maps.LatLng(60, 105);
			var newyork = new google.maps.LatLng(40.69847032728747, -73.9514422416687);
			var browserSupportFlag =  new Boolean();
			  
			// Try W3C Geolocation (Preferred)
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
  			// Try Google Gears Geolocation
  			} else if (google.gears) {
    			browserSupportFlag = true;
    			var geo = google.gears.factory.create('beta.geolocation');
    			geo.getCurrentPosition(function(position) {
      				initialLocation = new google.maps.LatLng(position.latitude,position.longitude);
      				map.setCenter(initialLocation);
      				infowindow = new google.maps.InfoWindow({
             			map: map,
              			position: initialLocation,
              			content: 'You are here'
            		});
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
      				alert("Geolocation service failed.");
      				initialLocation = newyork;
    			} else {
      				alert("Your browser doesn't support geolocation. We've placed you in Siberia.");
      				initialLocation = siberia;
    			}
    			
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
	<%
	
		// create instance of data access object (DAO)
		Dao dao = Dao.INSTANCE;

		// 		UserService userService = UserServiceFactory.getUserService();
		// 		User user = userService.getCurrentUser();

		// 		String url = userService.createLoginURL(request.getRequestURI());
		// 		String urlLinktext = "Login";
		List<Person> persons = new ArrayList<Person>();
		List<Group> groups = new ArrayList<Group>();

		// 		if (user != null) {
		// 			url = userService.createLogoutURL(request.getRequestURI());
		// 			urlLinktext = "Logout";
		persons = dao.getPersons();
		groups = dao.getGroups();
		// 		}
	%>
	<div style="width: 100%;">
		<div class="line"></div>
		<div class="topLine">
			<div style="float: left;">
				<img src="images/todo.png" width="25%" height="25%" />
			</div>
			<div style="float: left;" class="headline">$USER_NAME HERE</div>
			<div style="float: right;">
				<a href="">CHANGE USER INFO???</a>
			</div>
		</div>

	<p>$CURRENT_GROUP HERE</p>

		<div style="clear: both;"></div>
		There are a total number of
		<%=groups.size()%>
		groups.

		<table>
			<tr>
				<th>Name</th>
				<th>Description</th>
				<th>Creator</th>
				<th>Creation date</th>
			</tr>

			<%
				for (Group group : groups) {
			%>
			<tr>
				<td><%=group.getName()%></td>
				<td><%=group.getDescription()%></td>
				<td><%=group.getCreator()%></td>
				<td><%=group.getCreationDate()%></td>
				<%-- 			<td><a class="done" href="/join?id=<%=group.getId()%>">Join</a></td> --%>

			</tr>
			<%
				}
			%>

		</table>
		
		<div id="map_canvas"></div>
		<div style="position: absolute; left: 50px;
			top:200px;">JOIN A GROUP HERE</div>

</body>
</html>