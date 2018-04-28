<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="html/text; charset=ISO-8859-1">
<title>Miscellaneous</title>
<link href="css/header.css" rel="stylesheet" type="text/css" />
<style type="text/css">
 .topcorner{
   position:absolute;
   top:0;
   right:0;
  }
</style>
<script>
function gdownload(gfile)
{
	  var objHidden = document.getElementById("gfile");
      objHidden.value = gfile;
      document.form2.submit();
}
</script>
</head>
<body>
<B>EMPLOYEE DB</B><div class="topcorner"><a href="login.jsp">Logout</a>&nbsp;&nbsp;&nbsp;</div>
<jsp:include page="header.jsp" />
<BR>

	<%
	    HttpSession session1 = request.getSession(true);
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
		out.println("<B><U>Miscellaneous</U></B>" + 
				"<center><span style='color:blue;'>" + status + "</span></center><BR><BR>");
		      session1.removeAttribute("status"); }
	    else {
	    out.println("<B><U>Miscellaneous</U></B>" + 
					"<BR><BR>");	
	    }
	 %>

<B><U>Upload Excel File</U></B><BR/><BR/>
<form action="UploadServlet" method="POST" enctype="multipart/form-data">
File : <input type="FILE"  name="file" size="50"/>&nbsp;&nbsp;&nbsp;
<input type="submit" value="Upload File"/>
</form>

<%List<String> results = new ArrayList<String>();

File[] files = new File("h:\\uploadfiles").listFiles();
//If this pathname does not denote a directory, then listFiles() returns null. 

for (File file : files) {
    if (file.isFile()) {
        results.add(file.getName());
    }
} %>

<BR>
<form action="Download" method="post" name="form2">
<table style="border-collapse: collapse; overflow: scroll;"
class="table table-bordered table-striped" border="1" cellpadding="0" cellspacing="2"
			width=500px height=100px>
<thead>
<tr>
<th	colspan=2 align="left" style="padding: 3px 3px; background-color: #f48941;">
<B>File List</B>
</th>
</tr>
</thead>
<tbody>
<%for(int i = 0; i < results.size(); i++) { %>
<tr><td><%out.print(results.get(i)); %></td>
<td width="30px"><input type="button"  value="Download" onclick="gdownload('<%out.print(results.get(i));%>')"/></td>
</tr>
<%} %>
</tbody>
</table>
<input type="hidden" name="gfile" id="gfile"/>
</form>
</body>
</html>