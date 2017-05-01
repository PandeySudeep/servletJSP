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

import aafnai.hamrai.model.MilanProfile;

@WebServlet("/RespondToRequests")
public class RespondToRequests extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RespondToRequests() {
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
				} catch (NamingException e) {
					e.printStackTrace();
					}
		}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
				
		HttpSession session = request.getSession();
		String usr = (String)session.getAttribute("sessionattr");
		String pwd = (String)session.getAttribute("userpwd");
		
		String dbusr=null;
		String dbpwd=null;
		
		boolean exists = false;
		String query = "SELECT USERNAME, PASS_WORD FROM dating_profile;";
		
		if(usr==null){
			request.setAttribute("message", "Session expired.Please click the 'Back' button to the left of this page to log in again.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}else{
		
		ResultSet rs = null;
		try{
			con = dataSource.getConnection();
            stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				dbusr = (String)rs.getString("USERNAME");
				dbpwd = (String)rs.getString("PASS_WORD");
				
				if(dbusr.equals(usr)&&dbpwd.equals(pwd)){
					exists=true;
					break;
				}
			}
		}catch(SQLException e){
			out.print("check"+e.getMessage());
		}
		if(exists==false){
			try{if(null!=rs)rs.close();}catch(SQLException e){out.print(e.getMessage());}
			try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
			try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
				
			request.setAttribute("message", "You don't have any profile yet.");
			request.setAttribute("link", "main.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			//out.print("you don't have a profile");
		}else{
			
			String requestcheck = "SELECT RECEIVER_NAME,RECEIVER_PWD FROM relationship WHERE RECEIVER_NAME=\""+dbusr+"\" AND RECEIVER_PWD=\""+dbpwd+"\";";
			ResultSet rs2 = null;
			try {
				rs2 = stmt.executeQuery(requestcheck);
				if(!rs2.next()){
					try{if(null!=rs2)rs2.close();}catch(SQLException e){out.print(e.getMessage());}
					try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
					try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
					
					request.setAttribute("message", "Please try again.");
					request.setAttribute("link", "main.jsp");
					RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
					view.forward(request,response);
					//out.print("no requests received");
				}else{
						List<MilanProfile> requestors = new ArrayList<MilanProfile>();
						String requestorlist = "SELECT ID,NICKNAME,GENDER,AGE,ADDRESS FROM dating_profile WHERE ID IN (SELECT SENDER_ID from relationship WHERE STATUS=\"PROPOSED\" AND RECEIVER_NAME=\""+dbusr+"\" AND RECEIVER_PWD=\""+dbpwd+"\");";
						ResultSet rs3 = null;
						try{
							rs3 = stmt.executeQuery(requestorlist);
							while(rs3.next())
								{
									requestors.add(new MilanProfile(rs3.getInt("ID"),rs3.getString("NICKNAME"),rs3.getString("GENDER"),rs3.getString("AGE"),rs3.getString("ADDRESS")));
								}
							request.setAttribute("list_of_requestors", requestors);
							
							try{if(null!=rs3)rs3.close();}catch(SQLException e){out.print(e.getMessage());}
							try{if(null!=rs2)rs2.close();}catch(SQLException e){out.print(e.getMessage());}
							try{if(null!=rs)rs.close();}catch(SQLException e){out.print(e.getMessage());}
							try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
							try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
							RequestDispatcher view = request.getRequestDispatcher("requestors.jsp");
							view.forward(request,response);
						}catch(SQLException e){
							out.print("wrong sql"+e.getMessage());
							}
					}
			} catch (SQLException e) {
				out.print("test"+e.getMessage());
			}
		}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
