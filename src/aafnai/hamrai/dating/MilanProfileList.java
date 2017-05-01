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

@WebServlet("/MilanProfileList")
public class MilanProfileList extends HttpServlet {
	
	Connection con = null;
	Statement stmt = null;
	DataSource dataSource = null;
	 
	private static final long serialVersionUID = 1L;
       
    public MilanProfileList() {
        super();
    	}
    
    public void init(){
		 
       	try {
    		// Get DataSource
    		Context initContext  = new InitialContext();
    		Context envContext  = (Context)initContext.lookup("java:/comp/env");
    		dataSource = (DataSource)envContext.lookup("jdbc/hamroaa1_hamro_db");
    	}catch (NamingException e) {
    		}
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		
		String usr = (String)session.getAttribute("sessionattr");
		String pwd = (String)session.getAttribute("userpwd");
		
		String selected_gender = (String)request.getParameter("gender");
		String minimum_age = (String)request.getParameter("minage");
		String maximum_age = (String)request.getParameter("maxage");

		int min_age=0;
		int max_age=0;
		
		List<MilanProfile> milanproflist = new ArrayList<MilanProfile>();
		
		if(usr==null){
			request.setAttribute("message", "Session expired. Please click 'Back' button to the left and log in again.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}else{
		
		if(minimum_age.length()<1||maximum_age.length()<1){
			
			request.setAttribute("message", "Please fill out the form completely.");
			request.setAttribute("link", "main.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			//out.println("please enter minimum and maximum dates");
		}else{
			boolean valerr=false;
			try
				{
					min_age = Integer.parseInt(minimum_age);
					max_age = Integer.parseInt(maximum_age);
				}catch(NumberFormatException ne){
					valerr=true;
					request.setAttribute("message", "Please enter only numbers for age.");
					request.setAttribute("link", "main.jsp");
					RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
					view.forward(request,response);
				}
			
			if(valerr==false){
			String query = "SELECT ID,NICKNAME,GENDER,AGE,ADDRESS FROM dating_profile WHERE GENDER = \""+selected_gender+"\" AND (AGE>=" + min_age+ " and AGE <="+max_age+");";
			
			ResultSet res = null;
				try
					{
						con = dataSource.getConnection();
						stmt = con.createStatement();
						res = stmt.executeQuery(query);
						
						while(res.next()){
							milanproflist.add(new MilanProfile(res.getInt("ID"),res.getString("NICKNAME"),res.getString("GENDER"),res.getString("AGE"),res.getString("ADDRESS")));
							}
						request.setAttribute("listofmilanprofs", milanproflist);
				}catch(SQLException e){
					out.println("Could not create list of milan profile objects"+e.getMessage());
				}finally{
					try{if(null!=res)res.close();}catch(SQLException e){out.print(e.getMessage());}
					try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
					try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
					}
			
			if(milanproflist.size()>=1){
				RequestDispatcher view = request.getRequestDispatcher("milanprofiles.jsp");
				view.forward(request,response);
			}else{
				
				request.setAttribute("message", "No profiles to display within the selected range.");
				request.setAttribute("link", "main.jsp");
				RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
				view.forward(request,response);
				//out.println("no milan profiles to display");
				}	
		}
	
	}}}
}
