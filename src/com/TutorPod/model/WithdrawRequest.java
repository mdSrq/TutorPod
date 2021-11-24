package com.TutorPod.model;

public class WithdrawRequest {
	private int request_id;
	private int wallet_id;
	private double amount;
	private String status;
	private String remarks;
	public WithdrawRequest(int request_id, int wallet_id, double amount, String status, String remarks) {
		super();
		this.request_id = request_id;
		this.wallet_id = wallet_id;
		this.amount = amount;
		this.status = status;
		this.remarks = remarks;
	}
	public WithdrawRequest(int wallet_id, double amount, String status, String remarks) {
		super();
		this.wallet_id = wallet_id;
		this.amount = amount;
		this.status = status;
		this.remarks = remarks;
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
}