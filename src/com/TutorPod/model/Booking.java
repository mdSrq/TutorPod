package com.TutorPod.model;

public class Booking {
	private int booking_id;
	private int tutor_id;
	private int subject_id;
	private double duration;
	private String booking_type;
	private int transaction_id;
	private String time_from;
	private String time_to;
	private String status;
	public Booking(int booking_id, int tutor_id, int subject_id, double duration, String booking_type, int transaction_id, String time_from, String time_to, String status) {
		super();
		this.booking_id = booking_id;
		this.tutor_id = tutor_id;
		this.subject_id = subject_id;
		this.duration = duration;
		this.booking_type = booking_type;
		this.transaction_id = transaction_id;
		this.time_from = time_from;
		this.time_to = time_to;
		this.status = status;
	}
	public Booking(int tutor_id, int subject_id, double duration, String booking_type, int transaction_id, String time_from, String time_to, String status) {
		super();
		this.tutor_id = tutor_id;
		this.subject_id = subject_id;
		this.duration = duration;
		this.booking_type = booking_type;
		this.transaction_id = transaction_id;
		this.time_from = time_from;
		this.time_to = time_to;
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
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	public double getDuration() {
		return duration;
	}
	public void setDuration(double duration) {
		this.duration = duration;
	}
	public String getBooking_type() {
		return booking_type;
	}
	public void setBooking_type(String booking_type) {
		this.booking_type = booking_type;
	}
	public int getTransaction_id() {
		return transaction_id;
	}
	public void setTransaction_id(int transaction_id) {
		this.transaction_id = transaction_id;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
