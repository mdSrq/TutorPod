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

import com.TutorPod.dao.NotificationDAO;
import com.TutorPod.model.Tutor;
import com.TutorPod.model.User;
import com.google.gson.Gson;

@WebServlet("/NotificationController")
public class NotificationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	private NotificationDAO notifDAO;
	public void init(ServletConfig config) throws ServletException {
		super.init();
		try {
			notifDAO = new NotificationDAO(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}
    public NotificationController() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		try {
			if(request.getParameter("cmd")==null)
				out.write("request has no command");
			switch(request.getParameter("cmd")) {
			case"seeNotifications":
				String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
				response.setContentType("application/json");
				String responseJSON="";
				if(dashboardType.equals("USER")) {
					User user = (User)session.getAttribute("USER");
					responseJSON = new Gson().toJson(notifDAO.getNotificationsForUser(user.getUser_id(), true));
				}else {
					Tutor tutor = (Tutor)session.getAttribute("TUTOR");
					responseJSON = new Gson().toJson(notifDAO.getNotificationsForUser(tutor.getTutor_id(), false));
				}
			    out.write(responseJSON);
				break;
			case "seeAllNotifications":
				dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
				response.setContentType("application/json");
				responseJSON="";
				if(dashboardType.equals("USER")) {
					User user = (User)session.getAttribute("USER");
					responseJSON = new Gson().toJson(notifDAO.getAllNotificationsForUser(user.getUser_id(), true));
				}else {
					Tutor tutor = (Tutor)session.getAttribute("TUTOR");
					responseJSON = new Gson().toJson(notifDAO.getAllNotificationsForUser(tutor.getTutor_id(), false));
				}
			    out.write(responseJSON);
				break;
			case"seenNotifications":
				dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
				if(!request.getParameter("notification_id").equals("undefined")) {
					int notification_id = Integer.parseInt(request.getParameter("notification_id"));
					boolean success=false;
					if(dashboardType.equals("USER")) {
						User user = (User)session.getAttribute("USER");
						success = notifDAO.seenNotifications(notification_id, user.getUser_id(), true);
					}else {
						Tutor tutor = (Tutor)session.getAttribute("TUTOR");
						success = notifDAO.seenNotifications(notification_id, tutor.getTutor_id(), false);
					}
					if(success)
						out.write("Success");
					else
						out.write("Failed");
				}else
					out.write("No Notifications");
				break;
			case"markAllAsSeen":
				dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
				int notification_id = Integer.parseInt(request.getParameter("notification_id"));
				boolean success=false;
				if(dashboardType.equals("USER")) {
					User user = (User)session.getAttribute("USER");
					success = notifDAO.markAllAsSeen(notification_id, user.getUser_id(), true);
				}else {
					Tutor tutor = (Tutor)session.getAttribute("TUTOR");
					success = notifDAO.markAllAsSeen(notification_id, tutor.getTutor_id(), false);
				}
				if(success)
					out.write("Success");
				else
					out.write("Failed");
				break;
			case"clickedNotification":
				notification_id = Integer.parseInt(request.getParameter("notification_id"));
				success = notifDAO.clickedNotification(notification_id);
				if(success)
					out.write("Success");
				else
					out.write("Failed");
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
		HttpSession session = request.getSession();
		try {
				if(request.getParameter("cmd")==null)
					out.write("request has no command");
				switch(request.getParameter("cmd")) {
				case"deleteNotifications":
					String selectAll = request.getParameter("selectAll");
					boolean deleted=false;
					if(selectAll!=null) {
						if(session.getAttribute("DASHBOARD_TYPE").toString().equals("USER")) {
							User user = (User)session.getAttribute("USER");
							deleted = notifDAO.deleteAllNotification(user.getUser_id(), true);
						}else {
							Tutor tutor = (Tutor)session.getAttribute("TUTOR");
							deleted = notifDAO.deleteAllNotification(tutor.getTutor_id(), false);
						}
					}else {
						String[] notification_ids = request.getParameterValues("notification_ids");
						int deleteCount=0;
						for(String notification_id : notification_ids) {
							if(notifDAO.deleteNotification(Integer.parseInt(notification_id)))
								deleteCount++;
						}
						deleted = deleteCount == notification_ids.length;
					}
					if(deleted)
						out.write("Notifications Deleted");
					else
						out.write("Failed to delete notifications");
					break;
				default:
					out.write("Invalid Request");
				}
			}catch(Exception e) {
				e.printStackTrace(out);
		}
	}
}
