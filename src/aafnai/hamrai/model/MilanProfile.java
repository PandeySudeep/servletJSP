package aafnai.hamrai.model;

import java.io.Serializable;
//import java.sql.Date;

public class MilanProfile implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int profileid;
	private String nickname;
	private String gender;
	private String age;
	private String address;
	
	
    public MilanProfile(){
		
	}
	public MilanProfile(int _id,String _nickname,String _gender,String _age,String _address){
		this.profileid=_id;
		this.nickname=_nickname;
		this.gender=_gender;
		this.age=_age;
		this.address=_address;
		
	}
	
	public int getProfileid() {
		return profileid;
	}
	public void setProfileid(int id) {
		this.profileid = id;
	}
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String n) {
		this.nickname = n;
	}
	
	public String getGender() {
		return gender;
	}
	public void setGender(String g) {
		this.gender = g;
	}
	
	public String getAge() {
		return age;
	}
	public void setAge(String a) {
		this.age = a;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String ad) {
		this.address = ad;
	}
	
}
