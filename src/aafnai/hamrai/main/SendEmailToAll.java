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
import javax.sql.DataSource;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;  
import javax.mail.*;  
import javax.mail.internet.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class SendEmailToAll extends HttpServlet {
	
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
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String from = "hamro_saathi@hamroaafno.com";
		
		String country = (String)request.getParameter("country");
		String msg = (String)request.getParameter("msg");
		
		List<String> receivers = new ArrayList<String>();
		
		
		if(country.length()<1||msg.length()<1){
			
			request.setAttribute("message", "&#2325;&#2371;&#2346;&#2351;&#2366;&#0032;&#2347;&#2352;&#2381;&#2350;&#0032;&#2346;&#2369;&#2352;&#2376;&#0032;&#2349;&#2352;&#2381;&#2344;&#2369;&#2361;&#2379;&#2360;&#2381;&#2404;");
			request.setAttribute("link", "main.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			//out.println("please enter valid message and select a country");
		}else{
			
			String query = "SELECT EMAIL FROM registered_users WHERE NATIONALITY=\"" + country+ "\";";
			ResultSet res = null;
			try {
				con = dataSource.getConnection();
				stmt=con.createStatement();
				res = stmt.executeQuery(query);
				while(res.next()){
						receivers.add(res.getString("EMAIL"));
					}
			}catch (SQLException e) {
				
				out.println("Could not fetch receivers"+e.getMessage());
			}finally{
				try{if(null!=res)res.close();}catch (SQLException se){out.print(se.getMessage());}
				try{if(null!=stmt)stmt.close();}catch(SQLException se){se.getMessage();}
				try{if(null!=con)con.close();}catch(SQLException se){out.print(se.getMessage());}
				}
			}
			
			if(receivers.size()>=1){
				List<InternetAddress> mylist = new ArrayList<InternetAddress>();
				for (int i=0;i<receivers.size();i++){
					InternetAddress ia=null;
					try {
						ia = new InternetAddress(receivers.get(i));
					} catch (AddressException e) {
					
					}
					mylist.add(ia); 
				}
				InternetAddress[] recipients_Arr = new InternetAddress[mylist.size()];
				mylist.toArray(recipients_Arr);
				
				String SMTPhost = "localhost";	
			
				Properties props = new Properties();  
			
				props.put("mail.smtp.host", SMTPhost);
			  
				Session s = Session.getInstance(props,null);
				
				try
					{
					  MimeMessage message = new MimeMessage(s);  
					  message.setFrom(new InternetAddress(from));
					  message.addRecipients(Message.RecipientType.TO,recipients_Arr);
					  message.setSubject("Hello");  
					  message.setText(msg); 
					  Transport.send(message);
					  
					  request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;");
					  request.setAttribute("link", "main.jsp");
					  RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
					  view.forward(request,response);
					  //out.println("Messages sent to all selected recipients");
					  }catch(MessagingException e) {
						  
					  }			
			}else{
					request.setAttribute("message", "&#2312;&#2350;&#2375;&#2354;&#0032;&#2346;&#2366;&#2313;&#2344;&#2375;&#2361;&#2352;&#2369;&#2325;&#2379;&#0032;&#2360;&#2306;&#2326;&#2381;&#2351;&#2366;&#0032;&#2404;" + " " + 0);
					request.setAttribute("link", "main.jsp");
					RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
					view.forward(request,response);  
					//out.println("no receivers available");
				}
			}
		}


