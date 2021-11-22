package com.TutorPod.model;

public class Availability {
	private int availability_id;
	private int tutor_id;
	private int day_of_week;
	private String avail_date;
	private String time_from;
	private String time_to;
	public Availability(int availability_id, int tutor_id, int day_of_week, String avail_date, String time_from,
			String time_to) {
		super();
		this.availability_id = availability_id;
		this.tutor_id = tutor_id;
		this.day_of_week = day_of_week;
		this.avail_date = avail_date;
		this.time_from = time_from;
		this.time_to = time_to;
	}
	public Availability(int tutor_id, int day_of_week, String time_from, String time_to) {
		super();
		this.tutor_id = tutor_id;
		this.day_of_week = day_of_week;
		this.time_from = time_from;
		this.time_to = time_to;
	}
	public Availability( int tutor_id, String avail_date, String time_from, String time_to) {
		super();
		this.tutor_id = tutor_id;
		this.avail_date = avail_date;
		this.time_from = time_from;
		this.time_to = time_to;
	}
	public int getAvailability_id() {
		return availability_id;
	}
	public void setAvailability_id(int availability_id) {
		this.availability_id = availability_id;
	}
	public int getTutor_id() {
		return tutor_id;
	}
	public void setTutor_id(int tutor_id) {
		this.tutor_id = tutor_id;
	}
	public int getDay_of_week() {
		return day_of_week;
	}
	public void setDay_of_week(int day_of_week) {
		this.day_of_week = day_of_week;
	}
	public String getAvail_date() {
		return avail_date;
	}
	public void setAvail_date(String avail_date) {
		this.avail_date = avail_date;
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
}
/*
+-----------------+------+------+-----+---------+----------------+
| Field           | Type | Null | Key | Default | Extra          |
+-----------------+------+------+-----+---------+----------------+
| availability_id | int  | NO   | PRI | NULL    | auto_increment |
| tutor_id        | int  | NO   |     | NULL    |                |
| day_of_week     | int  | YES  | MUL | NULL    |                |
| avail_date      | date | YES  | MUL | NULL    |                |
| time_from       | time | NO   |     | NULL    |                |
| time_to         | time | NO   |     | NULL    |                |
+-----------------+------+------+-----+---------+----------------+
*/