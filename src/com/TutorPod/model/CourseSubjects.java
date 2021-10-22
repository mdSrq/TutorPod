package com.TutorPod.model;

import java.util.List;

public class CourseSubjects {
	private int course_id;
	private List<CourseSubject> courseSubjects;
	public CourseSubjects(int course_id, List<CourseSubject> courseSubjects) {
		super();
		this.course_id = course_id;
		this.courseSubjects = courseSubjects;
	}
	public int getCourse_id() {
		return course_id;
	}
	public void setCourse_id(int course_id) {
		this.course_id = course_id;
	}
	public List<CourseSubject> getCourseSubjects() {
		return courseSubjects;
	}
	public void setCourseSubjects(List<CourseSubject> courseSubjects) {
		this.courseSubjects = courseSubjects;
	}
	@Override
	public String toString() {
		return "CourseSubjects [course_id=" + course_id + ", courseSubjects=" + courseSubjects + "]";
	}
}
