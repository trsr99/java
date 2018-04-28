package employee;

import java.io.*;
import java.text.*;
import java.sql.*;

//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddEmployee extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void serviceRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Retrieve UI parameters
		String empname = request.getParameter("empname");
		String addr = request.getParameter("addr");
		String phone = request.getParameter("phone");
		String dojdt = request.getParameter("doj");

		// Conversion of String to corresponding DataType
		//int ph = Integer.parseInt(phone);

		int id = 1;
		try {
			// DB Connection
			Connection conn = DbConnection.getConnection();
			
			HttpSession session = request.getSession(true); 

			// Sequence for employee table
			String sqlstr = "select seq_emp.nextval id from dual";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sqlstr);
			while (rs.next()) {
				id = rs.getInt("id");
			}

			// Insert record with employee table
			sqlstr = "INSERT into Employee (empid,empname,empphone,address,doj) values (?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sqlstr);
			ps.setInt(1, id);
			ps.setString(2, empname);
			ps.setString(3, phone);
			ps.setString(4, addr);
			java.util.Date fdt = null;
			java.sql.Date doj = null;
			if (dojdt != ""){
			try {
				fdt = new SimpleDateFormat("MM/dd/yyyy").parse(dojdt);
				doj = new java.sql.Date(fdt.getTime());
			} catch (ParseException e) {
				e.printStackTrace();
			}
			ps.setDate(5, doj);
			}
			else
			{
				ps.setString(5, dojdt);
			}
			ps.executeUpdate();
			
			session.setAttribute("status","Successfully Added...!");

			String destination = "/employee/employee.jsp";
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