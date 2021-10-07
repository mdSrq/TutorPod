package com.TutorPod.model;

public class Subject {
	private int subject_id;
	private String subject_name;
	private String subject_code;
	public Subject(int subject_id, String subject_name, String subject_code) {
		super();
		this.subject_id = subject_id;
		this.subject_name = subject_name;
		this.subject_code = subject_code;
	}
	public Subject(String subject_name, String subject_code) {
		super();
		this.subject_name = subject_name;
		this.subject_code = subject_code;
	}
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}
	public String getSubject_code() {
		return subject_code;
	}
	public void setSubject_code(String subject_code) {
		this.subject_code = subject_code;
	}
	@Override
	public String toString() {
		return "Subject [subject_id=" + subject_id + ", subject_name=" + subject_name + ", subject_code=" + subject_code
				+ "]";
	}
}
