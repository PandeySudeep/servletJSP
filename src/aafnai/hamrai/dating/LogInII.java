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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 * Servlet implementation class LogInII
 */
@WebServlet("/LogInII")
public class LogInII extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	DataSource dataSource = null;
	Connection con = null;
	Statement stmt = null;
	int cnt=0;
	java.sql.Date aft_mth = null;
	java.sql.Date today = null;
	java.util.Calendar calendar = null;

	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogInII() {
        super();
        // TODO Auto-generated constructor stub
    }

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
		//doGet(request, response);
		
		PrintWriter out = response.getWriter();
		
		String login_name = (String)request.getParameter("loginname");
		String login_pwd = (String)request.getParameter("loginpwd");
		
		if(login_name.length()<1||login_pwd.length()<1){
			
			request.setAttribute("message", "Please enter both username and password. Hit 'Back' button to the left and try again.");
			request.setAttribute("link", "milan_main.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			
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
									//try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
									//try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
									HttpSession session = request.getSession();
									session.setMaxInactiveInterval(7200);
									session.setAttribute("sessionattr",login_name);
									session.setAttribute("userpwd", login_pwd);
									session.setAttribute("usremail", db_email);
									
									/////////////////////////////////////////////////////////
									String chk = "Select count(*) AS mycnt from vivah_pmt where username=\""+login_name+"\" and password=\""+login_pwd+"\";";
									ResultSet rs2=null;
									try {
										con = dataSource.getConnection();
							    		stmt = con.createStatement();
										rs2 = stmt.executeQuery(chk);
										while(rs2.next()){
											
											cnt = (int)rs2.getInt("mycnt");
										}
										
										if(cnt==0){
											
											//out.print("0");
											//insert new record
											
											
											//String ins_new_usr = "Insert into vivah_pmt(POSTED_DATE,PASSWORD,USERNAME,EXP_DT) VALUES (CURDATE(),\""+pwd+"\","+usr+"\",DATE_ADD(CURDATE(),INTERVAL 30 DAY));";
											String ins_new_usr = "Insert into vivah_pmt(POSTED_DATE,PASSWORD,USERNAME,EXP_DT) VALUES (CURDATE(),?,?,?);";
											PreparedStatement preparedstmt = null;
											
											calendar = java.util.Calendar.getInstance();
											today = new java.sql.Date(calendar.getTime().getTime());
											calendar.setTime(today);
											calendar.add(java.util.Calendar.DATE, 30);
											aft_mth = new java.sql.Date(calendar.getTime().getTime());
											
											
											 try {
										    	  //con = dataSource.getConnection();
										    	  preparedstmt = con.prepareStatement(ins_new_usr);
										    	  
										    	  //preparedstmt.setDate(1,today);
										    	  preparedstmt.setString(1,login_pwd);
										    	  preparedstmt.setString(2,login_name);
										    	  preparedstmt.setDate(3,aft_mth);
										    	  
										    	  preparedstmt.execute();
										    	  
											 }catch(SQLException se){
												 
											 }finally{
												 
												  try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
												  try{if(null!=stmt)stmt.close();}catch (SQLException e){out.print(e.getMessage());}
												  try{if(null!=rs2)rs2.close();}catch(SQLException e){out.print(e.getMessage());}
												  try{if(null!=preparedstmt)preparedstmt.close();}catch(SQLException e){out.print(e.getMessage());}
											 }
											 
											//insert new record
											
											
										}else{
											
											//out.print(cnt);
											//update existing expiry date
											
											
											//String renew = "Update vivah_pmt SET EXP_DATE = DATE_ADD(EXP_DATE, INTERVAL 30 DAY) where username=\""+usr+"\" and password=\""+pwd+"\";";
											String renew = "Update vivah_pmt SET EXP_DT = ? where username=? and password=?";
											
											PreparedStatement preparedstmt = null;
											
											calendar = java.util.Calendar.getInstance();
											today = new java.sql.Date(calendar.getTime().getTime());
											calendar.setTime(today);
											calendar.add(java.util.Calendar.DATE, 30);
											aft_mth = new java.sql.Date(calendar.getTime().getTime());
											
											
											 try {
										    	  //con = dataSource.getConnection();
										    	 preparedstmt = con.prepareStatement(renew);
										    	  
										    	 preparedstmt.setDate(1,aft_mth);
										    	 preparedstmt.setString(2,login_name);
										    	 preparedstmt.setString(3,login_pwd);
										    	 //preparedstmt.setDate(4,aft_mth);
										    	  
										    	  preparedstmt.executeUpdate();
										    	  
											 }catch(SQLException se){
												 out.print("sqlexception"+se.getMessage());
											 }finally{
												 
												  try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
												  try{if(null!=stmt)stmt.close();}catch (SQLException e){out.print(e.getMessage());}
												  try{if(null!=rs2)rs2.close();}catch(SQLException e){out.print(e.getMessage());}
												  try{if(null!=preparedstmt)preparedstmt.close();}catch(SQLException e){out.print(e.getMessage());}
											 }
											
											//update existing expiry date
										}
									}catch(SQLException se){
										
									}
									
									
									/////////////////////////////////////////////////////////
									
									
									
									response.sendRedirect("main.jsp?user="+login_name);	
						   }else{
									continue;
								}
						}
					if (valid_usr==false){
							try{if(null!=res)res.close();}catch(SQLException e){out.print(e.getMessage());}
							try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
							try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
							request.setAttribute("message", "Wrong user name and password. Please click 'Back' button to the left and try again.");
							request.setAttribute("link", "milan_main.jsp");
							//out.print("wrong username and password.Please try again.");
							RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
							view.forward(request,response);
							//out.print("Failed to Login. Please check your credentials");
						}
			}catch (SQLException e) {
				//out.print(e.getMessage());
			}catch(NullPointerException e){
			}finally{
						try{if(null!=res)res.close();}catch(SQLException e){out.print(e.getMessage());}
						try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
						try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
				}
			}
		
	}

}
