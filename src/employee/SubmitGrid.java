package employee;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SubmitGrid extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String destination = null;

		// Retrieve UI parameters
		String action = request.getParameter("submit");
		//System.out.println("Action: " + action);

		if (action.equals("Delete")) { // System.out.println("Act");
			// String nrows = request.getParameter("nrows");
			// System.out.println(nrows);
			destination = "DeleteEmp";
			RequestDispatcher rd = request.getRequestDispatcher(destination);
			rd.forward(request, response);
		} else if (action.equals("Apply Changes")) {
			destination = "UpdateEmp";
			RequestDispatcher rd = request.getRequestDispatcher(destination);
			rd.forward(request, response);
		}

	}
}
