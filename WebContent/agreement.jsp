<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="utf-8">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
   	
		<title>Terms And Agreement</title>

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
								border-right: 1px solid gray;
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
							   }
							
	@media (max-width: 767px) {
								article{
								display:none;
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
					</div>
				</ul>-->
			</nav>
			<article>
				<h1>TERMS AND AGREEMENT</h1>
				<p>The following terms and conditions applies to every registered users who log in to www.upakaar.com</p>
				<p>www.upakaar.com is intended to serve with decency. All the registered users should understand that all the information that they
				provide to www.upakaar.com is upon their will and that they allow www.upakaar.com to utilize such information for business purpose. All the payments
				that are required to be made via www.upakaar.com will be through PayPal. Upakaar.com doesn't provide any additional security on the transactions and
				financial information of the users. However, upakaar.com has strong trust on the services of PayPal. All the registered users are notified that there
				contact information will be utilized by upakaar.com for business but however never be used to harm the registered users. If anything harmful occurs to
				registered users, they should immediately notify upakaar.com and work together with upakaar.com to resolve the matter.</p>
				
				<p>Upakaar.com will utilize SSL Security Certificate to encrypt the data that is transferred between user's browser and the server. This is the maximum
				level of data encryption security that will be implemented. However, this feature will not be included during the pre-release version until the day that
				upakaar.com notifies of such service being implemented.</p>
				
				<p>All the registered users agree (by signing in) that they will not sue upakaar.com for any matter in the court without first discussing the issue
				with upakaar.com via email. Upakaar.com will always collaborate with the registered user to resolve the matter and avoid court and legal cases.</p>
				
				<p>Upakaar.com is an open source project for all Indian nationals interested to participate. The professionals accepted include - Analysts, Developers, Web Designers, Testers, Data Engineers. Please contact
				 exec_rep@pandtek.com to apply and work at Upakaar.com. Let's take ourselves to the next level.</p>
			</article>
			
			<footer style="color:red">&#2360;&#2381;&#2357;&#2366;&#2327;&#2340;&#0032;&#2331;</footer>
			
		</div>
	</body>
</html>