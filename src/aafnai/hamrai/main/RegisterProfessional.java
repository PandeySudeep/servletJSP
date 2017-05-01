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

	public class RegisterProfessional extends HttpServlet {
		
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
			
			
			String first_name = (String)request.getParameter("firstname");
			String last_name = (String)request.getParameter("lastname");
			String profession = (String)request.getParameter("profession");
			String contact_phone = (String)request.getParameter("phone");
			String contact_email = (String)request.getParameter("email");
			String address = (String)request.getParameter("address");
			String country = (String)request.getParameter("nationality");
			String other_info = (String)request.getParameter("otherinfo");
			
			if((first_name.length()<1)||(last_name.length()<1)||(profession.length()<1)||(contact_phone.length()<1)
					||(contact_email.length()<1)||(address.length()<1)||(other_info.length()<1)==true){
				
						request.setAttribute("message", "Please fill out form completely.");
						request.setAttribute("link", "main.jsp");
						RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						view.forward(request,response);
						//out.print("please enter all info");
					}else{
						
						String insert_professional = "INSERT INTO professionals(CREATED_DATE,FIRST_NAME,LAST_NAME,PROFESSION,ADDRESS,COUNTRY,EMAIL,PHONE,OTHERINFO)"+ "VALUES (CURDATE(),?,?,?,?,?,?,?,?);";
						PreparedStatement preparedStmt=null;
						
					      try {
					    	  con = dataSource.getConnection();
					    	  preparedStmt = con.prepareStatement(insert_professional);
							  preparedStmt.setString (1, first_name);
						      preparedStmt.setString   (2, last_name);
						      preparedStmt.setString(3, profession);
						      preparedStmt.setString(4, address);
						      preparedStmt.setString(5, country);
						      preparedStmt.setString(6,contact_email);
						      preparedStmt.setString(7,contact_phone);
						      preparedStmt.setString(8, other_info);
						      preparedStmt.execute();
						      
						      request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;");
							  request.setAttribute("link", "main.jsp");
							  RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
							  view.forward(request,response);
						      //out.print("professionals inserted successfully");
						} catch (SQLException e) {
							out.println("failed to insert professional.Please contact Hamro.com"+e.getMessage());
						}finally{
							try{if(null!=preparedStmt)preparedStmt.close();} catch (SQLException se) {out.print(se.getMessage());}
							try{if(null!=con)con.close();} catch (SQLException se) {out.print(se.getMessage());}
							}
					    }					
				}
		}

