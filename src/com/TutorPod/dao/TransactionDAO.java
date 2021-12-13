package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Transaction;

public class TransactionDAO {
	private DataSource dataSource;
	public TransactionDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<Transaction> getTransactions() throws Exception{
		List<Transaction> transactions = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from transaction order by transaction_id desc";
			
			Stmt = Conn.createStatement();
			
			// execute query
			Rs = Stmt.executeQuery(sql);
			
			// process result set
			while (Rs.next()) {
				
				Transaction tempTransaction = createTransaction(Rs);
				transactions.add(tempTransaction);				
			}
			
			return transactions;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Transaction getTransaction(int transaction_id)throws Exception{
		Transaction transaction=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from transaction where transaction_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, transaction_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				transaction = createTransaction(Rs);
			}
			return transaction;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Transaction getTransaction(String transaction_code)throws Exception{
		Transaction transaction=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from transaction where transaction_code=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, transaction_code);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				transaction = createTransaction(Rs);
			}
			return transaction;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addTransaction(Transaction transaction)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into transaction(transaction_name,transaction_code) values(?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, transaction.getTransaction_name());
			Stmt.setString(2, transaction.getTransaction_code());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateTransaction(Transaction transaction)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update transaction set transaction_name=?, transaction_code=? where transaction_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, transaction.getTransaction_name());
			Stmt.setString(2, transaction.getTransaction_code());
			Stmt.setInt(3, transaction.getTransaction_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteTransaction(int transaction_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from transaction where transaction_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, transaction_id);
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
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
	private Transaction createTransaction(ResultSet Rs)throws Exception {
		int transaction_id = Rs.getInt("transaction_id");
		String transaction_name = Rs.getString("transaction_name");
		String transaction_code = Rs.getString("transaction_code");
		
		return new Transaction(transaction_id,transaction_name,transaction_code);
	}
}
