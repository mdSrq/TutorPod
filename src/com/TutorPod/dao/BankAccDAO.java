package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.BankAcc;

public class BankAccDAO {
	private DataSource dataSource;
	public BankAccDAO(DataSource dataSource){
		super();
		this.dataSource = dataSource;
	}
	public List<BankAcc>getBankAccs()throws Exception{
		List<BankAcc> bankAccs = new ArrayList<>();
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			
			Stmt = Conn.createStatement();
			
			String sql = "select * from bank_acc order by bank_acc_id desc";
			
			Rs = Stmt.executeQuery(sql);
			
			while(Rs.next())
				bankAccs.add(createBankAcc(Rs));
			
			return bankAccs;
		}finally {
			close(Conn,Stmt,Rs);
		}
	}
	public BankAcc getBankAcc(int bank_acc_no)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from bank_acc where bank_acc_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, bank_acc_no);
			Rs = Stmt.executeQuery();
			if(Rs.next())
				return createBankAcc(Rs);
			else 
				return null;
		}finally {
			close(Conn,Stmt,Rs);
		}
	}
	public BankAcc getMostRecentBankAcc()throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from bank_acc order by bank_acc_id desc limit 1";
			Stmt = Conn.prepareStatement(sql);
			Rs = Stmt.executeQuery();
			if(Rs.next())
				return createBankAcc(Rs);
			else 
				return null;
		}finally {
			close(Conn,Stmt,Rs);
		}
	}
	public boolean addBankAcc(BankAcc bankAcc)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into bank_acc(bank_name,acc_no,holder_name,ifsc_code,balance) values(?,?,?,?,?)";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, bankAcc.getBank_name());
			Stmt.setString(2, bankAcc.getAcc_no());
			Stmt.setString(3, bankAcc.getHolder_name());
			Stmt.setString(4, bankAcc.getIfsc_code());
			Stmt.setLong(5, bankAcc.getBalance());
			if(Stmt.executeUpdate()>0)
				return true;
			else 
				return false;
		}finally {
			close(Conn,Stmt,Rs);
		}
	}
	public boolean updateBankAcc(BankAcc bankAcc)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update bank_acc set bank_name=?, acc_no=?, holder_name=?, ifsc_code=?, balance=? where bank_acc_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, bankAcc.getBank_name());
			Stmt.setString(2, bankAcc.getAcc_no());
			Stmt.setString(3, bankAcc.getHolder_name());
			Stmt.setString(4, bankAcc.getIfsc_code());
			Stmt.setLong(5, bankAcc.getBalance());
			Stmt.setInt(6, bankAcc.getBank_acc_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else 
				return false;
		}finally {
			close(Conn,Stmt,Rs);
		}
	}
	public boolean deleteBankAcc(int bank_acc_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from bank_acc where bank_acc_id=?";
			Stmt = Conn.prepareStatement(sql);

			Stmt.setInt(1, bank_acc_id);
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
	private BankAcc createBankAcc(ResultSet Rs)throws Exception {
		int bank_acc_id = Rs.getInt("bank_acc_id");
		String bank_name = Rs.getString("bank_name");
		String acc_no = Rs.getString("acc_no");
		String holder_name = Rs.getString("holder_name");
		String ifsc_code = Rs.getString("ifsc_code");
		long balance = Rs.getLong("balance");
		return new BankAcc(bank_acc_id,bank_name,acc_no,holder_name,ifsc_code,balance);
	}
}
