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
	public Transaction getRecentTransaction(String payer,int payer_id)throws Exception{
		Transaction transaction=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from transaction where payer=? and payer_id=? order by transaction_id desc limit 1";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, payer);
			Stmt.setInt(2, payer_id);
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
	public List<Transaction> getTransactionsByPayer(String payer,int payer_id)throws Exception{
		List<Transaction> transactions = new ArrayList<>();
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from transaction where payer=? and payer_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, payer);
			Stmt.setInt(2, payer_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				transactions.add(createTransaction(Rs));
			}
			return transactions;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public List<Transaction> getTransactionsByReceiver(String receiver,int receiver_id)throws Exception{
		List<Transaction> transactions = new ArrayList<>();
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from transaction where receiver=? and receiver_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, receiver);
			Stmt.setInt(2, receiver_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				transactions.add(createTransaction(Rs));
			}
			return transactions;
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
			String sql = "insert into transaction(payer,payer_id,receiver,receiver_id,amount,description,date,datetime) values(?,?,?,?,?,?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, transaction.getPayer());
			Stmt.setInt(2, transaction.getPayer_id());
			Stmt.setString(3, transaction.getReceiver());
			Stmt.setInt(4, transaction.getReceiver_id());
			Stmt.setDouble(5, transaction.getAmount());
			Stmt.setString(6, transaction.getDescription());
			Stmt.setString(7, transaction.getDate());
			Stmt.setString(8, transaction.getDatetime());
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
			String sql = "update transaction set payer=?,payer_id=?,receiver=?,receiver_id=?,amount=?,description=?,date=?,datetime=? where transaction_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, transaction.getPayer());
			Stmt.setInt(2, transaction.getPayer_id());
			Stmt.setString(3, transaction.getReceiver());
			Stmt.setInt(4, transaction.getReceiver_id());
			Stmt.setDouble(5, transaction.getAmount());
			Stmt.setString(6, transaction.getDescription());
			Stmt.setString(7, transaction.getDate());
			Stmt.setString(8, transaction.getDatetime());
			Stmt.setInt(9, transaction.getTransaction_id());
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
		String payer = Rs.getString("payer");
		int payer_id = Rs.getInt("payer_id");
		String receiver = Rs.getString("receiver");
		int receiver_id = Rs.getInt("receiver_id");
		double amount = Rs.getDouble("amount");
		String description = Rs.getString("description");
		String date = Rs.getString("date");
		String datetime = Rs.getString("datetime");
		
		return new Transaction(transaction_id,payer,payer_id,receiver,receiver_id,amount,description,date,datetime);
	}
}
