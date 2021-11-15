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
import com.TutorPod.dao.TutorDAO;
import com.TutorPod.model.Address;
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
	public void init() throws ServletException {
		super.init();
		try {
			tutorDAO = new TutorDAO(dataSource);
			addressDAO = new AddressDAO(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}
    public TutorController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {
			if(request.getParameter("cmd")==null)
				out.write("request has no command");
			switch(request.getParameter("cmd")) {
			case "loadLanguages":
				response.setContentType("application/json");
				String responseJSON = new Gson().toJson(tutorDAO.getLanguages());
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
				if(session.getAttribute("USER")==null) {
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/UserController?cmd2=addUser");
					rd.include(request, response);
				}else {
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/UserController");
					rd.include(request, response);
				}
				if(session.getAttribute("TUTOR")==null) {
					String bio = request.getParameter("bio");
					String profile_status = "NewApply";
					User user = (User)session.getAttribute("USER");
					if( tutorDAO.addTutor(new Tutor(bio,"",profile_status,user.getUser_id(),0)) )
					session.setAttribute("TUTOR", tutorDAO.getTutorByUserID(user.getUser_id()));
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
				 if(addressDAO.addAddress(new Address(street_address,locality,district,city,state,pincode),tutor.getTutor_id())) {
					 Address address = addressDAO.getAddressByTutorId(tutor.getTutor_id());
					 session.setAttribute("ADDRESS",address);
					 tutor.setAddress_id(address.getAddress_id());
					 session.setAttribute("TUTOR", tutor);
					 out.write("Details Saved");
				 }
				 else
					 out.write("Failed to saved details");
				break;
			case"saveLanguages":
				String[] languages = request.getParameterValues("languages");
				tutor = (Tutor)session.getAttribute("TUTOR");
				int successCounter=0;
				for(String language : languages) {
					int lang_id = Integer.parseInt(language);
					if(tutorDAO.addLanguage(lang_id, tutor.getTutor_id()) )
						successCounter++;
				}
				if(languages.length / successCounter == 1) {
					session.setAttribute("LANGUAGES", tutorDAO.getLanguages(tutor.getTutor_id()));
					out.write("Details Saved");
				}
				else
					out.write(successCounter+"/"+languages.length+" languages Saved");
				break;
			default:
				response.getWriter().write("Invalid Request");
			}
		}catch(Exception e) {
			e.printStackTrace(out);
		}
	}
}
