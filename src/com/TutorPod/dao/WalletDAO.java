package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Wallet;
import com.TutorPod.model.WalletTransaction;

public class WalletDAO {
	 DataSource dataSource;
	public WalletDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<Wallet> getWallets() throws Exception{
		List<Wallet> wallets = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from wallet order by wallet_id desc";
			
			Stmt = Conn.createStatement();
			
			Rs = Stmt.executeQuery(sql);
			
			while (Rs.next())
				wallets.add(createWallet(Rs));				
			
			return wallets;		
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public List<WalletTransaction> getWalletTransactions(int wallet_id) throws Exception{
		List<WalletTransaction> wallets = new ArrayList<>();
		
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from wallet_transaction where wallet_id=? order by wallet_transaction_id desc";
			
			Stmt = Conn.prepareStatement(sql);
			
			Stmt.setInt(1, wallet_id);
			
			Rs = Stmt.executeQuery();
			
			while (Rs.next())
				wallets.add(createWalletTransaction(Rs));				
			
			return wallets;		
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addWallet(Wallet wallet)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into wallet(balance, user_id) values(?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setDouble(1, wallet.getBalance());
			Stmt.setInt(2, wallet.getUser_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean addWalletTransaction(WalletTransaction txn)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into wallet_transaction(wallet_id, amount, credit, debit, balance, comment, status, datetime)"
					+ " values(?,?,?,?,?,?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, txn.getWallet_id());
			Stmt.setDouble(2, txn.getAmount());
			Stmt.setBoolean(3, txn.isCredit());
			Stmt.setBoolean(4, txn.isDebit());
			Stmt.setDouble(5, txn.getBalance());
			Stmt.setString(6, txn.getComment());
			Stmt.setString(7, txn.getStatus());
			Stmt.setString(8, txn.getDatetime());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public Wallet getRecentWallet()throws Exception{
		Wallet wallet=null;
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from wallet order by wallet_id desc limit 1";
			Stmt = Conn.createStatement();
			Rs = Stmt.executeQuery(sql);
			if(Rs.next()) {
				wallet = createWallet(Rs);
			}
			return wallet;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Wallet getWalletByUserID(int user_id)throws Exception{
		Wallet wallet=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from wallet where user_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				wallet = createWallet(Rs);
			}
			return wallet;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Wallet getWallet(int wallet_id)throws Exception{
		Wallet wallet=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from wallet where wallet_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, wallet_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				wallet = createWallet(Rs);
			}
			return wallet;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public WalletTransaction getRecentWalletTransaction()throws Exception{
		WalletTransaction wallet=null;
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from wallet_transaction order by wallet_transaction_id desc limit 1";
			Stmt = Conn.createStatement();
			Rs = Stmt.executeQuery(sql);
			if(Rs.next()) {
				wallet = createWalletTransaction(Rs);
			}
			return wallet;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean updateWallet(Wallet wallet)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update wallet set wallet_id=?, balance=? where user_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, wallet.getWallet_id());
			Stmt.setDouble(2, wallet.getBalance());
			Stmt.setInt(3, wallet.getUser_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteWallet(int wallet_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from wallet where wallet_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, wallet_id);
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	 Wallet createWallet(ResultSet Rs)throws Exception {
		int wallet_id = Rs.getInt("wallet_id");
		double balance = Rs.getDouble("balance");
		int user_id = Rs.getInt("user_id");
		return new Wallet(wallet_id, balance, user_id);
	}
	private WalletTransaction createWalletTransaction(ResultSet Rs)throws Exception {
		 int wallet_transaction_id = Rs.getInt("wallet_transaction_id");
		 int wallet_id = Rs.getInt("wallet_id");
		 double amount = Rs.getDouble("amount");
		 boolean credit = Rs.getBoolean("credit");
		 boolean debit =  Rs.getBoolean("debit");
		 double balance = Rs.getDouble("balance");
		 String comment = Rs.getString("comment");
		 String status = Rs.getString("status");
		 String datetime = Rs.getString("datetime");
		 return new WalletTransaction(wallet_transaction_id,wallet_id,amount,credit,debit,balance,comment,status,datetime);
		 
	}
	 void close(Connection Conn, Statement Stmt, ResultSet Rs) {

		try {
			if (Rs != null) {
				Rs.close();
			}
			if (Stmt != null) {
				Stmt.close();
			}
			if (Conn != null) {
				Conn.close();   // doesn't really close it ... just puts back in connection pool
			}
		}
		catch (Exception exc) {
			exc.printStackTrace();
		}
	}
	 public void setAutoCommit(int setValue)throws Exception {
			String sql = "set autocommit="+setValue;
			Connection Conn = dataSource.getConnection();
			Statement Stmt = Conn.createStatement();
			Stmt.execute(sql);
			close(Conn,Stmt,null);
		}
		public void Commit()throws Exception {
			Connection Conn = dataSource.getConnection();
			Statement Stmt = Conn.createStatement();
			Stmt.execute("commit");
			close(Conn,Stmt,null);
		}
		public void Rollback()throws Exception {
			Connection Conn = dataSource.getConnection();
			Statement Stmt = Conn.createStatement();
			Stmt.execute("rollback");
			close(Conn,Stmt,null);
		}
}
