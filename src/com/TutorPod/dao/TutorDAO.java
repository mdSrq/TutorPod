package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Tutor;
import com.TutorPod.model.TutorBasicInfo;

public class TutorDAO {
	private DataSource dataSource;
	public TutorDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<Tutor> getTutors() throws Exception{
		List<Tutor> tutors = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from tutor order by tutor_id desc";
			
			Stmt = Conn.createStatement();
			
			Rs = Stmt.executeQuery(sql);
			
			while (Rs.next()) {
				
				Tutor tempTutor = createTutor(Rs);
				tutors.add(tempTutor);				
			}
			return tutors;
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public List<Tutor> getTutorApplications() throws Exception{
		List<Tutor> tutors = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from tutor where profile_status='Applied' order by tutor_id asc";
			
			Stmt = Conn.createStatement();
			
			Rs = Stmt.executeQuery(sql);
			
			while (Rs.next()) {
				
				Tutor tempTutor = createTutor(Rs);
				tutors.add(tempTutor);				
			}
			return tutors;
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public List<TutorBasicInfo> getTutorApplicantsBasicInfo() throws Exception{
		List<TutorBasicInfo> tutors = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from tutor inner join user on tutor.user_id = user.user_id where profile_status like 'Applied' order by tutor.tutor_id asc";
			
			Stmt = Conn.createStatement();
			
			Rs = Stmt.executeQuery(sql);
			
			while (Rs.next()) {
				
				TutorBasicInfo tempTutor = createTutorBasicInfo(Rs);
				tutors.add(tempTutor);
			}
			return tutors;
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public TutorBasicInfo getTutorBasicInfo(int tutor_id)throws Exception{
		TutorBasicInfo tutor=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from tutor inner join user on tutor.user_id = user.user_id where tutor.tutor_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, tutor_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				tutor = createTutorBasicInfo(Rs);
			}
			return tutor;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Tutor getTutor(int tutor_id)throws Exception{
		Tutor tutor=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from tutor where tutor_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, tutor_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				tutor = createTutor(Rs);
			}
			return tutor;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public List<String[]> getLanguages()throws Exception{
		List<String[]> languages = new ArrayList<>();
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from language order by language_id";
			
			Stmt = Conn.createStatement();
			
			Rs = Stmt.executeQuery(sql);

			while (Rs.next()) {
				String [] language = {""+Rs.getInt("language_id"),Rs.getString("language_name")};
				languages.add(language);			
			}
			return languages;
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public List<String[]> getLanguages(int tutor_id)throws Exception{
		List<String[]> languages = new ArrayList<>();
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from language inner join language_info on language.language_id = language_info.language_id where language_info.tutor_id=? order by language.language_id";
			
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, tutor_id);
			Rs = Stmt.executeQuery();

			while (Rs.next()) {
				String [] language = {""+Rs.getInt("language_id"),Rs.getString("language_name")};
				languages.add(language);			
			}
			return languages;
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean deleteLanguageInfo(int tutor_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from language_info where tutor_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, tutor_id);
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}
	}
	public boolean addLanguage(int language_id,int tutor_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into language_info(tutor_id,language_id) values(?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, tutor_id);
			Stmt.setInt(2, language_id);
			return (Stmt.executeUpdate()>0);
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public Tutor getTutorByUserID(int user_id)throws Exception{
		Tutor tutor=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from tutor where user_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				tutor = createTutor(Rs);
			}
			return tutor;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addTutor(Tutor tutor)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into tutor(bio,profile_status,user_id) values(?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, tutor.getBio());
			Stmt.setString(2, tutor.getProfile_status());
			Stmt.setInt(3, tutor.getUser_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateTutor(Tutor tutor)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update tutor set bio=?, approval_date=?, profile_status=?, address_id=? where tutor_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, tutor.getBio());
			Stmt.setString(2, tutor.getApproval_date());
			Stmt.setString(3, tutor.getProfile_status());
			Stmt.setInt(4, tutor.getAddress_id());
			Stmt.setInt(5, tutor.getTutor_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateTutorField(String field,String data,boolean isInt,int tutor_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update tutor set "+field+"=? where tutor_id=? ";
			Stmt = Conn.prepareStatement(sql);
			if(isInt) 
				Stmt.setInt(1, Integer.parseInt(data));
			else
				Stmt.setString(1, data);
			Stmt.setInt(2, tutor_id);
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteTutor(int tutor_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from tutor where tutor_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, tutor_id);
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
	private Tutor createTutor(ResultSet Rs)throws Exception{
		int tutor_id = Rs.getInt("tutor_id");
		String bio = Rs.getString("bio");
		String approval_date = Rs.getString("approval_date");
		String profile_status = Rs.getString("profile_status");
		int user_id = Rs.getInt("user_id");
		int address_id = Rs.getInt("address_id");
		return new Tutor(tutor_id, bio, approval_date, profile_status, user_id, address_id);
	}
	private TutorBasicInfo createTutorBasicInfo(ResultSet Rs)throws Exception{
		int user_id = Rs.getInt("user_id");
		String fname = Rs.getString("fname");
		String lname = Rs.getString("lname");
		String username = Rs.getString("username");
		String email_id = Rs.getString("email_id");
		String mobile_no = Rs.getString("mobile_no");
		String gender = Rs.getString("gender");
		String photo = Rs.getString("photo");
		String joining_date = Rs.getString("joining_date");
		int tutor_id = Rs.getInt("tutor_id");
		String bio = Rs.getString("bio");
		String approval_date = Rs.getString("approval_date");
		String profile_status = Rs.getString("profile_status");
		return new TutorBasicInfo(user_id,fname,lname,username,email_id,
				mobile_no, gender, photo, joining_date, tutor_id, bio,
				approval_date, profile_status);
	}
}
