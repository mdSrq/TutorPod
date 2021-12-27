package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Fees;

public class FeesDAO {
	private DataSource dataSource;
	public FeesDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<Fees> getFees() throws Exception{
		List<Fees> feess = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from fees order by fees_id desc";
			
			Stmt = Conn.createStatement();
			
			Rs = Stmt.executeQuery(sql);
			
			while (Rs.next()) {
				
				Fees tempFees = createFees(Rs);
				feess.add(tempFees);				
			}
			return feess;
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public Fees getFees(int fees_id)throws Exception{
		Fees fees=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from fees where fees_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, fees_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				fees = createFees(Rs);
			}
			return fees;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Fees getDuplicateFees(int subject_id,int tutor_id)throws Exception{
		Fees fees=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from fees where subject_id=? and tutor_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, subject_id);
			Stmt.setInt(2, tutor_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				fees = createFees(Rs);
			}
			return fees;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Fees getMostRecentFees(int tutor_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from fees where tutor_id=? order by fees_id desc limit 1";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, tutor_id);
			Rs = Stmt.executeQuery();
			if(Rs.next())
				return createFees(Rs);
			else
				return null;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public List<Fees> getFeesByTutorID(int tutor_id)throws Exception{
		List<Fees> fees = new ArrayList<>();
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from fees inner join subject on fees.subject_id = subject.subject_id where tutor_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, tutor_id);
			Rs = Stmt.executeQuery();
			while(Rs.next()) {
				Fees tmpFees = createFees(Rs);
				tmpFees.setSubject_name(Rs.getString("subject_code")+" - "+Rs.getString("subject_name"));
				fees.add(tmpFees);
			}
			return fees;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addFees(Fees fees)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into fees(tutor_id,subject_id,fee) values(?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, fees.getTutor_id());
			Stmt.setInt(2, fees.getSubject_id());
			Stmt.setDouble(3, fees.getFee());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateFees(Fees fees)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update fees set fee=? where fees_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setDouble(1, fees.getFee());
			Stmt.setInt(2, fees.getFees_id());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteFees(int fees_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from fees where fees_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, fees_id);
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
	private Fees createFees(ResultSet Rs)throws Exception{
		int fees_id = Rs.getInt("fees_id");
		int tutor_id = Rs.getInt("tutor_id");
		int subject_id = Rs.getInt("subject_id");
		double fee = Rs.getDouble("fee");
		return new Fees(fees_id,tutor_id,subject_id,fee);
	}
}
