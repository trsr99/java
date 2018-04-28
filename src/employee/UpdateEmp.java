package employee;

import java.io.*;
//import java.util.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateEmp extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void serviceRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// DB Connection
			Connection conn = DbConnection.getConnection();
			
			HttpSession session = request.getSession(true); 

			// Delete record with employee table
			String sqlstr = "Update Employee set EMPNAME=?, EMPPHONE=?, ADDRESS=?, DOJ=? where rowid = ?";
			PreparedStatement ps = conn.prepareStatement(sqlstr);

			java.util.Date sdf = null;
			java.sql.Date edoj = null;
			String dt = null;
			int nrows = Integer.parseInt(request.getParameter("nrows"));
			// System.out.println(nrows);
			int j;
			int k = 0;
			for (int i = 0; i < nrows; i++) {
				j = i + 1;
				String rd = request.getParameter("erid" + j);
				// System.out.println(rd);
				String ename = request.getParameter("ename" + j);
				String eph = request.getParameter("eph" + j);
				String eaddr = request.getParameter("eaddr" + j);
				if (request.getParameter("edoj" + j) != "") {
					sdf = new SimpleDateFormat("MM/dd/yyyy").parse(request.getParameter("edoj" + j));
					edoj = new java.sql.Date(sdf.getTime());
					ps.setDate(4, edoj);
				} else {
					dt = request.getParameter("edoj" + j);
					ps.setString(4, dt);
				}
				ps.setString(1, ename);
				ps.setString(2, eph);
				ps.setString(3, eaddr);
				ps.setString(5, rd);
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

		String destination = "/employee/employee.jsp";
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
