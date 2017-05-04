package aafnai.hamrai.site;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

public class Log_in extends HttpServlet{
	
	DataSource dataSource = null;
	Connection con = null;
	Statement stmt = null;
	
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

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		
		
		String login_name = (String)request.getParameter("loginname");
		String login_pwd = (String)request.getParameter("loginpwd");
		
		if(login_name.length()<1||login_pwd.length()<1){
			
			request.setAttribute("message", "Please fill out form completely.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			
			//out.print("please enter credentials");
		}else{
				ResultSet res = null;
				String query="Select USER_NAME,PASS_WORD,EMAIL from registered_users";
				try {
						con = dataSource.getConnection();
						stmt = con.createStatement();
						res = stmt.executeQuery(query);
						boolean valid_usr=false;
						while(res.next())
							{
								String db_username=res.getString("USER_NAME");
								String db_password=res.getString("PASS_WORD");
								String db_email=res.getString("EMAIL");
								
					
								if(login_name.equals(db_username)&&login_pwd.equals(db_password))
									{
										valid_usr=true;
										try{if(null!=res)res.close();}catch(SQLException e){out.print(e.getMessage());}
										try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
										try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
										HttpSession session = request.getSession();
										session.setMaxInactiveInterval(7200);
										session.setAttribute("sessionattr",login_name);
										session.setAttribute("userpwd", login_pwd);
										session.setAttribute("usremail", db_email);
										response.sendRedirect("main.jsp?user="+login_name);	
							   }else{
										continue;
									}
							}
						if (valid_usr==false){
								try{if(null!=res)res.close();}catch(SQLException e){out.print(e.getMessage());}
								try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
								try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
								request.setAttribute("message", "Wrong username or password.");
								request.setAttribute("link", "welcome.jsp");
								RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
								view.forward(request,response);
								//out.print("Failed to Login. Please check your credentials");
							}
				}catch (SQLException e) {
					out.print(e.getMessage());
				}catch(NullPointerException e){
				}finally{
							try{if(null!=res)res.close();}catch(SQLException e){out.print(e.getMessage());}
							try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
							try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
					}
				}
			}
		}