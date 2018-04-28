package employee;

import java.io.*;
import java.sql.*;

//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddProfile extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void serviceRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Retrieve UI parameters
		String name = request.getParameter("name");
		String email = request.getParameter("email0");
		String pass = request.getParameter("pass");
		String active = request.getParameter("active");
		
		// Conversion of String to corresponding DataType
		int act = Integer.parseInt(active);

		try {
			// DB Connection
			Connection conn = DbConnection.getConnection();
			
			HttpSession session = request.getSession(true); 

			// Insert record with employee table
			String sqlstr = "INSERT into users (name,email,pass,active) values (?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sqlstr);
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, pass);
			ps.setInt(4, act);
			ps.executeUpdate();
			
			session.setAttribute("status","Successfully Added...!");

			String destination = "/employee/profile.jsp";
			// RequestDispatcher rd = request.getRequestDispatcher(destination);
			// rd.include(request, response);
			response.sendRedirect(destination);

			conn.close();
			ps.close();
		} catch (Exception e2) {
			System.out.println("Error at Line # " + e2.getStackTrace()[0].getLineNumber());
			e2.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//System.out.println("get");
		serviceRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// System.out.println("post");
		serviceRequest(request, response);
	}

}
