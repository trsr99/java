package employee;

import java.io.*;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;

public class UploadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
    private boolean isMultipart;
	private String filePath;
	private int maxFileSize = 50 * 1024;
	private int maxMemSize = 4 * 1024;
	private File file ;

	public void serviceRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
			HttpSession session = request.getSession(true); 

			//-------Start of Upload Process
			   ServletContext context = getServletContext();    
			   filePath = context.getInitParameter("file-upload");
		      // Check that we have a file upload request
		      isMultipart = ServletFileUpload.isMultipartContent(request);
		      response.setContentType("text/html");
		   
		      if( !isMultipart ) {
		    	 session.setAttribute("status","No file uploaded...!");
		         return;
		      }
		  
		      DiskFileItemFactory factory = new DiskFileItemFactory();
		   
		      // maximum size that will be stored in memory
		      factory.setSizeThreshold(maxMemSize);
		   
		      // Location to save data that is larger than maxMemSize.
		      factory.setRepository(new File("c:\\t"));

		      // Create a new file upload handler
		      ServletFileUpload upload = new ServletFileUpload(factory);
		   
		      // maximum file size to be uploaded.
		      upload.setSizeMax( maxFileSize );

		      try { 
		        // Parse the request to get file items.
		        @SuppressWarnings("rawtypes")
				List fileItems = upload.parseRequest(request);
			
		        // Process the uploaded file items
		        @SuppressWarnings("rawtypes")
				Iterator i = fileItems.iterator();
		   
		         while ( i.hasNext () ) {
		            FileItem fi = (FileItem)i.next();
		            if ( !fi.isFormField () ) {
		               // Get the uploaded file parameters
		               String fieldName = fi.getFieldName();
		               String fileName = fi.getName();
		               String contentType = fi.getContentType();
		               boolean isInMemory = fi.isInMemory();
		               long sizeInBytes = fi.getSize();
		            
		               // Write the file
		               if( fileName.lastIndexOf("\\") >= 0 ) {
		                  file = new File(filePath +              
				                    fileName.substring( fileName.lastIndexOf("\\")).replace(".","_"+session.getId()+".")) ;
		               } else {
		                  file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\")+1).replace(".","_"+session.getId()+".")) ;
		               } System.out.println(filePath +              
				                    fileName.substring( fileName.lastIndexOf("\\")).replace(".","_"+session.getId()+"."));
		               fi.write( file ) ;
		               session.setAttribute("status","Successfully Uploaded the File"); 
		            }
		         }
		         } catch(Exception ex) {
		            System.out.println(ex);
		         }
			//-------End of Upload Process
        
		String destination = "/employee/miscellaneous.jsp";
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
