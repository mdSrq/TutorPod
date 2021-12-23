package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.WithdrawRequest;

public class WithdrawRequestDAO {
	private DataSource dataSource;
	public WithdrawRequestDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<WithdrawRequest> getWithdrawRequests() throws Exception{
		List<WithdrawRequest> withdraw_requests = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from withdraw_request order by request_id desc";
			
			Stmt = Conn.createStatement();
			
			// execute query
			Rs = Stmt.executeQuery(sql);
			
			// process result set
			while (Rs.next()) {
				WithdrawRequest tempWithdrawRequest = createWithdrawRequest(Rs);
				withdraw_requests.add(tempWithdrawRequest);
			}
			
			return withdraw_requests;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public List<WithdrawRequest> getWithdrawRequests(String status) throws Exception{
		List<WithdrawRequest> withdraw_requests = new ArrayList<>();
		
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from withdraw_request where status=? order by request_id desc";
			
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, status);
			// execute query
			Rs = Stmt.executeQuery();
			
			// process result set
			while (Rs.next())
				withdraw_requests.add(createWithdrawRequest(Rs));
			
			return withdraw_requests;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public WithdrawRequest getWithdrawRequest(int request_id)throws Exception{
		WithdrawRequest withdraw_request=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from withdraw_request where request_id = ?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, request_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				withdraw_request = createWithdrawRequest(Rs);
			}
			return withdraw_request;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public double getRequestedAmount(int user_id)throws Exception{
		double amount=0;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select sum(withdraw_request.amount) as requested_amount from withdraw_request inner join wallet on withdraw_request.wallet_id = wallet.wallet_id"
					+ " inner join user on wallet.user_id=user.user_id  where user.user_id = ? group by user.user_id";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
			Rs = Stmt.executeQuery();
			if(Rs.next())
				amount = Rs.getDouble("requested_amount");
			return amount;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public double getPendingLessonsAmount(int tutor_id)throws Exception{
		double amount=0;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select sum(calc) as amount from (select booking.price * booking.duration as calc from booking inner join lesson on lesson.booking_id = booking.booking_id where booking.tutor_id=? and lesson.status!='Completed' ) as t";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, tutor_id);
			Rs = Stmt.executeQuery();
			if(Rs.next())
				amount = Rs.getDouble("amount");
			return amount;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addWithdrawRequest(WithdrawRequest withdraw_request)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into withdraw_request(wallet_id,wallet_transaction_id,amount,status,remarks,date) values(?,?,?,?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, withdraw_request.getWallet_id());
			Stmt.setInt(2, withdraw_request.getWallet_transaction_id());
			Stmt.setDouble(3, withdraw_request.getAmount());
			Stmt.setString(4, withdraw_request.getStatus());
			Stmt.setString(5, withdraw_request.getRemarks());
			Stmt.setString(6, withdraw_request.getDate());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateWithdrawRequest(WithdrawRequest withdraw_request)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update withdraw_request set wallet_id=?,wallet_transaction_id=?,amount=?,status=?,remarks=?,date=? where request_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, withdraw_request.getWallet_id());
			Stmt.setInt(2, withdraw_request.getWallet_transaction_id());
			Stmt.setDouble(3, withdraw_request.getAmount());
			Stmt.setString(4, withdraw_request.getStatus());
			Stmt.setString(5, withdraw_request.getRemarks());
			Stmt.setString(6, withdraw_request.getDate());
			Stmt.setInt(7, withdraw_request.getRequest_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteWithdrawRequest(int request_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from withdraw_request where request_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, request_id);
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
	private WithdrawRequest createWithdrawRequest(ResultSet Rs)throws Exception {
		int request_id = Rs.getInt("request_id");
		int wallet_id = Rs.getInt("wallet_id");
		int wallet_transaction_id = Rs.getInt("wallet_transaction_id");
		double amount = Rs.getDouble("amount");
		String status = Rs.getString("status");
		String remarks = Rs.getString("remarks");
		String date = Rs.getString("date");
		
		return new WithdrawRequest(request_id,wallet_id,wallet_transaction_id,amount,status,remarks,date);
	}
}
