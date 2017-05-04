<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
   	
   		<title>&#2313;&#2346;&#2325;&#2366;&#2352;</title>
	
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
				<h1 style="color:red">&#2344;&#2350;&#2360;&#2381;&#2325;&#2366;&#2352;</h1>
			</header>
			
				
				<nav>
				<ul>
					<div class="list-group">
						
						<a href="welcome.jsp" class="list-group-item" style="background-color:black;color:red;font-weight:bold">Back</a>
					</div>
				</ul>
			</nav>
			<article>
				<h1 id="msg_header">Send Message To Upakaar</h1>
				<form action="messageforme" method="POST">
					<div class="form-group">
						<label>Please include in your message- your name, email, phone number:</label>
						<textarea name="message" cols="50" rows="5" class="form-control"></textarea>	
						
						<button type="submit" class="btn btn-primary">Send</button>

					</div>
				</form>
					
			</article>
			
			<footer style="color:red">&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;</footer>
			
		</div>
</body>
</html>