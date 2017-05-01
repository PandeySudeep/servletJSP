<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Date"%>


<html>
	<head>
		<meta charset="utf-8">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<title>&#2350;&#2367;&#2354;&#2344;&#0032;&#2405;&#0032;&#2357;&#2367;&#2357;&#2366;&#2361;</title>
		
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<link href="css/sagarmatha_styles.css" rel="stylesheet">
		
		<link href='https://fonts.googleapis.com/css?family=Oxygen:400,300,700' rel='stylesheet' type='text/css'>
		
		<style>
							*{
								box-sizing: border-box;
							 }
						body {
								font-family: 'Oxygen', sans-serif;	
							 }
				div.container{
								width: 100%;
								border: 1px solid gray;
							  }
				       header {
								padding: 1em;
								color: white;
								background-color: black;
								clear: left;
								text-align: center;
							  }
						footer {
								position:fixed;
								bottom:2px;
								padding: 1em;
								color: white;
								background-color: black;
								clear: left;
								text-align: center;
								width:100%;
							  }
						nav   {
							    float: left;
								margin: 0;
								padding: 1em;
								
							  }
					 nav ul   {
								list-style-type: none;
								padding: 0;
							  }
   
					nav ul a  {
								text-decoration: none;
							  }
	
					article   {
								margin-left: 170px;
								padding: 1em;
								overflow: hidden;
								border-left: 1px solid gray;
							   }
	@media (max-width: 767px) {
					  #end_msg{
								display:none;
							  }
					article   {
								margin-left: 100px;
								padding: 1em;
								overflow: hidden;
								border-left: 1px solid gray;
							  }
							  
							  }
		</style>
	</head>

	<body>
		<%
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Expires","0");
			response.setHeader("Cache-Control", "no-store");
			response.setDateHeader("Expires", 0);
			
			//response.setHeader("Cache-Control","no-cache"); 
			//response.setHeader("Pragma","no-cache"); 
			//response.setDateHeader ("Expires", -1);
		%>
		
		<%!
	    	Connection con = null;
			Statement stmt = null;
			DataSource dataSource = null;
			ResultSet rs = null;
		%>
		
		<%!
			//instance variables
			int cnt =0;
			java.sql.Date aft_mth = null;
			java.sql.Date today = null;
			java.util.Calendar calendar = null;
		
		%>
		
		<%!
			public void jspInit(){
		
	    		try {
					// Get DataSource
					Context initContext  = new InitialContext();
					Context envContext  = (Context)initContext.lookup("java:/comp/env");
					dataSource = (DataSource)envContext.lookup("jdbc/hamroaa1_hamro_db");
				} catch (NamingException e) {
						e.printStackTrace();
					}
	  			}
		%>
		
		<%
			String usr = (String)session.getAttribute("sessionattr");
			String pwd = (String)session.getAttribute("userpwd");
			
			String chk = "Select count(*) AS mycnt from vivah_pmt where username=\""+usr+"\" and password=\""+pwd+"\";";
		    
			//String newmember=null;
			
			
			try {
				con = dataSource.getConnection();
	    		stmt = con.createStatement();
				rs = stmt.executeQuery(chk);
				while(rs.next()){
					
					cnt = (int)rs.getInt("mycnt");
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
				    	  preparedstmt.setString(1,pwd);
				    	  preparedstmt.setString(2,usr);
				    	  preparedstmt.setDate(3,aft_mth);
				    	  
				    	  preparedstmt.execute();
				    	  
					 }catch(SQLException se){
						 
					 }finally{
						 
						  try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
						  try{if(null!=stmt)stmt.close();}catch (SQLException e){out.print(e.getMessage());}
						  try{if(null!=rs)rs.close();}catch(SQLException e){out.print(e.getMessage());}
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
				    	 preparedstmt.setString(2,usr);
				    	 preparedstmt.setString(3,pwd);
				    	 //preparedstmt.setDate(4,aft_mth);
				    	  
				    	  preparedstmt.executeUpdate();
				    	  
					 }catch(SQLException se){
						 out.print("sqlexception"+se.getMessage());
					 }finally{
						 
						  try{if(null!=con)con.close();}catch (SQLException e){out.print(e.getMessage());}
						  try{if(null!=stmt)stmt.close();}catch (SQLException e){out.print(e.getMessage());}
						  try{if(null!=rs)rs.close();}catch(SQLException e){out.print(e.getMessage());}
						  try{if(null!=preparedstmt)preparedstmt.close();}catch(SQLException e){out.print(e.getMessage());}
					 }
					
					//update existing expiry date
				}
			}catch(SQLException se){
				
			}
		%>
		 
		<div class="container">
			<header>
				<h1 style="color:red">&#2350;&#2367;&#2354;&#2344;&#0032;&#2405;&#0032;&#2357;&#2367;&#2357;&#2366;&#2361;</h1>
			</header>
			<nav>
				<!-- <ul>
					<div class="list-group">
						<a href="main.jsp" class="list-group-item" style="background-color:black;color:red;font-weight:bold">Back</a>
					</div>
				</ul>-->
				<ul>
					<div class="list-group">
						<a style="color:black;font-weight:bold" href="#" class="list-group-item disabled">Order Info:</a>
						<p class="list-group-item">Transaction ID: ${result.txn_id }<br>
						Name: ${result.first_name } ${result.last_name }<br>
						
						Email: ${result.payer_email }<br>
						Payment Gross: ${result.payment_gross }
					</div>
				</ul>
				
				<!-- <ul>
					<div class="list-group">
						<a style="color:red;font-weight:bold" href="#" class="list-group-item disabled">&#2350;&#2367;&#2354;&#2344;&#0032;&#2405;&#0032;&#2357;&#2367;&#2357;&#2366;&#2361;</a>
						
						<a href="viv_create.jsp" class="list-group-item">Create My Profile</a>
						<a href="editmyprofile	" class="list-group-item">Edit My Profile</a>
						<a href="deletemyprofile" class="list-group-item">Delete My Profile</a>
						<a href="viewmyprofile" class="list-group-item">View My Profile</a>
						<a href="viv_search_form.jsp" class="list-group-item">Search Matching Profiles</a>
						<a href="respondtorequest" class="list-group-item">View Requests & Respond</a>
						<a href="listacceptors" class="list-group-item">Communicate With Matches</a>
						<a href="mil_inbox" class="list-group-item">My Inbox</a>
					</div>
				</ul>-->
			</nav>
			<article>
				
				<h1>Thank You for payment. Please log in below again to complete your registration.</h1>
				
				
				 <div id="log_in">
					<!--<img src="/sagarmatha/my_images/namaskar.gif" alt="please use google chrome browser" style="width:100px;height:100px;margin-left:10%">-->
					<img src="/img/namaskar.gif" alt="please use google chrome browser" style="width:100px;height:100px;margin-left:10%">
					<form action="login2" class="form-horizontal" method="POST">
						<div class="form-group">
							<label style="margin-left:30%">Username<sub>(case sensitive)</sub></label>
							<div>
								<input type="text" name="loginname" class="form-control" required>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" style="margin-left:30%">Password<sub>(case sensitive)</sub></label>
							<div>
								<input type="password" name="loginpwd" class="form-control" required>
							</div>
						</div>
						<div id="agreement">
							<p style="width:200px;font-size:0.75em">By clicking the link below, I confirm that I agree with all terms and conditions <a style="font-weight:bold" href="agreement.jsp">here</a>.</p>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-default" style="color:red;margin-left:15%">&#2360;&#2381;&#2357;&#2366;&#2327;&#2340;&#2350;</button>
							</div>
						</div>
					</form>
				</div>
			</article>
			
			<footer style="color:red">&copy;pAnalyticsTech Solutions. All Rights Reserved.</footer>
			
		</div>
	</body>
</html>