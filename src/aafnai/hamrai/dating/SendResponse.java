package aafnai.hamrai.dating;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;


@WebServlet("/SendResponse")
public class SendResponse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SendResponse() {
        super();
        }
    
    Connection con = null;
   	Statement stmt = null;
   	DataSource dataSource = null;

       public void init(){
    	   try 
    	   	{
    		   Context initContext  = new InitialContext();
    		   Context envContext  = (Context)initContext.lookup("java:/comp/env");
    		   dataSource = (DataSource)envContext.lookup("jdbc/hamroaa1_hamro_db");
    	   		}catch (NamingException e){
    	   			e.printStackTrace();
    	   			}
    	   }

       protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
       }

	
       protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	PrintWriter out = response.getWriter();
		
		int requestor_id=0;
		
		String requestorid = (String)request.getParameter("requestorprofileid");
		String decision = (String)request.getParameter("decision");
		
		HttpSession session = request.getSession();
		
		String receivername = (String)session.getAttribute("sessionattr");
		String receiverpwd = (String)session.getAttribute("userpwd");
		
		if(receivername==null){
			request.setAttribute("message", "Session expired.Please click the 'Back' button to the left of this page to log in again.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}else{
		
		if(requestorid.length()<1){
			
			request.setAttribute("message", "Please fill out the form.");
			request.setAttribute("link", "main.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			//out.println("please enter profile id of requestor");
		}else if(requestorid.length()>=1){
			try{
				requestor_id = Integer.parseInt(requestorid);
				
				
				String query1 = "SELECT SENDER_ID FROM relationship WHERE RECEIVER_NAME=\""+receivername+"\" and RECEIVER_PWD=\""+receiverpwd+"\";";
				ArrayList<Integer> requestorlist = new ArrayList<Integer>();
				
				ResultSet rs1 = null;
				try
					{
						con = dataSource.getConnection();
						stmt = con.createStatement();
						rs1 = stmt.executeQuery(query1);
						while(rs1.next())
							{
								int sender_id=rs1.getInt("SENDER_ID");
								requestorlist.add(sender_id);
						}
					}catch(SQLException se){
						out.print(se.getMessage());
				}
				
				
				boolean is_real_requestor = false;
				
				for (int requestor:requestorlist){
					if (requestor==requestor_id){
						is_real_requestor=true;
						break;
					}
				}
				
				if (is_real_requestor==false){
					try{if(null!=rs1)rs1.close();}catch(SQLException e){out.print(e.getMessage());}
					try{ if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
					try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
					
					request.setAttribute("message", "You have not received any request from this member.");
					request.setAttribute("link", "main.jsp");
					RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
					view.forward(request,response);
					//out.print("This profile didn't send you any request.");
				}else{
					String update = "UPDATE relationship SET STATUS=\""+decision+"\" WHERE SENDER_ID= ? AND RECEIVER_NAME=\""+receivername+"\" and RECEIVER_PWD=\""+receiverpwd+"\";";
					
					PreparedStatement preparedStmt=null;
					
				    try {
				    	  preparedStmt = con.prepareStatement(update);
						  
					      preparedStmt.setInt   (1,requestor_id);
					      preparedStmt.executeUpdate();
					      
					      request.setAttribute("message", "Your response has been sent."); 
						  request.setAttribute("link","main.jsp");
					      RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						  view.forward(request,response);
					      
					      }catch(SQLException e){
						   	out.println("couldn't update the decision"+e.getMessage());
					      }finally{
					    	  try{if(null!=rs1)rs1.close();}catch(SQLException e){out.print(e.getMessage());}
					    	  try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException e){out.print(e.getMessage());}
					      	}
				      				      
				   /*
				    String emailrecipient="SELECT EMAIL FROM dating_profile where ID ="+requestor_id+";";
				    String to_email=null;
				    ResultSet rs4=null;
				    try{
				    	 rs4 = stmt.executeQuery(emailrecipient);
							while(rs4.next()){
								to_email = rs4.getString("EMAIL");
								}
				      }catch(SQLException e){
				    	  
				      }finally{
				    	  try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
				    	  try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
				      	}
				      
				      
				      String from = "hamro_saathi@hamroaafno.com";
					  String msg = "Decision has been made on your request by"+receivername+".Please log in to view the decision.";
					  String to = to_email;
					  String SMTPhost = "localhost";
					  Properties props = new Properties();  
					  props.put("mail.smtp.host", SMTPhost);
					
					  Session s = Session.getInstance(props,null);
					  String result=null;
					  try
					  	{  
						  MimeMessage message = new MimeMessage(s);  
						  message.setFrom(new InternetAddress(from));//change accordingly  
						  message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));  
						  message.setSubject("message from Milan/Vivah - Hamro's matrimony site!!");  
						  message.setText(msg);  
						    
						  Transport.send(message);  
						  request.setAttribute("message", "&#2340;&#2346;&#2366;&#2312;&#2325;&#2379;&#0032;&#2344;&#2367;&#2352;&#2381;&#2339;&#2351;&#0032;&#2346;&#2336;&#2366;&#2312;&#2319;&#2325;&#2379;&#0032;&#2331;&#2404;"); 
						  request.setAttribute("link","main.jsp");
						  //result="Your decision has been emailed to the requestor";
					  		}catch(MessagingException e){
								request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;"); 
								request.setAttribute("link","main.jsp");
						    	//result="Failed to sent message"+e.getMessage();
							}catch(NullPointerException ne){
								request.setAttribute("message", "Invalid Profile"); 
								request.setAttribute("link","main.jsp");
								//result="The requestor ID doesn't exist. Invalid profile Id Selection";
							  }
					  RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
					  view.forward(request,response);
					  */
					  
					  	//out.print("<center><h1>Send Email using JSP</h1></center><p align=\"center\">\"Result: \"" + result + "\n");
						  }
						}catch(NumberFormatException ne){
								request.setAttribute("message", "Please enter only number.");
								request.setAttribute("link", "main.jsp");
								RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
								view.forward(request,response);
								//RequestDispatcher view = request.getRequestDispatcher("nonumberforprofileid.jsp");
								//view.forward(request,response);
					}	
				}
			}
		}}
