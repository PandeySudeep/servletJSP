package aafnai.hamrai.main;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;


public class PostJob extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	Connection con = null;
	DataSource dataSource = null;
	 
	public void init(){
		
	    try {
			// Get DataSource
			Context initContext  = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("jdbc/hamroaa1_hamro_db");

			
		} catch (NamingException e) {
			e.printStackTrace();
			
		}
	  }

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String posted_by = (String)request.getParameter("postedby");
		String job_desc = (String)request.getParameter("jobdesc");
		String job_location = (String)request.getParameter("joblocation");
		String country = (String)request.getParameter("nationality");
		String contact_phone = (String)request.getParameter("phone");
		String contact_email = (String)request.getParameter("contactemail");
		String other_info = (String)request.getParameter("otherinfo");
		
		if((posted_by.length()<1)||(job_desc.length()<1)||(job_location.length()<1)||(contact_phone.length()<1)
				||(contact_email.length()<1)||(other_info.length()<1)==true){
					
						request.setAttribute("message", "Please fill out form completely.");
						request.setAttribute("link", "post_job.jsp");
						RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						view.forward(request,response);
						//out.print("please enter all job related fields");
				}else{
					
					String insert_job = "INSERT INTO job_postings(POSTED_DATE,POSTED_BY,JOB_DESC,LOCATION,COUNTRY,EMAIL,PHONE,OTHERINFO)"+ "VALUES (CURDATE(),?,?,?,?,?,?,?);";
					PreparedStatement preparedStmt=null;
					
				      try {
				    	  con = dataSource.getConnection();
				    	  preparedStmt = con.prepareStatement(insert_job);
						  preparedStmt.setString (1, posted_by);
					      preparedStmt.setString   (2, job_desc);
					      preparedStmt.setString(3, job_location);
					      preparedStmt.setString(4, country);
					      preparedStmt.setString    (5, contact_email);
					      preparedStmt.setString(6,contact_phone);
					      preparedStmt.setString(7,other_info);
					      preparedStmt.execute();
					      try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
						  try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException e){out.print(e.getMessage());}
					      
						  request.setAttribute("message", "Your job has been successfully posted. Please click the back button to the left to go to home page and log "
						  		+ "in again. To view your job click on 'Search for Job' and enter today's date.");
						  request.setAttribute("link", "welcome.jsp");
						  RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						  view.forward(request,response);
						  //out.print("job posted successfully");
					} catch (SQLException e) {
						
						request.setAttribute("message", "Job Posting Failed. Please contact exec_rep@pandtek.com");
						request.setAttribute("link", "post_job.jsp");
						RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						view.forward(request,response);
						//out.println("failed to post job.Please contact Hamro.com");
					}finally{
						try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
						try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException e){out.print(e.getMessage());}
					}
				}  	
			}
		}
