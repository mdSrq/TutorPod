package com.TutorPod.model;

import java.util.List;

public class AdminDashboardInfo {
	private double total_sales;
	private double admin_profit;
	private int total_users;
	private int total_tutors;
	private int total_bookings;
	private int total_lessons;
	private int scheduled_lessons;
	private int completed_lessons;
	private List<BookingDetails> recentBookings;
	private List<LessonDetails> recentsLessons;
	public AdminDashboardInfo(double total_sales, double admin_profit, int total_users, int total_tutors,
			int total_bookings, int total_lessons, int scheduled_lessons, int completed_lessons,
			List<BookingDetails> recentBookings, List<LessonDetails> recentsLessons) {
		super();
		this.total_sales = total_sales;
		this.admin_profit = admin_profit;
		this.total_users = total_users;
		this.total_tutors = total_tutors;
		this.total_bookings = total_bookings;
		this.total_lessons = total_lessons;
		this.scheduled_lessons = scheduled_lessons;
		this.completed_lessons = completed_lessons;
		this.recentBookings = recentBookings;
		this.recentsLessons = recentsLessons;
	}
	public double getTotal_sales() {
		return total_sales;
	}
	public void setTotal_sales(double total_sales) {
		this.total_sales = total_sales;
	}
	public double getAdmin_profit() {
		return admin_profit;
	}
	public void setAdmin_profit(double admin_profit) {
		this.admin_profit = admin_profit;
	}
	public int getTotal_users() {
		return total_users;
	}
	public void setTotal_users(int total_users) {
		this.total_users = total_users;
	}
	public int getTotal_tutors() {
		return total_tutors;
	}
	public void setTotal_tutors(int total_tutors) {
		this.total_tutors = total_tutors;
	}
	public int getTotal_bookings() {
		return total_bookings;
	}
	public void setTotal_bookings(int total_bookings) {
		this.total_bookings = total_bookings;
	}
	public int getTotal_lessons() {
		return total_lessons;
	}
	public void setTotal_lessons(int total_lessons) {
		this.total_lessons = total_lessons;
	}
	public int getScheduled_lessons() {
		return scheduled_lessons;
	}
	public void setScheduled_lessons(int scheduled_lessons) {
		this.scheduled_lessons = scheduled_lessons;
	}
	public int getCompleted_lessons() {
		return completed_lessons;
	}
	public void setCompleted_lessons(int completed_lessons) {
		this.completed_lessons = completed_lessons;
	}
	public List<BookingDetails> getRecentBookings() {
		return recentBookings;
	}
	public void setRecentBookings(List<BookingDetails> recentBookings) {
		this.recentBookings = recentBookings;
	}
	public List<LessonDetails> getRecentsLessons() {
		return recentsLessons;
	}
	public void setRecentsLessons(List<LessonDetails> recentsLessons) {
		this.recentsLessons = recentsLessons;
	}
	@Override
	public String toString() {
		return "AdminDashboardInfo [total_sales=" + total_sales + ", admin_profit=" + admin_profit + ", total_users="
				+ total_users + ", total_tutors=" + total_tutors + ", total_bookings=" + total_bookings
				+ ", total_lessons=" + total_lessons + ", scheduled_lessons=" + scheduled_lessons
				+ ", completed_lessons=" + completed_lessons + ", recentBookings=" + recentBookings
				+ ", recentsLessons=" + recentsLessons + "]";
	}
}
