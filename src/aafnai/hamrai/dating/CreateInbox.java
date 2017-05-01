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

import aafnai.hamrai.model.Mil_Inbox;

/**
 * Servlet implementation class CreateInbox
 */
@WebServlet("/CreateInbox")
public class CreateInbox extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	Connection con = null;
   	Statement stmt = null;
   	DataSource dataSource = null;
   	
    public CreateInbox() {
        super();
        // TODO Auto-generated constructor stub
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

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		String usr = (String)session.getAttribute("sessionattr");
		String pwd = (String)session.getAttribute("userpwd");
		
		String create_table = "SELECT ID,MSG_DATE,SENDER_ID,SENDER,SENDER_PWD,RECEIVER_ID,RECEIVER,REC_PWD,MESSAGE,REC_EMAIL,SENDER_EMAIL,STATUS FROM milan_inbox WHERE RECEIVER=\""+usr+"\" AND REC_PWD=\""+pwd+"\";";   
		List<Mil_Inbox> msg_lst = new ArrayList<Mil_Inbox>();
		
		
		if(usr==null){
			request.setAttribute("message", "Session has expired. Please log in again by clicking the 'Back' button to the left of this page.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
		}else{
		
		ResultSet rs = null;
		
		
		try{
			con = dataSource.getConnection();
            stmt = con.createStatement();
			rs = stmt.executeQuery(create_table);
			while(rs.next()){
				
				msg_lst.add(new Mil_Inbox(rs.getInt("ID"),rs.getString("MSG_DATE"),rs.getInt("SENDER_ID"),rs.getString("SENDER"),rs.getString("SENDER_PWD"),rs.getInt("RECEIVER_ID"),rs.getString("RECEIVER"),rs.getString("REC_PWD"),rs.getString("MESSAGE"),rs.getString("REC_EMAIL"),rs.getString("SENDER_EMAIL"),rs.getString("STATUS")));
				
				}
			request.setAttribute("mil_inbox", msg_lst);
			try{if(null!=rs)rs.close();}catch(SQLException e){out.print(e.getMessage());}
			try{if(null!=stmt)stmt.close();}catch(SQLException e){e.getMessage();}
			try{if(null!=con)con.close();}catch(SQLException e){out.print(e.getMessage());}
			RequestDispatcher view = request.getRequestDispatcher("mil_inbox.jsp");
			view.forward(request,response);
			
		}catch(SQLException e){
			out.print("check"+e.getMessage());
		}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
	}

}
