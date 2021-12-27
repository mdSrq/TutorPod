package com.TutorPod.model;

public class WithdrawRequestDetails {
	private int request_id;
	private int wallet_id;
	private int wallet_transaction_id;
	private double amount;
	private String status;
	private String date;
	private String remarks;
	private User user;
	private BankAcc bankAcc;
	public WithdrawRequestDetails(int request_id, int wallet_id, int wallet_transaction_id, double amount,
			String status, String date, String remarks, User user, BankAcc bankAcc) {
		super();
		this.request_id = request_id;
		this.wallet_id = wallet_id;
		this.wallet_transaction_id = wallet_transaction_id;
		this.amount = amount;
		this.status = status;
		this.date = date;
		this.remarks = remarks;
		this.user = user;
		this.bankAcc = bankAcc;
	}
	public int getRequest_id() {
		return request_id;
	}
	public void setRequest_id(int request_id) {
		this.request_id = request_id;
	}
	public int getWallet_id() {
		return wallet_id;
	}
	public void setWallet_id(int wallet_id) {
		this.wallet_id = wallet_id;
	}
	public int getWallet_transaction_id() {
		return wallet_transaction_id;
	}
	public void setWallet_transaction_id(int wallet_transaction_id) {
		this.wallet_transaction_id = wallet_transaction_id;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public BankAcc getBankAcc() {
		return bankAcc;
	}
	public void setBankAcc(BankAcc bankAcc) {
		this.bankAcc = bankAcc;
	}
	
}
