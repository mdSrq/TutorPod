package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.CourseSub;

public class CourseSubDAO {
	private DataSource dataSource;
	public CourseSubDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<CourseSub> getCourseSubs() throws Exception{
		List<CourseSub> courseSubs = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from course_sub order by course_sub_id desc";
			
			Stmt = Conn.createStatement();
			
			// execute query
			Rs = Stmt.executeQuery(sql);
			
			// process result set
			while (Rs.next()) {
				
				CourseSub tempSubject = createCourseSub(Rs);
				courseSubs.add(tempSubject);				
			}
			
			return courseSubs;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public CourseSub getCourseSub(int course_sub_id)throws Exception{
		CourseSub courseSub=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from course_sub where course_sub_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, course_sub_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				courseSub = createCourseSub(Rs);
			}
			return courseSub;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public List<CourseSub> getCourseSubsBySubjectId(int subject_id)throws Exception{
		List<CourseSub> courseSubs = new ArrayList<>();
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from course_sub where subject_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, subject_id);
			Rs = Stmt.executeQuery();
			while (Rs.next()) {
				
				CourseSub tempSubject = createCourseSub(Rs);
				courseSubs.add(tempSubject);				
			}
			return courseSubs;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addCourseSub(CourseSub courseSub)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into course_sub(course_id,duration_no,subject_id) values(?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, courseSub.getCourse_id());
			Stmt.setInt(2, courseSub.getDuration_no());
			Stmt.setInt(3, courseSub.getSubject_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateCourseSub(CourseSub courseSub)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update course_sub set course_id=?, duration_no=?, subject_id=? where course_sub_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, courseSub.getCourse_id());
			Stmt.setInt(2, courseSub.getDuration_no());
			Stmt.setInt(3, courseSub.getSubject_id());
			Stmt.setInt(4, courseSub.getCourse_sub_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteCourseSub(int course_sub_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from course_sub where course_sub_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, course_sub_id);
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
	private CourseSub createCourseSub(ResultSet Rs)throws Exception {
		int course_sub_id = Rs.getInt("course_sub_id");
		int course_id = Rs.getInt("course_id");
		int duration_no = Rs.getInt("duration_no");
		int subject_id = Rs.getInt("subject_id"); 
		
		return new CourseSub(course_sub_id,course_id,duration_no,subject_id);
	}
}
