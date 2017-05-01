package aafnai.hamrai.dating;

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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

@WebServlet("/EditProfile")
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditProfile() {
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
		
		ResultSet rs = null;
		
		if(usr==null){
			request.setAttribute("message", "Session expired. Please log in again by clicking 'Back' button to the left of this page.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}
		else{
		try {
			con = dataSource.getConnection();
            stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				String db_usr = rs.getString("USERNAME");
				String db_pwd = rs.getString("PASS_WORD");
				
				if(db_usr.equals(usr)&&db_pwd.equals(pwd)){
					try{if(null!=rs)rs.close();} catch (SQLException e){out.print(e.getMessage());}
					try{if(null!=stmt)stmt.close();} catch (SQLException e){e.getMessage();}
					try{if(null!=con)con.close();} catch (SQLException e) {out.print(e.getMessage());}
					RequestDispatcher view = request.getRequestDispatcher("editprofile.jsp");
	    			view.forward(request,response);
					}
				}
			
			request.setAttribute("message", "You don't have a profile registered. Please create one.");
			request.setAttribute("link", "main.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			//out.print("You need to have profile to edit");
		} catch (SQLException e) {
			out.print(e.getMessage());
		}
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
