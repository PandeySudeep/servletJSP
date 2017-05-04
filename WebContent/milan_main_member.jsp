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
		
				 
		<div class="container">
			<header>
				<h1 style="color:red">&#2350;&#2367;&#2354;&#2344;&#0032;&#2405;&#0032;&#2357;&#2367;&#2357;&#2366;&#2361;</h1>
			</header>
			<nav>
				<ul>
					<div class="list-group">
						<a href="main.jsp" class="list-group-item" style="background-color:black;color:red;font-weight:bold">Back</a>
					</div>
				</ul>
				
				<ul>
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
				</ul>
			</nav>
			<article>
				
				<h1>Welcome <%out.print(session.getAttribute("sessionattr"));%></h1>
				<p>Upakaar.com would like to wish you luck in your partner search.</p>
				<p>Upakaar.com plans to have Milan/Vivah segment of its service as a separate hosted private service soon.</p>
				<p>Upakaar.com is an open source project for all Indian nationals interested to participate. The professionals accepted include - Analysts, Developers, Web Designers, Testers, Data Engineers. Please contact
				 exec_rep@pandtek.com to apply and work at Upakaar.com.</p>
			</article>
			
			<footer style="color:red">&copy;pAnalyticsTech Solutions. All Rights Reserved.</footer>
			
		</div>
	</body>
</html>