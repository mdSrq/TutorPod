package com.TutorPod.model;

public class Experience {
	private int experience_id;
	private String experience_type;
	private String title;
	private String institution;
	private String location;
	private String description;
	private String start_year;
	private String end_year;
	private int tutor_id;
	
	public Experience(int experience_id, String experience_type, String title, String institution, String location,
			String description, String start_year, String end_year, int tutor_id) {
		super();
		this.experience_id = experience_id;
		this.experience_type = experience_type;
		this.title = title;
		this.institution = institution;
		this.location = location;
		this.description = description;
		this.start_year = start_year;
		this.end_year = end_year;
		this.tutor_id = tutor_id;
	}
	public Experience(String experience_type, String title, String institution, String location, String description,
			String start_year, String end_year, int tutor_id) {
		super();
		this.experience_type = experience_type;
		this.title = title;
		this.institution = institution;
		this.location = location;
		this.description = description;
		this.start_year = start_year;
		this.end_year = end_year;
		this.tutor_id = tutor_id;
	}
	
	public int getTutor_id() {
		return tutor_id;
	}
	public void setTutor_id(int tutor_id) {
		this.tutor_id = tutor_id;
	}
	public int getExperience_id() {
		return experience_id;
	}
	public void setExperience_id(int experience_id) {
		this.experience_id = experience_id;
	}
	public String getExperience_type() {
		return experience_type;
	}
	public void setExperience_type(String experience_type) {
		this.experience_type = experience_type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getInstitution() {
		return institution;
	}
	public void setInstitution(String institution) {
		this.institution = institution;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getStart_year() {
		return start_year;
	}
	public void setStart_year(String start_year) {
		this.start_year = start_year;
	}
	public String getEnd_year() {
		return end_year;
	}
	public void setEnd_year(String end_year) {
		this.end_year = end_year;
	}
	@Override
	public String toString() {
		return "Experience [experience_id=" + experience_id + ", experience_type=" + experience_type + ", title="
				+ title + ", institution=" + institution + ", location=" + location + ", description=" + description
				+ ", start_year=" + start_year + ", end_year=" + end_year + "]";
	}
	
}
