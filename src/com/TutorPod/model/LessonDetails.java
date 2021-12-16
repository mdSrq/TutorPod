package com.TutorPod.model;

public class LessonDetails {
	private int lesson_id;
	private int booking_id;
	private String meeting_link;
	private String notes;
	private String time_from;
	private String time_to;
	private String date;
	private String status;
	private int tutor_id;
	private int user_id;
	private int subject_id;
	private double price;
	private double duration;
	private int no_of_lesson;
	private int transaction_id;
	private String booking_status;
	private User user;
	private User tutorUser;
	private Subject subject;
	public LessonDetails(int lesson_id, int booking_id, String meeting_link, String notes, String time_from,
			String time_to, String date, String status, int tutor_id, int user_id, int subject_id, double price,
			double duration, int no_of_lesson, int transaction_id, String booking_status) {
		super();
		this.lesson_id = lesson_id;
		this.booking_id = booking_id;
		this.meeting_link = meeting_link;
		this.notes = notes;
		this.time_from = time_from;
		this.time_to = time_to;
		this.date = date;
		this.status = status;
		this.tutor_id = tutor_id;
		this.user_id = user_id;
		this.subject_id = subject_id;
		this.price = price;
		this.duration = duration;
		this.no_of_lesson = no_of_lesson;
		this.transaction_id = transaction_id;
		this.booking_status = booking_status;
	}
	public LessonDetails(int lesson_id, int booking_id, String meeting_link, String notes, String time_from,
			String time_to, String date, String status, int tutor_id, int user_id, int subject_id, double price,
			double duration, int no_of_lesson, int transaction_id, String booking_status, User user, User tutorUser,
			Subject subject) {
		super();
		this.lesson_id = lesson_id;
		this.booking_id = booking_id;
		this.meeting_link = meeting_link;
		this.notes = notes;
		this.time_from = time_from;
		this.time_to = time_to;
		this.date = date;
		this.status = status;
		this.tutor_id = tutor_id;
		this.user_id = user_id;
		this.subject_id = subject_id;
		this.price = price;
		this.duration = duration;
		this.no_of_lesson = no_of_lesson;
		this.transaction_id = transaction_id;
		this.booking_status = booking_status;
		this.user = user;
		this.tutorUser = tutorUser;
		this.subject = subject;
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
	public int getTutor_id() {
		return tutor_id;
	}
	public void setTutor_id(int tutor_id) {
		this.tutor_id = tutor_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getDuration() {
		return duration;
	}
	public void setDuration(double duration) {
		this.duration = duration;
	}
	public int getNo_of_lesson() {
		return no_of_lesson;
	}
	public void setNo_of_lesson(int no_of_lesson) {
		this.no_of_lesson = no_of_lesson;
	}
	public int getTransaction_id() {
		return transaction_id;
	}
	public void setTransaction_id(int transaction_id) {
		this.transaction_id = transaction_id;
	}
	public String getBooking_status() {
		return booking_status;
	}
	public void setBooking_status(String booking_status) {
		this.booking_status = booking_status;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public User getTutorUser() {
		return tutorUser;
	}
	public void setTutorUser(User tutorUser) {
		this.tutorUser = tutorUser;
	}
	public Subject getSubject() {
		return subject;
	}
	public void setSubject(Subject subject) {
		this.subject = subject;
	}
}
