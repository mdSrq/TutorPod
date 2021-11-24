package com.TutorPod.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.TutorPod.dao.AddressDAO;
import com.TutorPod.dao.ExperienceDAO;
import com.TutorPod.dao.FeesDAO;
import com.TutorPod.dao.NotificationDAO;
import com.TutorPod.dao.TutorDAO;
import com.TutorPod.dao.UserDAO;
import com.TutorPod.model.Address;
import com.TutorPod.model.Experience;
import com.TutorPod.model.Fees;
import com.TutorPod.model.Notification;
import com.TutorPod.model.Tutor;
import com.TutorPod.model.TutorInfo;
import com.TutorPod.model.User;
import com.google.gson.Gson;

@WebServlet("/TutorController")
@MultipartConfig(fileSizeThreshold = 10*1024*1024,maxFileSize = 50*1024*1024,maxRequestSize = 100*1024*1024)
public class TutorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
    private TutorDAO tutorDAO;
    private AddressDAO addressDAO;
    private ExperienceDAO experienceDAO;
    private FeesDAO feesDAO;
    private UserDAO userDAO;
    private NotificationDAO notificationDAO;
	public void init() throws ServletException {
		super.init();
		try {
			tutorDAO = new TutorDAO(dataSource);
			addressDAO = new AddressDAO(dataSource);
			experienceDAO = new ExperienceDAO(dataSource);
			feesDAO = new FeesDAO(dataSource);
			userDAO = new UserDAO(dataSource);
			notificationDAO = new NotificationDAO(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}
    public TutorController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		try {
			if(request.getParameter("cmd")==null)
				out.write("request has no command");
			switch(request.getParameter("cmd")) {
			case "loadBasicInfo":
				String responseJSON="[]";
				response.setContentType("application/json");
				if(session.getAttribute("USER")!=null) {
					User user = (User)session.getAttribute("USER");
					responseJSON = new Gson().toJson(user);
					Tutor tutor = tutorDAO.getTutorByUserID(user.getTutor_id());
					if(tutor!=null) {
						String tutorJSON = new Gson().toJson(tutor);
						responseJSON = responseJSON.substring(0, responseJSON.length()-1);
						tutorJSON = tutorJSON.substring(1, tutorJSON.length()); 
						responseJSON += ","+tutorJSON;
					}
				}
			    out.write(responseJSON);
				break;
			case "loadAddress":
				responseJSON = "[]";
				response.setContentType("application/json");
				if(session.getAttribute("TUTOR")!=null) {
					Tutor tutor = (Tutor)session.getAttribute("TUTOR");
			 		if(tutor.getAddress_id()>0) {
			 			responseJSON = new Gson().toJson(addressDAO.getAddress(tutor.getAddress_id()));
			 		}
				}
		 		out.write(responseJSON);
				break;
			case "loadSelectedLanguages":
				responseJSON="[]";
				response.setContentType("application/json");
				if(session.getAttribute("TUTOR")!=null) {
					Tutor tutor = (Tutor)session.getAttribute("TUTOR");
					responseJSON = new Gson().toJson(tutorDAO.getLanguages(tutor.getTutor_id()));
				}
				out.write(responseJSON);
				break;
			case "loadLanguages":
				responseJSON="[]";
				response.setContentType("application/json");
				responseJSON = new Gson().toJson(tutorDAO.getLanguages());
			    out.write(responseJSON);
				break;
			case "loadExperiences":
				responseJSON="[]";
				response.setContentType("application/json");
				if(session.getAttribute("TUTOR")!=null) {
					Tutor tutor = (Tutor)session.getAttribute("TUTOR");
					responseJSON = new Gson().toJson(experienceDAO.getExperiencesByTutorId(tutor.getTutor_id()));
				}
				out.write(responseJSON);
				break;
			case "loadExperience":
				int experience_id = Integer.parseInt(request.getParameter("experience_id"));
				response.setContentType("application/json");
				responseJSON = new Gson().toJson(experienceDAO.getExperience(experience_id));
				out.write(responseJSON);
				break;
			case "loadPrices":
				responseJSON="[]";
				response.setContentType("application/json");
				if(session.getAttribute("TUTOR")!=null) {
					Tutor tutor = (Tutor)session.getAttribute("TUTOR");
					responseJSON = new Gson().toJson(feesDAO.getFeesByTutorID(tutor.getTutor_id()));
				}
				out.write(responseJSON);
				break;
			case "loadApplied":
				responseJSON="[]";
				response.setContentType("application/json");
				responseJSON = new Gson().toJson(tutorDAO.getTutorApplications());
				out.write(responseJSON);
				break;
			case "loadAppliedTutors":
				responseJSON="[]";
				response.setContentType("application/json");
				responseJSON = new Gson().toJson(tutorDAO.getTutorApplicantsBasicInfo());
				out.write(responseJSON);
				break;
			case "loadAppliedTutorInfo":
				
				break;
			default:
				response.getWriter().write("Invalid Request");
			}
		}catch(Exception e) {
			e.printStackTrace(out);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		try {
			if(request.getParameter("cmd")==null)
				out.write("request has no command");
			switch(request.getParameter("cmd")) {
			case "saveBasicInfo":
					if((User)session.getAttribute("USER")!=null) {
					User user = (User)session.getAttribute("USER");
						if(user.getPhoto()==null) {
							RequestDispatcher rd = getServletContext().getRequestDispatcher("/UserController");
							rd.include(request, response);
						}
					}
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/UserController?cmd2=addUser");
				rd.include(request, response);
				if(session.getAttribute("TUTOR")==null) {
					String bio = request.getParameter("bio");
					String profile_status = "NewApply";
					User user = (User)session.getAttribute("USER");
					if( tutorDAO.addTutor(new Tutor(bio,"",profile_status,user.getUser_id(),0)) ) {
						Tutor tutor = tutorDAO.getTutorByUserID(user.getUser_id());
						if(userDAO.updateUserField("tutor_id", ""+tutor.getTutor_id(), true, user.getUser_id())) {
							user.setTutor_id(tutor.getTutor_id());
							session.setAttribute("USER", user);
						}
						session.setAttribute("TUTOR", tutor);
					}
					
				}else{
					String bio = request.getParameter("bio");
					Tutor tutor = (Tutor)session.getAttribute("TUTOR");
					tutor.setBio(bio);
					if(tutorDAO.updateTutor(tutor)) {
						session.setAttribute("TUTOR", tutor);
						out.write("Bio Updated");
					}
				}
				out.write("TutorController Response");
				break;
			case "updateBio":
				String bio = request.getParameter("bio");
				Tutor tutor = (Tutor)session.getAttribute("TUTOR");
				tutor.setBio(bio);
				if(tutorDAO.updateTutor(tutor)) {
					session.setAttribute("TUTOR", tutor);
					out.write("Bio Saved");
				}else
					out.write("Failed to save bio");
				break;
			case"saveAddress":
				 String street_address = request.getParameter("street_address");
				 String locality = request.getParameter("locality");
				 String district = request.getParameter("district");
				 String city = request.getParameter("city");
				 String state = request.getParameter("state");
				 String pincode = request.getParameter("pincode");
				 tutor = (Tutor)session.getAttribute("TUTOR");
				 if(tutor!=null)
					 if(tutor.getAddress_id()>0) {
						 Address address = addressDAO.getAddress(tutor.getAddress_id());
						 address.setStreet_address(street_address);
						 address.setLocality(locality);
						 address.setDistrict(district);
						 address.setCity(city);
						 address.setState(state);
						 address.setPincode(pincode);
						 if(addressDAO.updateAddress(address))
							 out.write("Update Saved");
						 else
							 out.write("Failed to saved details");
					 }else {
						 boolean added= false;
						 int address_id= addressDAO.getDuplicateAddress(street_address, locality, pincode);
						 Address address=null;
						 if(address_id==0) {
							 added = addressDAO.addAddress(new Address(street_address,locality,district,city,state,pincode),tutor.getTutor_id());
							 address = addressDAO.getAddressByTutorId(tutor.getTutor_id());
							 tutor.setAddress_id(address.getAddress_id());
						 }else {
							 added = true;
							 tutor.setAddress_id(address_id);
						 }
						 if(added) {
							 session.setAttribute("TUTOR", tutor);
							 out.write("Details Saved");
						 }else
							 out.write("Failed to saved details");
					 }
				break;
			case"saveLanguages":
				String[] languages = request.getParameterValues("languages");
				tutor = (Tutor)session.getAttribute("TUTOR");
				int successCounter=0;
				tutorDAO.deleteLanguageInfo(tutor.getTutor_id());
				for(String language : languages) {
					int lang_id = Integer.parseInt(language);
					if(tutorDAO.addLanguage(lang_id, tutor.getTutor_id()) )
						successCounter++;
				}
				if(languages.length / successCounter == 1) {
					out.write("Details Saved");
				}
				else
					out.write(successCounter+"/"+languages.length+" languages Saved");
				break;
			case"saveExperience":
				session.setAttribute("EXPERIENCES_SAVED", "TRUE");
				response.sendRedirect("./TutorApplication?tab=4");
				break;
			case"addExperience":
				String experience_type = request.getParameter("experience_type");
				String title = request.getParameter("title");
				String institution = request.getParameter("institution");
				String location = request.getParameter("location");
				String description = request.getParameter("description");
				String start_year = request.getParameter("start_year");
				String end_year = request.getParameter("end_year");
				response.setContentType("application/json");
				tutor = (Tutor)session.getAttribute("TUTOR");
				Experience experience = new Experience(experience_type,title,institution,location,description,start_year,end_year,tutor.getTutor_id());
				if(request.getParameter("experience_id")!=null) {
					int experience_id = Integer.parseInt(request.getParameter("experience_id"));
					experience.setExperience_id(experience_id);
					if(experienceDAO.updateExperience(experience))
						out.write("{\"msg\":\"Update Added\",\"experience_id\":"+experience_id+"}");
					else
						out.write("{'msg':'Failed to Update experience'}");
				}else {
					if( experienceDAO.addExperience(experience)) {
						int experience_id = experienceDAO.getMostRecentExperience(tutor.getTutor_id()).getExperience_id();
						out.write("{\"msg\": \"Added\",\"experience_id\":"+experience_id+"}");
					}
					else
						out.write("{'msg':'Failed to add experience'}");
				}
				break;
			case"savePrice":
				session.setAttribute("FEES_SAVED", "TRUE");
				response.sendRedirect("./TutorApplication?tab=5");
				break;
			case"addPrice":
				double fee = Double.parseDouble(request.getParameter("fee"));
				int subject_id = Integer.parseInt(request.getParameter("subject_id"));
				tutor = (Tutor)session.getAttribute("TUTOR");
				response.setContentType("application/json");
				if(feesDAO.addFees(new Fees(tutor.getTutor_id(),subject_id,fee))) {
					int fees_id = feesDAO.getMostRecentFees(tutor.getTutor_id()).getFees_id();
					out.write("{\"msg\": \"Added\",\"fees_id\":"+fees_id+"}");
				}
				break;
			case "deleteExperience":
				int experience_id = Integer.parseInt(request.getParameter("experience_id"));
				if(experienceDAO.deleteExperience(experience_id))
					out.write("Experience Deleted");
				else
					out.write("Failed to delete experience");
				break;
			case "deletePrice":
				int fees_id = Integer.parseInt(request.getParameter("fees_id"));
				if(feesDAO.deleteFees(fees_id))
					out.write("Fees Deleted");
				else
					out.write("Failed to delete fees");
				break;
			case "submitApplication":
				tutor = (Tutor)session.getAttribute("TUTOR");
				if(tutorDAO.updateTutorField("profile_status", "Applied", false, tutor.getTutor_id())) {
					tutor.setProfile_status("Applied");
					session.setAttribute("TUTOR", tutor);
					out.write("Submitted");
				}
				else
					out.write("Failed to submit");
				break;
			case"approveApplication":
				int tutor_id = Integer.parseInt(request.getParameter("tutor_id"));
				String date = new java.text.SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
				if(tutorDAO.updateTutorField("profile_status","Tutor", false, tutor_id) && tutorDAO.updateTutorField("approval_date", date, false, tutor_id)) {
					if(sendNotification(tutor_id,"Your Application is approved now you will apear in the search results."
							+ " Make sure you add your availabiltiy, Click to add availability","./Availability"))
						out.write("Notification Sent ");
					else
						out.write("Failed to add notification ");
					out.write("Application Approved");
				}
				else
					out.write("Failed to approve application");
				break;
			case"dismissApplication":
				tutor_id = Integer.parseInt(request.getParameter("tutor_id"));
				String message = request.getParameter("message");
				String link = request.getParameter("link");
				if(tutorDAO.updateTutorField("profile_status","Dismissed", false, tutor_id) && tutorDAO.updateTutorField("approval_date", null, false, tutor_id)) {
					if(sendNotification(tutor_id,message,link))
						out.write("Notification Sent ");
					else
						out.write("Failed to add notification ");
					out.write("Application Dismissed");
				}
				else
					out.write("Failed to dismiss application");
				break;
			default:
				response.getWriter().write("Invalid Request");
			}
		}catch(Exception e) {
			e.printStackTrace(out);
		}
	}
	private TutorInfo getTutorInfo(Tutor tutor)throws Exception{
		User user = userDAO.getUser(tutor.getUser_id());
		Address address = addressDAO.getAddressByTutorId(tutor.getTutor_id());
		List<String[]> languages = tutorDAO.getLanguages(tutor.getTutor_id());
		List<Experience> experiences = experienceDAO.getExperiencesByTutorId(tutor.getTutor_id());
		List<Fees> fees = feesDAO.getFeesByTutorID(tutor.getTutor_id());
		return new TutorInfo(user.getUser_id(), user.getFname(), user.getLname(), user.getUsername(), user.getEmail_id(), user.getMobile_no(),
				user.getGender(), user.getPhoto(),user.getJoining_date(), tutor.getTutor_id(), tutor.getBio(), tutor.getApproval_date(),
				tutor.getProfile_status(),address,languages,experiences,fees);
	}
	private boolean sendNotification(int tutor_id,String message,String link)throws Exception{
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
		Instant instant = Instant.now();
		String datetime = dateTimeFormatter.format(instant);
		return notificationDAO.addNotification(new Notification(message,link,datetime,-1,tutor_id,false,false));
	}
}
