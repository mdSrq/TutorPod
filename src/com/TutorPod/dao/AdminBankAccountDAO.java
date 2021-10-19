package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.AdminBankAccount;

public class AdminBankAccountDAO {
	private DataSource dataSource;
	public AdminBankAccountDAO(DataSource dataSource){
		super();
		this.dataSource = dataSource;
	}
	public List<AdminBankAccount>getAdminBankAcccounts()throws Exception{
		List<AdminBankAccount> bankAccs = new ArrayList<>();
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			
			Stmt = Conn.createStatement();
			
			String sql = "select * from admin_bank_acc "
					+ "inner join bank_acc on admin_bank_acc.bank_acc_id = bank_acc.bank_acc_id "
					+ "inner join admin on admin_bank_acc.admin_id = admin.admin_id "
					+ "order by admin_bank_acc_id desc";
			
			Rs = Stmt.executeQuery(sql);
			
			while(Rs.next())
				bankAccs.add(createAdminBankAcc(Rs));
			
			return bankAccs;
		}finally {
			close(Conn,Stmt,Rs);
		}
	}
	public AdminBankAccount getAdminBankAccount(int admin_bank_acc_no)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from admin_bank_acc "
					+ "inner join bank_acc on admin_bank_acc.bank_acc_id = bank_acc.bank_acc_id "
					+ "inner join admin on admin_bank_acc.admin_id = admin.admin_id "
					+ "where admin_bank_acc_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, admin_bank_acc_no);
			Rs = Stmt.executeQuery();
			if(Rs.next())
				return createAdminBankAcc(Rs);
			else 
				return null;
		}finally {
			close(Conn,Stmt,Rs);
		}
	}
	private void close(Connection Conn, Statement Stmt, ResultSet Rs) {

		try {
			if (Rs != null)
				Rs.close();
			if (Stmt != null)
				Stmt.close();
			if (Conn != null) 
				Conn.close();   // doesn't really close it ... just puts back in connection pool
		}
		catch (Exception exc) {
			exc.printStackTrace();
		}
	}
	private AdminBankAccount createAdminBankAcc(ResultSet Rs)throws Exception {
		int admin_bank_acc_id = Rs.getInt("admin_bank_acc_id");
		int admin_id = Rs.getInt("admin_id");
		String name = Rs.getString("name");
		int bank_acc_id = Rs.getInt("bank_acc_id");
		String bank_name = Rs.getString("bank_name");
		String acc_no = Rs.getString("acc_no");
		String holder_name = Rs.getString("holder_name");
		String ifsc_code = Rs.getString("ifsc_code");
		long balance = Rs.getLong("balance");
		boolean selected = Rs.getBoolean("selected");
		return new AdminBankAccount(admin_bank_acc_id,admin_id,name,bank_acc_id,bank_name,acc_no,holder_name,ifsc_code,balance,selected);
	}
}
