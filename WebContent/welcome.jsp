<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<html>

	<head>
		<meta charset="utf-8">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
   	
   		<title>&#2313;&#2346;&#2325;&#2366;&#2352;</title>
	
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/sagarmatha_styles.css" rel="stylesheet">
		<link href='https://fonts.googleapis.com/css?family=Oxygen:400,300,700' rel='stylesheet' type='text/css'>
	</head>
	
	<body>
	<%!
	    Connection con = null;
		Statement stmt = null;
		DataSource dataSource = null;
		ResultSet othrs1,othrs2,othrs3,othrs4,othrs5,othrs6,othrs7,othrs8,othrs9,othrs10,neprs1,neprs2,neprs3,neprs4,neprs5,neprs6,neprs7,neprs8,neprs9,neprs10,indrs1,indrs2,indrs3,indrs4,indrs5,indrs6,indrs7,indrs8,indrs9,indrs10,jprs1,jprs2,jprs3,jprs4,jprs5,jprs6,jprs7,jprs8,jprs9,jprs10,eurs1,eurs2,eurs3,eurs4,eurs5,eurs6,eurs7,eurs8,eurs9,eurs10,ausrs1,ausrs2,ausrs3,ausrs4,ausrs5,ausrs6,ausrs7,ausrs8,ausrs9,ausrs10,cars1,cars2,cars3,cars4,cars5,cars6,cars7,cars8,cars9,cars10,ukrs1,ukrs2,ukrs3,ukrs4,ukrs5,ukrs6,ukrs7,ukrs8,ukrs9,ukrs10,usrs1,usrs2,usrs3,usrs4,usrs5,usrs6,usrs7,usrs8,usrs9,usrs10,rs1,rs2,rs3,rs4,rs5,rs6,rs7,rs8,rs9,rs10 = null;
	%>
	<%!
		int tot_reg_usrs_m,tot_reg_usrs_m_US, tot_reg_usrs_m_UK, tot_reg_usrs_m_CA, tot_reg_usrs_m_AUS,tot_reg_usrs_m_EU,tot_reg_usrs_m_JP,tot_reg_usrs_m_IND,tot_reg_usrs_m_NEP,tot_reg_usrs_m_OTH= 0;
		int tot_reg_usrs_f, tot_reg_usrs_f_US, tot_reg_usrs_f_UK, tot_reg_usrs_f_CA,tot_reg_usrs_f_AUS,tot_reg_usrs_f_EU,tot_reg_usrs_f_JP,tot_reg_usrs_f_IND,tot_reg_usrs_f_NEP,tot_reg_usrs_f_OTH = 0;
		int tot_mil_usrs_m= 0;
		int tot_mil_usrs_f= 0;
		int tot_lyrs, tot_lyrs_US, tot_lyrs_UK, tot_lyrs_CA,tot_lyrs_AUS,tot_lyrs_EU,tot_lyrs_JP,tot_lyrs_IND,tot_lyrs_NEP,tot_lyrs_OTH=0;
		int tot_docs, tot_docs_US,tot_docs_UK, tot_docs_CA,tot_docs_AUS,tot_docs_EU,tot_docs_JP,tot_docs_IND,tot_docs_NEP,tot_docs_OTH = 0;
		int tot_stds, tot_stds_US,tot_stds_UK, tot_stds_CA,tot_stds_AUS,tot_stds_EU,tot_stds_JP,tot_stds_IND,tot_stds_NEP,tot_stds_OTH = 0;
		int tot_bus_prfs, tot_bus_prfs_US,tot_bus_prfs_UK, tot_bus_prfs_CA,tot_bus_prfs_AUS,tot_bus_prfs_EU,tot_bus_prfs_JP,tot_bus_prfs_IND,tot_bus_prfs_NEP,tot_bus_prfs_OTH = 0;
		int tot_oth_prfs, tot_oth_prfs_US, tot_oth_prfs_UK, tot_oth_prfs_CA,tot_oth_prfs_AUS,tot_oth_prfs_EU,tot_oth_prfs_JP,tot_oth_prfs_IND,tot_oth_prfs_NEP,tot_oth_prfs_OTH = 0;
		int tot_jobs, tot_jobs_US,tot_jobs_UK, tot_jobs_CA,tot_jobs_AUS,tot_jobs_EU,tot_jobs_JP,tot_jobs_IND,tot_jobs_NEP,tot_jobs_OTH = 0;
	%>
	<%!public void jspInit(){
		
		
	    try {
			// Get DataSource
			Context initContext  = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("jdbc/hamroaa1_hamro_db");

		}catch (NamingException e) {
				e.printStackTrace();
			}
	  }
	%>
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
	<%
			String usr = (String)session.getAttribute("sessionattr");
			String pwd = (String)session.getAttribute("userpwd");
			
			String query1 = "SELECT COUNT(*) AS \"TOTAL MALE USERS\" FROM registered_users WHERE GENDER = \"male\";";
			String query2 = "SELECT COUNT(*) AS \"TOTAL FEMALE USERS\" FROM registered_users WHERE GENDER = \"female\";";
			String query3 = "SELECT COUNT(*) AS \"TOTAL MALE VIV USERS\" FROM dating_profile WHERE GENDER = \"male\";";
			String query4 = "SELECT COUNT(*) AS \"TOTAL FEMALE VIV USERS\" FROM dating_profile WHERE GENDER = \"female\";";
			String query5 = "SELECT COUNT(*) AS \"TOTAL LAWYERS\" FROM professionals WHERE PROFESSION = \"lawyers\";";
			String query6 = "SELECT COUNT(*) AS \"TOTAL DOCTORS\" FROM professionals WHERE PROFESSION = \"doctors\";";
			String query7 = "SELECT COUNT(*) AS \"TOTAL BSNSMEN\" FROM professionals WHERE PROFESSION = \"businessmen\";";
			String query8 = "SELECT COUNT(*) AS \"TOTAL STUDENTS\" FROM professionals WHERE PROFESSION = \"students\";";
			String query9 = "SELECT COUNT(*) AS \"TOTAL OTHER PROFS\" FROM professionals WHERE PROFESSION = \"others\";";
			String query10 = "SELECT COUNT(*) AS \"TOTAL JOBS\" FROM job_postings WHERE POSTED_DATE >= CURDATE()-INTERVAL 30 DAY;";
			
			String us_query1 = "SELECT COUNT(*) AS \"TOTAL MALE USERS\" FROM registered_users WHERE GENDER = \"male\" AND NATIONALITY=\"USA\";";
			String us_query2 = "SELECT COUNT(*) AS \"TOTAL FEMALE USERS\" FROM registered_users WHERE GENDER = \"female\" AND NATIONALITY=\"USA\";";
			//String us_query3 = "SELECT COUNT(*) AS \"TOTAL MALE VIV USERS\" FROM dating_profile WHERE GENDER = \"male\" AND COUNTRY=\"USA\";";
			//String us_query4 = "SELECT COUNT(*) AS \"TOTAL FEMALE VIV USERS\" FROM dating_profile WHERE GENDER = \"female\" AND COUNTRY=\"USA\";";
			String us_query5 = "SELECT COUNT(*) AS \"TOTAL LAWYERS\" FROM professionals WHERE PROFESSION = \"lawyers\" AND COUNTRY=\"USA\";";
			String us_query6 = "SELECT COUNT(*) AS \"TOTAL DOCTORS\" FROM professionals WHERE PROFESSION = \"doctors\" AND COUNTRY=\"USA\";";
			String us_query7 = "SELECT COUNT(*) AS \"TOTAL BSNSMEN\" FROM professionals WHERE PROFESSION = \"businessmen\" AND COUNTRY=\"USA\";";
			String us_query8 = "SELECT COUNT(*) AS \"TOTAL STUDENTS\" FROM professionals WHERE PROFESSION = \"students\" AND COUNTRY=\"USA\";";
			String us_query9 = "SELECT COUNT(*) AS \"TOTAL OTHER PROFS\" FROM professionals WHERE PROFESSION = \"others\" AND COUNTRY=\"USA\";";
			String us_query10 = "SELECT COUNT(*) AS \"TOTAL JOBS\" FROM job_postings WHERE POSTED_DATE >= CURDATE()-INTERVAL 30 DAY AND COUNTRY=\"USA\";";
			
			String uk_query1 = "SELECT COUNT(*) AS \"TOTAL MALE USERS\" FROM registered_users WHERE GENDER = \"male\" AND NATIONALITY=\"UK\";";
			String uk_query2 = "SELECT COUNT(*) AS \"TOTAL FEMALE USERS\" FROM registered_users WHERE GENDER = \"female\" AND NATIONALITY=\"UK\";";
			//String us_query3 = "SELECT COUNT(*) AS \"TOTAL MALE VIV USERS\" FROM dating_profile WHERE GENDER = \"male\" AND COUNTRY=\"USA\";";
			//String us_query4 = "SELECT COUNT(*) AS \"TOTAL FEMALE VIV USERS\" FROM dating_profile WHERE GENDER = \"female\" AND COUNTRY=\"USA\";";
			String uk_query5 = "SELECT COUNT(*) AS \"TOTAL LAWYERS\" FROM professionals WHERE PROFESSION = \"lawyers\" AND COUNTRY=\"UK\";";
			String uk_query6 = "SELECT COUNT(*) AS \"TOTAL DOCTORS\" FROM professionals WHERE PROFESSION = \"doctors\" AND COUNTRY=\"UK\";";
			String uk_query7 = "SELECT COUNT(*) AS \"TOTAL BSNSMEN\" FROM professionals WHERE PROFESSION = \"businessmen\" AND COUNTRY=\"UK\";";
			String uk_query8 = "SELECT COUNT(*) AS \"TOTAL STUDENTS\" FROM professionals WHERE PROFESSION = \"students\" AND COUNTRY=\"UK\";";
			String uk_query9 = "SELECT COUNT(*) AS \"TOTAL OTHER PROFS\" FROM professionals WHERE PROFESSION = \"others\" AND COUNTRY=\"UK\";";
			String uk_query10 = "SELECT COUNT(*) AS \"TOTAL JOBS\" FROM job_postings WHERE POSTED_DATE >= CURDATE()-INTERVAL 30 DAY AND COUNTRY=\"UK\";";
			
			String ca_query1 = "SELECT COUNT(*) AS \"TOTAL MALE USERS\" FROM registered_users WHERE GENDER = \"male\" AND NATIONALITY=\"CANADA\";";
			String ca_query2 = "SELECT COUNT(*) AS \"TOTAL FEMALE USERS\" FROM registered_users WHERE GENDER = \"female\" AND NATIONALITY=\"CANADA\";";
			//String us_query3 = "SELECT COUNT(*) AS \"TOTAL MALE VIV USERS\" FROM dating_profile WHERE GENDER = \"male\" AND COUNTRY=\"USA\";";
			//String us_query4 = "SELECT COUNT(*) AS \"TOTAL FEMALE VIV USERS\" FROM dating_profile WHERE GENDER = \"female\" AND COUNTRY=\"USA\";";
			String ca_query5 = "SELECT COUNT(*) AS \"TOTAL LAWYERS\" FROM professionals WHERE PROFESSION = \"lawyers\" AND COUNTRY=\"CANADA\";";
			String ca_query6 = "SELECT COUNT(*) AS \"TOTAL DOCTORS\" FROM professionals WHERE PROFESSION = \"doctors\" AND COUNTRY=\"CANADA\";";
			String ca_query7 = "SELECT COUNT(*) AS \"TOTAL BSNSMEN\" FROM professionals WHERE PROFESSION = \"businessmen\" AND COUNTRY=\"CANADA\";";
			String ca_query8 = "SELECT COUNT(*) AS \"TOTAL STUDENTS\" FROM professionals WHERE PROFESSION = \"students\" AND COUNTRY=\"CANADA\";";
			String ca_query9 = "SELECT COUNT(*) AS \"TOTAL OTHER PROFS\" FROM professionals WHERE PROFESSION = \"others\" AND COUNTRY=\"CANADA\";";
			String ca_query10 = "SELECT COUNT(*) AS \"TOTAL JOBS\" FROM job_postings WHERE POSTED_DATE >= CURDATE()-INTERVAL 30 DAY AND COUNTRY=\"CANADA\";";
			

			String aus_query1 = "SELECT COUNT(*) AS \"TOTAL MALE USERS\" FROM registered_users WHERE GENDER = \"male\" AND NATIONALITY=\"AUSTRALIA\";";
			String aus_query2 = "SELECT COUNT(*) AS \"TOTAL FEMALE USERS\" FROM registered_users WHERE GENDER = \"female\" AND NATIONALITY=\"AUSTRALIA\";";
			//String us_query3 = "SELECT COUNT(*) AS \"TOTAL MALE VIV USERS\" FROM dating_profile WHERE GENDER = \"male\" AND COUNTRY=\"USA\";";
			//String us_query4 = "SELECT COUNT(*) AS \"TOTAL FEMALE VIV USERS\" FROM dating_profile WHERE GENDER = \"female\" AND COUNTRY=\"USA\";";
			String aus_query5 = "SELECT COUNT(*) AS \"TOTAL LAWYERS\" FROM professionals WHERE PROFESSION = \"lawyers\" AND COUNTRY=\"AUSTRALIA\";";
			String aus_query6 = "SELECT COUNT(*) AS \"TOTAL DOCTORS\" FROM professionals WHERE PROFESSION = \"doctors\" AND COUNTRY=\"AUSTRALIA\";";
			String aus_query7 = "SELECT COUNT(*) AS \"TOTAL BSNSMEN\" FROM professionals WHERE PROFESSION = \"businessmen\" AND COUNTRY=\"AUSTRALIA\";";
			String aus_query8 = "SELECT COUNT(*) AS \"TOTAL STUDENTS\" FROM professionals WHERE PROFESSION = \"students\" AND COUNTRY=\"AUSTRALIA\";";
			String aus_query9 = "SELECT COUNT(*) AS \"TOTAL OTHER PROFS\" FROM professionals WHERE PROFESSION = \"others\" AND COUNTRY=\"AUSTRALIA\";";
			String aus_query10 = "SELECT COUNT(*) AS \"TOTAL JOBS\" FROM job_postings WHERE POSTED_DATE >= CURDATE()-INTERVAL 30 DAY AND COUNTRY=\"AUSTRALIA\";";
			
			
			String eu_query1 = "SELECT COUNT(*) AS \"TOTAL MALE USERS\" FROM registered_users WHERE GENDER = \"male\" AND NATIONALITY=\"EUROPE\";";
			String eu_query2 = "SELECT COUNT(*) AS \"TOTAL FEMALE USERS\" FROM registered_users WHERE GENDER = \"female\" AND NATIONALITY=\"EUROPE\";";
			//String us_query3 = "SELECT COUNT(*) AS \"TOTAL MALE VIV USERS\" FROM dating_profile WHERE GENDER = \"male\" AND COUNTRY=\"USA\";";
			//String us_query4 = "SELECT COUNT(*) AS \"TOTAL FEMALE VIV USERS\" FROM dating_profile WHERE GENDER = \"female\" AND COUNTRY=\"USA\";";
			String eu_query5 = "SELECT COUNT(*) AS \"TOTAL LAWYERS\" FROM professionals WHERE PROFESSION = \"lawyers\" AND COUNTRY=\"EUROPE\";";
			String eu_query6 = "SELECT COUNT(*) AS \"TOTAL DOCTORS\" FROM professionals WHERE PROFESSION = \"doctors\" AND COUNTRY=\"EUROPE\";";
			String eu_query7 = "SELECT COUNT(*) AS \"TOTAL BSNSMEN\" FROM professionals WHERE PROFESSION = \"businessmen\" AND COUNTRY=\"EUROPE\";";
			String eu_query8 = "SELECT COUNT(*) AS \"TOTAL STUDENTS\" FROM professionals WHERE PROFESSION = \"students\" AND COUNTRY=\"EUROPE\";";
			String eu_query9 = "SELECT COUNT(*) AS \"TOTAL OTHER PROFS\" FROM professionals WHERE PROFESSION = \"others\" AND COUNTRY=\"EUROPE\";";
			String eu_query10 = "SELECT COUNT(*) AS \"TOTAL JOBS\" FROM job_postings WHERE POSTED_DATE >= CURDATE()-INTERVAL 30 DAY AND COUNTRY=\"EUROPE\";";
			
			String jp_query1 = "SELECT COUNT(*) AS \"TOTAL MALE USERS\" FROM registered_users WHERE GENDER = \"male\" AND NATIONALITY=\"JAPAN\";";
			String jp_query2 = "SELECT COUNT(*) AS \"TOTAL FEMALE USERS\" FROM registered_users WHERE GENDER = \"female\" AND NATIONALITY=\"JAPAN\";";
			//String us_query3 = "SELECT COUNT(*) AS \"TOTAL MALE VIV USERS\" FROM dating_profile WHERE GENDER = \"male\" AND COUNTRY=\"USA\";";
			//String us_query4 = "SELECT COUNT(*) AS \"TOTAL FEMALE VIV USERS\" FROM dating_profile WHERE GENDER = \"female\" AND COUNTRY=\"USA\";";
			String jp_query5 = "SELECT COUNT(*) AS \"TOTAL LAWYERS\" FROM professionals WHERE PROFESSION = \"lawyers\" AND COUNTRY=\"JAPAN\";";
			String jp_query6 = "SELECT COUNT(*) AS \"TOTAL DOCTORS\" FROM professionals WHERE PROFESSION = \"doctors\" AND COUNTRY=\"JAPAN\";";
			String jp_query7 = "SELECT COUNT(*) AS \"TOTAL BSNSMEN\" FROM professionals WHERE PROFESSION = \"businessmen\" AND COUNTRY=\"JAPAN\";";
			String jp_query8 = "SELECT COUNT(*) AS \"TOTAL STUDENTS\" FROM professionals WHERE PROFESSION = \"students\" AND COUNTRY=\"JAPAN\";";
			String jp_query9 = "SELECT COUNT(*) AS \"TOTAL OTHER PROFS\" FROM professionals WHERE PROFESSION = \"others\" AND COUNTRY=\"JAPAN\";";
			String jp_query10 = "SELECT COUNT(*) AS \"TOTAL JOBS\" FROM job_postings WHERE POSTED_DATE >= CURDATE()-INTERVAL 30 DAY AND COUNTRY=\"JAPAN\";";
			
			
			String ind_query1 = "SELECT COUNT(*) AS \"TOTAL MALE USERS\" FROM registered_users WHERE GENDER = \"male\" AND NATIONALITY=\"INDIA\";";
			String ind_query2 = "SELECT COUNT(*) AS \"TOTAL FEMALE USERS\" FROM registered_users WHERE GENDER = \"female\" AND NATIONALITY=\"INDIA\";";
			//String us_query3 = "SELECT COUNT(*) AS \"TOTAL MALE VIV USERS\" FROM dating_profile WHERE GENDER = \"male\" AND COUNTRY=\"USA\";";
			//String us_query4 = "SELECT COUNT(*) AS \"TOTAL FEMALE VIV USERS\" FROM dating_profile WHERE GENDER = \"female\" AND COUNTRY=\"USA\";";
			String ind_query5 = "SELECT COUNT(*) AS \"TOTAL LAWYERS\" FROM professionals WHERE PROFESSION = \"lawyers\" AND COUNTRY=\"INDIA\";";
			String ind_query6 = "SELECT COUNT(*) AS \"TOTAL DOCTORS\" FROM professionals WHERE PROFESSION = \"doctors\" AND COUNTRY=\"INDIA\";";
			String ind_query7 = "SELECT COUNT(*) AS \"TOTAL BSNSMEN\" FROM professionals WHERE PROFESSION = \"businessmen\" AND COUNTRY=\"INDIA\";";
			String ind_query8 = "SELECT COUNT(*) AS \"TOTAL STUDENTS\" FROM professionals WHERE PROFESSION = \"students\" AND COUNTRY=\"INDIA\";";
			String ind_query9 = "SELECT COUNT(*) AS \"TOTAL OTHER PROFS\" FROM professionals WHERE PROFESSION = \"others\" AND COUNTRY=\"INDIA\";";
			String ind_query10 = "SELECT COUNT(*) AS \"TOTAL JOBS\" FROM job_postings WHERE POSTED_DATE >= CURDATE()-INTERVAL 30 DAY AND COUNTRY=\"INDIA\";";
			
			
			String nep_query1 = "SELECT COUNT(*) AS \"TOTAL MALE USERS\" FROM registered_users WHERE GENDER = \"male\" AND NATIONALITY=\"NEPAL\";";
			String nep_query2 = "SELECT COUNT(*) AS \"TOTAL FEMALE USERS\" FROM registered_users WHERE GENDER = \"female\" AND NATIONALITY=\"NEPAL\";";
			//String us_query3 = "SELECT COUNT(*) AS \"TOTAL MALE VIV USERS\" FROM dating_profile WHERE GENDER = \"male\" AND COUNTRY=\"USA\";";
			//String us_query4 = "SELECT COUNT(*) AS \"TOTAL FEMALE VIV USERS\" FROM dating_profile WHERE GENDER = \"female\" AND COUNTRY=\"USA\";";
			String nep_query5 = "SELECT COUNT(*) AS \"TOTAL LAWYERS\" FROM professionals WHERE PROFESSION = \"lawyers\" AND COUNTRY=\"NEPAL\";";
			String nep_query6 = "SELECT COUNT(*) AS \"TOTAL DOCTORS\" FROM professionals WHERE PROFESSION = \"doctors\" AND COUNTRY=\"NEPAL\";";
			String nep_query7 = "SELECT COUNT(*) AS \"TOTAL BSNSMEN\" FROM professionals WHERE PROFESSION = \"businessmen\" AND COUNTRY=\"NEPAL\";";
			String nep_query8 = "SELECT COUNT(*) AS \"TOTAL STUDENTS\" FROM professionals WHERE PROFESSION = \"students\" AND COUNTRY=\"NEPAL\";";
			String nep_query9 = "SELECT COUNT(*) AS \"TOTAL OTHER PROFS\" FROM professionals WHERE PROFESSION = \"others\" AND COUNTRY=\"NEPAL\";";
			String nep_query10 = "SELECT COUNT(*) AS \"TOTAL JOBS\" FROM job_postings WHERE POSTED_DATE >= CURDATE()-INTERVAL 30 DAY AND COUNTRY=\"NEPAL\";";
			
			
			String oth_query1 = "SELECT COUNT(*) AS \"TOTAL MALE USERS\" FROM registered_users WHERE GENDER = \"male\" AND NATIONALITY=\"OTHERL\";";
			String oth_query2 = "SELECT COUNT(*) AS \"TOTAL FEMALE USERS\" FROM registered_users WHERE GENDER = \"female\" AND NATIONALITY=\"OTHER\";";
			//String us_query3 = "SELECT COUNT(*) AS \"TOTAL MALE VIV USERS\" FROM dating_profile WHERE GENDER = \"male\" AND COUNTRY=\"USA\";";
			//String us_query4 = "SELECT COUNT(*) AS \"TOTAL FEMALE VIV USERS\" FROM dating_profile WHERE GENDER = \"female\" AND COUNTRY=\"USA\";";
			String oth_query5 = "SELECT COUNT(*) AS \"TOTAL LAWYERS\" FROM professionals WHERE PROFESSION = \"lawyers\" AND COUNTRY=\"OTHER\";";
			String oth_query6 = "SELECT COUNT(*) AS \"TOTAL DOCTORS\" FROM professionals WHERE PROFESSION = \"doctors\" AND COUNTRY=\"OTHER\";";
			String oth_query7 = "SELECT COUNT(*) AS \"TOTAL BSNSMEN\" FROM professionals WHERE PROFESSION = \"businessmen\" AND COUNTRY=\"OTHER\";";
			String oth_query8 = "SELECT COUNT(*) AS \"TOTAL STUDENTS\" FROM professionals WHERE PROFESSION = \"students\" AND COUNTRY=\"OTHER\";";
			String oth_query9 = "SELECT COUNT(*) AS \"TOTAL OTHER PROFS\" FROM professionals WHERE PROFESSION = \"others\" AND COUNTRY=\"OTHER\";";
			String oth_query10 = "SELECT COUNT(*) AS \"TOTAL JOBS\" FROM job_postings WHERE POSTED_DATE >= CURDATE()-INTERVAL 30 DAY AND COUNTRY=\"OTHER\";";
			
			
			try{
					con = dataSource.getConnection();
		    		stmt = con.createStatement();
			
		    		//Global figure starts here
			
					try {
							rs1 = stmt.executeQuery(query1);
							while(rs1.next())
												{
													tot_reg_usrs_m = rs1.getInt("TOTAL MALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=rs1){rs1.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					try {
							rs2 = stmt.executeQuery(query2);
							while(rs2.next())
												{
													tot_reg_usrs_f = rs2.getInt("TOTAL FEMALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=rs2){rs2.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					try {
							rs3 = stmt.executeQuery(query3);
							while(rs3.next())
												{
													tot_mil_usrs_m = rs3.getInt("TOTAL MALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=rs3){rs3.close();}}catch (SQLException e){out.print(e.getMessage());}}
		
					try {
							rs4 = stmt.executeQuery(query4);
							while(rs4.next())
												{
													tot_mil_usrs_f = rs4.getInt("TOTAL FEMALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=rs4){rs4.close();}}catch (SQLException e){out.print(e.getMessage());}}
					
					try {
						rs5 = stmt.executeQuery(query5);
						while(rs5.next())
											{
												tot_lyrs = rs5.getInt("TOTAL LAWYERS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=rs5){rs5.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						rs6 = stmt.executeQuery(query6);
						while(rs6.next())
											{
												tot_docs = rs6.getInt("TOTAL DOCTORS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=rs6){rs6.close();}}catch (SQLException e){out.print(e.getMessage());}}
										
					try {
						rs7 = stmt.executeQuery(query7);
						while(rs7.next())
											{
												tot_bus_prfs = rs7.getInt("TOTAL BSNSMEN");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=rs7){rs7.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						rs8 = stmt.executeQuery(query8);
						while(rs8.next())
											{
												tot_stds = rs8.getInt("TOTAL STUDENTS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=rs8){rs8.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						rs9 = stmt.executeQuery(query9);
						while(rs9.next())
											{
												tot_oth_prfs = rs9.getInt("TOTAL OTHER PROFS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=rs9){rs9.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						rs10 = stmt.executeQuery(query10);
						while(rs10.next())
											{
												tot_jobs = rs10.getInt("TOTAL JOBS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=rs10){rs10.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					//Global figure ends here
					
					
					//USA figure starts here
					
					try {
							usrs1 = stmt.executeQuery(us_query1);
							while(usrs1.next())
												{
													tot_reg_usrs_m_US = usrs1.getInt("TOTAL MALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs1){usrs1.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					try {
							usrs2 = stmt.executeQuery(us_query2);
							while(usrs2.next())
												{
													tot_reg_usrs_f_US = usrs2.getInt("TOTAL FEMALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs2){usrs2.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					/*try {
							usrs3 = stmt.executeQuery(us_query3);
							while(usrs3.next())
												{
													tot_mil_usrs_m_US = usrs3.getInt("TOTAL MALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs3){usrs3.close();}}catch (SQLException e){out.print(e.getMessage());}}
		
					try {
							usrs4 = stmt.executeQuery(us_query4);
							while(usrs4.next())
												{
													tot_mil_usrs_f_US = usrs4.getInt("TOTAL FEMALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs4){usrs4.close();}}catch (SQLException e){out.print(e.getMessage());}}
					*/
					try {
						usrs5 = stmt.executeQuery(us_query5);
						while(usrs5.next())
											{
												tot_lyrs_US = usrs5.getInt("TOTAL LAWYERS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs5){usrs5.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						usrs6 = stmt.executeQuery(us_query6);
						while(usrs6.next())
											{
												tot_docs_US = usrs6.getInt("TOTAL DOCTORS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs6){usrs6.close();}}catch (SQLException e){out.print(e.getMessage());}}
										
					try {
						usrs7 = stmt.executeQuery(us_query7);
						while(usrs7.next())
											{
												tot_bus_prfs_US = usrs7.getInt("TOTAL BSNSMEN");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs7){usrs7.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						usrs8 = stmt.executeQuery(us_query8);
						while(usrs8.next())
											{
												tot_stds_US = usrs8.getInt("TOTAL STUDENTS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs8){usrs8.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						usrs9 = stmt.executeQuery(us_query9);
						while(usrs9.next())
											{
												tot_oth_prfs_US = usrs9.getInt("TOTAL OTHER PROFS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs9){usrs9.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						usrs10 = stmt.executeQuery(us_query10);
						while(usrs10.next())
											{
												tot_jobs_US = usrs10.getInt("TOTAL JOBS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs10){usrs10.close();}}catch (SQLException e){out.print(e.getMessage());}}
					//USA figure ends here
					
					
					//UK figure starts here
					
					try {
							ukrs1 = stmt.executeQuery(uk_query1);
							while(ukrs1.next())
												{
													tot_reg_usrs_m_UK = ukrs1.getInt("TOTAL MALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ukrs1){ukrs1.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					try {
							ukrs2 = stmt.executeQuery(uk_query2);
							while(ukrs2.next())
												{
													tot_reg_usrs_f_UK = ukrs2.getInt("TOTAL FEMALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ukrs2){ukrs2.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					/*try {
							usrs3 = stmt.executeQuery(us_query3);
							while(usrs3.next())
												{
													tot_mil_usrs_m_US = usrs3.getInt("TOTAL MALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs3){usrs3.close();}}catch (SQLException e){out.print(e.getMessage());}}
		
					try {
							usrs4 = stmt.executeQuery(us_query4);
							while(usrs4.next())
												{
													tot_mil_usrs_f_US = usrs4.getInt("TOTAL FEMALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs4){usrs4.close();}}catch (SQLException e){out.print(e.getMessage());}}
					*/
					try {
						ukrs5 = stmt.executeQuery(uk_query5);
						while(ukrs5.next())
											{
												tot_lyrs_UK = ukrs5.getInt("TOTAL LAWYERS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ukrs5){ukrs5.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						ukrs6 = stmt.executeQuery(uk_query6);
						while(ukrs6.next())
											{
												tot_docs_UK = ukrs6.getInt("TOTAL DOCTORS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ukrs6){ukrs6.close();}}catch (SQLException e){out.print(e.getMessage());}}
										
					try {
						ukrs7 = stmt.executeQuery(uk_query7);
						while(ukrs7.next())
											{
												tot_bus_prfs_UK = ukrs7.getInt("TOTAL BSNSMEN");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ukrs7){ukrs7.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						ukrs8 = stmt.executeQuery(uk_query8);
						while(ukrs8.next())
											{
												tot_stds_UK = ukrs8.getInt("TOTAL STUDENTS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ukrs8){ukrs8.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						ukrs9 = stmt.executeQuery(uk_query9);
						while(ukrs9.next())
											{
												tot_oth_prfs_UK = ukrs9.getInt("TOTAL OTHER PROFS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ukrs9){ukrs9.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						ukrs10 = stmt.executeQuery(uk_query10);
						while(ukrs10.next())
											{
												tot_jobs_UK = ukrs10.getInt("TOTAL JOBS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ukrs10){ukrs10.close();}}catch (SQLException e){out.print(e.getMessage());}}
					//UK figure ends here
					
					
					//CANADA figure starts here
					
					try {
							cars1 = stmt.executeQuery(ca_query1);
							while(cars1.next())
												{
													tot_reg_usrs_m_CA = cars1.getInt("TOTAL MALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=cars1){cars1.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					try {
							cars2 = stmt.executeQuery(ca_query2);
							while(cars2.next())
												{
													tot_reg_usrs_f_CA = cars2.getInt("TOTAL FEMALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=cars2){cars2.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					/*try {
							usrs3 = stmt.executeQuery(us_query3);
							while(usrs3.next())
												{
													tot_mil_usrs_m_US = usrs3.getInt("TOTAL MALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs3){usrs3.close();}}catch (SQLException e){out.print(e.getMessage());}}
		
					try {
							usrs4 = stmt.executeQuery(us_query4);
							while(usrs4.next())
												{
													tot_mil_usrs_f_US = usrs4.getInt("TOTAL FEMALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs4){usrs4.close();}}catch (SQLException e){out.print(e.getMessage());}}
					*/
					try {
						cars5 = stmt.executeQuery(ca_query5);
						while(cars5.next())
											{
												tot_lyrs_CA = cars5.getInt("TOTAL LAWYERS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=cars5){cars5.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						cars6 = stmt.executeQuery(ca_query6);
						while(cars6.next())
											{
												tot_docs_CA = cars6.getInt("TOTAL DOCTORS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=cars6){cars6.close();}}catch (SQLException e){out.print(e.getMessage());}}
										
					try {
						cars7 = stmt.executeQuery(ca_query7);
						while(cars7.next())
											{
												tot_bus_prfs_CA = cars7.getInt("TOTAL BSNSMEN");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=cars7){cars7.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						cars8 = stmt.executeQuery(ca_query8);
						while(cars8.next())
											{
												tot_stds_CA = cars8.getInt("TOTAL STUDENTS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=cars8){cars8.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						cars9 = stmt.executeQuery(ca_query9);
						while(cars9.next())
											{
												tot_oth_prfs_CA = cars9.getInt("TOTAL OTHER PROFS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=cars9){cars9.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						cars10 = stmt.executeQuery(ca_query10);
						while(cars10.next())
											{
												tot_jobs_CA = cars10.getInt("TOTAL JOBS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=cars10){cars10.close();}}catch (SQLException e){out.print(e.getMessage());}}
					//CANADA figure ends here
					
					
					//AUSTRALIA figure starts here
					
					try {
							ausrs1 = stmt.executeQuery(aus_query1);
							while(ausrs1.next())
												{
													tot_reg_usrs_m_AUS = ausrs1.getInt("TOTAL MALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ausrs1){ausrs1.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					try {
							ausrs2 = stmt.executeQuery(aus_query2);
							while(ausrs2.next())
												{
													tot_reg_usrs_f_AUS = ausrs2.getInt("TOTAL FEMALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ausrs2){ausrs2.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					/*try {
							usrs3 = stmt.executeQuery(us_query3);
							while(usrs3.next())
												{
													tot_mil_usrs_m_US = usrs3.getInt("TOTAL MALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs3){usrs3.close();}}catch (SQLException e){out.print(e.getMessage());}}
		
					try {
							usrs4 = stmt.executeQuery(us_query4);
							while(usrs4.next())
												{
													tot_mil_usrs_f_US = usrs4.getInt("TOTAL FEMALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs4){usrs4.close();}}catch (SQLException e){out.print(e.getMessage());}}
					*/
					try {
						ausrs5 = stmt.executeQuery(aus_query5);
						while(ausrs5.next())
											{
												tot_lyrs_AUS = ausrs5.getInt("TOTAL LAWYERS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ausrs5){ausrs5.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						ausrs6 = stmt.executeQuery(aus_query6);
						while(ausrs6.next())
											{
												tot_docs_AUS = ausrs6.getInt("TOTAL DOCTORS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ausrs6){ausrs6.close();}}catch (SQLException e){out.print(e.getMessage());}}
										
					try {
						ausrs7 = stmt.executeQuery(aus_query7);
						while(ausrs7.next())
											{
												tot_bus_prfs_AUS = ausrs7.getInt("TOTAL BSNSMEN");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ausrs7){ausrs7.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						ausrs8 = stmt.executeQuery(aus_query8);
						while(ausrs8.next())
											{
												tot_stds_AUS = ausrs8.getInt("TOTAL STUDENTS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ausrs8){ausrs8.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						ausrs9 = stmt.executeQuery(aus_query9);
						while(ausrs9.next())
											{
												tot_oth_prfs_AUS = ausrs9.getInt("TOTAL OTHER PROFS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ausrs9){ausrs9.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						ausrs10 = stmt.executeQuery(aus_query10);
						while(ausrs10.next())
											{
												tot_jobs_AUS = ausrs10.getInt("TOTAL JOBS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=ausrs10){ausrs10.close();}}catch (SQLException e){out.print(e.getMessage());}}
					
					//AUSTRALIA figure ends here
		
					
					//EUROPE figure starts here
					
					try {
							eurs1 = stmt.executeQuery(eu_query1);
							while(eurs1.next())
												{
													tot_reg_usrs_m_EU = eurs1.getInt("TOTAL MALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=eurs1){eurs1.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					try {
							eurs2 = stmt.executeQuery(eu_query2);
							while(eurs2.next())
												{
													tot_reg_usrs_f_EU = eurs2.getInt("TOTAL FEMALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=eurs2){eurs2.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					/*try {
							usrs3 = stmt.executeQuery(us_query3);
							while(usrs3.next())
												{
													tot_mil_usrs_m_US = usrs3.getInt("TOTAL MALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs3){usrs3.close();}}catch (SQLException e){out.print(e.getMessage());}}
		
					try {
							usrs4 = stmt.executeQuery(us_query4);
							while(usrs4.next())
												{
													tot_mil_usrs_f_US = usrs4.getInt("TOTAL FEMALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs4){usrs4.close();}}catch (SQLException e){out.print(e.getMessage());}}
					*/
					try {
						eurs5 = stmt.executeQuery(eu_query5);
						while(eurs5.next())
											{
												tot_lyrs_EU = eurs5.getInt("TOTAL LAWYERS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=eurs5){eurs5.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						eurs6 = stmt.executeQuery(eu_query6);
						while(eurs6.next())
											{
												tot_docs_EU = eurs6.getInt("TOTAL DOCTORS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=eurs6){eurs6.close();}}catch (SQLException e){out.print(e.getMessage());}}
										
					try {
						eurs7 = stmt.executeQuery(eu_query7);
						while(eurs7.next())
											{
												tot_bus_prfs_EU = eurs7.getInt("TOTAL BSNSMEN");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=eurs7){eurs7.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						eurs8 = stmt.executeQuery(eu_query8);
						while(eurs8.next())
											{
												tot_stds_EU = eurs8.getInt("TOTAL STUDENTS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=eurs8){eurs8.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						eurs9 = stmt.executeQuery(eu_query9);
						while(eurs9.next())
											{
												tot_oth_prfs_EU = eurs9.getInt("TOTAL OTHER PROFS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=eurs9){eurs9.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						eurs10 = stmt.executeQuery(eu_query10);
						while(eurs10.next())
											{
												tot_jobs_EU = eurs10.getInt("TOTAL JOBS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=eurs10){eurs10.close();}}catch (SQLException e){out.print(e.getMessage());}}
					
					//EUROPE figure ends here
					
					//JAPAN	 figure starts here
					
					try {
							jprs1 = stmt.executeQuery(jp_query1);
							while(jprs1.next())
												{
													tot_reg_usrs_m_JP = jprs1.getInt("TOTAL MALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=jprs1){jprs1.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					try {
							jprs2 = stmt.executeQuery(jp_query2);
							while(jprs2.next())
												{
													tot_reg_usrs_f_JP = jprs2.getInt("TOTAL FEMALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=jprs2){jprs2.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					/*try {
							usrs3 = stmt.executeQuery(us_query3);
							while(usrs3.next())
												{
													tot_mil_usrs_m_US = usrs3.getInt("TOTAL MALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs3){usrs3.close();}}catch (SQLException e){out.print(e.getMessage());}}
		
					try {
							usrs4 = stmt.executeQuery(us_query4);
							while(usrs4.next())
												{
													tot_mil_usrs_f_US = usrs4.getInt("TOTAL FEMALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs4){usrs4.close();}}catch (SQLException e){out.print(e.getMessage());}}
					*/
					try {
						jprs5 = stmt.executeQuery(jp_query5);
						while(jprs5.next())
											{
												tot_lyrs_JP = jprs5.getInt("TOTAL LAWYERS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=jprs5){jprs5.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						jprs6 = stmt.executeQuery(jp_query6);
						while(jprs6.next())
											{
												tot_docs_JP = jprs6.getInt("TOTAL DOCTORS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=jprs6){jprs6.close();}}catch (SQLException e){out.print(e.getMessage());}}
										
					try {
						jprs7 = stmt.executeQuery(jp_query7);
						while(jprs7.next())
											{
												tot_bus_prfs_JP = jprs7.getInt("TOTAL BSNSMEN");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=jprs7){jprs7.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						jprs8 = stmt.executeQuery(jp_query8);
						while(jprs8.next())
											{
												tot_stds_JP = jprs8.getInt("TOTAL STUDENTS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=jprs8){jprs8.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						jprs9 = stmt.executeQuery(jp_query9);
						while(jprs9.next())
											{
												tot_oth_prfs_JP = jprs9.getInt("TOTAL OTHER PROFS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=jprs9){jprs9.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						jprs10 = stmt.executeQuery(jp_query10);
						while(jprs10.next())
											{
												tot_jobs_JP = jprs10.getInt("TOTAL JOBS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=jprs10){jprs10.close();}}catch (SQLException e){out.print(e.getMessage());}}
					
					//JAPAN figure ends here
					
					
					//INDIA figure starts here
					
					try {
							indrs1 = stmt.executeQuery(ind_query1);
							while(indrs1.next())
												{
													tot_reg_usrs_m_IND = indrs1.getInt("TOTAL MALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=indrs1){indrs1.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					try {
							indrs2 = stmt.executeQuery(ind_query2);
							while(indrs2.next())
												{
													tot_reg_usrs_f_IND = indrs2.getInt("TOTAL FEMALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=indrs2){indrs2.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					/*try {
							usrs3 = stmt.executeQuery(us_query3);
							while(usrs3.next())
												{
													tot_mil_usrs_m_US = usrs3.getInt("TOTAL MALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs3){usrs3.close();}}catch (SQLException e){out.print(e.getMessage());}}
		
					try {
							usrs4 = stmt.executeQuery(us_query4);
							while(usrs4.next())
												{
													tot_mil_usrs_f_US = usrs4.getInt("TOTAL FEMALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs4){usrs4.close();}}catch (SQLException e){out.print(e.getMessage());}}
					*/
					try {
						indrs5 = stmt.executeQuery(ind_query5);
						while(indrs5.next())
											{
												tot_lyrs_IND = indrs5.getInt("TOTAL LAWYERS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=indrs5){indrs5.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						indrs6 = stmt.executeQuery(ind_query6);
						while(indrs6.next())
											{
												tot_docs_IND = indrs6.getInt("TOTAL DOCTORS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=indrs6){indrs6.close();}}catch (SQLException e){out.print(e.getMessage());}}
										
					try {
						indrs7 = stmt.executeQuery(ind_query7);
						while(indrs7.next())
											{
												tot_bus_prfs_IND = indrs7.getInt("TOTAL BSNSMEN");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=indrs7){indrs7.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						indrs8 = stmt.executeQuery(ind_query8);
						while(indrs8.next())
											{
												tot_stds_IND = indrs8.getInt("TOTAL STUDENTS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=indrs8){indrs8.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						indrs9 = stmt.executeQuery(ind_query9);
						while(indrs9.next())
											{
												tot_oth_prfs_IND = indrs9.getInt("TOTAL OTHER PROFS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=indrs9){indrs9.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						indrs10 = stmt.executeQuery(ind_query10);
						while(indrs10.next())
											{
												tot_jobs_IND = indrs10.getInt("TOTAL JOBS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=indrs10){indrs10.close();}}catch (SQLException e){out.print(e.getMessage());}}
					
					//INDIA figure ends here
					
					
					//NEPAL	 figure starts here
					
					try {
							neprs1 = stmt.executeQuery(nep_query1);
							while(neprs1.next())
												{
													tot_reg_usrs_m_NEP = neprs1.getInt("TOTAL MALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=neprs1){neprs1.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					try {
							neprs2 = stmt.executeQuery(nep_query2);
							while(neprs2.next())
												{
													tot_reg_usrs_f_NEP = neprs2.getInt("TOTAL FEMALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=neprs2){neprs2.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					/*try {
							usrs3 = stmt.executeQuery(us_query3);
							while(usrs3.next())
												{
													tot_mil_usrs_m_US = usrs3.getInt("TOTAL MALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs3){usrs3.close();}}catch (SQLException e){out.print(e.getMessage());}}
		
					try {
							usrs4 = stmt.executeQuery(us_query4);
							while(usrs4.next())
												{
													tot_mil_usrs_f_US = usrs4.getInt("TOTAL FEMALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs4){usrs4.close();}}catch (SQLException e){out.print(e.getMessage());}}
					*/
					try {
						neprs5 = stmt.executeQuery(nep_query5);
						while(neprs5.next())
											{
												tot_lyrs_NEP = neprs5.getInt("TOTAL LAWYERS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=neprs5){neprs5.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						neprs6 = stmt.executeQuery(nep_query6);
						while(neprs6.next())
											{
												tot_docs_NEP = neprs6.getInt("TOTAL DOCTORS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=neprs6){neprs6.close();}}catch (SQLException e){out.print(e.getMessage());}}
										
					try {
						neprs7 = stmt.executeQuery(nep_query7);
						while(neprs7.next())
											{
												tot_bus_prfs_NEP = neprs7.getInt("TOTAL BSNSMEN");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=neprs7){neprs7.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						neprs8 = stmt.executeQuery(nep_query8);
						while(neprs8.next())
											{
												tot_stds_NEP = neprs8.getInt("TOTAL STUDENTS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=neprs8){neprs8.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						neprs9 = stmt.executeQuery(nep_query9);
						while(neprs9.next())
											{
												tot_oth_prfs_NEP = neprs9.getInt("TOTAL OTHER PROFS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=neprs9){neprs9.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						neprs10 = stmt.executeQuery(nep_query10);
						while(neprs10.next())
											{
												tot_jobs_NEP = neprs10.getInt("TOTAL JOBS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=neprs10){neprs10.close();}}catch (SQLException e){out.print(e.getMessage());}}
					
					//NEPAL figure ends here
					
					
					//OTHER figure starts here
					
						try {
							othrs1 = stmt.executeQuery(oth_query1);
							while(othrs1.next())
												{
													tot_reg_usrs_m_OTH = othrs1.getInt("TOTAL MALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=othrs1){othrs1.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					try {
							othrs2 = stmt.executeQuery(oth_query2);
							while(othrs2.next())
												{
													tot_reg_usrs_f_OTH = othrs2.getInt("TOTAL FEMALE USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=othrs2){othrs2.close();}}catch (SQLException e){out.print(e.getMessage());}}
			
					/*try {
							usrs3 = stmt.executeQuery(us_query3);
							while(usrs3.next())
												{
													tot_mil_usrs_m_US = usrs3.getInt("TOTAL MALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs3){usrs3.close();}}catch (SQLException e){out.print(e.getMessage());}}
		
					try {
							usrs4 = stmt.executeQuery(us_query4);
							while(usrs4.next())
												{
													tot_mil_usrs_f_US = usrs4.getInt("TOTAL FEMALE VIV USERS");
												}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=usrs4){usrs4.close();}}catch (SQLException e){out.print(e.getMessage());}}
					*/
					try {
						othrs5 = stmt.executeQuery(oth_query5);
						while(othrs5.next())
											{
												tot_lyrs_OTH = othrs5.getInt("TOTAL LAWYERS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=othrs5){othrs5.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						othrs6 = stmt.executeQuery(oth_query6);
						while(othrs6.next())
											{
												tot_docs_OTH = othrs6.getInt("TOTAL DOCTORS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=othrs6){othrs6.close();}}catch (SQLException e){out.print(e.getMessage());}}
										
					try {
						othrs7 = stmt.executeQuery(oth_query7);
						while(othrs7.next())
											{
												tot_bus_prfs_OTH = othrs7.getInt("TOTAL BSNSMEN");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=othrs7){othrs7.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						othrs8 = stmt.executeQuery(oth_query8);
						while(othrs8.next())
											{
												tot_stds_OTH = othrs8.getInt("TOTAL STUDENTS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=othrs8){othrs8.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						othrs9 = stmt.executeQuery(oth_query9);
						while(othrs9.next())
											{
												tot_oth_prfs_OTH = othrs9.getInt("TOTAL OTHER PROFS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=othrs9){othrs9.close();}}catch (SQLException e){out.print(e.getMessage());}}
				
					try {
						othrs10 = stmt.executeQuery(oth_query10);
						while(othrs10.next())
											{
												tot_jobs_OTH = othrs10.getInt("TOTAL JOBS");
											}
					}catch (SQLException e) {out.print(e.getMessage());}
					finally{try{if(null!=othrs10){othrs10.close();}}catch (SQLException e){out.print(e.getMessage());}}
					
					
					
					//OTHER figure ends here
					
				}catch(Exception e){
					
				}finally{
							
						try 
							{ 
								if(null!=stmt)stmt.close();
						} catch (SQLException e) 
								{
									//e.printStackTrace();
									e.getMessage();
						}
						try 
							{ 
								if(null!=con)con.close();
						} catch (SQLException e) {
									out.print(e.getMessage());
									//e.printStackTrace();
						}
			}

			%>
		<header>
			<!--header with navigation, logo and title-->
				<div class="pull-left visible-md visible-lg">
				<!--logo with quote-->
					<h2 id="logo">&#2332;&#2344;&#2344;&#2368;&#0032;&#2332;&#2344;&#2381;&#2350;&#2349;&#2370;&#2350;&#2367;&#2358;&#2381;&#2330;&#0032;&#2360;&#2381;&#2357;&#2352;&#2381;&#2327;&#2366;&#2342;&#2346;&#2367;&#0032;&#2327;&#2352;&#2368;&#2351;&#2360;&#2368;</h2>
				</div>
				<div id="title">
					<h1>&#2313;&#2346;&#2325;&#2366;&#2352;</h1>
				</div>
				
				<div id="navigation" class="pull-left visible-md visible-lg">
					<a style="color:red;font-weight:bold" class="btn btn-default" href="registration.jsp" role="button">Register</a>
					<a style="color:red;font-weight:bold" class="btn btn-default" href="#" role="button">Admin</a>
				</div>
			
		</header>
		
		<section>
			<article>
				<div id="googleMap">

					<script>
						function myMap() {
								var mapProp= {
												center:new google.maps.LatLng(28.3949,84.1240),
								
												zoom:4,
											 };
								var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);
										  }
					</script>

					<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAe24fmynItFChhWr5vYytQ1ukL43o9hZ8&callback=myMap"></script>
				</div>
			</article>
		</section>
		
	
		<section>
			<article id="stats">
				<p style="color:blue;font-weight:bold">Global Figures--------></p>
				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>Total Registered Users (Male)</th>
							<th>Total Registered Users (Female)</th>
							<th>Total Milan/Vivah Profiles (Male)</th>
							<th>Total Milan/Vivah Profiles (Female)</th>
							<th>Total Lawyers' Profile</th>
							<th>Total Doctors' Profile</th>
							<th>Total Students' Profile</th>
							<th>Total Business Profile</th>
							<th>Total Other Professionals' Profile</th>
							<th>Total Jobs Posted Within Last 30 Days</th>
						</tr>
						<tr>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_m)%></td>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_f)%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_mil_usrs_m);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_mil_usrs_f);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_lyrs);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_docs);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_stds);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_bus_prfs);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_oth_prfs);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_jobs);%></td>
					</table>
				</div>
				<p style="color:blue;font-weight:bold">USA Figures--------></p>
				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>Total Registered Users (Male)</th>
							<th>Total Registered Users (Female)</th>
							<th>Total Milan/Vivah Profiles (Male)</th>
							<th>Total Milan/Vivah Profiles (Female)</th>
							<th>Total Lawyers' Profile</th>
							<th>Total Doctors' Profile</th>
							<th>Total Students' Profile</th>
							<th>Total Business Profile</th>
							<th>Total Other Professionals' Profile</th>
							<th>Total Jobs Posted Within Last 30 Days</th>
						</tr>
						<tr>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_m_US)%></td>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_f_US)%></td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold"><%out.print(tot_lyrs_US);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_docs_US);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_stds_US);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_bus_prfs_US);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_oth_prfs_US);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_jobs_US);%></td>
					</table>
				</div>
				
				<p style="color:blue;font-weight:bold">UK Figures--------></p>
				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>Total Registered Users (Male)</th>
							<th>Total Registered Users (Female)</th>
							<th>Total Milan/Vivah Profiles (Male)</th>
							<th>Total Milan/Vivah Profiles (Female)</th>
							<th>Total Lawyers' Profile</th>
							<th>Total Doctors' Profile</th>
							<th>Total Students' Profile</th>
							<th>Total Business Profile</th>
							<th>Total Other Professionals' Profile</th>
							<th>Total Jobs Posted Within Last 30 Days</th>
						</tr>
						<tr>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_m_UK)%></td>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_f_UK)%></td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold"><%out.print(tot_lyrs_UK);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_docs_UK);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_stds_UK);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_bus_prfs_UK);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_oth_prfs_UK);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_jobs_UK);%></td>
					</table>
				</div>
				
				<p style="color:blue;font-weight:bold">CANADA Figures--------></p>
				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>Total Registered Users (Male)</th>
							<th>Total Registered Users (Female)</th>
							<th>Total Milan/Vivah Profiles (Male)</th>
							<th>Total Milan/Vivah Profiles (Female)</th>
							<th>Total Lawyers' Profile</th>
							<th>Total Doctors' Profile</th>
							<th>Total Students' Profile</th>
							<th>Total Business Profile</th>
							<th>Total Other Professionals' Profile</th>
							<th>Total Jobs Posted Within Last 30 Days</th>
						</tr>
						<tr>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_m_CA)%></td>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_f_CA)%></td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold"><%out.print(tot_lyrs_CA);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_docs_CA);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_stds_CA);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_bus_prfs_CA);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_oth_prfs_CA);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_jobs_CA);%></td>
					</table>
				</div>
				
				<p style="color:blue;font-weight:bold">AUSTRALIA Figures--------></p>
				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>Total Registered Users (Male)</th>
							<th>Total Registered Users (Female)</th>
							<th>Total Milan/Vivah Profiles (Male)</th>
							<th>Total Milan/Vivah Profiles (Female)</th>
							<th>Total Lawyers' Profile</th>
							<th>Total Doctors' Profile</th>
							<th>Total Students' Profile</th>
							<th>Total Business Profile</th>
							<th>Total Other Professionals' Profile</th>
							<th>Total Jobs Posted Within Last 30 Days</th>
						</tr>
						<tr>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_m_AUS)%></td>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_f_AUS)%></td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold"><%out.print(tot_lyrs_AUS);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_docs_AUS);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_stds_AUS);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_bus_prfs_AUS);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_oth_prfs_AUS);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_jobs_AUS);%></td>
					</table>
				</div>
				
				<p style="color:blue;font-weight:bold">EUROPE Figures--------></p>
				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>Total Registered Users (Male)</th>
							<th>Total Registered Users (Female)</th>
							<th>Total Milan/Vivah Profiles (Male)</th>
							<th>Total Milan/Vivah Profiles (Female)</th>
							<th>Total Lawyers' Profile</th>
							<th>Total Doctors' Profile</th>
							<th>Total Students' Profile</th>
							<th>Total Business Profile</th>
							<th>Total Other Professionals' Profile</th>
							<th>Total Jobs Posted Within Last 30 Days</th>
						</tr>
						<tr>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_m_EU)%></td>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_f_EU)%></td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold"><%out.print(tot_lyrs_EU);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_docs_EU);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_stds_EU);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_bus_prfs_EU);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_oth_prfs_EU);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_jobs_EU);%></td>
					</table>
				</div>
				
				<p style="color:blue;font-weight:bold">JAPAN Figures--------></p>
				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>Total Registered Users (Male)</th>
							<th>Total Registered Users (Female)</th>
							<th>Total Milan/Vivah Profiles (Male)</th>
							<th>Total Milan/Vivah Profiles (Female)</th>
							<th>Total Lawyers' Profile</th>
							<th>Total Doctors' Profile</th>
							<th>Total Students' Profile</th>
							<th>Total Business Profile</th>
							<th>Total Other Professionals' Profile</th>
							<th>Total Jobs Posted Within Last 30 Days</th>
						</tr>
						<tr>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_m_JP)%></td>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_f_JP)%></td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold"><%out.print(tot_lyrs_JP);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_docs_JP);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_stds_JP);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_bus_prfs_JP);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_oth_prfs_JP);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_jobs_JP);%></td>
					</table>
				</div>
				
				<p style="color:blue;font-weight:bold">INDIA Figures--------></p>
				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>Total Registered Users (Male)</th>
							<th>Total Registered Users (Female)</th>
							<th>Total Milan/Vivah Profiles (Male)</th>
							<th>Total Milan/Vivah Profiles (Female)</th>
							<th>Total Lawyers' Profile</th>
							<th>Total Doctors' Profile</th>
							<th>Total Students' Profile</th>
							<th>Total Business Profile</th>
							<th>Total Other Professionals' Profile</th>
							<th>Total Jobs Posted Within Last 30 Days</th>
						</tr>
						<tr>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_m_IND)%></td>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_f_IND)%></td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold"><%out.print(tot_lyrs_IND);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_docs_IND);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_stds_IND);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_bus_prfs_IND);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_oth_prfs_IND);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_jobs_IND);%></td>
					</table>
				</div>
				
				<p style="color:blue;font-weight:bold">NEPAL Figures--------></p>
				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>Total Registered Users (Male)</th>
							<th>Total Registered Users (Female)</th>
							<th>Total Milan/Vivah Profiles (Male)</th>
							<th>Total Milan/Vivah Profiles (Female)</th>
							<th>Total Lawyers' Profile</th>
							<th>Total Doctors' Profile</th>
							<th>Total Students' Profile</th>
							<th>Total Business Profile</th>
							<th>Total Other Professionals' Profile</th>
							<th>Total Jobs Posted Within Last 30 Days</th>
						</tr>
						<tr>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_m_NEP)%></td>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_f_NEP)%></td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold"><%out.print(tot_lyrs_NEP);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_docs_NEP);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_stds_NEP);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_bus_prfs_NEP);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_oth_prfs_NEP);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_jobs_NEP);%></td>
					</table>
				</div>
				
				<p style="color:blue;font-weight:bold">ALL OTHER NATION Figures--------></p>
				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>Total Registered Users (Male)</th>
							<th>Total Registered Users (Female)</th>
							<th>Total Milan/Vivah Profiles (Male)</th>
							<th>Total Milan/Vivah Profiles (Female)</th>
							<th>Total Lawyers' Profile</th>
							<th>Total Doctors' Profile</th>
							<th>Total Students' Profile</th>
							<th>Total Business Profile</th>
							<th>Total Other Professionals' Profile</th>
							<th>Total Jobs Posted Within Last 30 Days</th>
						</tr>
						<tr>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_m_OTH)%></td>
							<td style="color:red;font-weight:bold"><%=(tot_reg_usrs_f_OTH)%></td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold">see global figure</td>
							<td style="color:red;font-weight:bold"><%out.print(tot_lyrs_OTH);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_docs_OTH);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_stds_OTH);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_bus_prfs_OTH);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_oth_prfs_OTH);%></td>
							<td style="color:red;font-weight:bold"><%out.print(tot_jobs_OTH);%></td>
					</table>
				</div>
			</article>
		</section>
		
		<section id="main_section">
			
				<!--<div id="chrome_notice">
					<img id="chrome_logo" src="/img/Google_Chrome_icon.png" alt="chrome_icon">
					<p id="chrome_msg">Please use google chrome for hamroaafno.com || hamroaafno.com is an open source project for Nepalese nationals being built upon Google Chrome as recommended browser.</p>
				</div>-->
				<div id="log_in">
					<!--<img src="/sagarmatha/my_images/namaskar.gif" alt="please use google chrome browser" style="width:100px;height:100px;margin-left:10%">-->
					<img src="/img/namaskar.gif" alt="please use google chrome browser" style="width:100px;height:100px;margin-left:10%">
					<form action="login" class="form-horizontal" method="POST">
						<div class="form-group">
							<label style="margin-left:30%">Username<sub>(case sensitive)</sub></label>
							<div>
								<input type="text" name="loginname" class="form-control" required>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" style="margin-left:30%">Password<sub>(case sensitive)</sub></label>
							<div>
								<input type="password" name="loginpwd" class="form-control" required>
							</div>
						</div>
						<div id="agreement">
							<p style="width:200px;font-size:0.75em">By clicking the link below, I confirm that I agree with all terms and conditions <a style="font-weight:bold" href="agreement.jsp">here</a>.</p>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-default" style="color:red;margin-left:15%">&#2360;&#2381;&#2357;&#2366;&#2327;&#2340;&#2350;</button>
							</div>
						</div>
					</form>
				</div>
				
			
			
				<div id="jobs">
					<p>To see job openings<br> available at swades.com<br> please visit <a style="color:red;font-weight:bold" href="hamro_jobs.jsp">link</a></p>
				</div>
			
		</section>
			
		<footer>	
			<div id="foot">
				<p id="foot_msg">&copy;pAnalyticsTech Solutions. All Rights Reserved. For any comments or messages, please <a style="color:red" href="write_to_hamro.jsp">write</a> to us.</p>
			</div>
		</footer>	
	
</body>
</html>