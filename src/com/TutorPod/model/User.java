package com.TutorPod.model;

public class User {
	private int user_id;
	private String fname;
	private String lname;
	private String username;
	private String password;
	private String email_id;
	private String mobile_no;
	private String gender;
	private String photo;
	private String profile_status;
	private String joining_date;
	private int tutor_id;
	private int wallet_id;
	private int bank_acc_id;
	public User(int user_id, String fname, String lname, String username, String password, String email_id,
			String mobile_no, String gender, String photo, String profile_status, String joining_date, int tutor_id,
			int wallet_id, int bank_acc_id) {
		super();
		this.user_id = user_id;
		this.fname = fname;
		this.lname = lname;
		this.username = username;
		this.password = password;
		this.email_id = email_id;
		this.mobile_no = mobile_no;
		this.gender = gender;
		this.photo = photo;
		this.profile_status = profile_status;
		this.joining_date = joining_date;
		this.tutor_id = tutor_id;
		this.wallet_id = wallet_id;
		this.bank_acc_id = bank_acc_id;
	}
	public User(String fname, String lname, String username, String password, String email_id,
			String mobile_no, String gender, String profile_status, String joining_date) {
		super();
		this.fname = fname;
		this.lname = lname;
		this.username = username;
		this.password = password;
		this.email_id = email_id;
		this.mobile_no = mobile_no;
		this.gender = gender;
		this.profile_status = profile_status;
		this.joining_date = joining_date;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail_id() {
		return email_id;
	}
	public void setEmail_id(String email_id) {
		this.email_id = email_id;
	}
	public String getMobile_no() {
		return mobile_no;
	}
	public void setMobile_no(String mobile_no) {
		this.mobile_no = mobile_no;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getProfile_status() {
		return profile_status;
	}
	public void setProfile_status(String profile_status) {
		this.profile_status = profile_status;
	}
	public String getJoining_date() {
		return joining_date;
	}
	public void setJoining_date(String joining_date) {
		this.joining_date = joining_date;
	}
	public int getTutor_id() {
		return tutor_id;
	}
	public void setTutor_id(int tutor_id) {
		this.tutor_id = tutor_id;
	}
	public int getWallet_id() {
		return wallet_id;
	}
	public void setWallet_id(int wallet_id) {
		this.wallet_id = wallet_id;
	}
	public int getBank_acc_id() {
		return bank_acc_id;
	}
	public void setBank_acc_id(int bank_acc_id) {
		this.bank_acc_id = bank_acc_id;
	}
	@Override
	public String toString() {
		return "User [user_id=" + user_id + ", fname=" + fname + ", lname=" + lname + ", username=" + username
				+ ", password=" + password + ", email_id=" + email_id + ", mobile_no=" + mobile_no + ", gender="
				+ gender + ", photo=" + photo + ", profile_status=" + profile_status + ", joining_date=" + joining_date
				+ ", tutor_id=" + tutor_id + ", wallet_id=" + wallet_id + ", bank_acc_id=" + bank_acc_id + "]";
	}
	
}
/*
+----------------+-------------------------------+------+-----+---------+----------------+
| Field          | Type                          | Null | Key | Default | Extra          |
+----------------+-------------------------------+------+-----+---------+----------------+
| user_id        | int                           | NO   | PRI | NULL    | auto_increment |
| fname          | varchar(25)                   | NO   |     | NULL    |                |
| lname          | varchar(25)                   | YES  |     | NULL    |                |
| username       | varchar(20)                   | NO   | UNI | NULL    |                |
| password       | varchar(20)                   | NO   |     | NULL    |                |
| email_id       | varchar(40)                   | NO   |     | NULL    |                |
| mobile_no      | varchar(13)                   | NO   |     | NULL    |                |
| gender         | enum('Male','Female','Other') | NO   |     | NULL    |                |
| photo          | varchar(20)                   | YES  |     | NULL    |                |
| profile_status | varchar(20)                   | NO   |     | NULL    |                |
| joining_date   | date                          | NO   |     | NULL    |                |
| tutor_id       | int                           | YES  |     | NULL    |                |
| wallet_id      | int                           | YES  |     | NULL    |                |
| bank_acc_id    | int                           | YES  |     | NULL    |                |
+----------------+-------------------------------+------+-----+---------+----------------+
*/