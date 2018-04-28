package employee;

import java.io.*;
import java.sql.*;

//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddMapEmployee extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void serviceRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Retrieve UI parameters
		String empid = request.getParameter("empid");
		String deptid = request.getParameter("deptid");
		
		// Conversion of String to corresponding DataType
		int empid1 = Integer.parseInt(empid);
		int deptid1 = Integer.parseInt(deptid);

		try {
			// DB Connection
			Connection conn = DbConnection.getConnection();
			
			HttpSession session = request.getSession(true); 

			// Insert record with employee table
			String sqlstr = "INSERT into mapemployee (empid,deptid) values (?,?)";
			PreparedStatement ps = conn.prepareStatement(sqlstr);
			ps.setInt(1, empid1);
			ps.setInt(2, deptid1);
			ps.executeUpdate();
			
			session.setAttribute("status","Successfully Added...!");

			String destination = "/employee/mapemployee.jsp";
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