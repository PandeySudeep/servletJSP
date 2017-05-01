package aafnai.hamrai.model;

import java.io.Serializable;
import java.sql.Date;

public class Job implements Serializable{

	private Date posted_date;
	private String posted_by;
	private String job_desc;
	private String location;
	private String country;
	private String email;
	private String phone;
	private String otherinfo;
	
    public Job(){
		
	}
	public Job(Date posteddate,String postedby,String jobdesc,String location,String country,String email,String phone,String otherinfo){
		this.posted_date=posteddate;
		this.posted_by=postedby;
		this.job_desc=jobdesc;
		this.location=location;
		this.country=country;
		this.email=email;
		this.phone=phone;
		this.otherinfo=otherinfo;
	}
	
	public Date getPosted_date() {
		return posted_date;
	}
	public void setPosted_date(Date posted_date) {
		this.posted_date = posted_date;
	}
	
	public String getPosted_by() {
		return posted_by;
	}
	public void setPosted_by(String posted_by) {
		this.posted_by = posted_by;
	}
	
	public String getJob_desc() {
		return job_desc;
	}
	public void setJob_desc(String job_desc) {
		this.job_desc = job_desc;
	}
	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getOtherinfo() {
		return otherinfo;
	}
	public void setOtherinfo(String otherinfo) {
		this.otherinfo = otherinfo;
	}
	
	
}
