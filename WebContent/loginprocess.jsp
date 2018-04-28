<%@page import="employee.LoginDao"%>
<jsp:useBean id="obj" class="employee.LoginBean"/>

<jsp:setProperty property="*" name="obj"/>

<%
HttpSession session1 = request.getSession(true);
boolean status=LoginDao.validate(obj);
session1.setAttribute("strack",session1.getId());
if(status){
session1.setAttribute("strack",session1.getId());
String email = request.getParameter("email");
session1.setAttribute("userid",email);
//New location to be redirected
String site = new String("index.jsp");
response.setStatus(response.SC_MOVED_TEMPORARILY);
response.setHeader("Location", site); 
}
else
{
    session1.setAttribute("loginstatus","Invalid email or password credentials...!");
  //New location to be redirected
    String site = new String("login.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site);
}%>
