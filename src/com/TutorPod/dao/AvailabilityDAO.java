package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Availability;

public class AvailabilityDAO {
	 DataSource dataSource;
	public AvailabilityDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<Availability> getAllAvailability(int tutor_id) throws Exception{
		List<Availability> availability = new ArrayList<>();
		
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from availability where tutor_id=? order by availability_id desc";
			
			
			Stmt = Conn.prepareStatement(sql);
			
			Stmt.setInt(1, tutor_id);
			
			// execute query
			Rs = Stmt.executeQuery(sql);
			
			// process result set
			while (Rs.next()) {

				Availability tempAvailability = createAvailability(Rs);
				availability.add(tempAvailability);
			}
			
			return availability;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public List<Availability> getWeeklyAvailability(int tutor_id) throws Exception{
		List<Availability> availability = new ArrayList<>();
		
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from availability where tutor_id=? and avail_date is null";
			
			
			Stmt = Conn.prepareStatement(sql);
			
			Stmt.setInt(1, tutor_id);
			
			// execute query
			Rs = Stmt.executeQuery(sql);
			
			// process result set
			while (Rs.next()) {

				Availability tempAvailability = createAvailability(Rs);
				availability.add(tempAvailability);
			}
			
			return availability;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Availability getAvailability(int availability_id)throws Exception{
		Availability availability=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from availability where availability_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, availability_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				availability = createAvailability(Rs);
			}
			return availability;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addWeekAvailability(Availability availability)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into availability(tutor_id,day_of_week,time_from,time_to) values(?,?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, availability.getAvailability_id());
			Stmt.setInt(2, availability.getDay_of_week());
			Stmt.setString(3, availability.getTime_from());
			Stmt.setString(4, availability.getTime_to());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean addDateAvailability(Availability availability)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into availability(tutor_id,avail_date,time_from,time_to) values(?,?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, availability.getAvailability_id());
			Stmt.setInt(2, availability.getDay_of_week());
			Stmt.setString(3, availability.getTime_from());
			Stmt.setString(4, availability.getTime_to());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateAvailability(Availability availability)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update availability set tutor_id =? ,day_of_week =? ,avail_date =? ,time_from =? ,time_to =? where availability_id =? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, availability.getTutor_id());
			Stmt.setInt(2, availability.getDay_of_week());
			Stmt.setString(3, availability.getAvail_date());
			Stmt.setString(4, availability.getTime_from());
			Stmt.setString(5, availability.getTime_to());
			Stmt.setInt(6, availability.getAvailability_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteAvailability(int availability_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from availability where availability_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, availability_id);
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
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
	private Availability createAvailability(ResultSet Rs)throws Exception {
		 int availability_id = Rs.getInt("availability_id");
		 int tutor_id = Rs.getInt("tutor_id");
		 int day_of_week = Rs.getInt("day_of_week");
		 String avail_date = Rs.getString("avail_date");
		 String time_from = Rs.getString("time_from");
		 String time_to = Rs.getString("time_to");
		
		return new Availability(availability_id,tutor_id,day_of_week,avail_date,time_from,time_to);
	}
}
