<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ page import="java.util.*"%>
<%@ page import="aafnai.hamrai.model.*"%>

<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
    	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
   
		<title>&#2350;&#2367;&#2354;&#2344;</title>

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
								overflow:hidden;
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
			</nav>
			<article>
				<form style="width:40%" action="profileshow" method="POST">
					<div class="form-group">
						<label>Select Profile ID To View</label>
						<input type="text" name="desiredprofile" class="form-control" required>
					</div>
					<button type="submit" class="btn btn-primary">View</button>
				</form>
				<form style="width:40%" action="createrelationship" method="POST">	
					<div class="form-group">
						<label>Send Request To Profile ID</label>
						<input type="text" name="profileforrequest" class="form-control" required>
					</div>	
					<button type="submit" class="btn btn-primary">Send Request</button>
				</form>
				
				<div style="margin-top:10px" class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>PROFILE ID</th>
							<th>NICKNAME</th>
							<th>GENDER</th>
							<th>AGE</th>
							<th>ADDRESS</th>
						</tr>
						<%ArrayList<MilanProfile> l = (ArrayList<MilanProfile>)request.getAttribute("listofmilanprofs");
						  int size = l.size();%>
  						<%
  							for(int i=0;i<size;i++){
  						%>
  								<tr>
									<td><%out.print(l.get(i).getProfileid());%></td>
									<td><%out.print(l.get(i).getNickname());%></td>
									<td><%out.print(l.get(i).getGender());%></td>
									<td><%out.print(l.get(i).getAge());%></td>
									<td><%out.print(l.get(i).getAddress());%></td>
								</tr>
							<%} %>
					</table>
				</div>
			</article>
			
			<div style="width:100%;height:100px;background-color:black;color:red;text-align:justify;">
				<p>Welcome <%out.print(session.getAttribute("sessionattr"));%></p>			
				<p style="color:white;text-align:center">&copy;pAnalyticsTech Solutions. All Rights Reserved.</p>
			</div>
		</div>
	</body>
</html>