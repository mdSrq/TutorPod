package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

import javax.sql.DataSource;

import com.TutorPod.model.Course;
import com.TutorPod.model.CourseSubject;
import com.TutorPod.model.CourseSubjects;

public class CourseSubjectDAO {
	private DataSource dataSource;
	private CourseDAO courseDAO;
	private CourseSubDAO courseSubDAO;
	private SubjectDAO subjectDAO;
	public CourseSubjectDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
		courseDAO = new CourseDAO(dataSource);
		courseSubDAO = new CourseSubDAO(dataSource);
		subjectDAO = new SubjectDAO(dataSource);
	}
	public List<CourseSubject> getCourseSubjects(String selector) throws Exception{
		List<CourseSubject> courseSubjects = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from course_sub "
					+ "inner join subject on course_sub.subject_id=subject.subject_id "
					+ "inner join course on course_sub.course_id=course.course_id "
					+ "order by course_sub.course_sub_id desc ";
			if(selector.equals("Recent"))
				sql += "limit 5";
			
			Stmt = Conn.createStatement();
			
			// execute query
			Rs = Stmt.executeQuery(sql);
			
			// process result set
			while (Rs.next()) {
				
				CourseSubject tempSubject = createCourseSubject(Rs);
				courseSubjects.add(tempSubject);				
			}
			
			return courseSubjects;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public List<CourseSubject> getCourseSubjectsByCourseId(int course_id) throws Exception{
		List<CourseSubject> courseSubjects = new ArrayList<>();
		
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from course_sub "
					+ "inner join subject on course_sub.subject_id=subject.subject_id "
					+ "inner join course on course_sub.course_id=course.course_id "
					+ "where course_sub.course_id=? "
					+ "order by course_sub.duration_no ASC, subject.subject_code ASC";
			
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, course_id);
			Rs = Stmt.executeQuery();
			
			while (Rs.next()) {
				CourseSubject tempSubject = createCourseSubject(Rs);
				courseSubjects.add(tempSubject);				
			}
			
			return courseSubjects;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	
	public CourseSubject getCourseSubject(int course_sub_id)throws Exception{
		CourseSubject courseSubject=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from course_sub "
					+ "inner join subject on course_sub.subject_id=subject.subject_id "
					+ "inner join course on course_sub.course_id=course.course_id "
					+ "where course_sub_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, course_sub_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				courseSubject = createCourseSubject(Rs);
			}
			return courseSubject;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}	
	public List<CourseSubjects> getCourseSubjects()throws Exception{
		List<CourseSubjects> courseSubjects = new ArrayList<>();
		ListIterator<Course> courses = courseDAO.getCourses("All").listIterator();
		while(courses.hasNext()) {
			int course_id = courses.next().getCourse_id();
			List<CourseSubject> subjects = getCourseSubjectsByCourseId(course_id);
			courseSubjects.add(new CourseSubjects(course_id, subjects));
		}
		return courseSubjects;
	}
	public boolean deleteCourseSubject(int course_sub_id,int subject_id) throws Exception{
		boolean courseSubProcessed = courseSubDAO.deleteCourseSub(course_sub_id);
		boolean subjectProcessed=false;
		if(courseSubDAO.getCourseSubsBySubjectId(subject_id).size() < 1 ) {
			subjectProcessed = subjectDAO.deleteSubject(subject_id);
		}else {
			subjectProcessed = true;
		}
		if(courseSubProcessed && subjectProcessed)
			return true;
		else
			return false;
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
	private CourseSubject createCourseSubject(ResultSet Rs)throws Exception {
		int course_sub_id = Rs.getInt("course_sub_id");
		int course_id = Rs.getInt("course_id");
		int duration_no = Rs.getInt("duration_no");
		int subject_id = Rs.getInt("subject_id"); 
		String subject_name = Rs.getString("subject_name");
		String subject_code = Rs.getString("subject_code");
		String course_name = Rs.getString("course_name");
		String name_abbr = Rs.getString("name_abbr");
		String duration_type = Rs.getString("duration_type");
		int duration = Rs.getInt("duration");
		
		return new CourseSubject(course_sub_id,course_id,duration_no,subject_id,subject_name,subject_code,course_name,name_abbr,duration_type,duration);
	}
}
