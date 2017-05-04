package aafnai.hamrai.main;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;  
import javax.mail.*;  
import javax.mail.internet.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class SendEmailToProfessionals extends HttpServlet {
	
	Connection con = null;
	Statement stmt = null;
	DataSource dataSource = null; 
	 
	private static final long serialVersionUID = 1L;
	
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

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException{
		
		int failure = 0;
		int success = 0;
				
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String profession = (String)request.getParameter("profession");
		String country = (String)request.getParameter("nationality");
		String msg = (String)request.getParameter("msg");
		
		List<String> receivers = new ArrayList<String>();
		
		HttpSession session = request.getSession();
		String usr = (String)session.getAttribute("sessionattr");
		String pwd = (String)session.getAttribute("userpwd");
		
		if(usr==null){
			
			request.setAttribute("message", "Your session has expired. Please click 'Back' button to the left and log in again.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}else{
		
				if(msg.length()<1){
			
									request.setAttribute("message", "Please fill out the form completely.");
									request.setAttribute("link", "main.jsp");
									RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
									view.forward(request,response);
			
			//out.println("please enter valid message and select a profession");
							}else{
			
									String query = "SELECT EMAIL FROM professionals WHERE COUNTRY=\""+country+"\" AND PROFESSION=\"" + profession+ "\";";
									ResultSet res = null;
									try {
											con = dataSource.getConnection();
											stmt=con.createStatement();
											res = stmt.executeQuery(query);
											while(res.next()){
													receivers.add(res.getString("EMAIL"));
												}
									} catch (SQLException e) {
											out.println("Could not fetch receivers"+e.getMessage());
									}finally{
											try{if(null!=res)res.close();} catch (SQLException se) {out.print(se.getMessage());}
											try { if(null!=stmt)stmt.close();} catch (SQLException se) {se.getMessage();}
											try { if(null!=con)con.close();} catch (SQLException se) {out.print(se.getMessage());}
										}	
						//}
			
									if(receivers.size()>=1){
											String SMTPhost = "localhost";
											String from = "mitra@upakaar.com";
											Properties props = new Properties(); 
			
											props.put("mail.smtp.host", SMTPhost);
			  		 
											Session s = Session.getInstance(props,null);
											String result=null;
				
											for(int i=0;i<receivers.size();i++)
													{
														try
															{
																MimeMessage message = new MimeMessage(s);  
																message.setFrom(new InternetAddress(from));
																message.addRecipient(Message.RecipientType.TO,new InternetAddress(receivers.get(i)));
																message.setSubject("Hello");  
																message.setText(msg); 
																Transport.send(message);
																success++;
															}catch (MessagingException e) {
																failure++;
															}
													} 

											request.setAttribute("message", "Message sent to" + " " + success+" professionals.");
											request.setAttribute("link", "main.jsp");
											RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
											view.forward(request,response);  
				
									}else{
											request.setAttribute("message", "Selected professional profile doesn't exist.");
											request.setAttribute("link", "main.jsp");
											RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
											view.forward(request,response);
											//out.println("no receivers available");
									}
			 
									//out.println("Messages sent to"+success+"email addresses");	
									//out.println("Messages failed to send to" + failure + "email addresses");//+msgerror);
				  
		}}}
	}


