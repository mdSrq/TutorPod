package com.TutorPod.model;

public class Address {
	private int address_id;
	private String street_address;
	private String locality;
	private String district;
	private String city;
	private String state;
	private String pincode;
	public Address(int address_id, String street_address, String locality, String district, String city, String state,
			String pincode) {
		super();
		this.address_id = address_id;
		this.street_address = street_address;
		this.locality = locality;
		this.district = district;
		this.city = city;
		this.state = state;
		this.pincode = pincode;
	}
	public Address(String street_address, String locality, String district, String city, String state,
			String pincode) {
		super();
		this.street_address = street_address;
		this.locality = locality;
		this.district = district;
		this.city = city;
		this.state = state;
		this.pincode = pincode;
	}
	
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public int getAddress_id() {
		return address_id;
	}
	public void setAddress_id(int address_id) {
		this.address_id = address_id;
	}
	public String getStreet_address() {
		return street_address;
	}
	public void setStreet_address(String street_address) {
		this.street_address = street_address;
	}
	public String getLocality() {
		return locality;
	}
	public void setLocality(String locality) {
		this.locality = locality;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPincode() {
		return pincode;
	}
	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	@Override
	public String toString() {
		return "Address [address_id=" + address_id + ", street_address=" + street_address + ", locality=" + locality
				+ ", district=" + district + ", state=" + state + ", pincode=" + pincode + "]";
	}
}