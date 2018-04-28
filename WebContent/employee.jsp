<%@ page
	import="java.lang.*,java.io.*,java.util.*,java.sql.*,employee.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Employee Info</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link href="css/paging.css" rel="stylesheet" type="text/css" />
<link href="css/header.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="js/jquery.table.hpaging.min.js"></script>
<script>
//DatePicker using JQuery
$( function() { 
$( '#datepicker' ).datepicker({ 
	changeMonth: true, 
	changeYear: true });
} ); 

//Validate Phone Number
  function validphone(ph,r)  
  {  
    var phoneno = /^[0-9]*\d$/;
    var str = "";
    var p = null;
    var phone = null;
    if (r == "0") 
    {
    if(ph.value.match(phoneno) || (!ph.value))  
      {  
        return true;  
      }  
    else  
      { 
       	if (ph.value != null && ph.value !== undefined)
       		{
               alert("Please enter valid phone number: " + ph.value);  
               return false;  
            }
        else {return true;}
       }  
     }
     else if (r == "1")
    	{
    	var j=0;
    	var k=0;
    	for (i=0;i<ph.value;i++)
    		{j++;
    		phone =document.form2["eph"+j].value;
    		
     	    if(phone.trim().match(phoneno) || (!phone))  
              {
     	    	p = null; 
              }  
            else  
              {  
            	if (phone != null && phone !== undefined)
            		{
            		str = str + "Line no " + j + ": " + phone + "\n";
            		k++;
                    }
              }
    		 }
    	     if (k > 0)
    	    	{
    	        alert("Please enter valid phone number in the grid:\n" + str); 
    	        return false; 
    	    	}
    	     return true;
    	}
  } 
  
  function setapply(i)
  {
	  var objHidden = document.getElementById("apply"+i);
	      objHidden.value = 1; 
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
	    HttpSession session1 = request.getSession(true);
	    String pg = request.getParameter("pglmt");
	    String status = (String)session1.getAttribute("status");
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
	    
	    if (status != null) {
		out.println("<B><U>Employee Information</U></B>" + 
				"<center><span style='color:blue;'>" + status + "</span></center><BR><BR>");
		      session1.removeAttribute("status"); }
	    else {
	    out.println("<B><U>Employee Information</U></B>" + 
					"<BR><BR>");	
	    }
	%>

	<form action="AddEmployee" method="post" name="form1"
		style="border: solid 1px #000000; width: 600px; background-color: #f48941;">
		<table>
			<tr>
				<td align="right" colspan="2"><input type="submit" value="Add"
					onclick="return validphone(document.form1.phone,'0')" /></td>
			</tr>
			<tr>
				<td align="right"><Span
					style="font-weight: bold; color: black; padding: 12px 20px;">Employee
						Name : </Span></td>
				<td><input type="text" name="empname" size="50" maxlength="100" /></td>
			</tr>
			<tr>
				<td align="right"><Span
					style="font-weight: bold; color: black; padding: 12px 20px;">Address
						: </Span></td>
				<td><textarea rows="4" cols="50" name="addr" maxlenght="1000"></textarea></td>
			</tr>
			<tr>
				<td align="right"><Span
					style="font-weight: bold; color: black; padding: 12px 20px;">Phone
						: </Span></td>
				<td><input type="text" name="phone" maxlength="12" /></td>
			</tr>
			<tr>
				<td align="right"><Span
					style="font-weight: bold; color: black; padding: 12px 20px;">Date
						of Joining : </Span></td>
				<td><input type="text" id="datepicker" readonly="readonly"
					name="doj" maxlength="10" /></td>
			</tr>
		</table>
	</form>

	<%
		Connection con = DbConnection.getConnection();
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(
				"select a.rowid,a.EMPID,a.EMPNAME,a.EMPPHONE,a.ADDRESS,to_char(a.DOJ,'mm/dd/yyyy') DOJ from employee a order by empid");
	%>
	<form name="pg" method="post">
	<table>
            <tr>
                <td>
                    <input name="pglmt" id="pglmt" placeholder="Page Limit" title="Page Limit" value="<%if (pg != null) {out.print(pg);} %>" class="form-control">
                </td>
                <td>
                    <button id="btnApply" class="btn btn-danger">Go</button>
                </td>
                <td>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Search: <input type="text" id="myInput" placeholder="Search String" onkeyup="doSearch()" size=50/>
                </td>
            </tr>
    </table>
    </form>
        
	<form action="SubmitGrid" method="post" name="form2">
		<table id="table2" class="table table-bordered table-striped" border="1" cellpadding="0" cellspacing="0"
			width=900px height=100px
			style="border-collapse: collapse; overflow: scroll;">
			<thead>
			<tr>
				<th colspan="6" align="right"
					style="padding: 3px 3px; background-color: #111;"><input
					type="submit" name="submit" Value="Delete" />&nbsp;&nbsp; <input
					type="submit" name="submit" Value="Apply Changes"
					onclick="return validphone(document.form2.nrows,1)" /></th>
			</tr>
			<tr style="background-color: #f48941;">
				<th width=5%></th>
				<th width=10%>Emp ID</th>
				<th width=30%>Name</th>
				<th width=15%>Phone</th>
				<th width=30%>Address</th>
				<th width=20%>Date of Joining</th>
			</tr>
			</thead>
            <tbody>
			<%
				int i = 0;
				while (rs.next()) {
					i++;
					out.print("<script> " + "$( function() { " + "$( '#datepicker" + i + "' ).datepicker({ "
							+ "changeMonth: true, " + "changeYear: true " + "});" + "} ); " + "</script>");
			%>
			<tr>
				<td valign="top"><input type="checkbox"
					name="check<%out.print(i);%>" value="1" /> <input type="hidden"
					id="apply<%out.print(i);%>" name="apply<%out.print(i);%>" value="0" /></td>
				<td valign="top"><input type="hidden"
					name="erid<%out.print(i);%>" value="<%=rs.getString("rowid")%>" /><%=rs.getString("empid")%></td>
				<td valign="top"><input type="text"
					name="ename<%out.print(i);%>" value="<%=rs.getString("empname")%>"
					size=30% maxlength=100 onchange="setapply(<%out.print(i);%>);" /></td>
				<td valign="top"><input type="text" name="eph<%out.print(i);%>"
					value="<%if (rs.getString("empphone") != null) {
					out.print(rs.getString("empphone"));
				}%>"
					size=15% maxlength=12 onchange="setapply(<%out.print(i);%>);"/></td>
				<td valign="top"><input type="text" value="<%=rs.getString("Address")%>"
						name="eaddr<%out.print(i);%>" maxlength=1000 onchange="setapply(<%out.print(i);%>);" /></td>
				<td valign="top"><input type="text"
					name="edoj<%out.print(i);%>"
					value="<%if (rs.getString("DOJ") != null) {
					out.print(rs.getString("DOJ"));
				}%>"
					size=20% maxlength=10 id="datepicker<%out.print(i);%>"
					readonly="readonly" /></td>
			</tr>
			<%
				}
			%>
			</tbody>
		</table>
		<input type="hidden" name="nrows" value="<%out.print(i);%>" />
	</form>
	<%
		rs.close();
		st.close();
		con.close();
	%>
<script>
//Pagination
 $(function () {
    if ($("#pglmt").val() == null || $("#pglmt").val() == "") {
    $("#table2").hpaging({"limit" : 10});}
    else {$("#table2").hpaging({"limit" : document.pg.pglmt.value});}
});

 function doSearch() {
	  // Declare variables 
	  var input, filter, table, tr, td, i,k;
	  input = document.getElementById("myInput");
	  filter = input.value.toUpperCase();
	  table = document.getElementById("table2");
	  tr = table.getElementsByTagName("tr");

	  // Loop through all table rows, and hide those who don't match the search query
	  for (i = 0; i < tr.length; i++) {
		k=0;
		for (j=1;j < 6;j++) {
	    td = tr[i].getElementsByTagName("td")[j];
	    if (td) {
	      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
	        k=1;
	      } else {
	        tr[i].style.display = "none";
	      }
	    } 
	      if (k==1) {tr[i].style.display = "";}
		}
	  }
	}

</script>
</body>
</html>