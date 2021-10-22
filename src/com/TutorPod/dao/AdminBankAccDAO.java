package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.AdminBankAcc;

public class AdminBankAccDAO {
	private DataSource dataSource;
	public AdminBankAccDAO(DataSource dataSource){
		super();
		this.dataSource = dataSource;
	}
	public List<AdminBankAcc>getAdminBankAccs()throws Exception{
		List<AdminBankAcc> bankAccs = new ArrayList<>();
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			
			Stmt = Conn.createStatement();
			
			String sql = "select * from admin_bank_acc order by admin_bank_acc_id desc";
			
			Rs = Stmt.executeQuery(sql);
			
			while(Rs.next())
				bankAccs.add(createAdminBankAcc(Rs));
			
			return bankAccs;
		}finally {
			close(Conn,Stmt,Rs);
		}
	}
	public AdminBankAcc getAdminBankAcc(int admin_bank_acc_no)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from admin_bank_acc where admin_bank_acc_id=? ";
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
	public boolean addBankAcc(AdminBankAcc adminBankAcc)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into admin_bank_acc(admin_id,bank_acc_id,selected) values(?,?,?)";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, adminBankAcc.getAdmin_id());
			Stmt.setInt(2, adminBankAcc.getBank_acc_id());
			Stmt.setBoolean(3, adminBankAcc.isSelected());
			if(Stmt.executeUpdate()>0)
				return true;
			else 
				return false;
		}finally {
			close(Conn,Stmt,Rs);
		}
	}
	public boolean updateBankAcc(AdminBankAcc adminBankAcc)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update admin_bank_acc set admin_id=?,bank_acc_id=?,selected=? where admin_bank_acc_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, adminBankAcc.getAdmin_id());
			Stmt.setInt(2, adminBankAcc.getBank_acc_id());
			Stmt.setBoolean(3, adminBankAcc.isSelected());
			Stmt.setInt(4, adminBankAcc.getAdmin_bank_acc_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else 
				return false;
		}finally {
			close(Conn,Stmt,Rs);
		}
	}
	public boolean selectBankAcc(int admin_bank_acc_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
		Conn = dataSource.getConnection();
		Stmt = Conn.prepareStatement("update admin_bank_acc set selected=false where selected=true");
		Stmt.execute();
		Stmt.close();
		String sql = "update admin_bank_acc set selected=true where admin_bank_acc_id=?";
		Stmt = Conn.prepareStatement(sql);
		Stmt.setInt(1, admin_bank_acc_id);
		if(Stmt.executeUpdate()>0)
			return true;
		else 
			return false;
		}finally {
			close(Conn,Stmt,null);
		}
	}
	public boolean deleteBankAcc(int admin_bank_acc_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from admin_bank_acc where admin_bank_acc_id=?";
			Stmt = Conn.prepareStatement(sql);

			Stmt.setInt(1, admin_bank_acc_id);
			if(Stmt.executeUpdate()>0)
				return true;
			else 
				return false;
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
	private AdminBankAcc createAdminBankAcc(ResultSet Rs)throws Exception {
		int admin_bank_acc_id = Rs.getInt("admin_bank_acc_id");
		int admin_id = Rs.getInt("admin_id");
		int bank_acc_id = Rs.getInt("bank_acc_id");
		boolean selected = Rs.getBoolean("selected"); 
		return new AdminBankAcc(admin_bank_acc_id,admin_id,bank_acc_id,selected);
	}
}
