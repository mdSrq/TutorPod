package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Subject;

public class SubjectDAO {
	private DataSource dataSource;
	public SubjectDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<Subject> getSubjects() throws Exception{
		List<Subject> subjects = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from subject order by subject_id desc";
			
			Stmt = Conn.createStatement();
			
			// execute query
			Rs = Stmt.executeQuery(sql);
			
			// process result set
			while (Rs.next()) {
				
				Subject tempSubject = createSubject(Rs);
				subjects.add(tempSubject);				
			}
			
			return subjects;		
		}
		finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Subject getSubject(int subject_id)throws Exception{
		Subject subject=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from subject where subject_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, subject_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				subject = createSubject(Rs);
			}
			return subject;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Subject getSubject(String subject_code)throws Exception{
		Subject subject=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from subject where subject_code=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, subject_code);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				subject = createSubject(Rs);
			}
			return subject;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addSubject(Subject subject)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into subject(subject_name,subject_code) values(?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, subject.getSubject_name());
			Stmt.setString(2, subject.getSubject_code());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateSubject(Subject subject)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update subject set subject_name=?, subject_code=? where subject_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, subject.getSubject_name());
			Stmt.setString(2, subject.getSubject_code());
			Stmt.setInt(3, subject.getSubject_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteSubject(int subject_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from subject where subject_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, subject_id);
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
	private Subject createSubject(ResultSet Rs)throws Exception {
		int subject_id = Rs.getInt("subject_id");
		String subject_name = Rs.getString("subject_name");
		String subject_code = Rs.getString("subject_code");
		
		return new Subject(subject_id,subject_name,subject_code);
	}
}
