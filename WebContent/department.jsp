<%@ page
	import="java.lang.*,java.io.*,java.util.*,java.sql.*,employee.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Department Info</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="css/paging.css" rel="stylesheet" type="text/css" />
<link href="css/header.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="js/jquery.table.hpaging.min.js"></script>
<script>
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
	    String status = null;
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

	<sql:setDataSource var="xesrc" driver="oracle.jdbc.driver.OracleDriver"
		url="jdbc:oracle:thin:@(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = TRSR)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
    )"
	user="sample" password="sample" />
	
    <%
	// Retrieve UI parameters
	String action = request.getParameter("submit");
    if (action == null) {action = "NOACTION";}
    //System.out.println(action);
    if (action.equals("Add")) { 
	   %>
		<sql:update dataSource="${xesrc}" var="count"> 
	    insert into department (deptid,deptname,description) values(seq_dept.nextval,?,?)
	    <sql:param value="${param.deptname}" />
	    <sql:param value="${param.deptdesc}" /> 
	    </sql:update>
    <%
	session1.setAttribute("status","Successfully Added...!");
    } else if (action.equals("Delete")) { 
		int nrows = Integer.parseInt(request.getParameter("nrows"));
		// System.out.println(nrows);
		int j;
		for (int i1 = 0; i1 < nrows; i1++) {
			j = i1 + 1;
			// String check = request.getParameter("check" + j);
			// System.out.println(check);
			if (request.getParameter("check" + j) != null && request.getParameter("check" + j).equals("1")) {
				String rd = request.getParameter("erid" + j);
				pageContext.setAttribute("rowId", rd, PageContext.PAGE_SCOPE);
	%>
		<sql:update dataSource="${xesrc}" var="count"> 
	    delete from department a where a.rowid = ?
	    <sql:param value="${rowId}" /> 
	    </sql:update>
	<%
			}
		} 
	session1.setAttribute("status","Successfully Deleted...!");
	} else if (action.equals("Apply Changes")) { 
		int nrows = Integer.parseInt(request.getParameter("nrows"));
		// System.out.println(nrows);
		int j;
		int k = 0;
		for (int i1 = 0; i1 < nrows; i1++) {
			j = i1 + 1;
			String rd = request.getParameter("erid" + j);
			// System.out.println(rd);
			String ename = request.getParameter("ename" + j);
			String edesc = request.getParameter("edesc" + j);
			if (request.getParameter("apply" + j).equals("1")) {
				pageContext.setAttribute("rowId", rd, PageContext.PAGE_SCOPE);
				pageContext.setAttribute("deptname1", ename, PageContext.PAGE_SCOPE);
				pageContext.setAttribute("deptdesc1", edesc, PageContext.PAGE_SCOPE);
	%>
		<sql:update dataSource="${xesrc}" var="count"> 
	    update department a set deptname = ? , description = ? where a.rowid = ?
	    <sql:param value="${deptname1}" /> 
	    <sql:param value="${deptdesc1}" /> 
	    <sql:param value="${rowId}" /> 
	    </sql:update>
	<%
	k++;
	}
    } 
	if (k>0) { session1.setAttribute("status","Successfully Updated...!");}
	else {session1.setAttribute("status","No rows Updated...!");}
	}
	%>
	
	<%  status = (String)session1.getAttribute("status");
	    if (status != null) {
		out.println("<B><U>Department Information</U></B>" + 
				"<center><span style='color:blue;'>" + status + "</span></center><BR><BR>");
		      session1.removeAttribute("status"); }
	    else {
	    out.println("<B><U>Department Information</U></B>" + 
					"<BR><BR>");	
	    } %>

	<form action="department.jsp" method="post" name="form1"
		style="border: solid 1px #000000; width: 600px; background-color: #f48941;">
		<table>
			<tr>
				<td align="right" colspan="2"><input type="submit" name="submit" value="Add"/></td>
			</tr>
			<tr>
				<td align="right"><Span
					style="font-weight: bold; color: black; padding: 12px 20px;">Department
						Name : </Span></td>
				<td><input type="text" name="deptname" size="50" maxlength="100" /></td>
			</tr>
			<tr>
				<td align="right"><Span
					style="font-weight: bold; color: black; padding: 12px 20px;">Description
						: </Span></td>
				<td><textarea rows="4" cols="50" name="deptdesc" maxlenght="1000"></textarea></td>
			</tr>
		</table>
	</form>
	
	<sql:query dataSource="${xesrc}" var="dept"> 
    select ROWIDTOCHAR(a.rowid) rowid1,a.deptid,a.deptname,a.description from department a order by deptid
    </sql:query>

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
        
	<form action="department.jsp" method="post" name="form2">
		<table id="table2" class="table table-bordered table-striped" border="1" cellpadding="0" cellspacing="0"
			width=900px height=100px
			style="border-collapse: collapse; overflow: scroll;">
			<thead>
			<tr>
				<th colspan="4" align="right"
					style="padding: 3px 3px; background-color: #111;"><input
					type="submit" name="submit" Value="Delete" />&nbsp;&nbsp; <input
					type="submit" name="submit" Value="Apply Changes" /></th>
			</tr>
			<tr style="background-color: #f48941;">
				<th width=5%></th>
				<th width=10%>Dept ID</th>
				<th width=35%>Department Name</th>
				<th width=50%>Description</th>
			</tr>
			</thead>
            <tbody>
			<%
				int i = 0;
			%>
			<c:forEach var="e" items="${dept.rows}">
			<% i++; %>
			<tr>
				<td valign="top"><input type="checkbox" size=5
					name="check<%out.print(i);%>" value="1" /> <input type="hidden"
					id="apply<%out.print(i);%>" name="apply<%out.print(i);%>" value="0" /></td>
				<td valign="top"><input type="hidden"
					name="erid<%out.print(i);%>" value="${e.rowid1}" /><c:out value="${e.deptid}" /></td>
				<td valign="top"><input type="text"
					name="ename<%out.print(i);%>" value="${e.deptname}"
					size=30 maxlength=100 onchange="setapply(<%out.print(i);%>);" /></td>
				<td valign="top"><input type="text" size=70
						name="edesc<%out.print(i);%>" value="${e.description}" maxlength=1000 
						onchange="setapply(<%out.print(i);%>);"/></td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<input type="hidden" name="nrows" value="<% out.print(i);%>" />
	</form>
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
		for (j=1;j < 4;j++) {
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