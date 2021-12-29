package com.TutorPod.model;

import java.util.List;

public class DashboardInfo {
	private double total_earning;
	private int total_lessons;
	private int completed_lessons;
	private double wallet_balance;
	private List<LessonDetails> upcoming_lessons;
	private List<LessonDetails> recent_lessons;
	public DashboardInfo(double total_earning, int total_lessons, int completed_lessons, double wallet_balance,
			List<LessonDetails> upcoming_lessons, List<LessonDetails> recent_lessons) {
		super();
		this.total_earning = total_earning;
		this.total_lessons = total_lessons;
		this.completed_lessons = completed_lessons;
		this.wallet_balance = wallet_balance;
		this.upcoming_lessons = upcoming_lessons;
		this.recent_lessons = recent_lessons;
	}
	public double getTotal_earning() {
		return total_earning;
	}
	public void setTotal_earning(double total_earning) {
		this.total_earning = total_earning;
	}
	public int getTotal_lessons() {
		return total_lessons;
	}
	public void setTotal_lessons(int total_lessons) {
		this.total_lessons = total_lessons;
	}
	public int getCompleted_lessons() {
		return completed_lessons;
	}
	public void setCompleted_lessons(int completed_lessons) {
		this.completed_lessons = completed_lessons;
	}
	public double getWallet_balance() {
		return wallet_balance;
	}
	public void setWallet_balance(double wallet_balance) {
		this.wallet_balance = wallet_balance;
	}
	public List<LessonDetails> getUpcoming_lessons() {
		return upcoming_lessons;
	}
	public void setUpcoming_lessons(List<LessonDetails> upcoming_lessons) {
		this.upcoming_lessons = upcoming_lessons;
	}
	public List<LessonDetails> getRecent_lessons() {
		return recent_lessons;
	}
	public void setRecent_lessons(List<LessonDetails> recent_lessons) {
		this.recent_lessons = recent_lessons;
	}
}
