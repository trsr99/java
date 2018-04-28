package employee;

import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateMapEmp extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void serviceRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// DB Connection
			Connection conn = DbConnection.getConnection();
			
			HttpSession session = request.getSession(true); 

			// Delete record with employee table
			String sqlstr = "Update mapemployee set EMPID=?, DEPTID=? where rowid = ?";
			PreparedStatement ps = conn.prepareStatement(sqlstr);

			int nrows = Integer.parseInt(request.getParameter("nrows"));
			// System.out.println(nrows);
			int j;
			int k = 0;
			for (int i = 0; i < nrows; i++) {
				j = i + 1;
				String rd = request.getParameter("erid" + j);
				// System.out.println(rd);
				String empid = request.getParameter("empid" + j);
				int empid1 = Integer.parseInt(empid);
				String deptid = request.getParameter("deptid" + j);
				int deptid1 = Integer.parseInt(deptid);
				ps.setInt(1, empid1);
				ps.setInt(2, deptid1);
				ps.setString(3, rd);
				if (request.getParameter("apply" + j).equals("1")) {
					int upd = ps.executeUpdate();k++;
				}
			}

			if (k>0) { session.setAttribute("status","Successfully Updated...!");}
			else {session.setAttribute("status","No rows Updated...!");}
			conn.close();
			ps.close();
		} catch (Exception e2) {
			System.out.println("Error at Line # " + e2.getStackTrace()[0].getLineNumber());
			e2.printStackTrace();
		}

		String destination = "/employee/mapemployee.jsp";
		// System.out.println("Hello");
		response.sendRedirect(destination);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// System.out.println("get");
		serviceRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// System.out.println("post");
		serviceRequest(request, response);
	}

}
