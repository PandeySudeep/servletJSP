package aafnai.hamrai.archives;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class Uploader
 */

@WebServlet("/Uploader")
public class Uploader extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Uploader() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		ServletContext ctx = getServletConfig().getServletContext();
		String imagedir = ctx.getInitParameter("dating_image_repository");
		
		HttpSession session = request.getSession();
		String dirname1 = (String)session.getAttribute("sessionattr");
		String dirname2 = (String)session.getAttribute("userpwd");
		
		
		PrintWriter out = response.getWriter();
		
		if(!ServletFileUpload.isMultipartContent(request)){
			out.println("Nothing to upload");
			return;
		}
		
		FileItemFactory itemfactory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(itemfactory);
		try{
			List<FileItem> items = upload.parseRequest(request);
			/*if(items.size()>1){
				out.println("Only one pic at a time please");
			}*/
			
			for (FileItem item:items){
				
				String name = item.getName();
				if(item.getSize()>102400){
					//out.print("Please replace this image. It's too large. Please include file no larger than 100KB");
					RequestDispatcher view = request.getRequestDispatcher("reuploaddatingpic.jsp");
	    			view.forward(request,response);
	    			//continue;
					
				}
				/*else if(!name.startsWith(dirname1+dirname2)){
					//out.print("Please replace this pic. It has wrong name. Please make sure the name of the image starts with your username + your password"
						//	+ ". For example if your login username is 'Sudeep' and your password is 'mypwd' then your image names should start"
							//+ "with Sudeepmypwd.....");
					RequestDispatcher view = request.getRequestDispatcher("reuploaddatingpic.jsp");
	    			view.forward(request,response);
					
				}*/
				else{
				String contentType = item.getContentType();
				if(!contentType.equals("image/jpeg")){
					//out.println("Please replace this pic. Only jpeg/jpg format image files supported");
					RequestDispatcher view = request.getRequestDispatcher("reuploaddatingpic.jsp");
	    			view.forward(request,response);
					
					//continue;
				}
				
				File uploadDir = new File(imagedir+dirname1+dirname2);
				File file = File.createTempFile(name,".jpg",uploadDir);
				//file.renameTo(new File("test.jpg"));
				item.write(file);
				
				/*
				File[] files = uploadDir.listFiles();
				
				request.setAttribute("totalfilesuploaded", files.length);
				
				if (files.length==1){
					files[0].renameTo(new File(dirname1+dirname2+"profilepic.jpg"));
				}*/
				
				
				//out.println("File saved successfully"+item.getSize()+"Total Files: "+items.size());
				RequestDispatcher view = request.getRequestDispatcher("uploadsuccess.jsp");
    			view.forward(request,response);
				
				}
			}
			}catch(FileUploadException e){
				out.print("upload failed");
			}catch(Exception e){
				out.print("can't save"+e.getMessage());
			}
		
		}
}
	
	