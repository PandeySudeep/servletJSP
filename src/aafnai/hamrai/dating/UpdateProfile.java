package aafnai.hamrai.dating;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

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


@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {

	private static final long serialVersionUID = 1L;
       
    public UpdateProfile() {
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
   		} catch (NamingException e) {
   			
   			}
   	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		boolean all_values_entered = false;
		
		String username=null;
		String login_pwd=null;
		
		HttpSession session = request.getSession();
		username = (String)session.getAttribute("sessionattr");
		login_pwd = (String)session.getAttribute("userpwd");
		
		
		String col = (String)request.getParameter("updatecolumn");
		String newentry = (String)request.getParameter("entry");
		
		if(username==null){
			request.setAttribute("message", "Oops!! Your session has already expired. Please click 'Back' button to the left of this page and log in again to"
					+ " complete the update.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}else{
		
		if(col.length()<1||newentry.length()<1){
			
			request.setAttribute("message", "Please fill out the form completely.");
			request.setAttribute("link", "editprofile.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			//out.print("please enter what to update and the updated entry");
		}
		
		else{
			
			all_values_entered=true;
		}	
		
		if(all_values_entered==true){
			
			
			String query = "UPDATE dating_profile SET "+col+"=? WHERE USERNAME=? AND PASS_WORD=?;";
			
			PreparedStatement preparedStmt = null;
			 try {
				con = dataSource.getConnection();
				preparedStmt = con.prepareStatement(query);
				
				preparedStmt.setString(1, newentry);
				
				preparedStmt.setString(2, username);
				preparedStmt.setString(3, login_pwd);
				
				preparedStmt.executeUpdate();
				
				request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;");
				request.setAttribute("link", "editprofile.jsp");
				RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
				view.forward(request,response);
				//out.print("update successful");
				
			} catch (SQLException e) {
				out.println(e.getMessage());//e.printStackTrace();
			}catch(Exception e){
				out.print(e.getMessage());
			}
			 finally{
				 try{if(null!=preparedStmt)preparedStmt.close();} catch (SQLException e) {out.print(e.getMessage());}
				 try{if(null!=con)con.close();} catch (SQLException e) {out.print(e.getMessage());}
			 }
		}
		
		
		}
		
		
	}
}
