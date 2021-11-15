package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.User;

public class UserDAO {
	private DataSource dataSource;
	public UserDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<User> getUsers() throws Exception{
		List<User> users = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from user order by user_id desc";
			
			Stmt = Conn.createStatement();
			
			Rs = Stmt.executeQuery(sql);
			
			while (Rs.next())
				users.add(createUser(Rs));				
			
			return users;		
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public User getUser(int user_id)throws Exception{
		User user=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from user where user_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				user = createUser(Rs);
			}
			return user;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public User getUser(String username)throws Exception{
		User user=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from user where username = binary ?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, username);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				user = createUser(Rs);
			}
			return user;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public User getRecentUser()throws Exception{
		User user=null;
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from user order by user_id desc limit 1";
			Stmt = Conn.createStatement();
			Rs = Stmt.executeQuery(sql);
			if(Rs.next()) {
				user = createUser(Rs);
			}
			return user;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	
	public boolean addUser(User user)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into user(fname, lname, username, password, email_id, mobile_no, gender, profile_status,joining_date) values(?,?,?,?,?,?,?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, user.getFname());
			Stmt.setString(2, user.getLname());
			Stmt.setString(3, user.getUsername());
			Stmt.setString(4, user.getPassword());
			Stmt.setString(5, user.getEmail_id());
			Stmt.setString(6, user.getMobile_no());
			Stmt.setString(7, user.getGender());
			Stmt.setString(8, user.getProfile_status());
			Stmt.setString(9, user.getJoining_date());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateUser(User user)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update user set fname=?, lname=?, username=?, password=?, email_id=?, mobile_no=?, gender=?, photo=?, profile_status=?,joining_date=?,tutor_id=?,wallet_id=?,bank_acc_id=? where user_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, user.getFname());
			Stmt.setString(2, user.getLname());
			Stmt.setString(3, user.getUsername());
			Stmt.setString(4, user.getPassword());
			Stmt.setString(5, user.getEmail_id());
			Stmt.setString(6, user.getMobile_no());
			Stmt.setString(7, user.getGender());
			Stmt.setString(8, user.getPhoto());
			Stmt.setString(9, user.getProfile_status());
			Stmt.setString(10, user.getJoining_date());
			Stmt.setInt(11, user.getTutor_id());
			Stmt.setInt(12, user.getWallet_id());
			Stmt.setInt(13, user.getBank_acc_id());
			Stmt.setInt(14, user.getUser_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateUserField(String field,String data,boolean isInt,int user_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update user set "+field+"=? where user_id=? ";
			Stmt = Conn.prepareStatement(sql);
			if(isInt) 
				Stmt.setInt(1, Integer.parseInt(data));
			else
				Stmt.setString(1, data);
			Stmt.setInt(2, user_id);
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteUser(int user_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from user where user_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
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
	private User createUser(ResultSet Rs)throws Exception{
		int user_id = Rs.getInt("user_id");
		String fname = Rs.getString("fname");
		String lname = Rs.getString("lname");
		String username = Rs.getString("username");
		String password = Rs.getString("password");
		String email_id = Rs.getString("email_id");
		String mobile_no = Rs.getString("mobile_no");
		String gender = Rs.getString("gender");
		String photo = Rs.getString("photo");
		String profile_status = Rs.getString("profile_status");
		String joining_date = Rs.getString("joining_date");
		int tutor_id = Rs.getInt("tutor_id");
		int wallet_id = Rs.getInt("wallet_id");
		int bank_acc_id = Rs.getInt("bank_acc_id");
		return new User(user_id, fname, lname, username, password, email_id, mobile_no, gender, photo, profile_status,joining_date,tutor_id,wallet_id,bank_acc_id);
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
