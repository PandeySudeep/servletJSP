package aafnai.hamrai.site;

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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.sql.DataSource;


public class Register extends HttpServlet {

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
				
		String fst_name = (String)request.getParameter("firstname");
		String lst_name = (String)request.getParameter("lastname");
		String usr_name = (String)request.getParameter("username");
		String pass_word = (String)request.getParameter("pwd");
		String email_add = (String)request.getParameter("email");
		String gender = (String)request.getParameter("gender");
		String age = (String)request.getParameter("age");
		String phone_num = (String)request.getParameter("phone");
		String nationality = (String)request.getParameter("nationality");
		
		
		if((fst_name.length()<1)||(lst_name.length()<1)||(usr_name.length()<1)||(pass_word.length()<1)
				||(email_add.length()<1)||(gender.length()<1)||(age.length()<1)||(nationality.length()<1)==true){
			
			request.setAttribute("message", "Please enter all items.");
			request.setAttribute("link", "registration.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}else{
		
		
	    ResultSet rs = null;
		
	    String query = "Select FIRST_NAME,LAST_NAME,USER_NAME,PASS_WORD,EMAIL,PHONE,GENDER,AGE,NATIONALITY from registered_users;";
		
	    String db_usrname=null;
		String db_pwd=null;
		
		boolean match = false;
		
		try {
			con = dataSource.getConnection();
            stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				
				db_usrname = rs.getString("USER_NAME");
				db_pwd = rs.getString("PASS_WORD");
				
			if(usr_name.equals(db_usrname)&&pass_word.equals(db_pwd)){		
				match=true;
				break;
					
				}else{
					match=false;
				}
			}
		} catch (SQLException e) {
			out.print(e.getMessage());
		}catch (NullPointerException ne){
			out.print("null"+ne.getMessage());
		}finally{
			try{if(null!=rs)rs.close();}catch(SQLException e){out.print(e.getMessage());}
			try{if(null!=stmt)stmt.close();}catch(SQLException e){out.print(e.getMessage());}
			}
		
		if(match==true){
			try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
			request.setAttribute("message", "You were already registered.Please log in.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			//out.println("Already Registered");
		}else if(match==false){
			String registration="INSERT INTO registered_users(FIRST_NAME,LAST_NAME,USER_NAME,PASS_WORD,EMAIL,PHONE,GENDER,AGE,NATIONALITY)" + "VALUES (?,?,?,?,?,?,?,?,?);";
			PreparedStatement preparedStmt=null;
		      try {
		    	  preparedStmt = con.prepareStatement(registration);
				  
				  preparedStmt.setString(1,fst_name);
			      preparedStmt.setString(2,lst_name);
			      preparedStmt.setString(3,usr_name);
			      preparedStmt.setString(4,pass_word);
			      preparedStmt.setString(5,email_add);
			      preparedStmt.setString(6,phone_num);
			      preparedStmt.setString(7,gender);
			      preparedStmt.setString(8,age);
			      preparedStmt.setString(9,nationality);
			      preparedStmt.execute();
			      
			      try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException e){out.print(e.getMessage());}
				  try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
			      
				  	request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;");
					request.setAttribute("link", "welcome.jsp");
					RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
					view.forward(request,response);
				    //out.print("registered successfully");
			}catch(SQLException e) {
				request.setAttribute("message", "Unexpected Error Occurred. Please report to exec_rep@pandtek.com!!");
				request.setAttribute("link", "welcome.jsp");
				RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
				view.forward(request,response);
			}finally{
		    	 
		    	 try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException e){out.print(e.getMessage());}
				 try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
				}
			}
		  }
	}
}

