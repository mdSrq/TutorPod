package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Lesson;
import com.TutorPod.model.LessonDetails;

public class LessonDAO {
	 DataSource dataSource;
	public LessonDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<LessonDetails> getLessons(String selector) throws Exception{
		List<LessonDetails> lessons = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from lesson inner join booking on lesson.booking_id = booking.booking_id ";
			
			switch(selector) {
			case"Completed":
				sql += "where status='Completed' ";
				break;
			case"Scheduled":
				sql += "where status='Scheduled' ";
				break;
			case"Unscheduled":
				sql += "where status='Unscheduled' ";
				break;
			case"Cancelled":
				sql += "where status='Cancelled' ";
				break;
			}
			sql+="order by lesson_id desc";
			Stmt = Conn.createStatement();
			
			// execute query
			Rs = Stmt.executeQuery(sql);
			
			// process result set
			while (Rs.next()) {
				lessons.add(createLessonDetails(Rs));
			}
			
			return lessons;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public List<LessonDetails> getLessonByTutorID(int tutor_id,String selector)throws Exception{
		List<LessonDetails> lessons = new ArrayList<>();
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from lesson inner join booking on lesson.booking_id = booking.booking_id where booking.tutor_id=? ";
			switch(selector) {
			case"Completed":
				sql += "and status='Completed'";
				break;
			case"Scheduled":
				sql += "and status='Scheduled'";
				break;
			case"Unscheduled":
				sql += "and status='Unscheduled'";
				break;
			case"Cancelled":
				sql += "and status='Cancelled'";
				break;
			}
			sql+=" order by lesson_id desc";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, tutor_id);
			Rs = Stmt.executeQuery();
			while(Rs.next()) {
				lessons.add(createLessonDetails(Rs));
			}
			return lessons;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public List<LessonDetails> getLessonByUserID(int user_id,String selector)throws Exception{
		List<LessonDetails> lessons = new ArrayList<>();
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from lesson inner join booking on lesson.booking_id = booking.booking_id where booking.user_id=? ";
			switch(selector) {
			case"Completed":
				sql += "and status='Completed'";
				break;
			case"Scheduled":
				sql += "and status='Scheduled'";
				break;
			case"Unscheduled":
				sql += "and status='Unscheduled'";
				break;
			case"Cancelled":
				sql += "and status='Cancelled'";
				break;
			}
			sql+=" order by lesson_id desc";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
			Rs = Stmt.executeQuery();
			while(Rs.next()) {
				lessons.add(createLessonDetails(Rs));
			}
			return lessons;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Lesson getLesson(int lesson_id)throws Exception{
		Lesson lesson=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from lesson where lesson_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, lesson_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				lesson = createLesson(Rs);
			}
			return lesson;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addLesson(Lesson lesson)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into lesson(booking_id,meeting_link,notes,time_from,time_to,date,status) values(?,?,?,?,?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, lesson.getBooking_id());
			Stmt.setString(2, lesson.getMeeting_link());
			Stmt.setString(3, lesson.getNotes());
			Stmt.setString(4, lesson.getTime_from());
			Stmt.setString(5, lesson.getTime_to());
			Stmt.setString(6, lesson.getDate());
			Stmt.setString(7, lesson.getStatus());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateLesson(Lesson lesson)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update lesson set booking_id=?,meeting_link=?,notes=?,time_from=?,time_to=?,date=?,status=? where lesson_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, lesson.getBooking_id());
			Stmt.setString(2, lesson.getMeeting_link());
			Stmt.setString(3, lesson.getNotes());
			Stmt.setString(4, lesson.getTime_from());
			Stmt.setString(5, lesson.getTime_to());
			Stmt.setString(6, lesson.getDate());
			Stmt.setString(7, lesson.getStatus());
			Stmt.setInt(8, lesson.getLesson_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteLesson(int lesson_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from lesson where lesson_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, lesson_id);
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
	private Lesson createLesson(ResultSet Rs)throws Exception {
		 int lesson_id = Rs.getInt("lesson_id");
		 int booking_id = Rs.getInt("booking_id");
		 String meeting_link = Rs.getString("meeting_link");
		 String notes = Rs.getString("notes");
		 String time_from = Rs.getString("time_from");
		 String time_to = Rs.getString("time_to");
		 String date = Rs.getString("date");
		 String status = Rs.getString("status");
		 
		return new Lesson(lesson_id,booking_id,meeting_link,notes,time_from,time_to,date,status);
	}
	private LessonDetails createLessonDetails(ResultSet Rs)throws Exception{
		int lesson_id = Rs.getInt("lesson_id");
		int booking_id = Rs.getInt("booking_id");
		String meeting_link = Rs.getString("meeting_link");
		String notes = Rs.getString("notes");
		String time_from = Rs.getString("time_from");
		String time_to = Rs.getString("time_to");
		String date = Rs.getString("date");
		String status = Rs.getString("status");
		int tutor_id = Rs.getInt("tutor_id");
		int user_id = Rs.getInt("user_id");
		int subject_id = Rs.getInt("subject_id");
		double price = Rs.getDouble("price");
		double duration = Rs.getDouble("duration");
		int no_of_lesson = Rs.getInt("no_of_lesson");
		int transaction_id = Rs.getInt("transaction_id");
		String booking_status = Rs.getString("booking_status");
		
		return new LessonDetails(lesson_id,booking_id,meeting_link,notes,time_from,time_to,date,status,tutor_id,user_id,subject_id,price,duration,no_of_lesson,transaction_id,booking_status);
	}
}
