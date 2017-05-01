package aafnai.hamrai.dating;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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


@WebServlet("/DeleteProfile")
public class DeleteProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteProfile(){
        super();
       }
    
    Connection con = null;
	Statement stmt = null;
	DataSource dataSource = null;

    public void init(){
		 
	    try
	    	{
				// Get DataSource
				Context initContext  = new InitialContext();
				Context envContext  = (Context)initContext.lookup("java:/comp/env");
				dataSource = (DataSource)envContext.lookup("jdbc/hamroaa1_hamro_db");
	    	} catch (NamingException e) {
				}
	  }
    	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		
		String usr = (String)session.getAttribute("sessionattr");
		String pwd = (String)session.getAttribute("userpwd");
		
		String query = "Select USERNAME, PASS_WORD from dating_profile where USERNAME=\""+usr+"\"" + "AND PASS_WORD= \""+pwd+"\";";
		String deletequery = null;
		
		
		if(usr==null){
			request.setAttribute("message", "Your session's expired. Please click 'Back' button to the left of this page and log in again.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}else{
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
            stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			PreparedStatement preparedStmt = null;
			while(rs.next())
				{
					String db_usr = rs.getString("USERNAME");
					String db_pwd = rs.getString("PASS_WORD");
				
					if(db_usr.equals(usr)&&db_pwd.equals(pwd))
						{
							deletequery = "DELETE FROM dating_profile WHERE USERNAME=\""+usr+"\"" + "AND PASS_WORD= \""+pwd+"\";";
							try 
								{
									preparedStmt = con.prepareStatement(deletequery);
									preparedStmt.executeUpdate();
										
									File dir = new File("/home/hamroaa1/my_images");
									File[] toBeDeleted = dir.listFiles(new FileFilter() {
										public boolean accept(File pathname) {
											return (pathname.getName().startsWith(usr+pwd));
											}}); 
									for (File f : toBeDeleted) {
										f.delete();
										}
							 }catch (SQLException e) {
							out.println(e.getMessage());
			}catch(Exception e){
					out.print(e.getMessage());
			}finally{
						try{if(null!=rs)rs.close();}catch(SQLException e){out.print(e.getMessage());}
						try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
						try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
					}
					
					request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;");
					request.setAttribute("link", "main.jsp");
					RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
					view.forward(request,response);
				}
			}
			request.setAttribute("message", "You don't have any profile to delete.");
			request.setAttribute("link", "main.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			//out.print("You need to have profile to delete");
		} catch (SQLException e) {
			out.print(e.getMessage());
		}
		
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
}
