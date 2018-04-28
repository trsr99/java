<ul>
	<li><a href="index.jsp">Dashboard</a></li>
	<li><a href="employee.jsp">Employee</a></li>
	<li><a href="department.jsp">Department</a></li>
	<li><a href="mapemployee.jsp">Map Employee</a></li>
	<li><a href="miscellaneous.jsp">Miscellaneous</a></li>
	<%HttpSession session1 = request.getSession(true);
	String email = (String)session1.getAttribute("userid");
	if (email.equals("admin")) {
	out.print("<li><a href='profile.jsp'>User Profile</a></li>");
	} %>
</ul>