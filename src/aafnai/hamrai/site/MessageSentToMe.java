package aafnai.hamrai.site;

import java.io.IOException;
//import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import java.util.Properties;  
import javax.mail.*;  
import javax.mail.internet.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class MessageSentToMe extends HttpServlet {

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
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException{
		
		response.setContentType("text/html");
		//PrintWriter out = response.getWriter();
		
		
		
		//String Fr = "hamro_saathi@hamroaafno.com";
		//String To = "pandey.datatech@gmail.com";
		//String SMTPhost = "localhost";
		String msg = (String)request.getParameter("message");

		
		if(msg.length()<1){
					
						request.setAttribute("message", "&#2325;&#2371;&#2346;&#2351;&#2366;&#0032;&#2347;&#2352;&#2381;&#2350;&#0032;&#2346;&#2369;&#2352;&#2376;&#0032;&#2349;&#2352;&#2381;&#2344;&#2369;&#2361;&#2379;&#2360;&#2381;&#2404;");
						request.setAttribute("link", "write_to_hamro.jsp");
						RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						view.forward(request,response);
						//out.print("please enter all job related fields");
				}else{
					
					
					String insert_job = "INSERT INTO hamro_inbox(POSTED_DATE,SENDER,S_PWD,MSG,STATUS) VALUES (CURDATE(),?,?,?,?);";
					PreparedStatement preparedStmt=null;
					
				      try {
				    	  con = dataSource.getConnection();
				    	  preparedStmt = con.prepareStatement(insert_job);
						  preparedStmt.setString (1, null);
					      preparedStmt.setString   (2, null);
					      preparedStmt.setString(3, msg);
					      preparedStmt.setString(4, "UNREAD");
					      //preparedStmt.setString    (5, contact_email);
					      //preparedStmt.setString(6,contact_phone);
					      //preparedStmt.setString(7,other_info);
					      preparedStmt.execute();
					      try{if(null!=con)con.close();}catch (SQLException e){}
						  try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException e){}
					      
						  request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;");
						  request.setAttribute("link", "welcome.jsp");
						  RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						  view.forward(request,response);
						  //out.print("job posted successfully");
					} catch (SQLException e) {
						
						request.setAttribute("message", "Message Sending Failed. Please contact exec_rep@pandtek.com");
						request.setAttribute("link", "welcome.jsp");
						RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						view.forward(request,response);
						//out.println("failed to post job.Please contact Hamro.com");
					}finally{
						try{if(null!=con)con.close();}catch (SQLException e){}
						try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException e){}
					}
					
				}
		//Properties props = new Properties();
		//props.put("mail.smtp.host", SMTPhost);
		//Session s = Session.getInstance(props,null);

		//String result=null;
		/*
		try {
			  	MimeMessage message = new MimeMessage(s);

				InternetAddress from = new InternetAddress(Fr);
				message.setFrom(from);
				InternetAddress to = new InternetAddress(To);
				message.addRecipient(Message.RecipientType.TO, to);
				message.setSubject("Test from JavaMail.");
				message.setText(msg);

				Transport.send(message);
				
				request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;");
				request.setAttribute("link", "welcome.jsp");
				RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
				view.forward(request,response);
				//result="Message Sent Successfully";
			  
		}catch (MessagingException e) {
				
				request.setAttribute("message", "Your message might be sent if queued or it might be discarded due to server rule/policy. We recommend you to re-send the email at exec_rep@pandtek.com directly for more confidence.");
				request.setAttribute("link", "welcome.jsp");
				RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
				view.forward(request,response);
				//result="Failed to sent message"+e.getMessage();
			}
			*/
		
		  
		 // out.print("<center><h1>Send Email using JSP</h1></center><p align=\"center\">\"Result: \"" + result + "\n");
	}
}
