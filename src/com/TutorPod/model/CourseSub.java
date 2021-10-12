package com.TutorPod.model;

public class CourseSub {
	private int course_sub_id;
	private int course_id;
	private int duration_no;
	private int subject_id;
	public CourseSub(int course_sub_id, int course_id, int duration_no, int subject_id) {
		super();
		this.course_sub_id = course_sub_id;
		this.course_id = course_id;
		this.duration_no = duration_no;
		this.subject_id = subject_id;
	}
	public CourseSub(int course_id, int duration_no, int subject_id) {
		super();
		this.course_id = course_id;
		this.duration_no = duration_no;
		this.subject_id = subject_id;
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
	@Override
	public String toString() {
		return "CourseSub [course_sub_id=" + course_sub_id + ", course_id=" + course_id + ", duration_no=" + duration_no
				+ ", subject_id=" + subject_id + "]";
	}
}
