package aafnai.hamrai.dating;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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


@WebServlet("/CreateRelationship")
public class CreateRelationship extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CreateRelationship() {
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
   				}catch(NamingException e) {
    		e.printStackTrace();
   			}
   		}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		
		int receiver_id=0;
		int sender_id=0;
		String receivername = null;
		String receiverpwd = null;
		
		HttpSession session = request.getSession();
		
		String sendername = (String)session.getAttribute("sessionattr");
		String senderpwd = (String)session.getAttribute("userpwd");
		
		if(sendername==null){
			request.setAttribute("message", "Session expired. Please click 'Back' button to the left and log in again.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}else{
			
		
		String receiverid = (String)request.getParameter("profileforrequest");
		if(receiverid.length()<1)
			{
				
				request.setAttribute("message", "Please fill the form.");
				request.setAttribute("link", "main.jsp");
				RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
				view.forward(request,response);
				//RequestDispatcher view = request.getRequestDispatcher("pleaseenterreceiver.jsp");
				//view.forward(request,response);
			}else if(receiverid.length()>=1)
				{
					try
						{
							receiver_id = Integer.parseInt(receiverid);
							//HttpSession session = request.getSession();
			
							//String sendername = (String)session.getAttribute("sessionattr");
							//String senderpwd = (String)session.getAttribute("userpwd");
			
							String query1 = "SELECT ID FROM dating_profile WHERE USERNAME=\""+sendername+"\" and PASS_WORD=\""+senderpwd+"\";";
							ResultSet rs1 = null;
							try
								{
									con = dataSource.getConnection();
									stmt = con.createStatement();
									rs1 = stmt.executeQuery(query1);
									while(rs1.next())
										{
											sender_id=rs1.getInt("ID");
										}
								}catch(SQLException se){
									out.print(se.getMessage());
								}
					
							boolean relationshipexist = false;
							String crosscheck = "SELECT SENDER_ID,RECEIVER_ID from relationship;";
							ResultSet r = null;
							try
								{
									r = stmt.executeQuery(crosscheck);
									while(r.next())
										{
											int sendercheck=r.getInt("SENDER_ID");
											int receivercheck=r.getInt("RECEIVER_ID");
											if(sender_id==sendercheck&&receiver_id==receivercheck){
												relationshipexist=true;
												break;
											}
										}
								}catch(SQLException e){
										out.print(e.getMessage());
								}
			
							if (relationshipexist==true)
								{
									try{if(null!=rs1)rs1.close();}catch (SQLException e){e.getMessage();}
									try{if(null!=r)r.close();}catch (SQLException e){e.getMessage();}
									try{if(null!=stmt)stmt.close();}catch (SQLException e){e.getMessage();}
									try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
									
									request.setAttribute("message", "Your request was already sent in the past.");
									request.setAttribute("link", "main.jsp");
									RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
									view.forward(request,response);
									//RequestDispatcher view = request.getRequestDispatcher("relationshipexist.jsp");
									//view.forward(request,response);
							}else{
									String query2 = "SELECT USERNAME,PASS_WORD FROM dating_profile WHERE ID="+receiver_id+";";
									ResultSet rs2=null;
									try
										{
										rs2 = stmt.executeQuery(query2);
										while(rs2.next())
											{
												receivername=rs2.getString("USERNAME");
												receiverpwd=rs2.getString("PASS_WORD");
												}
									}catch(SQLException se){
										out.print(se.getMessage());
										}
				
									String insert_relationship = "INSERT INTO relationship(SENDER_NAME,SENDER_PWD,SENDER_ID,RECEIVER_NAME,RECEIVER_PWD,RECEIVER_ID,CREATED_DATE,STATUS)"+ "VALUES (?,?,?,?,?,?,CURDATE(),?);";
			
									PreparedStatement preparedStmt=null;
				
									try
										{
											preparedStmt = con.prepareStatement(insert_relationship);
											preparedStmt.setString (1,sendername);
											preparedStmt.setString   (2,senderpwd);
											preparedStmt.setInt(3,sender_id);
											preparedStmt.setString    (4,receivername);
											preparedStmt.setString(5,receiverpwd);
											preparedStmt.setInt(6,receiver_id);
											preparedStmt.setString(7,"PROPOSED");
											preparedStmt.execute();
											
											request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;");
											request.setAttribute("link", "milan_main_member.jsp");
											RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
											view.forward(request,response);
									}catch(SQLException e){
										out.println("failed to create relationship.Please contact Hamro.com"+e.getMessage());
										}
			      /*
									String emailrecipient="SELECT EMAIL FROM dating_profile where ID ="+receiverid+";";
									String to_email=null;
									try
										{
											ResultSet rs4 = stmt.executeQuery(emailrecipient);
												while(rs4.next())
													{
														to_email = rs4.getString("EMAIL");
											}
									}catch(SQLException e){
									}finally{
												try{if(null!=r)r.close();}catch(SQLException e){out.print(e.getMessage());}
												try{if(null!=rs1)rs1.close();}catch(SQLException e){out.print(e.getMessage());}
												try{if(null!=rs2)rs2.close();}catch(SQLException e){out.print(e.getMessage());}
												try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
												try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
										}
			      
									String from = "hamro_saathi@hamroaafno.com";
									String msg = "You have received a new request from profile id: '"+ sender_id +"' on milan/vivah. Please log on to accept or decline the request. Good Luck!!.";
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
						     
											//send message  
											Transport.send(message);
											request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;");
											request.setAttribute("link", "main.jsp");
											//result="Request sent plus email reminder Successfully";
										} catch (MessagingException e) {
											//result="Failed to send message"+e.getMessage();
										}catch(NullPointerException ne){
											request.setAttribute("message", "&#2340;&#2346;&#2366;&#2312;&#2325;&#2379;&#0032;&#2331;&#2344;&#2380;&#2335;&#0032;&#2313;&#2346;&#2351;&#2369;&#2325;&#2381;&#2340;&#0032;&#2341;&#2367;&#2319;&#2344;&#2404;");
											request.setAttribute("link", "main.jsp");
											//result="The receiver doesn't exist. Invalid profile Id Selection";
										}
									
									RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
									view.forward(request,response);
					*/				//out.print("<center><h1>Send Email using JSP</h1></center><p align=\"center\">\"Result: \"" + result + "\n");
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
						}}
					}


