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
				<h1 style="color:red">&#2313;&#2346;&#2325;&#2366;&#2352;</h1>
			</header>
			<nav>
				<ul>
					<div class="list-group">
						<a href="main.jsp" class="list-group-item" style="background-color:black;color:red;font-weight:bold">Back</a>
					</div>
				</ul>
				<ul>
					<div class="list-group">
						<a style="color:black;font-weight:bold" href="#" class="list-group-item disabled">Order Info:</a>
						<p class="list-group-item">Transaction ID: ${result.txn_id }<br>
						Name: ${result.first_name } ${result.last_name }<br>
						<!-- Last Name: ${result.last_name }<br>-->
						Email: ${result.payer_email }<br>
						Payment Gross: ${result.payment_gross }
						
					</div>
				</ul>
			</nav>
			<article>
				<form style="width:40%" action="postjob" method="POST">
					<div class="form-group">
						<label>Posted By</label>
						<input type="text" name="postedby" class="form-control" required>
					</div>
					<div class="form-group">
						<label>Job Description</label>
						<textarea name="jobdesc" cols="50" rows="5" class="form-control" required></textarea>	
					</div>
					<div class="form-group">
						<label>Location</label>
						<input type="text" name="joblocation" class="form-control" required>
					</div>
					<div class="form-group">
						<label>Country</label>
							<select type="text" name="nationality" class="form-control" required>
								<option value="USA">USA</option>
								<option value="CANADA">CANADA</option>
								<option value="UK">UK</option>
								<option value="AUSTRALIA">AUSTRALIA</option>
								<option value="EUROPE">EUROPE</option>
								<option value="JAPAN">JAPAN</option>
								<option value="NEPAL">NEPAL</option>
								<option value="INDIA">INDIA</option>
								<option value="OTHER">OTHER</option>
							</select>
					</div>
					<div class="form-group">
						<label>Contact Phone</label>
						<input type="text" name="phone" class="form-control" required>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">Email address</label>
						<input type="email" name="contactemail" class="form-control" id="exampleInputEmail1" placeholder="Email" required>
					</div>
					<div class="form-group">
						<label>Other Info</label>
						<textarea name="otherinfo" cols="50" rows="5" class="form-control" required></textarea>	
					</div>
					<button type="submit" class="btn btn-primary">Post Your Job</button>
				</form>
			</article>
			<div style="width:100%;height:100px;background-color:black;color:red;text-align:justify;">
				<p>Welcome</p>	
							
				<p style="color:white;text-align:center">&copy;pAnalyticsTech Solutions. All Rights Reserved.</p>
				
			</div>
		</div>
	</body>
</html>