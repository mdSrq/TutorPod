package com.TutorPod.model;

public class WalletTransaction {
	private int wallet_transaction_id;
	private int wallet_id;
	private double amount;
	private boolean credit;
	private boolean debit;
	private double balance;
	private String comment;
	private String status;
	private String datetime;
	public WalletTransaction(int wallet_transaction_id, int wallet_id, double amount, boolean credit, boolean debit,
			double balance, String comment, String status, String datetime) {
		super();
		this.wallet_transaction_id = wallet_transaction_id;
		this.wallet_id = wallet_id;
		this.amount = amount;
		this.credit = credit;
		this.debit = debit;
		this.balance = balance;
		this.comment = comment;
		this.status = status;
		this.datetime = datetime;
	}
	public WalletTransaction(int wallet_id, double amount, boolean credit, boolean debit, double balance,
			String comment, String status, String datetime) {
		super();
		this.wallet_id = wallet_id;
		this.amount = amount;
		this.credit = credit;
		this.debit = debit;
		this.balance = balance;
		this.comment = comment;
		this.status = status;
		this.datetime = datetime;
	}
	public int getWallet_transaction_id() {
		return wallet_transaction_id;
	}
	public void setWallet_transaction_id(int wallet_transaction_id) {
		this.wallet_transaction_id = wallet_transaction_id;
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
	public boolean isCredit() {
		return credit;
	}
	public void setCredit(boolean credit) {
		this.credit = credit;
	}
	public boolean isDebit() {
		return debit;
	}
	public void setDebit(boolean debit) {
		this.debit = debit;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	
}
/*
+-----------------------+-----------------------------------------+------+-----+---------+----------------+
| Field                 | Type                                    | Null | Key | Default | Extra          |
+-----------------------+-----------------------------------------+------+-----+---------+----------------+
| wallet_transaction_id | int                                     | NO   | PRI | NULL    | auto_increment |
| wallet_id             | int                                     | NO   |     | NULL    |                |
| amount                | double                                  | NO   |     | NULL    |                |
| credit                | tinyint(1)                              | YES  |     | NULL    |                |
| debit                 | tinyint(1)                              | YES  |     | NULL    |                |
| balance               | double                                  | NO   |     | NULL    |                |
| comment               | varchar(120)                            | NO   |     | NULL    |                |
| status                | enum('Completed','In Proccess''Failed') | NO   |     | NULL    |                |
| datetime              | datetime                                | NO   |     | NULL    |                |
+-----------------------+-----------------------------------------+------+-----+---------+----------------+
*/
