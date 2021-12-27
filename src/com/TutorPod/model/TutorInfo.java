package com.TutorPod.model;

import java.util.List;

public class TutorInfo {
	private int user_id;
	private String fname;
	private String lname;
	private String username;
	private String email_id;
	private String mobile_no;
	private String gender;
	private String photo;
	private String joining_date;
	private int tutor_id;
	private String bio;
	private String approval_date;
	private String profile_status;
	private Address address;
	private List<String[]> languages;
	private List<Experience> experiences;
	private List<Fees> fees;
	private List<Availability> availability;
	public TutorInfo(int user_id, String fname, String lname, String username, String email_id, String mobile_no,
			String gender, String photo, String joining_date, int tutor_id, String bio, String approval_date,
			String profile_status, Address address, List<String[]> languages, List<Experience> experiences,
			List<Fees> fees, List<Availability> availability) {
		super();
		this.user_id = user_id;
		this.fname = fname;
		this.lname = lname;
		this.username = username;
		this.email_id = email_id;
		this.mobile_no = mobile_no;
		this.gender = gender;
		this.photo = photo;
		this.joining_date = joining_date;
		this.tutor_id = tutor_id;
		this.bio = bio;
		this.approval_date = approval_date;
		this.profile_status = profile_status;
		this.address = address;
		this.languages = languages;
		this.experiences = experiences;
		this.fees = fees;
		this.availability = availability;
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
	public String getBio() {
		return bio;
	}
	public void setBio(String bio) {
		this.bio = bio;
	}
	public String getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}
	public String getProfile_status() {
		return profile_status;
	}
	public void setProfile_status(String profile_status) {
		this.profile_status = profile_status;
	}
	public Address getAddress() {
		return address;
	}
	public void setAddress(Address address) {
		this.address = address;
	}
	public List<String[]> getLanguages() {
		return languages;
	}
	public void setLanguages(List<String[]> languages) {
		this.languages = languages;
	}
	public List<Experience> getExperiences() {
		return experiences;
	}
	public void setExperiences(List<Experience> experiences) {
		this.experiences = experiences;
	}
	public List<Fees> getFees() {
		return fees;
	}
	public void setFees(List<Fees> fees) {
		this.fees = fees;
	}
	
}
