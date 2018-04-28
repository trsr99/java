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

public class UpdateProfile extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void serviceRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// DB Connection
			Connection conn = DbConnection.getConnection();
			
			HttpSession session = request.getSession(true); 

			// Delete record with employee table
			String sqlstr = "Update users set name=?, pass=?, active=? where rowid = ?";
			PreparedStatement ps = conn.prepareStatement(sqlstr);

			int nrows = Integer.parseInt(request.getParameter("nrows"));
			// System.out.println(nrows);
			int j;
			int k = 0;
			for (int i = 0; i < nrows; i++) {
				j = i + 1;
				String rd = request.getParameter("erid" + j);
				// System.out.println(rd);
				String name = request.getParameter("name" + j);
				String pass = request.getParameter("pass" + j);
				String active = request.getParameter("active" + j);
				int active1 = Integer.parseInt(active);
				ps.setString(1, name);
				ps.setString(2, pass);
				ps.setInt(3, active1);
				ps.setString(4, rd);
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

		String destination = "/employee/profile.jsp";
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
