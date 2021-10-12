package com.TutorPod.model;

public class CourseSubject {
	private int course_sub_id;
	private int course_id;
	private int duration_no;
	private int subject_id;
	private String subject_name;
	private String subject_code;
	private String course_name;
	private String name_abbr;
	private String duration_type;
	private int duration;
	public CourseSubject(int course_sub_id, int course_id, int duration_no, int subject_id, String subject_name,
			String subject_code, String course_name, String name_abbr, String duration_type, int duration) {
		super();
		this.course_sub_id = course_sub_id;
		this.course_id = course_id;
		this.duration_no = duration_no;
		this.subject_id = subject_id;
		this.subject_name = subject_name;
		this.subject_code = subject_code;
		this.course_name = course_name;
		this.name_abbr = name_abbr;
		this.duration_type = duration_type;
		this.duration = duration;
	}
	public int getCourse_sub_id() {
		return course_sub_id;
	}
	public void setCourse_sub_id(int course_sub_id) {
		this.course_sub_id = course_sub_id;
	}
	public int getCourse_id() {
		return course_id;
	}
	public void setCourse_id(int course_id) {
		this.course_id = course_id;
	}
	public int getDuration_no() {
		return duration_no;
	}
	public void setDuration_no(int duration_no) {
		this.duration_no = duration_no;
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
	
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public String getName_abbr() {
		return name_abbr;
	}
	public void setName_abbr(String name_abbr) {
		this.name_abbr = name_abbr;
	}
	public String getDuration_type() {
		return duration_type;
	}
	public void setDuration_type(String duration_type) {
		this.duration_type = duration_type;
	}
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	@Override
	public String toString() {
		return "CourseSubject [course_sub_id=" + course_sub_id + ", course_id=" + course_id + ", duration_no="
				+ duration_no + ", subject_id=" + subject_id + ", subject_name=" + subject_name + ", subject_code="
				+ subject_code + "]";
	}
}
