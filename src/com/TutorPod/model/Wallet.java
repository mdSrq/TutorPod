package com.TutorPod.model;

public class Wallet {
	private int wallet_id;
	private double balance;
	private int user_id;
	public Wallet(int wallet_id, double balance, int user_id) {
		super();
		this.wallet_id = wallet_id;
		this.balance = balance;
		this.user_id = user_id;
	}
	public Wallet(double balance, int user_id) {
		super();
		this.balance = balance;
		this.user_id = user_id;
	}
	public int getWallet_id() {
		return wallet_id;
	}
	public void setWallet_id(int wallet_id) {
		this.wallet_id = wallet_id;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	@Override
	public String toString() {
		return "Wallet [wallet_id=" + wallet_id + ", balance=" + balance + ", user_id=" + user_id + "]";
	}
}
