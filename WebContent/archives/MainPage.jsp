<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<header>
Welcome!!
<%=session.getAttribute("sessionattr") %>
		<h2><font size="12"><center>&#2361;&#2366;&#2350;&#2381;&#2352;&#2379;&#0032;&#2310;&#2347;&#2381;&#2344;&#2379;</center></font></h2>
</header>
	
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
#postjob { 
	position: absolute;
	visibility: visible;
	left: 120px; 
	top: 450px;
	height: 100px;
	width: 350px;
	z-index: 200; 
}
#date { 
	position: absolute;
	visibility: visible;
	left: 520px; 
	top: 650px;
	height: 100px;
	width: 350px;
	z-index: 200; 
}
#findjobs { 
	position: absolute;
	visibility: visible;
	left: 520px; 
	top: 100px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}
#findrooms { 
	position: absolute;
	visibility: visible;
	left: 920px; 
	top: 100px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}
#sendmsg { 
	position: absolute;
	visibility: visible;
	left: 220px; 
	top: 50px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}
#momoparty { 
	position: absolute;
	visibility: visible;
	left: 320px; 
	top: 300px;
	height: 200px;
	width: 350px;
	z-index: 200; 
	}
#dating { 
	position: absolute;
	visibility: visible;
	left: 820px; 
	top:600px;
	height: 200px;
	width: 350px;
	z-index: 200; 
	}
#matrimony { 
	position: absolute;
	visibility: visible;
	left: 920px; 
	top:200px;
	height: 200px;
	width: 350px;
	z-index: 200; 
	}
#postaccomodation { 
	position: absolute;
	visibility: visible;
	left: 620px; 
	top: 300px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}
#profileview{ 
	position: absolute;
	visibility: visible;
	left: 420px; 
	top: 600px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}
#profileedit{ 
	position: absolute;
	visibility: visible;
	left: 620px; 
	top: 600px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}
#profiledelete{ 
	position: absolute;
	visibility: visible;
	left: 920px; 
	top: 400px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}
#profilepicchange{ 
	position: absolute;
	visibility: visible;
	left: 620px; 
	top: 700px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}
#secondpicchange{ 
	position: absolute;
	visibility: visible;
	left: 620px; 
	top: 740px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}
#thirdpicchange{ 
	position: absolute;
	visibility: visible;
	left: 760px; 
	top: 740px;
	height: 200px;
	width: 450px;
	z-index: 200; 
}
#contactprofessionals { 
	position: absolute;
	visibility: visible;
	left: 1220px; 
	top: 600px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}
#registerasprofessionals { 
	position: absolute;
	visibility: visible;
	left: 1320px; 
	top: 200px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}
#milanprofilesearch { 
	position: absolute;
	visibility: visible;
	left: 0px; 
	top: 350px;
	height: 200px;
	width: 350px;
	z-index: 200; 
}

</style>

  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#datepicker" ).datepicker();
  } );
  </script>
  <script>
  $( function() {
    $( "#datepicker2" ).datepicker();
  } );
  </script>
</head>
<body>


<div style="position:fixed;bottom:2px;">
<form action="jobslist" method="POST">
Posted Date:<br><input type="text" name="posteddate" id="datepicker"><br>
<input type="submit" value="Find Jobs">
			</form></div>
 
<div id="findrooms">
<form action="roomslist" method="POST">
Posted Date:<br><input type="text" name="posteddate" id="datepicker2"><br>
<input type="submit" value="Find Rooms/Apartments">
			</form></div>

<div style="positon:fixed;bottom:5px;right:2px;">
    <form action="postjob" method="POST">
  Posted By:<br><input type="text" name="postedby"><br>
  Job Description:<br><input type="text" name="jobdesc"><br>
  Location:<br><input type="text" name="joblocation"><br>
  Contact Phone:<br><input type="text" name="phone"><br>
  Contact Email:<br><input type="text" name="contactemail"><br>
  Other Info:<br><input type="text" name="otherinfo"><br>
  <input type="submit" value="Post Your Job">
			</form></div>
						
<div  id="sendmsg">
   <form action="msgtoeveryone" method="POST">
            To All Nepalese residing in:<br>
            <select name="country">
				<option value="USA">USA</option>
				<option value="UK">UK</option>
			    <option value="AUSTRALIA">AUSTRALIA</option>
			    <option value="CANADA">CANADA</option>
			    <option value="OTHER">OTHER</option>
			</select>
			<br>
  Message:<br><input type="text" name="msg"><br>
   <input type="submit" value="Send Email to all Nepalese">
			</form>
    
</div>


<div><a href="datingsite.html">Create</a></div>

<div><a href="deletemyprofile">Delete My Profile</a></div>


<div><a href="viewmyprofile">View My Profile</a></div>

<div><a href="editmyprofile">Edit My Profile</a></div>

<div><a href="checkprofileforpicchange">Change profile pic</a></div>

<div><a href="checkprofileforpicchange2">Change second pic</a></div>

<div><a href="checkprofileforpicchange3">Change third pic</a></div>

<div><a href="respondtorequest">View Requests/Respond</a></div>

<div><a href="listacceptors">My Contacts/Send Email</a></div>

<div id="milanprofilesearch">
<form action="milanprofilelist" method="POST">
Gender:<select name="gender">
				<option value="male">MALE</option>
				<option value="female">FEMALE</option>
			    </select> </br>
			    Age between:<input type="text" name="minage"> and <input type="text" name="maxage"><input type="submit" value="Show Profiles"></form></div>
			    


<div  id="contactprofessionals">
    
        
            <form action="emailprofessionals" method="POST">
            Contact Nepalese Professionals:<br>
            <select name="profession">
				<option value="lawyers">LAWYERS</option>
				<option value="doctors">DOCTORS</option>
			    <option value="businessmen">BUSINESS OWNERS</option>
			    <option value="students">STUDENTS</option>
			    <option value="others">OTHER</option>
			</select>
			<br>
   Message:<br><input type="text" name="msg"><br>
   <input type="submit" value="Send Email">
			</form>
    
</div>

<div  id="registerasprofessionals">
    <form action="insertprofessional" method="POST">
            Register as Professional:<br>
            
			First Name:<br><input type="text" name="firstname"><br>
			Last Name:<br><input type="text" name="lastname"><br>
			Profession:<br>
			<select name="profession">
				<option value="lawyers">LAWYER</option>
				<option value="doctors">DOCTOR</option>
			    <option value="businessmen">BUSINESS OWNER</option>
				<option value="students">STUDENT</option>
			    <option value="others">OTHER</option>
			</select><br>
			Address:<br><input type="text" name="address"><br>
			Email:<br><input type="text" name="email"><br>
			Phone:<br><input type="text" name="phone"><br>
			Other Details:<br><input type="text" name="otherinfo"><br>
			<input type="submit" value="Get Listed as Professional">
			</form>
    </div>




<div style="position:fixed;left:100px;bottom:2px;">
    
        
            <form action="postroom" method="POST">
  Posted By:<br> <input type="text" name="postedby"><br>
  Description:<br> <input type="text" name="roomdesc"><br>
  Location:<br><input type="text" name="roomlocation"><br>
  Contact Phone:<br><input type="text" name="phone"><br>
  Contact Email:<br><input type="text" name="contactemail"><br>
  Other Info:<br><input type="text" name="otherinfo"><br>
  <input type="submit" value="Post Your Available Room">
			</form>
    
</div>

</body>

</html>