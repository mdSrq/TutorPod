package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Notification;
public class NotificationDAO {
	private DataSource dataSource;
	public NotificationDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<Notification> getNotificationsForUser(int user_id,boolean forUser) throws Exception{
		List<Notification> notifications = new ArrayList<>();
		
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from notification where ";
			if(forUser)
				sql+="user_id";
			else
				sql+="tutor_id";
			sql+="=? order by notification_id desc limit 10";
			
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
			
			Rs = Stmt.executeQuery();
			
			while (Rs.next())
				notifications.add(createNotification(Rs));				
			
			return notifications;		
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public List<Notification> getAllNotificationsForUser(int user_id,boolean forUser) throws Exception{
		List<Notification> notifications = new ArrayList<>();
		
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from notification where ";
			if(forUser)
				sql+="user_id";
			else
				sql+="tutor_id";
			sql+="=? order by notification_id desc";
			
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
			
			Rs = Stmt.executeQuery();
			
			while (Rs.next())
				notifications.add(createNotification(Rs));				
			
			return notifications;		
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addNotification(Notification notification)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into notification(notification,link,datetime,";
			if(notification.getUser_id()>0)
				sql+="user_id";
			else
				sql+="tutor_id";
			sql+= ",seen,clicked) values(?,?,?,?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, notification.getNotification());
			Stmt.setString(2, notification.getLink());
			Stmt.setString(3, notification.getDatetime());
			if(notification.getUser_id()>0)
				Stmt.setInt(4, notification.getUser_id());
			else
				Stmt.setInt(4, notification.getTutor_id());
			Stmt.setBoolean(5, notification.isSeen());
			Stmt.setBoolean(6, notification.isClicked());
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean seenNotifications(int nofificationId,int user_id,boolean forUser)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update notification set seen=true where ";
			if(forUser)
				sql += "user_id = ?";
			else
				sql += "tutor_id = ?";
			sql+= " and (notification_id <= ? and seen=false)";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
			Stmt.setInt(2, nofificationId);
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean clickedNotification(int nofificationId)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update notification set clicked=true where notification_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, nofificationId);
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean markAllAsSeen(int nofificationId,int user_id,boolean forUser)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update notification set seen=true,clicked=true where ";
			if(forUser)
				sql += "user_id = ?";
			else
				sql += "tutor_id = ?";
			sql+= " and (notification_id <= ? and (clicked=false or seen=false))";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
			Stmt.setInt(2, nofificationId);
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteNotification(int nofificationId)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from notification where notification_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, nofificationId);
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteAllNotification(int user_id, boolean isUser)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from notification where ";
			if(isUser)
				sql += "user_id = ?";
			else
				sql += "tutor_id = ?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, user_id);
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
	private Notification createNotification(ResultSet Rs)throws Exception{
		int notification_id = Rs.getInt("notification_id");
		String notification = Rs.getString("notification");
		String link = Rs.getString("link");
		String datetime = Rs.getString("datetime");
		int user_id = Rs.getInt("user_id");
		int tutor_id = Rs.getInt("tutor_id");
		boolean seen = Rs.getBoolean("seen");
		boolean clicked = Rs.getBoolean("clicked");
		return new Notification(notification_id, notification, link, datetime, user_id,tutor_id,seen,clicked);
	}
}
