<%@ page
	import="java.lang.*,java.io.*,java.util.*,java.sql.*,employee.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% ArrayList<Employee> aemp = new ArrayList<Employee>();%>
<html>
<head>
<title>Dashboard</title>
<link href="css/header.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/zingchart.min.js"></script>
	<script>  
        <%  
           //// --- Create two Java Arrays  
            ArrayList<String> months = new ArrayList<String>();  
            ArrayList<Integer> users = new ArrayList<Integer>(); 
            int ctl;
            String dept;
            
            Connection conn = DbConnection.getConnection();
            String opt = request.getParameter("graph");
            if (opt == null) {opt = "2";}
            String sqlstr = null;
            if (opt.equals("2")) 
            sqlstr = "with qry " +
            		"as (select count(empid) ctl,deptid from mapemployee group by deptid) " +
            		"select a.ctl,b.deptname from qry a,department b " +
            		"where a.deptid(+) = b.deptid " +
            		"order by deptname";
            else if (opt.equals("1"))
                sqlstr = "select count(empid) ctl,to_char(doj,'YYYY') deptname from employee group by to_char(doj,'YYYY')";
            
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sqlstr);

           // --- Loop and create 10 string dates and users  
            while(rs.next())  
            {  
            	if  (opt.equals("2")) {
            	ctl = rs.getInt("ctl");
            	dept = rs.getString("deptname");
                months.add(dept);  
                users.add(ctl); }
            	else if  (opt.equals("1")) {
                	ctl = rs.getInt("ctl");
                	dept = rs.getString("deptname");
                    months.add(dept);  
                    users.add(ctl); }
            }  
           
            conn.close();
        %>  
        
        <%!  
        // --- String Join Function converts from Java array to javascript string.  
        public String join(ArrayList<?> arr, String del)  
        {  

            StringBuilder output = new StringBuilder();  

            for (int i = 0; i < arr.size(); i++)  
            {  

                if (i > 0) output.append(del);  

                  // --- Quote strings, only, for JS syntax  
                  if (arr.get(i) instanceof String) output.append("\"");  
                  output.append(arr.get(i));  
                  if (arr.get(i) instanceof String) output.append("\"");  
            }  

            return output.toString();  
        }  
    %> 

       // --- add a comma after each value in the array and convert to javascript string representing an array  
        var monthData = [<%= join(months, ",") %>];  
        var userData = [<%= join(users, ",") %>];  

    </script>

	<script>  
window.onload = function() {  
  zingchart.render({
    id: "myChart",
    width: "100%",
    height: 400,
    data: {
      "type": <%if (opt.equals("2")) {%> "bar"<%} else if (opt.equals("1")) {%> "line"<%}%>,
      "title": {
        "text": <%if (opt.equals("2")) {%> "Department vs Employees"<%} else if (opt.equals("1")) {%> "Employees vs Date of Joining"<%}%>
      },
      "scale-x": {
        "labels": monthData
      },
      "plot": {
        "line-width": 1
      },
      "series": [{
        "values": userData
      }]
    }
  });
};

function post()
{
	document.getElementById('form1').submit();
}
</script>
<style type="text/css">
 .topcorner{
   position:absolute;
   top:0;
   right:0;
  }
</style>
</head>
<body>
	<B>EMPLOYEE DB</B><div class="topcorner"><a href="login.jsp">Logout</a>&nbsp;&nbsp;&nbsp;</div>
	<jsp:include page="header.jsp" />
	<BR>

	<%
	out.println("<B><U>Dashboard</U></B><BR><BR>");
	HttpSession session1 = request.getSession(true);
	String strack = (String)session1.getAttribute("strack");
    if (strack == null) {session1.setAttribute("loginstatus","Invalid Session...!");
	                     //New location to be redirected
                         String site = new String("login.jsp");
                         response.setStatus(response.SC_MOVED_TEMPORARILY);
                         response.setHeader("Location", site);}
    else {
    if (strack.equals(session1.getId())) {String ignore=null;}
    else { session1.setAttribute("loginstatus","Invalid Session...!");
    	//New location to be redirected
        String site = new String("login.jsp");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);}
    }
	%>

	<form id="form1" name="form1" method="post" action="index.jsp">
	<select name="graph" onchange="post();">
	<%if (opt.equals("1")) {%>
	<option value="1" selected>Employee</option>
	<option value="2" >Department Vs Employee</option>
	<%}
	else if (opt.equals("2")) {%>
	<option value="1" >Employee</option>
	<option value="2" selected>Department Vs Employee</option>
	</select>
	</form>
	<%}
	%>
	</select>
	</form>
	
	<%if (opt.equals("1")) {%>
		<h1>Employee Information</h1>
	<%}
	else if (opt.equals("2")) {%>
		<h1>Map Employee Information</h1>
	<%}%>

	<div id="myChart"></div>
</body>
</html>
