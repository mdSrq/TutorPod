package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Admin;

public class AdminDAO {
	private DataSource dataSource;
	public AdminDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<Admin> getAdmins() throws Exception{
		List<Admin> admins = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from admin order by admin_id desc";
			
			Stmt = Conn.createStatement();
			
			// execute query
			Rs = Stmt.executeQuery(sql);
			
			// process result set
			while (Rs.next()) {
				
				Admin tempAdmin = createAdmin(Rs);
				admins.add(tempAdmin);				
			}
			
			return admins;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Admin getAdmin(String name)throws Exception{
		Admin admin=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from admin where name=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, name);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				admin = createAdmin(Rs);
			}
			return admin;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Admin getAdmin(int admin_id)throws Exception{
		Admin admin=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from admin where admin_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, admin_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				admin = createAdmin(Rs);
			}
			return admin;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addAdmin(Admin admin)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into admin(name,password) values(?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, admin.getName());
			Stmt.setString(2, admin.getPassword());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateAdmin(Admin admin)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update admin set name=?, password=? where admin_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, admin.getName());
			Stmt.setString(2, admin.getPassword());
			Stmt.setInt(3, admin.getAdmin_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteAdmin(int admin_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from admin where admin_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, admin_id);
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
	private Admin createAdmin(ResultSet Rs)throws Exception {
		int admin_id = Rs.getInt("admin_id");
		String name = Rs.getString("name");
		String password = Rs.getString("password");
		
		return new Admin(admin_id,name,password);
	}
}
