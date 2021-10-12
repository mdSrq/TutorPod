package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Course;

public class CourseDAO {
	private DataSource dataSource;
	public CourseDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<Course> getCourses(String selector) throws Exception{
		List<Course> courses = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql;
			if(selector.equals("Recent"))
				sql = "select * from course order by course_id desc limit 5";
			else
				sql = "select * from course order by course_id desc";
			
			Stmt = Conn.createStatement();
			
			// execute query
			Rs = Stmt.executeQuery(sql);
			
			// process result set
			while (Rs.next()) {
				
				Course tempCourse = createCourse(Rs);
				courses.add(tempCourse);				
			}
			
			return courses;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Course getCourse(int course_id)throws Exception{
		Course course = null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from course where course_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, course_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				course = createCourse(Rs);
			}
			return course;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addCourse(Course course)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into course(course_name,name_abbr,duration_type,duration) values(?,?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, course.getCourse_name());
			Stmt.setString(2, course.getName_abbr());
			Stmt.setString(3, course.getDuration_type());
			Stmt.setInt(4, course.getDuration());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateCourse(Course course)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update course set course_name=?, name_abbr=?, duration_type=?, duration=? where course_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, course.getCourse_name());
			Stmt.setString(2, course.getName_abbr());
			Stmt.setString(3, course.getDuration_type());
			Stmt.setInt(4, course.getDuration());
			Stmt.setInt(5, course.getCourse_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteCourse(int course_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from course where course_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, course_id);
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
	private Course createCourse(ResultSet Rs)throws Exception {
		
		int course_id = Rs.getInt("course_id");
		String course_name = Rs.getString("course_name");
		String name_abbr = Rs.getString("name_abbr");
		String duration_type = Rs.getString("duration_type");
		int duration = Rs.getInt("duration");
		
		return new Course(course_id,course_name,name_abbr,duration_type,duration);
	}
}
