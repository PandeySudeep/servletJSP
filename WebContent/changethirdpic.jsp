<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ page import="java.io.File"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>

<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
    
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
			</nav>
		</div>
		<%
		String usr = (String)session.getAttribute("sessionattr");
		String pwd = (String)session.getAttribute("userpwd");
		FileItemFactory itemfactory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(itemfactory);
		try{
			List<FileItem> items = upload.parseRequest(request);
				for (FileItem item:items)
					{
						String name = "boom";
						if(item.getSize()>102400){//102400
							request.setAttribute("message", "The file size is too large. Please enter file less that 10 KB.");
							request.setAttribute("link","editprofile.jsp");
				%>
				<jsp:forward page="msg_display.jsp"/>   
				<%}else{
					String contentType = item.getContentType();
					if(!contentType.equals("image/jpeg"))
						{
						request.setAttribute("message", "Please upload only jpeg/jpg file type");
						request.setAttribute("link","editprofile.jsp");
					%>
					 <jsp:forward page="msg_display.jsp"/>   
				<%}
			}
			File uploadDir = new File("/home/hamroaa1/my_images");
		%>
		<%//}
			File file = File.createTempFile(name,".jpg",uploadDir);
			item.write(file);
			File[] files = uploadDir.listFiles();
			String filecheck=null;
			for (File f : files)
				{
		    		if(f.getName().startsWith(usr+pwd+"sagarmatha2"))
		    			{
		      				f.delete();
		     				}
					}
		
			for(File f : files)
				{
					if(f.getName().startsWith("boom"))
						{
							f.renameTo(new File("/home/hamroaa1/my_images/"+usr+pwd+"sagarmatha2.jpg"));
						}
				}
			  request.setAttribute("message", "&#2343;&#2344;&#2381;&#2351;&#2357;&#2366;&#2342;&#2405;");
			  request.setAttribute("link", "editprofile.jsp");
			  RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			  view.forward(request,response);
			//out.print("success");
		}
		}catch(FileUploadException fe){
			out.print("upload failed");
		}catch(Exception e){
			out.print("can't save"+e.getMessage());
		}%>
	</body>
</html>