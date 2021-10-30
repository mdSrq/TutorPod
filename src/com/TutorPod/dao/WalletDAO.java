package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Wallet;

public class WalletDAO {
	private DataSource dataSource;
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
	public boolean updateWallet(Wallet wallet)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update wallet set wallet_id=?, balance=? where user_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setDouble(1, wallet.getBalance());
			Stmt.setInt(2, wallet.getUser_id());
			Stmt.setInt(3, wallet.getWallet_id());
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
	private Wallet createWallet(ResultSet Rs)throws Exception {
		int wallet_id = Rs.getInt("wallet_id");
		double balance = Rs.getDouble("balance");
		int user_id = Rs.getInt("user_id");
		return new Wallet(wallet_id, balance, user_id);
	}
	private void close(Connection Conn, Statement Stmt, ResultSet Rs) {

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
}
