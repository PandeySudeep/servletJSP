package aafnai.hamrai.dating;

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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;


//@WebServlet("/CreateProfile")
public class CreateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public CreateProfile() {
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
			
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
		
			boolean exist = false;
			boolean all_values_entered = false;
						
			String username=null;
			String login_pwd=null;
			String checkname=null;
			String password=null;
			
		    String profilename = (String)request.getParameter("name");
			String age = (String)request.getParameter("age");
			String address = (String)request.getParameter("address");
			String email = (String)request.getParameter("email");
			String hobby = (String)request.getParameter("hobby");
			String gender = (String)request.getParameter("gender");
			String about = (String)request.getParameter("about");
			String looking_for = (String)request.getParameter("lookingfor");
			String about_life = (String)request.getParameter("life");
			String fav_quote = (String)request.getParameter("quote");
			String other_info = (String)request.getParameter("otherinfo");
			
			if(profilename.length()<1||age.length()<1||address.length()<1||email.length()<1||hobby.length()<1||gender.length()<1||about.length()<1||
					looking_for.length()<1||about_life.length()<1||fav_quote.length()<1||other_info.length()<1){
				
				request.setAttribute("message", "Please fill out form completely.");
				request.setAttribute("link", "main.jsp");
				RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
				view.forward(request,response);
				//out.print("please enter all values");
			}
			
			else{
				
				all_values_entered=true;
			}	
			
			if(all_values_entered==true){
				
				ResultSet rs=null;
				HttpSession session = request.getSession();
				username = (String)session.getAttribute("sessionattr");
				login_pwd = (String)session.getAttribute("userpwd");
				
				String query = "SELECT USERNAME,PASS_WORD FROM dating_profile;";
				
				try {
					con = dataSource.getConnection();
		            stmt = con.createStatement();
					rs = stmt.executeQuery(query);
					
					while (rs.next()){
						checkname = (String)rs.getString("USERNAME");
						password = (String)rs.getString("PASS_WORD");
						
						if(checkname.equals(username)&&password.equals(login_pwd)){
							exist=true;
							break;
						}
					}
				}catch(SQLException e){
					//out.println(e.getMessage());
					}
				finally{
					try{ if(null!=rs)rs.close();}catch(SQLException e){out.print(e.getMessage());}
					try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
					}
				}
						
				if (exist==true){
						try {if(null!=con)con.close();} catch (SQLException e) {out.print(e.getMessage());}
							
						request.setAttribute("message", "You already have a profile registered.");
						request.setAttribute("link", "main.jsp");
						RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
						view.forward(request,response);
						//out.print("profile already exists. One user cannot have multiple profiles. Please delete your profile first and re-create new one.");
						}
						
				if (exist==false && all_values_entered==true){
							String insert_profile = "INSERT INTO dating_profile(NICKNAME,USERNAME,PASS_WORD,GENDER,EMAIL,AGE,ADDRESS,HOBBY,LOOKING_FOR,ABOUT,LIFE_IS,FAV_QUOTE,OTHER_INFO,CREATED_DATE,VALID_UNTIL)"+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,CURDATE(),CURDATE()+INTERVAL 1 MONTH);";
							PreparedStatement preparedStmt=null;
						      try {
						    	  preparedStmt = con.prepareStatement(insert_profile);
								  preparedStmt.setString(1, profilename);
							      preparedStmt.setString(2, username);
							      preparedStmt.setString(3, login_pwd);
							      preparedStmt.setString(4, gender);
							      preparedStmt.setString(5,email);
							      preparedStmt.setString(6,age);
							      preparedStmt.setString(7, address);
							      preparedStmt.setString(8, hobby);
							      preparedStmt.setString(9, looking_for);
							      preparedStmt.setString(10, about);
							      preparedStmt.setString(11, about_life);
							      preparedStmt.setString(12, fav_quote);
							      preparedStmt.setString(13, other_info);
							      preparedStmt.execute(); 
						      	}catch (SQLException e) {
								  out.println("failed to create profile. Please contact exec_rep@pandtek.com");
						      	}finally{
						      	  try{if(null!=preparedStmt)preparedStmt.close();}catch(SQLException e){out.print(e.getMessage());}
						      	  try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
								}
						      
						    RequestDispatcher view = request.getRequestDispatcher("viv_upload.jsp");
				    		view.forward(request,response);         	      
						}
					}
				} 
			


