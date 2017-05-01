<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
   
		<title>Payment</title>
		
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
				<h1 style="color:red">&#2344;&#2350;&#2360;&#2381;&#2325;&#2366;&#2352;</h1>
			</header>
			<nav>
				<ul>
					<div class="list-group">
						<a href="main.jsp" class="list-group-item" style="background-color:black;color:red;font-weight:bold">Back</a>
					</div>
				</ul>
				<ul>
			</nav>
			
			<article>
				<h1>Milan/Vivah Membership</h1>
				
				<p>Membership is monthly only and each months costs 6.99 USD. Membership has to be renewed after month if interested to proceed.</p>
				<p>Monthly charge is non-refundable and non-cancellable under any circumstances including temporary/permanent shut down of Milan/Vivah.</p>
				<p>Hamroaafno.com wishes every member good luck in finding suitable life-partner.</p>
				
				
				<form method="post" action="${initParam['posturl']}">
					<input type="hidden" name="upload" value="1" /> 
					<input type="hidden" name="return" value="${initParam['returnurl2']}" /> 
					<input type="hidden" name="cmd" value="_cart" /> 
					<input type="hidden" name="business" value="${initParam['business']}" />
					<!-- Post 1  -->
					<input type="hidden" name="item_name_1" value="Milan/Vivah Membership" />
					<input type="hidden" name="item_number_1" value="Monthly Payment" />
					<input type="hidden" name="amount_1" value="0.01" />
					<input type="hidden" name="quantity_1" value="1" />
	
					<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif"> 
				</form>
			</article>
			
			<div style="width:100%;height:100px;background-color:black;color:red;text-align:justify;">
				<p>&#2360;&#2381;&#2357;&#2366;&#2327;&#2340;&#0032;&#2331; <%out.print(session.getAttribute("sessionattr"));%></p>			
				<p style="color:white;text-align:center">&copy;pAnalyticsTech Solutions. All Rights Reserved.</p>
				
			</div>

	</body>
</html>