package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Experience;

public class ExperienceDAO {
	 DataSource dataSource;
		public ExperienceDAO(DataSource dataSource) {
			super();
			this.dataSource = dataSource;
		}
		public List<Experience> getExperiences() throws Exception{
			List<Experience> experiences = new ArrayList<>();
			
			Connection Conn = null;
			Statement Stmt = null;
			ResultSet Rs = null;
			
			try {
				Conn = dataSource.getConnection();
				
				String sql = "select * from experience order by experience_id desc";
				
				Stmt = Conn.createStatement();
				
				Rs = Stmt.executeQuery(sql);
				
				while (Rs.next())
					experiences.add(createExperience(Rs));				
				
				return experiences;		
			}
			finally {
				close(Conn,Stmt,Rs);
			}	
		}
		public Experience getExperience(int experience_id)throws Exception{
			Experience experience=null;
			Connection Conn = null;
			PreparedStatement Stmt = null;
			ResultSet Rs = null;
			try {
				Conn = dataSource.getConnection();
				String sql = "select * from experience where experience_id=?";
				Stmt = Conn.prepareStatement(sql);
				Stmt.setInt(1, experience_id);
				Rs = Stmt.executeQuery();
				if(Rs.next()) {
					experience = createExperience(Rs);
				}
				return experience;
			}finally {
				// close JDBC objects
				close(Conn,Stmt,Rs);
			}	
		}
		public Experience getMostRecentExperience(int tutor_id)throws Exception{
			Connection Conn = null;
			PreparedStatement Stmt = null;
			ResultSet Rs = null;
			try {
				Conn = dataSource.getConnection();
				String sql = "select * from experience where tutor_id = ? order by experience_id desc limit 1";
				Stmt = Conn.prepareStatement(sql);
				Stmt.setInt(1, tutor_id);
				Rs = Stmt.executeQuery();
				if(Rs.next())
					return createExperience(Rs);
				else
					return null;
			}finally {
				// close JDBC objects
				close(Conn,Stmt,Rs);
			}	
		}
		public  List<Experience> getExperiencesByTutorId(int tutor_id)throws Exception{
			List<Experience> experiences = new ArrayList<>();
			Connection Conn = null;
			PreparedStatement Stmt = null;
			ResultSet Rs = null;
			try {
				Conn = dataSource.getConnection();
				String sql = "select * from experience where tutor_id = ?";
				Stmt = Conn.prepareStatement(sql);
				Stmt.setInt(1, tutor_id);
				Rs = Stmt.executeQuery();
				while(Rs.next()) {
					experiences.add(createExperience(Rs));
				}
				return experiences;
			}finally {
				// close JDBC objects
				close(Conn,Stmt,Rs);
			}	
		}
		public boolean addExperience(Experience experience)throws Exception{
			Connection Conn = null;
			PreparedStatement Stmt = null;
			ResultSet Rs = null;
			try {
				Conn = dataSource.getConnection();
				String sql = "insert into experience(experience_type,title,institution,location,description,start_year,end_year,tutor_id) values(?,?,?,?,?,?,?,?) ";
				Stmt = Conn.prepareStatement(sql);
				
				Stmt.setString(1, experience.getExperience_type());
				Stmt.setString(2, experience.getTitle());
				Stmt.setString(3, experience.getInstitution());
				Stmt.setString(4, experience.getLocation());
				Stmt.setString(5, experience.getDescription());
				Stmt.setString(6, experience.getStart_year());
				Stmt.setString(7, experience.getEnd_year());
				Stmt.setInt(8, experience.getTutor_id());
				return Stmt.executeUpdate()>0;
				
			}finally {
				// close JDBC objects
				close(Conn,Stmt,Rs);
			}	
		}
		public boolean updateExperience(Experience experience)throws Exception{
			Connection Conn = null;
			PreparedStatement Stmt = null;
			try {
				Conn = dataSource.getConnection();
				String sql = "update experience set experience_type=?,title=?,institution=?,location=?,description=?,start_year=?,end_year=? where experience_id=? ";
				Stmt = Conn.prepareStatement(sql);
				
				Stmt.setString(1, experience.getExperience_type());
				Stmt.setString(2, experience.getTitle());
				Stmt.setString(3, experience.getInstitution());
				Stmt.setString(4, experience.getLocation());
				Stmt.setString(5, experience.getDescription());
				Stmt.setString(6, experience.getStart_year());
				Stmt.setString(7, experience.getEnd_year());
				Stmt.setInt(8, experience.getExperience_id());
				
				if(Stmt.executeUpdate()>0)
					return true;
				else
					return false;
			}finally {
				// close JDBC objects
				close(Conn,Stmt,null);
			}	
		}
		public boolean updateExperienceField(String field,String data,int experience_id)throws Exception{
			Connection Conn = null;
			PreparedStatement Stmt = null;
			try {
				Conn = dataSource.getConnection();
				String sql = "update experience set "+field+"=? where experience_id=? ";
				Stmt = Conn.prepareStatement(sql);
				Stmt.setString(1, data);
				Stmt.setInt(2, experience_id);
				if(Stmt.executeUpdate()>0)
					return true;
				else
					return false;
			}finally {
				// close JDBC objects
				close(Conn,Stmt,null);
			}	
		}
		public boolean deleteExperience(int experience_id)throws Exception{
			Connection Conn = null;
			PreparedStatement Stmt = null;
			try {
				Conn = dataSource.getConnection();
				String sql = "delete from experience where experience_id=?";
				Stmt = Conn.prepareStatement(sql);
				Stmt.setInt(1, experience_id);
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
		 Experience createExperience(ResultSet Rs)throws Exception{
			 int experience_id = Rs.getInt("experience_id");
			 String experience_type = Rs.getString("experience_type");
			 String title = Rs.getString("title");
			 String institution = Rs.getString("institution");
			 String location = Rs.getString("location");
			 String description = Rs.getString("description");
			 String start_year = Rs.getString("start_year");
			 String end_year = Rs.getString("end_year");
			 int tutor_id = Rs.getInt("tutor_id");
			return new Experience(experience_id,experience_type,title,institution,location,description,start_year,end_year,tutor_id);
		}
}
