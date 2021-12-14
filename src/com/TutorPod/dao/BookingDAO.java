package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Booking;

public class BookingDAO {
	private DataSource dataSource;
	public BookingDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<Booking> getBookings() throws Exception{
		List<Booking> bookings = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from booking order by booking_id desc";
			
			Stmt = Conn.createStatement();
			
			// execute query
			Rs = Stmt.executeQuery(sql);
			
			// process result set
			while (Rs.next()) {
				Booking tempBooking = createBooking(Rs);
				bookings.add(tempBooking);				
			}
			
			return bookings;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public List<Booking> getBookings(int user_id) throws Exception{
		List<Booking> bookings = new ArrayList<>();
		
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from booking where user_id=? order by booking_id desc";
			
			Stmt = Conn.prepareStatement(sql);
			
			Stmt.setInt(1, user_id);
			// execute query
			Rs = Stmt.executeQuery();
			
			// process result set
			while (Rs.next()) {
				
				Booking tempBooking = createBooking(Rs);
				bookings.add(tempBooking);				
			}
			
			return bookings;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public List<Booking> getBookingsForTutor(int tutor_id) throws Exception{
		List<Booking> bookings = new ArrayList<>();
		
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from booking where tutor_id=? order by booking_id desc";
			
			Stmt = Conn.prepareStatement(sql);
			
			Stmt.setInt(1, tutor_id);
			// execute query
			Rs = Stmt.executeQuery();
			
			// process result set
			while (Rs.next()) {
				
				Booking tempBooking = createBooking(Rs);
				bookings.add(tempBooking);				
			}
			
			return bookings;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Booking getBooking(int booking_id)throws Exception{
		Booking booking=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from booking where booking_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, booking_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				booking = createBooking(Rs);
			}
			return booking;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Booking getRecentBooking(int user_id)throws Exception{
		Booking booking=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from booking where user_id=? order by booking_id desc limit 1";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				booking = createBooking(Rs);
			}
			return booking;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addBooking(Booking booking)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into booking(tutor_id,user_id,subject_id,price,duration,no_of_lesson,transaction_id,status) values(?,?,?,?,?,?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			
			Stmt.setInt(1, booking.getTutor_id());
			Stmt.setInt(2, booking.getUser_id());
			Stmt.setInt(3, booking.getSubject_id());
			Stmt.setDouble(4, booking.getPrice());
			Stmt.setDouble(5, booking.getDuration());
			Stmt.setInt(6, booking.getNo_of_lesson());
			Stmt.setInt(7, booking.getTransaction_id());
			Stmt.setString(8, booking.getStatus());
			
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateBooking(Booking booking)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update booking set tutor_id=?,user_id=?,subject_id=?,price=?,duration=?,no_of_lesson=?,transaction_id=?,status=? where booking_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, booking.getTutor_id());
			Stmt.setInt(2, booking.getUser_id());
			Stmt.setInt(3, booking.getSubject_id());
			Stmt.setDouble(4, booking.getPrice());
			Stmt.setDouble(5, booking.getDuration());
			Stmt.setInt(6, booking.getNo_of_lesson());
			Stmt.setInt(7, booking.getTransaction_id());
			Stmt.setString(8, booking.getStatus());
			Stmt.setInt(9, booking.getBooking_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteBooking(int booking_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from booking where booking_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, booking_id);
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
	private Booking createBooking(ResultSet Rs)throws Exception {
		int booking_id = Rs.getInt("booking_id");
		int tutor_id = Rs.getInt("tutor_id");
		int user_id = Rs.getInt("user_id");
		int subject_id = Rs.getInt("subject_id");
		double price = Rs.getDouble("price");
		double duration = Rs.getDouble("duration");
		int no_of_lesson = Rs.getInt("no_of_lesson");
		int transaction_id = Rs.getInt("transaction_id");
		String status = Rs.getString("status");
		
		return new Booking(booking_id,tutor_id,user_id,subject_id,price,duration,no_of_lesson,transaction_id,status);
	}
}
