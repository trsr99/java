<html>
   <body bgcolor = "#ffffff" background="images/login.jpg" 
   style="height: 100%;width:100%;background-position: center;background-repeat: no-repeat;background-size: cover;">
      <center><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><B>EMPLOYEE DB</B><BR><BR>
      <% HttpSession session1 = request.getSession(true);
      session1.removeAttribute("strack");
      session1.removeAttribute("userid");%>
      
      <form method = "POST" action ="loginprocess.jsp">
         <table border = "0">
            <tr>
               <td>Login</td>
               <td><input type = "text" name="email"></td>
            </tr>
            <tr>
               <td>Password</td>
               <td><input type = "password" name="pass"></td>
            </tr>
         </table>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type = "submit" value = "Login">
         
      </form>
      <% String status = (String)session1.getAttribute("loginstatus");
	    if (status != null) {
		out.println("<span style='color:blue;'>" + status + "</span>");
		session1.removeAttribute("loginstatus"); }%>
      </center>
   </body>
</html>