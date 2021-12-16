package com.TutorPod.model;

public class Lesson {
	private int lesson_id;
	private int booking_id;
	private String meeting_link;
	private String notes;
	private String time_from;
	private String time_to;
	private String date;
	private String status;
	public Lesson(int lesson_id, int booking_id, String meeting_link, String notes, String time_from, String time_to,
			String date, String status) {
		super();
		this.lesson_id = lesson_id;
		this.booking_id = booking_id;
		this.meeting_link = meeting_link;
		this.notes = notes;
		this.time_from = time_from;
		this.time_to = time_to;
		this.date = date;
		this.status = status;
	}
	public Lesson(int booking_id, String meeting_link, String notes, String time_from, String time_to, String date,
			String status) {
		super();
		this.booking_id = booking_id;
		this.meeting_link = meeting_link;
		this.notes = notes;
		this.time_from = time_from;
		this.time_to = time_to;
		this.date = date;
		this.status = status;
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
	public String getTime_from() {
		return time_from;
	}
	public void setTime_from(String time_from) {
		this.time_from = time_from;
	}
	public String getTime_to() {
		return time_to;
	}
	public void setTime_to(String time_to) {
		this.time_to = time_to;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}