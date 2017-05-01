package aafnai.hamrai.payment;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
//import java.text.ParseException;
import java.text.SimpleDateFormat;

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
 * Servlet implementation class PaymentStatus
 */
@WebServlet("/PaymentStatus")
public class PaymentStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentStatus() {
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
			
			}
   		}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		//response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		//out.print("nothing");
		
		HttpSession session = request.getSession();
		String usr = (String)session.getAttribute("sessionattr");
		String pwd = (String)session.getAttribute("userpwd");
		//out.print(usr+pwd);
		
		String pmt_chk = "Select EXP_DT, USERNAME from vivah_pmt WHERE USERNAME=\""+usr+"\" AND PASSWORD=\""+pwd+"\";";
		//String pmt_chk = "SELECT * FROM viv_pmt;";
		
		ResultSet rs = null;
		Date expiry_dt = null;
		//String newmember = null;
		
		String user=null;
		//int count =0;
		
		Date aaja = null;
		Date record = null;
		
		try {
			con = dataSource.getConnection();
            stmt = con.createStatement();
			rs = stmt.executeQuery(pmt_chk);
			
			//if(rs == null){
			
			//if(!rs.next()){
				//out.print("test");
				//newmember="yes";
				//expiry_dt=null;
				//close closeables and dispatch to payment page
				//try{ if(null!=rs)rs.close();}catch(SQLException e){}
				//try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
				//try{if(null!=con)con.close();}catch(SQLException e){e.getMessage();}
				//RequestDispatcher view = request.getRequestDispatcher("milan_pmt.jsp");
				//view.forward(request,response);
			//}else{
				//out.println("ok");
				
				while (rs.next()){
					//++count;
					//newmember="no";
					expiry_dt = (Date)rs.getDate("EXP_DT");
					user = (String)rs.getString("USERNAME");
					//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					//Date today = new Date(2017,04,11);
			
					
						}
							/*
							 * 
							 
							out.println("DB username: " + user);
							out.println(pmt_chk);
							out.println("Expiry Date:" + expiry_dt);
							*/
							
							if(user==null&&usr!=null){
								try{ if(null!=rs)rs.close();}catch(SQLException e){}
								try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
								try{if(null!=con)con.close();}catch(SQLException e){e.getMessage();}
								RequestDispatcher view = request.getRequestDispatcher("milan_pmt.jsp");
								view.forward(request,response);
							}else{
									try {
										Date today = new Date();
										SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
										record = sdf.parse(sdf.format(expiry_dt));
										aaja = sdf.parse(sdf.format(today));
									} catch (Exception e) {
										// TODO Auto-generated catch block
										//e.printStackTrace();
										}
									/*
									out.println("DB username: " + user);
									out.println(pmt_chk);
									out.println("Expiry Date:" + expiry_dt);
									out.println("Today's date: " + aaja);
									out.println("User Expires: "+ record);
									*/
									
									if(aaja.compareTo(record)==1){
										//close closeables and dispatch request to payment page
										try{ if(null!=rs)rs.close();}catch(SQLException e){}
										try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
										try{if(null!=con)con.close();}catch(SQLException e){e.getMessage();}
										RequestDispatcher view = request.getRequestDispatcher("milan_pmt.jsp");
										view.forward(request,response);
									}else if(aaja.compareTo(record)<1){
										//close closeables and dispatch request to viv_create.jsp
										try{ if(null!=rs)rs.close();}catch(SQLException e){}
										try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
										try{if(null!=con)con.close();}catch(SQLException e){e.getMessage();}
										RequestDispatcher view = request.getRequestDispatcher("milan_main_member.jsp");
										view.forward(request,response);
									}
								}
							
				//out.println(count);
							
				
				//}
			}catch(SQLException e){
				out.print("sql exception" + e.getMessage());
				}catch(NullPointerException ne){
					out.println("Session expired. Please log in as a member");
				}
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}
