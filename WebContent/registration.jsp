<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
   		<title>Registration</title>
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
	   	   header{
					padding: 1em;
					color: white;
					background-color: black;
					clear: left;
					text-align: center;
		   		   	}
		   	  nav{
					float: left;
					margin: 0;
					padding: 1em;
			  		}
		   nav ul{
					list-style-type: none;
					padding: 0;
					}
   	  	 nav ul a{
					text-decoration: none;
					}
	   	  article{
					margin-left: 170px;
					padding: 1em;
					overflow: hidden;
					border-left: 1px solid gray;
					}
	@media (max-width: 767px){
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
					<form style="width:40%" action="tryregister" method="POST">
						<div class="form-group">
							<label>First Name</label>
							<input type="text" name="firstname" class="form-control">
						</div>
						<div class="form-group">
							<label>Last Name</label>
							<input type="text" name="lastname" class="form-control">
						</div>
						<div class="form-group">
							<label>Desired UserName</label>
							<input type="text" name="username" class="form-control">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Desired Password</label>
							<input type="password" name="pwd" class="form-control" id="exampleInputPassword1">
						</div>
						<div class="form-group">
							<label>Gender</label>
								<select type="text" name="gender" class="form-control">
									<option value="male">MALE</option>
									<option value="female">FEMALE</option>
								</select>
						</div>
						<div class="form-group">
							<label>Age</label>
							<input type="text" name="age" class="form-control">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Email address</label>
							<input type="email" name="email" class="form-control" id="exampleInputEmail1" placeholder="Email">
						</div>
						<div class="form-group">
							<label>Phone (Optional)</label>
							<input type="text" name="phone" class="form-control">
						</div>
						<div class="form-group">
							<label>Country</label>
								<select type="text" name="nationality" class="form-control">
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
						<button type="submit" class="btn btn-primary">Submit</button>
					</form>
			</article>
			<div style="width:100%;height:100px;background-color:black;color:red;text-align:justify;">
				<p>&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;</p>			
				<p style="color:white;text-align:center">&copy;pAnalyticsTech Solutions. All Rights Reserved. For any comments or messages, please <a style="color:red" href="write_to_hamro.jsp">write</a> to us.
				</p>
			</div>
		</div>
	</body>
</html>