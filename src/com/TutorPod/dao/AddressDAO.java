package com.TutorPod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.TutorPod.model.Address;

public class AddressDAO {
	 DataSource dataSource;
	public AddressDAO(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	public List<Address> getAddresses() throws Exception{
		List<Address> addresss = new ArrayList<>();
		
		Connection Conn = null;
		Statement Stmt = null;
		ResultSet Rs = null;
		
		try {
			Conn = dataSource.getConnection();
			
			String sql = "select * from address order by address_id desc";
			
			Stmt = Conn.createStatement();
			
			Rs = Stmt.executeQuery(sql);
			
			while (Rs.next())
				addresss.add(createAddress(Rs));				
			
			return addresss;		
		}
		finally {
			close(Conn,Stmt,Rs);
		}	
	}
	public Address getAddress(int address_id)throws Exception{
		Address address=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from address where address_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, address_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				address = createAddress(Rs);
			}
			return address;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public Address getAddressByTutorId(int tutor_id)throws Exception{
		Address address=null;
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "select * from address inner join tutor on tutor.address_id = address.address_id where tutor.tutor_id = ?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, tutor_id);
			Rs = Stmt.executeQuery();
			if(Rs.next()) {
				address = createAddress(Rs);
			}
			return address;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean addAddress(Address address,int tutor_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		ResultSet Rs = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "insert into address(street_address,locality,district,city,state,pincode) values(?,?,?,?,?,?) ";
			Stmt = Conn.prepareStatement(sql);
			
			Stmt.setString(1, address.getStreet_address());
			Stmt.setString(2, address.getLocality());
			Stmt.setString(3, address.getDistrict());
			Stmt.setString(4, address.getCity());
			Stmt.setString(5, address.getState());
			Stmt.setString(6, address.getPincode());
			boolean addressAdded = Stmt.executeUpdate()>0;
			Stmt.close();
			sql = "select address_id from address order by address_id desc limit 1";
			Stmt = Conn.prepareStatement(sql);
			Rs = Stmt.executeQuery();
			Rs.next();
			int address_id = Rs.getInt("address_id");
			Stmt.close();
			sql = "update tutor set address_id=? where tutor_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, address_id);
			Stmt.setInt(2, tutor_id);
			boolean userUpdated = Stmt.executeUpdate()>0;
			
			return addressAdded && userUpdated;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,Rs);
		}	
	}
	public boolean updateAddress(Address address)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update address set street_address=?,locality=?,district=?,city=?,state=?,pincode=? where address_id=? ";
			Stmt = Conn.prepareStatement(sql);
			
			Stmt.setString(1, address.getStreet_address());
			Stmt.setString(2, address.getLocality());
			Stmt.setString(3, address.getDistrict());
			Stmt.setString(4, address.getCity());
			Stmt.setString(5, address.getState());
			Stmt.setString(6, address.getPincode());
			Stmt.setInt(7, address.getAddress_id());
			
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean updateAddressField(String field,String data,int address_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "update address set "+field+"=? where address_id=? ";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setString(1, data);
			Stmt.setInt(2, address_id);
			if(Stmt.executeUpdate()>0)
				return true;
			else
				return false;
		}finally {
			// close JDBC objects
			close(Conn,Stmt,null);
		}	
	}
	public boolean deleteAddress(int address_id)throws Exception{
		Connection Conn = null;
		PreparedStatement Stmt = null;
		try {
			Conn = dataSource.getConnection();
			String sql = "delete from address where address_id=?";
			Stmt = Conn.prepareStatement(sql);
			Stmt.setInt(1, address_id);
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
	 Address createAddress(ResultSet Rs)throws Exception{
		 int address_id = Rs.getInt("address_id");
		 String street_address = Rs.getString("street_address");
		 String locality = Rs.getString("locality");
		 String district = Rs.getString("district");
		 String city = Rs.getString("city");
		 String state = Rs.getString("state");
		 String pincode = Rs.getString("pincode");
		return new Address(address_id,street_address,locality,district,city,state,pincode);
	}
}
