package com.TutorPod.model;

public class AdminBankAcc {
	private int admin_bank_acc_id;
	private int admin_id;
	private int bank_acc_id;
	private boolean selected;
	public AdminBankAcc(int admin_bank_acc_id, int admin_id, int bank_acc_id, boolean selected) {
		super();
		this.admin_bank_acc_id = admin_bank_acc_id;
		this.admin_id = admin_id;
		this.bank_acc_id = bank_acc_id;
		this.selected = selected;
	}
	public AdminBankAcc(int admin_id, int bank_acc_id, boolean selected) {
		super();
		this.admin_id = admin_id;
		this.bank_acc_id = bank_acc_id;
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
	public int getBank_acc_id() {
		return bank_acc_id;
	}
	public void setBank_acc_id(int bank_acc_id) {
		this.bank_acc_id = bank_acc_id;
	}
	public boolean isSelected() {
		return selected;
	}
	public void setSelected(boolean selected) {
		this.selected = selected;
	}
	@Override
	public String toString() {
		return "AdminBankAcc [admin_bank_acc_id=" + admin_bank_acc_id + ", admin_id=" + admin_id + ", bank_acc_id="
				+ bank_acc_id + ", selected=" + selected + "]";
	}
}
