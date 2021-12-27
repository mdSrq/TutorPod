package com.TutorPod.model;

public class WithdrawRequest {
	private int request_id;
	private int wallet_id;
	private int wallet_transaction_id;
	private double amount;
	private String status;
	private String remarks;
	private String date;
	public WithdrawRequest(int wallet_id, int wallet_transaction_id, double amount, String status, String remarks,
			String date) {
		super();
		this.wallet_id = wallet_id;
		this.wallet_transaction_id = wallet_transaction_id;
		this.amount = amount;
		this.status = status;
		this.remarks = remarks;
		this.date = date;
	}
	public WithdrawRequest(int request_id, int wallet_id, int wallet_transaction_id, double amount, String status,
			String remarks, String date) {
		super();
		this.request_id = request_id;
		this.wallet_id = wallet_id;
		this.wallet_transaction_id = wallet_transaction_id;
		this.amount = amount;
		this.status = status;
		this.remarks = remarks;
		this.date = date;
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
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "WithdrawRequest [request_id=" + request_id + ", wallet_id=" + wallet_id + ", wallet_transaction_id="
				+ wallet_transaction_id + ", amount=" + amount + ", status=" + status + ", remarks=" + remarks
				+ ", date=" + date + "]";
	}
	
}