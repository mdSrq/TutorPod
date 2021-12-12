package com.TutorPod.model;

public class Booking {
	private int booking_id;
	private int tutor_id;
	private int user_id;
	private int subject_id;
	private double price;
	private double duration;
	private int no_of_lesson;
	private int transaction_id;
	private String status;
	public Booking(int booking_id, int tutor_id, int user_id, int subject_id, double price, double duration,
			int no_of_lesson, int transaction_id, String status) {
		super();
		this.booking_id = booking_id;
		this.tutor_id = tutor_id;
		this.user_id = user_id;
		this.subject_id = subject_id;
		this.price = price;
		this.duration = duration;
		this.no_of_lesson = no_of_lesson;
		this.transaction_id = transaction_id;
		this.status = status;
	}
	public Booking(int tutor_id, int user_id, int subject_id, double price, double duration, int no_of_lesson,
			int transaction_id, String status) {
		super();
		this.tutor_id = tutor_id;
		this.user_id = user_id;
		this.subject_id = subject_id;
		this.price = price;
		this.duration = duration;
		this.no_of_lesson = no_of_lesson;
		this.transaction_id = transaction_id;
		this.status = status;
	}
	public int getBooking_id() {
		return booking_id;
	}
	public void setBooking_id(int booking_id) {
		this.booking_id = booking_id;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}