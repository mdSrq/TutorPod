package com.TutorPod.model;

public class Course {
	private int course_id;
	private String course_name;
	private String name_abbr;
	private String duration_type;
	private int duration;
	public Course(int course_id, String course_name, String name_abbr, String duration_type, int duration) {
		super();
		this.course_id = course_id;
		this.course_name = course_name;
		this.name_abbr = name_abbr;
		this.duration_type = duration_type;
		this.duration = duration;
	}
	public Course(String course_name, String name_abbr, String duration_type, int duration) {
		super();
		this.course_name = course_name;
		this.name_abbr = name_abbr;
		this.duration_type = duration_type;
		this.duration = duration;
	}
	public int getCourse_id() {
		return course_id;
	}
	public void setCourse_id(int course_id) {
		this.course_id = course_id;
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
		return "Course [course_id=" + course_id + ", course_name=" + course_name + ", name_abbr=" + name_abbr
				+ ", duration_type=" + duration_type + ", duration=" + duration + "]";
	}
}
