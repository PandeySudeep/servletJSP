<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

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
					      nav {
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
							  
				   #msg_header{
								font-size:0.75em;
								font-weight:bold;
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
						<a href="checkprofileforpicchange" class="list-group-item">Change Profile Pic</a>
						<a href="checkprofileforpicchange2" class="list-group-item">Change Second Pic</a>
						<a href="checkprofileforpicchange3" class="list-group-item">Change Third Pic</a>
					</div>
				</ul>
			</nav>
			<article>
				<form style="width:40%" action="updateprofile" method="POST">
					<div class="form-group">
						<label>Update</label>
							<select type="text" name="updatecolumn" class="form-control">
								<option value="NICKNAME">NICKNAME</option>
								<option value="AGE">AGE</option>
								<option value="EMAIL">EMAIL</option>
								<option value="ADDRESS">ADDRESS</option>
								<option value="HOBBY">HOBBY</option>
								<option value="LOOKING_FOR">What I'm Looking for</option>
								<option value="ABOUT">About Myself</option>
								<option value="LIFE_IS">According to me, life is</option>
								<option value="FAV_QUOTE">Favorite Quote</option>
								<option value="OTHER_INFO">Miscellaneous Info about myself</option>
							</select>
					</div>
					
					<div class="form-group">
						<label>Enter Update</label>
						<textarea name="entry" cols="50" rows="5" class="form-control"></textarea>	
					</div>
										
					<button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</article>
			<footer style="width:100%;height:100px;background-color:black;color:red;text-align:justify;">
				<p>Welcome <%out.print(session.getAttribute("sessionattr"));%></p>			
				<p style="color:white;text-align:center">&copy;pAnalyticsTech Solutions. All Rights Reserved.</p>
			</footer>
		</div>
	</body>
</html>