package aafnai.hamrai.dating;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
//import java.util.Properties;

//import javax.mail.Message;
//import javax.mail.MessagingException;
//import javax.mail.Session;
//import javax.mail.Transport;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeMessage;
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


@WebServlet("/SendMessageToApprovers")
public class SendMessageToApprovers extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public SendMessageToApprovers() {
        super();
        }
    	
    	Connection con = null;
    	Statement stmt = null;
    	DataSource dataSource = null;
	 
	public void init(){
	
		try {
			// Get DataSource
			Context initContext  = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("jdbc/hamroaa1_hamro_db");
		}catch(NamingException e){
			}
		}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		
		String usr = (String)session.getAttribute("sessionattr");
		String pwd = (String)session.getAttribute("userpwd");
		
		String approver_id = (String)request.getParameter("acceptor_id");
		ArrayList<Integer> acceptors = new ArrayList<Integer>();
		
		if(usr==null){
			request.setAttribute("message", "Session has expired. Please log in again by clicking the 'Back' button to the left of this page.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}else{
		
		if(approver_id.length()<1){
			
			request.setAttribute("message", "Please fill out form.");
			request.setAttribute("link", "main.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			//out.print("please enter profile id you want to send message to");
		
		}else if(approver_id.length()>=1){
					
					try{
						
						int approverid = Integer.parseInt(approver_id);
						boolean valid_id=false;
						String email_to=null;
						String approvers = "SELECT RECEIVER_ID FROM relationship WHERE SENDER_NAME=\""+usr+"\" AND SENDER_PWD=\""+pwd+"\" AND STATUS=\"ACCEPTED\";";
						ResultSet rs=null;
						
						try
							{
								con = dataSource.getConnection();
								stmt = con.createStatement();
								rs = stmt.executeQuery(approvers);
								while(rs.next()){
									int _id = rs.getInt("RECEIVER_ID");
									acceptors.add(_id);
											}
						}catch(SQLException e){
								out.print(e.getMessage());
								}
						ResultSet rs2 = null;
						
						for(int i=0;i<acceptors.size();i++){
							if(acceptors.get(i)==approverid){
								valid_id = true;
								String email_fetch = "SELECT EMAIL FROM dating_profile WHERE ID="+acceptors.get(i)+";";
								try 
									{
										rs2 = stmt.executeQuery(email_fetch);
										while(rs2.next())
											{
												email_to = rs2.getString("EMAIL");
										}
								}catch(SQLException e){
										out.print(e.getMessage());
										}
								break;
								}
							}
		
					if(valid_id==false){
						try{if(null!=rs)rs.close();}catch(SQLException e){out.print(e.getMessage());}
						try{if(null!=rs2)rs2.close();}catch(SQLException e){out.print(e.getMessage());}
						try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
						try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
						
						request.setAttribute("message", "You cannot send message to this member. This member hasn't approved your request.");
						request.setAttribute("link", "milan_main_member.jsp");
						RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						view.forward(request,response);
						//out.print("invalid id to send message to");
					}else if(valid_id==true){
						
						
					////////////////////////////////////////
						
						//Date posted_date = null;
						String msg = (String)request.getParameter("msg");
						String sender_email = (String)session.getAttribute("usremail");
						String receiver_email = email_to;
						String sender = usr;
						String sender_pwd = pwd;
						int sender_id = 0;
						String receiver = null;
						String receiver_pwd = null;
						int receiver_id = Integer.parseInt(approver_id);
						String status = "UNREAD";
						
						
						String getsender = "SELECT SENDER_ID, RECEIVER_NAME, RECEIVER_PWD FROM relationship WHERE RECEIVER_ID="+approver_id+" AND SENDER_NAME=\""+usr+"\" AND SENDER_PWD=\""+pwd+"\" AND STATUS=\"ACCEPTED\";";
						ResultSet rs3=null;
						try
							{
								con = dataSource.getConnection();
								stmt = con.createStatement();
								rs3 = stmt.executeQuery(getsender);
								while(rs3.next()){
									
									sender_id = rs3.getInt("SENDER_ID");
									receiver = rs3.getString("RECEIVER_NAME");
									receiver_pwd = rs3.getString("RECEIVER_PWD");
									
									}
						}catch(SQLException e){
								out.print(e.getMessage());
								}finally{
									try{if(null!=rs)rs.close();}catch(SQLException e){out.print(e.getMessage());}
									try{if(null!=rs2)rs2.close();}catch(SQLException e){out.print(e.getMessage());}
									try{if(null!=rs3)rs3.close();}catch(SQLException e){out.print(e.getMessage());}
									try{if(null!=stmt)stmt.close();}catch(SQLException e){out.print(e.getMessage());}
								}
						
						
						String mil_inb_inp = "INSERT INTO milan_inbox(MSG_DATE,MESSAGE,RECEIVER,RECEIVER_ID,REC_EMAIL,REC_PWD,SENDER,SENDER_EMAIL,SENDER_ID,SENDER_PWD,STATUS) VALUES (CURDATE(),?,?,?,?,?,?,?,?,?,?);";
						PreparedStatement preparedStmt=null;
						
					      try {
					    	  con = dataSource.getConnection();
					    	  preparedStmt = con.prepareStatement(mil_inb_inp);
							  preparedStmt.setString(1,msg );
						      preparedStmt.setString(2,receiver);
						      preparedStmt.setInt(3,receiver_id);
						      preparedStmt.setString(4,receiver_email);
						      preparedStmt.setString(5,receiver_pwd);
						      preparedStmt.setString(6,sender);
						      preparedStmt.setString(7,sender_email);
						      preparedStmt.setInt(8,sender_id);
						      preparedStmt.setString(9,sender_pwd);
						      preparedStmt.setString(10,status);
						      preparedStmt.execute();
						      
						      try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
							  try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException e){out.print(e.getMessage());}
						      
							  request.setAttribute("message", "Your message has been sent.");
							  request.setAttribute("link", "milan_main_member.jsp");
							  
							  RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
							  view.forward(request,response);
							  //out.print("job posted successfully");
						} catch (SQLException e) {
							
							request.setAttribute("message", "Message Sending Failure. Please contact exec_rep@pandtek.com");
							request.setAttribute("link", "milan_main_member.jsp");
							RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
							view.forward(request,response);
							//out.println("failed to post job.Please contact Hamro.com");
						}
					      catch(NullPointerException ne){
					    	  out.print("null caught"+ne.getMessage());
					      }
					      finally{
							try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
							try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException e){out.print(e.getMessage());}
						}
											
						
					////////////////////////////////////////	
						
						/*
						try{if(null!=rs)rs.close();}catch(SQLException e){out.print(e.getMessage());}
						try{if(null!=rs2)rs2.close();}catch(SQLException e){out.print(e.getMessage());}
						try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
						try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
						
						String from = "hamro_saathi@hamroaafno.com";
						String msg = (String)request.getParameter("msg");
						String to = email_to;
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
					     
								//send message  
								Transport.send(message);  
								request.setAttribute("message", "&#2340;&#2346;&#2366;&#2312;&#2325;&#2379;&#0032;&#2360;&#2344;&#2381;&#2342;&#2375;&#2358;&#0032;&#2346;&#2336;&#2366;&#2312;&#2319;&#2325;&#2379;&#0032;&#2331;&#2404;"); 
								request.setAttribute("link","main.jsp");
								//result="Congrats.Message sent!!!!";
					    }catch (MessagingException e) {
					    		request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;"); 
					    		request.setAttribute("link","main.jsp");
					    		//result="Failed to sent message"+e.getMessage();
					    }catch(NullPointerException ne){
					    		request.setAttribute("message", "Invalid Profile"); 
					    		request.setAttribute("link","main.jsp");
					    		//result="oops";
						 	}
				  
						RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						view.forward(request,response);
						//out.print("<center><h1>Send Email using JSP</h1></center><p align=\"center\">\"Result: \"" + result + "\n");
						
					*/
					
					
					
					
					
					
					
					}
				}catch(NumberFormatException nfe){
						request.setAttribute("message", "Please enter number only for Profile ID.");
						request.setAttribute("link", "main.jsp");
						RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						view.forward(request,response);
						//out.print("please enter numeric type value for profile id");
			}
					catch(NullPointerException ne){
						out.print("null caught2"+ne.getMessage());
					}
		}
	}}
}
