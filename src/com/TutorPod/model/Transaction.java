package com.TutorPod.model;

public class Transaction {
	private int transaction_id;
	private String payer;
	private int payer_id;
	private String receiver;
	private int receiver_id;
	private double amount;
	private String description;
	private String date;
	private String datetime;
	public Transaction(int transaction_id, String payer, int payer_id, String receiver, int receiver_id, double amount,
			String description, String date, String datetime) {
		super();
		this.transaction_id = transaction_id;
		this.payer = payer;
		this.payer_id = payer_id;
		this.receiver = receiver;
		this.receiver_id = receiver_id;
		this.amount = amount;
		this.description = description;
		this.date = date;
		this.datetime = datetime;
	}
	public Transaction(String payer, int payer_id, String receiver, int receiver_id, double amount, String description, String date, String datetime) {
		super();
		this.payer = payer;
		this.payer_id = payer_id;
		this.receiver = receiver;
		this.receiver_id = receiver_id;
		this.amount = amount;
		this.description = description;
		this.date = date;
		this.datetime = datetime;
	}
	public int getTransaction_id() {
		return transaction_id;
	}
	public void setTransaction_id(int transaction_id) {
		this.transaction_id = transaction_id;
	}
	public String getPayer() {
		return payer;
	}
	public void setPayer(String payer) {
		this.payer = payer;
	}
	public int getPayer_id() {
		return payer_id;
	}
	public void setPayer_id(int payer_id) {
		this.payer_id = payer_id;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public int getReceiver_id() {
		return receiver_id;
	}
	public void setReceiver_id(int receiver_id) {
		this.receiver_id = receiver_id;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	
}