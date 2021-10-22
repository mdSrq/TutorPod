package com.TutorPod.model;

public class AdminBankAccount {
	private int admin_bank_acc_id;
	private int admin_id;
	private String name;
	private int bank_acc_id;
	private String bank_name;
	private String acc_no;
	private String holder_name;
	private String ifsc_code;
	private long balance;
	private boolean selected;
	public AdminBankAccount(int admin_bank_acc_id, int admin_id, String name, int bank_acc_id, String bank_name,
			String acc_no, String holder_name, String ifsc_code, long balance, boolean selected) {
		super();
		this.admin_bank_acc_id = admin_bank_acc_id;
		this.admin_id = admin_id;
		this.name = name;
		this.bank_acc_id = bank_acc_id;
		this.bank_name = bank_name;
		this.acc_no = acc_no;
		this.holder_name = holder_name;
		this.ifsc_code = ifsc_code;
		this.balance = balance;
		this.selected = selected;
	}
	public int getAdmin_bank_acc_id() {
		return admin_bank_acc_id;
	}
	public void setAdmin_bank_acc_id(int admin_bank_acc_id) {
		this.admin_bank_acc_id = admin_bank_acc_id;
	}
	public int getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getBank_acc_id() {
		return bank_acc_id;
	}
	public void setBank_acc_id(int bank_acc_id) {
		this.bank_acc_id = bank_acc_id;
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
	public long getBalance() {
		return balance;
	}
	public void setBalance(long balance) {
		this.balance = balance;
	}
	public boolean isSelected() {
		return selected;
	}
	public void setSelected(boolean selected) {
		this.selected = selected;
	}
	@Override
	public String toString() {
		return "AdminBankAccount [admin_bank_acc_id=" + admin_bank_acc_id + ", admin_id=" + admin_id + ", name=" + name
				+ ", bank_acc_id=" + bank_acc_id + ", bank_name=" + bank_name + ", acc_no=" + acc_no + ", holder_name="
				+ holder_name + ", ifsc_code=" + ifsc_code + ", balance=" + balance + ", selected=" + selected + "]";
	}
}
