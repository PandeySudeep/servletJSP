package aafnai.hamrai.main;

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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import aafnai.hamrai.model.Room;

public class RoomList extends HttpServlet {

	Connection con = null;
	Statement stmt = null;
	DataSource dataSource = null; 
	
	private static final long serialVersionUID = 1L;
	
	public void init(){
		 
		try {
			// Get DataSource
			Context initContext  = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("jdbc/hamroaa1_hamro_db");
		} catch (NamingException e) {
				
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String selected_date = (String)request.getParameter("posteddate");
		String country = (String)request.getParameter("nationality");
		
		List<Room> roomlist = new ArrayList<Room>();
		
		if(selected_date.length()<1){
			request.setAttribute("message", "Please fill out form completely.");
			request.setAttribute("link", "main.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			//out.println("please enter a date");
		}else{
			String query = "SELECT POSTED_DATE,POSTED_BY,ROOM_DESC,LOCATION,COUNTRY,EMAIL,PHONE,OTHERINFO FROM room_postings WHERE COUNTRY=\""+country+"\" AND POSTED_DATE>=\""+selected_date+"\";";
			ResultSet res = null;	
			try {
				con = dataSource.getConnection();
				stmt=con.createStatement();
				res = stmt.executeQuery(query);
				while(res.next()){
					roomlist.add(new Room(res.getDate("POSTED_DATE"),res.getString("POSTED_BY"),res.getString("ROOM_DESC"),res.getString("LOCATION"),res.getString("COUNTRY"),res.getString("EMAIL"),
					res.getString("PHONE"),res.getString("OTHERINFO")));
				
					request.setAttribute("listofrooms", roomlist);
					}
			}catch(SQLException e){
				//out.println("Could not create list of room objects"+e.getMessage());
			}
			
		if(roomlist.size()>=1){
			try{if(null!=res)res.close();}catch(SQLException se){out.print(se.getMessage());}
			try{if(null!=stmt)stmt.close();}catch(SQLException se){se.getMessage();}
			try{if(null!=con)con.close();}catch(SQLException se){out.print(se.getMessage());}
			
			RequestDispatcher view = request.getRequestDispatcher("rooms.jsp");
			view.forward(request,response);
			}else{
				try{if(null!=res)res.close();}catch(SQLException se){out.print(se.getMessage());}
				try{if(null!=stmt)stmt.close();}catch(SQLException se){se.getMessage();}
				try{if(null!=con)con.close();}catch(SQLException se){out.print(se.getMessage());}
				request.setAttribute("message", "No accomodation found within selected date range.");
				request.setAttribute("link", "main.jsp");
				RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
				view.forward(request,response);
				//out.println("no rooms to display");
			}
			
		}
		
	}
}
