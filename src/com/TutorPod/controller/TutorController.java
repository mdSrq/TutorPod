package com.TutorPod.controller;

import java.io.IOException;
import java.io.PrintWriter;

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
import com.TutorPod.dao.TutorDAO;
import com.TutorPod.dao.UserDAO;
import com.TutorPod.model.Address;
import com.TutorPod.model.Experience;
import com.TutorPod.model.Fees;
import com.TutorPod.model.Tutor;
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
	public void init() throws ServletException {
		super.init();
		try {
			tutorDAO = new TutorDAO(dataSource);
			addressDAO = new AddressDAO(dataSource);
			experienceDAO = new ExperienceDAO(dataSource);
			feesDAO = new FeesDAO(dataSource);
			userDAO = new UserDAO(dataSource);
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
					user = userDAO.getUser(user.getUser_id());
					user.setPassword(null);
					responseJSON = new Gson().toJson(user);
					String tutorJSON = new Gson().toJson(tutorDAO.getTutorByUserID(user.getUser_id()));
					if(!tutorJSON.equals("[]")) {
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
					if( tutorDAO.addTutor(new Tutor(bio,"",profile_status,user.getUser_id(),0)) )
					session.setAttribute("TUTOR", tutorDAO.getTutorByUserID(user.getUser_id()));
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
			case"saveAddress":
				String street_address = request.getParameter("street_address");
				 String locality = request.getParameter("locality");
				 String district = request.getParameter("district");
				 String city = request.getParameter("city");
				 String state = request.getParameter("state");
				 String pincode = request.getParameter("pincode");
				 Tutor tutor = (Tutor)session.getAttribute("TUTOR");
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
						 if(addressDAO.addAddress(new Address(street_address,locality,district,city,state,pincode),tutor.getTutor_id())) {
							 Address address = addressDAO.getAddressByTutorId(tutor.getTutor_id());
							 tutor.setAddress_id(address.getAddress_id());
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
				out.write("Submitted");
				break;
			default:
				response.getWriter().write("Invalid Request");
			}
		}catch(Exception e) {
			e.printStackTrace(out);
		}
	}
}
