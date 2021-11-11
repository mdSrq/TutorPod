package com.TutorPod.model;

public class Notification {
	private int notification_id;
	private String notification;
	private String link;
	private String datetime;
	private int user_id;
	private int tutor_id;
	private boolean seen;
	private boolean clicked;
	public Notification(int notification_id, String notification, String link, String datetime, int user_id,
			int tutor_id, boolean seen, boolean clicked) {
		super();
		this.notification_id = notification_id;
		this.notification = notification;
		this.link = link;
		this.datetime = datetime;
		this.user_id = user_id;
		this.tutor_id = tutor_id;
		this.seen = seen;
		this.clicked = clicked;
	}
	public Notification(String notification, String link, String datetime, int user_id, int tutor_id, boolean seen,
			boolean clicked) {
		super();
		this.notification = notification;
		this.link = link;
		this.datetime = datetime;
		this.user_id = user_id;
		this.tutor_id = tutor_id;
		this.seen = seen;
		this.clicked = clicked;
	}
	
	public boolean isSeen() {
		return seen;
	}
	public void setSeen(boolean seen) {
		this.seen = seen;
	}
	public boolean isClicked() {
		return clicked;
	}
	public void setClicked(boolean clicked) {
		this.clicked = clicked;
	}
	public int getNotification_id() {
		return notification_id;
	}
	public void setNotification_id(int notification_id) {
		this.notification_id = notification_id;
	}
	public String getNotification() {
		return notification;
	}
	public void setNotification(String notification) {
		this.notification = notification;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getTutor_id() {
		return tutor_id;
	}
	public void setTutor_id(int tutor_id) {
		this.tutor_id = tutor_id;
	}
	@Override
	public String toString() {
		return "Notification [notification_id=" + notification_id + ", notification=" + notification + ", link=" + link
				+ ", datetime=" + datetime + ", user_id=" + user_id + ", tutor_id=" + tutor_id + ", seen=" + seen
				+ ", clicked=" + clicked + "]";
	}
}
