package com.TutorPod.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.TutorPod.dao.AdminDAO;
import com.TutorPod.dao.AvailabilityDAO;
import com.TutorPod.model.Availability;
import com.TutorPod.model.Tutor;
import com.google.gson.Gson;

@WebServlet("/AvailabilityController")
public class AvailabilityController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	AvailabilityDAO availabilityDAO;
    public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		try {
			availabilityDAO = new AvailabilityDAO(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}
    public AvailabilityController() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		try {
				if(request.getParameter("cmd")==null)
					out.write("request has no command");
				else
				switch(request.getParameter("cmd")) {
				case"loadWeeklyAvailability":
					String responseJSON="[]";
					Tutor tutor = (Tutor)session.getAttribute("TUTOR");
					response.setContentType("application/json");
					responseJSON = new Gson().toJson(availabilityDAO.getWeeklyAvailability(tutor.getTutor_id()));
				    out.write(responseJSON);
					break;
				default:
					out.write("Invalid Request");
				}
		}catch(Exception e) {
			e.printStackTrace(out);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {
				if(request.getParameter("cmd")==null)
					out.write("request has no command");
				else
				switch(request.getParameter("cmd")) {
				case "addWeeklyAvailability":
					int tutor_id = Integer.parseInt(request.getParameter("tutor_id"));
					int day_of_week = Integer.parseInt(request.getParameter("day_of_week"));
					String time_from = request.getParameter("time_from");
					String time_to = request.getParameter("time_to");
					if(availabilityDAO.addWeekAvailability(new Availability(tutor_id,day_of_week,time_from,time_to)))
						out.write("Availability Saved");
					else
						out.write("Failed to save Availability");
					break;
				default:
					out.write("Invalid Request");
				}
		}catch(Exception e) {
			e.printStackTrace(out);
		}
	}

}
