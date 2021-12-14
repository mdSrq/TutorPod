package com.TutorPod.model;

public class BookingDetails {
	private Booking booking;
	private User user;
	private User tutorUser;
	private Subject subject;
	private double subTotal;
	private double totalForUser;
	private double totalForTutor;
	public BookingDetails(Booking booking, User user, User tutorUser, Subject subject) {
		super();
		this.booking = booking;
		this.user = user;
		this.tutorUser = tutorUser;
		this.subject = subject;
		subTotal = booking.getPrice()*booking.getDuration()*booking.getNo_of_lesson();
		totalForUser = subTotal+(subTotal/100)*2.5;
		totalForTutor = subTotal-(subTotal/100)*2.5;
	}
	public double getSubTotal() {
		return subTotal;
	}
	public double getTotalForUser() {
		return totalForUser;
	}
	public double getTotalForTutor() {
		return totalForTutor;
	}
	public Booking getBooking() {
		return booking;
	}
	public void setBooking(Booking booking) {
		this.booking = booking;
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
