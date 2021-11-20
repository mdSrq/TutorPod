package com.TutorPod.model;

public class Fees {
	private int fees_id;
	private int tutor_id;
	private int subject_id;
	private String subject_name;
	private double fee;
	public Fees(int fees_id, int tutor_id, int subject_id, double fee) {
		super();
		this.fees_id = fees_id;
		this.tutor_id = tutor_id;
		this.subject_id = subject_id;
		this.fee = fee;
	}
	public Fees(int tutor_id, int subject_id, double fee) {
		super();
		this.tutor_id = tutor_id;
		this.subject_id = subject_id;
		this.fee = fee;
	}
	public Fees(int fees_id, int tutor_id, int subject_id, String subject_name, double fee) {
		super();
		this.fees_id = fees_id;
		this.tutor_id = tutor_id;
		this.subject_id = subject_id;
		this.subject_name = subject_name;
		this.fee = fee;
	}
	
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}
	public int getFees_id() {
		return fees_id;
	}
	public void setFees_id(int fees_id) {
		this.fees_id = fees_id;
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
	public double getFee() {
		return fee;
	}
	public void setFee(double fee) {
		this.fee = fee;
	}
	@Override
	public String toString() {
		return "Fees [fees_id=" + fees_id + ", tutor_id=" + tutor_id + ", subject_id=" + subject_id + ", fee=" + fee
				+ "]";
	}
	
}
