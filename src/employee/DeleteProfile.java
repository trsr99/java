package employee;

import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteProfile extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void serviceRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        
		try {
			// DB Connection
			Connection conn = DbConnection.getConnection();
			
			HttpSession session = request.getSession(true); 

			// Delete record with employee table
			String sqlstr = "Delete from users where rowid = ?";
			PreparedStatement ps = conn.prepareStatement(sqlstr);

			int nrows = Integer.parseInt(request.getParameter("nrows"));
			// System.out.println(nrows);
			int j;
			for (int i = 0; i < nrows; i++) {
				j = i + 1;
				// String check = request.getParameter("check" + j);
				// System.out.println(check);
				if (request.getParameter("check" + j) != null && request.getParameter("check" + j).equals("1")) {
					String rd = request.getParameter("erid" + j);
					// System.out.println(rd);
					ps.setString(1, rd);
					int upd = ps.executeUpdate();
				}
			}

			session.setAttribute("status","Successfully Deleted...!");
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
