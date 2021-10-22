package com.TutorPod.model;

public class BankAcc {
	private int bank_acc_id;
	private String bank_name;
	private String acc_no;
	private String holder_name;
	private String ifsc_code;
	private long balance;
	public BankAcc(int bank_acc_id, String bank_name, String acc_no, String holder_name, String ifsc_code,
			long balance) {
		super();
		this.bank_acc_id = bank_acc_id;
		this.bank_name = bank_name;
		this.acc_no = acc_no;
		this.holder_name = holder_name;
		this.ifsc_code = ifsc_code;
		this.balance = balance;
	}
	public BankAcc(String bank_name, String acc_no, String holder_name, String ifsc_code, long balance) {
		super();
		this.bank_name = bank_name;
		this.acc_no = acc_no;
		this.holder_name = holder_name;
		this.ifsc_code = ifsc_code;
		this.balance = balance;
	}
	public int getBank_acc_id() {
		return bank_acc_id;
	}
	public void setBank_acc_id(int bank_acc_id) {
		this.bank_acc_id = bank_acc_id;
	}
	public long getBalance() {
		return balance;
	}
	public void setBalance(long balance) {
		this.balance = balance;
	}
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	public String getAcc_no() {
		return acc_no;
	}
	public void setAcc_no(String acc_no) {
		this.acc_no = acc_no;
	}
	public String getHolder_name() {
		return holder_name;
	}
	public void setHolder_name(String holder_name) {
		this.holder_name = holder_name;
	}
	public String getIfsc_code() {
		return ifsc_code;
	}
	public void setIfsc_code(String ifsc_code) {
		this.ifsc_code = ifsc_code;
	}
	@Override
	public String toString() {
		return "BankAcc [bank_acc_id=" + bank_acc_id + ", bank_name=" + bank_name + ", acc_no=" + acc_no
				+ ", holder_name=" + holder_name + ", ifsc_code=" + ifsc_code + ", balance=" + balance + "]";
	}
	
}