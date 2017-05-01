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

public class PostRoom extends HttpServlet {
	
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
		String room_desc = (String)request.getParameter("roomdesc");
		String room_location = (String)request.getParameter("roomlocation");
		String country = (String)request.getParameter("nationality");
		String contact_phone = (String)request.getParameter("phone");
		String contact_email = (String)request.getParameter("contactemail");
		String other_info = (String)request.getParameter("otherinfo");
		
		if((posted_by.length()<1)||(room_desc.length()<1)||(room_location.length()<1)||(contact_phone.length()<1)
				||(contact_email.length()<1)||(other_info.length()<1)==true){
					
					request.setAttribute("message", "Please fill the form completely.");
					request.setAttribute("link", "main.jsp");
					RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
					view.forward(request,response);
					//out.print("please enter all fields");
				}else{
					
					String insert_job = "INSERT INTO room_postings(POSTED_DATE,POSTED_BY,ROOM_DESC,LOCATION,COUNTRY,EMAIL,PHONE,OTHERINFO) VALUES (CURDATE(),?,?,?,?,?,?,?);";
					PreparedStatement preparedStmt=null;
					
				      try {
				    	  con = dataSource.getConnection();
				    	  preparedStmt = con.prepareStatement(insert_job);
						  preparedStmt.setString(1, posted_by);
					      preparedStmt.setString(2, room_desc);
					      preparedStmt.setString(3, room_location);
					      preparedStmt.setString(4, country);
					      preparedStmt.setString(5, contact_email);
					      preparedStmt.setString(6,contact_phone);
					      preparedStmt.setString(7,other_info);
					      preparedStmt.execute();
					      try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException se){se.getMessage();}
					      try{if(null!=con)con.close();}catch(SQLException se){out.print(se.getMessage());}	
					      
					      request.setAttribute("message", "Success!");
						  request.setAttribute("link", "main.jsp");
						  RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						  view.forward(request,response);
					      //out.print("room availability posted successfully");
					} catch (SQLException e) {
						try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException se){se.getMessage();}
						try {if(null!=con)con.close();}catch(SQLException se){out.print(se.getMessage());}	
						request.setAttribute("message", "Accomodation Posting Failed. Please contact exec_rep@pandtek.com");
						request.setAttribute("link", "main.jsp");
						RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						view.forward(request,response);
						//out.println("failed to post room availability.Please contact Hamro.com");
					}finally{
						try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException e){e.getMessage();}
						try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}	
					}
				 }		
			}
		}

