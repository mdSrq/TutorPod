package com.TutorPod.model;

public class Lesson {
	private int lesson_id;
	private int booking_id;
	private String status;
	private String meeting_link;
	private String notes;
	public Lesson(int lesson_id, int booking_id, String status, String meeting_link, String notes) {
		super();
		this.lesson_id = lesson_id;
		this.booking_id = booking_id;
		this.status = status;
		this.meeting_link = meeting_link;
		this.notes = notes;
	}
	public Lesson(int booking_id, String status, String meeting_link, String notes) {
		super();
		this.booking_id = booking_id;
		this.status = status;
		this.meeting_link = meeting_link;
		this.notes = notes;
	}
	public int getLesson_id() {
		return lesson_id;
	}
	public void setLesson_id(int lesson_id) {
		this.lesson_id = lesson_id;
	}
	public int getBooking_id() {
		return booking_id;
	}
	public void setBooking_id(int booking_id) {
		this.booking_id = booking_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMeeting_link() {
		return meeting_link;
	}
	public void setMeeting_link(String meeting_link) {
		this.meeting_link = meeting_link;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
}