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
				case"loadTutorAvailability":
					int tutor_id = Integer.parseInt(request.getParameter("tutor_id"));
					responseJSON="[]";
					response.setContentType("application/json");
					responseJSON = new Gson().toJson(availabilityDAO.getAvailabilityByTutorID(tutor_id));
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
					Availability avl = availabilityDAO.getDuplicateWeekDay(tutor_id, day_of_week);
					if(avl==null) {
						avl = new Availability(tutor_id,day_of_week,time_from,time_to);
						if(availabilityDAO.addWeekAvailability(avl))
							out.write("Availability Saved");
						else
							out.write("Failed to save Availability");
					}else {
						avl.setTime_from(time_from);
						avl.setTime_to(time_to);
						if(availabilityDAO.updateAvailability(avl))
							out.write("Availability Saved");
						else
							out.write("Failed to save Availability");
					}

					break;
				case "removeWeekAvailability":
					int availability_id = Integer.parseInt(request.getParameter("availability_id"));
					if(availabilityDAO.deleteAvailability(availability_id))
						out.write("Availability Removed");
					else
						out.write("Failed to remove Availability");
					break;
				default:
					out.write("Invalid Request");
				}
		}catch(Exception e) {
			e.printStackTrace(out);
		}
	}

}
