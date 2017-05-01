package aafnai.hamrai.dating;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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

/**
 * Servlet implementation class DisplayEmailMessage
 */
@WebServlet("/DisplayEmailMessage")
public class DisplayEmailMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DisplayEmailMessage() {
        super();
        // TODO Auto-generated constructor stub
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
		//	doGet(request, response);
		
		PrintWriter out = response.getWriter();
		//out.print("test");
		
		int msg_id=0;
		
		String msgid = (String)request.getParameter("message_identifier");
		
		HttpSession session = request.getSession();
		
		String rec_usr = (String)session.getAttribute("sessionattr");
		String rec_pwd = (String)session.getAttribute("userpwd");
		
		if(rec_usr==null){
			request.setAttribute("message", "Session expired. Please click 'Back' button to the left and log in again.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}else{
		
		if(msgid.length()<1)
			{
				request.setAttribute("message", "Please fill out the form.");
				request.setAttribute("link", "main.jsp");
				RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
				view.forward(request,response);
				//RequestDispatcher view = request.getRequestDispatcher("pleaseenterreceiver.jsp");
				//view.forward(request,response);
			}else if(msgid.length()>=1)
				
									{
											try{
												msg_id=Integer.parseInt(msgid);
												boolean invalid_msg_id=true;
												
												
												//String message = "SELECT MSG_DATE,SENDER,MESSAGE,SENDER_EMAIL FROM milan_inbox WHERE msg_id="+msg_id+";";
												String query = "SELECT ID FROM milan_inbox WHERE RECEIVER=\""+rec_usr+"\" and REC_PWD=\""+rec_pwd+"\";";
												
												List<Integer> lst = new ArrayList<Integer>();
												ResultSet rs = null;
												
												try
													{
														con = dataSource.getConnection();
														stmt = con.createStatement();
														rs = stmt.executeQuery(query);
														while(rs.next())
															{
																int _id=rs.getInt("ID");
																lst.add(_id);
															}
													}catch(SQLException se){
														out.print(se.getMessage());
													}
									
												for(int i=0;i<lst.size();i++){
													if(msg_id==lst.get(i)){
														invalid_msg_id=false;
														break;
													}
												}
												
												if(invalid_msg_id==true){
													
													try{if(null!=rs)rs.close();}catch (SQLException e){e.getMessage();}
													//try{if(null!=r)r.close();}catch (SQLException e){e.getMessage();}
													try{if(null!=stmt)stmt.close();}catch (SQLException e){e.getMessage();}
													try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
													request.setAttribute("message", "wront message id selection");
													request.setAttribute("link", "milan_main_member.jsp");
													RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
													view.forward(request,response);
												}else if(invalid_msg_id==false){
													
														String message = "SELECT MSG_DATE,SENDER,MESSAGE,SENDER_EMAIL FROM milan_inbox WHERE ID="+msg_id+";";
														ResultSet rs2=null;
														String message_date=null;
														String sender=null;
														String email_msg=null;
														String sender_email_address=null;							
														try
															{
																rs2 = stmt.executeQuery(message);
																while(rs2.next())
																	{
																		message_date=rs2.getString("MSG_DATE");
																		sender=rs2.getString("SENDER");
																		email_msg=rs2.getString("MESSAGE");
																		sender_email_address=rs2.getString("SENDER_EMAIL");
																		}
																request.setAttribute("msg",email_msg);
																request.setAttribute("msg_dt",message_date);
																request.setAttribute("sender",sender);
																request.setAttribute("sender_email",sender_email_address);
																
																try{if(null!=rs)rs.close();}catch (SQLException e){e.getMessage();}
																try{if(null!=rs2)rs2.close();}catch (SQLException e){e.getMessage();}
																try{if(null!=stmt)stmt.close();}catch (SQLException e){e.getMessage();}
																try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
																
																RequestDispatcher view = request.getRequestDispatcher("mil_msg.jsp");
																view.forward(request,response);
																//out.print(email_msg+message_date+sender+sender_email_address+"check");
															}catch(SQLException se){
																out.print(se.getMessage());
															}
														}
												
											}catch(NumberFormatException ne){
												request.setAttribute("message", "Please enter number only for message ID.");
												request.setAttribute("link", "main.jsp");
												RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
												view.forward(request,response);
												}
				
											}
		
									}}
							}
