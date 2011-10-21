<jsp:useBean id="person2" class="ttu.vorgu2.hw1.model.Person2">
	<jsp:setProperty name="person2" property="*"/>
</jsp:useBean>
<p>
	<jsp:getProperty name="person2" property="password" />
	<jsp:getProperty name="person2" property="name" />
</p>