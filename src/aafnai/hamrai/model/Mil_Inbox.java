package aafnai.hamrai.model;

import java.io.Serializable;
//import java.sql.Date;

public class Mil_Inbox implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int msg_id;
	private String msg_dt;
	private int sender_id;
	private String sender;
	private String sender_pwd;
	private int rec_id;
	private String rec;
	private String rec_pwd;
	private String msg;
	private String rec_eml;
	private String sen_eml;
	private String status;
	
	
    public Mil_Inbox(){
		
	}
    
	public Mil_Inbox(int _msg_id,String _msg_dt,int sen_id,String _sender,String _sen_pwd,int rc_id,String _rec,String rc_pwd,String message, String rc_email, String sen_email,String st){
		
		this.msg_id=_msg_id;
		this.msg_dt=_msg_dt;
		this.sender_id=sen_id;
		this.sender=_sender;
		this.sender_pwd=_sen_pwd;
		this.rec_id=rc_id;
		this.rec=_rec;
		this.rec_pwd=rc_pwd;
		this.msg=message;
		this.rec_eml=rc_email;
		this.sen_eml=sen_email;
		this.status=st;
		
		
	}


	public int getMsg_id() {
		return msg_id;
	}

	public void setMsg_id(int msg_id) {
		this.msg_id = msg_id;
	}
	
	public String getMsg_dt() {
		return msg_dt;
	}

	public void setMsg_dt(String msg_dt) {
		this.msg_dt = msg_dt;
	}

	public int getSender_id() {
		return sender_id;
	}

	public void setSender_id(int sender_id) {
		this.sender_id = sender_id;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getSender_pwd() {
		return sender_pwd;
	}

	public void setSender_pwd(String sender_pwd) {
		this.sender_pwd = sender_pwd;
	}

	public int getRec_id() {
		return rec_id;
	}

	public void setRec_id(int rec_id) {
		this.rec_id = rec_id;
	}

	public String getRec() {
		return rec;
	}

	public void setRec(String rec) {
		this.rec = rec;
	}

	public String getRec_pwd() {
		return rec_pwd;
	}

	public void setRec_pwd(String rec_pwd) {
		this.rec_pwd = rec_pwd;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getRec_eml() {
		return rec_eml;
	}

	public void setRec_eml(String rec_eml) {
		this.rec_eml = rec_eml;
	}

	public String getSen_eml() {
		return sen_eml;
	}

	public void setSen_eml(String sen_eml) {
		this.sen_eml = sen_eml;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
