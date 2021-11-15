package com.TutorPod.model;

public class Tutor {
	private int tutor_id;
	private String bio;
	private String approval_date;
	private String profile_status;
	private int user_id;
	private int address_id;
	public Tutor(int tutor_id, String bio, String approval_date, String profile_status, int user_id, int address_id) {
		super();
		this.tutor_id = tutor_id;
		this.bio = bio;
		this.approval_date = approval_date;
		this.profile_status = profile_status;
		this.user_id = user_id;
		this.address_id = address_id;
	}
	public Tutor(String bio, String approval_date, String profile_status, int user_id, int address_id) {
		super();
		this.bio = bio;
		this.approval_date = approval_date;
		this.profile_status = profile_status;
		this.user_id = user_id;
		this.address_id = address_id;
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
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getAddress_id() {
		return address_id;
	}
	public void setAddress_id(int address_id) {
		this.address_id = address_id;
	}
	@Override
	public String toString() {
		return "Tutor [tutor_id=" + tutor_id + ", bio=" + bio + ", approval_date=" + approval_date + ", profile_status="
				+ profile_status + ", user_id=" + user_id + ", address_id=" + address_id + "]";
	}
	
}
