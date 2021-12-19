package com.TutorPod.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

import javax.annotation.Resource;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.TutorPod.dao.BookingDAO;
import com.TutorPod.dao.LessonDAO;
import com.TutorPod.dao.NotificationDAO;
import com.TutorPod.dao.SubjectDAO;
import com.TutorPod.dao.TransactionDAO;
import com.TutorPod.dao.UserDAO;
import com.TutorPod.dao.WalletDAO;
import com.TutorPod.dao.WithdrawRequestDAO;
import com.TutorPod.model.LessonDetails;
import com.TutorPod.model.Notification;
import com.TutorPod.model.User;
import com.google.gson.Gson;

@WebServlet("/LessonController")
public class LessonController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	WalletDAO walletDAO;
	WithdrawRequestDAO withdrawRequestDAO;
	BookingDAO bookingDAO;
	TransactionDAO transactionDAO;
	UserDAO userDAO;
	NotificationDAO notificationDAO;
	SubjectDAO subjectDAO;
	LessonDAO lessonDAO;
    public LessonController() {
        super();
    }
    public void init(ServletConfig config) throws ServletException {
		
		super.init();
		try {
			 walletDAO = new WalletDAO(dataSource);
			 withdrawRequestDAO = new WithdrawRequestDAO(dataSource);
			 bookingDAO = new BookingDAO(dataSource);
			 transactionDAO = new TransactionDAO(dataSource);
			 userDAO = new UserDAO(dataSource);
			 notificationDAO = new NotificationDAO(dataSource);
			 subjectDAO = new SubjectDAO(dataSource);
			 lessonDAO = new LessonDAO(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		if(session.getAttribute("USER")!=null) {
			try {
				if(request.getParameter("cmd")==null)
					out.write("request has no command");
				else
				switch(request.getParameter("cmd")) {
				case"loadLessons":
					String selector = request.getParameter("filter");
					int booking_id=-1;
					if(request.getParameter("booking_id")!=null)
						booking_id = Integer.parseInt(request.getParameter("booking_id"));
					String responseJSON="[]";
					response.setContentType("application/json");
					User user  = (User)session.getAttribute("USER");
					String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
					ListIterator<LessonDetails> itr;
					List<LessonDetails> lessons = new ArrayList<>();
					if(dashboardType.equals("USER")) {
						itr = lessonDAO.getLessonByUserID(user.getUser_id(),selector,booking_id).listIterator();
					}
					else {
						itr = lessonDAO.getLessonByTutorID(user.getTutor_id(),selector,booking_id).listIterator();
					}
					while(itr.hasNext()) {
						LessonDetails lessonDtl = itr.next();
						lessonDtl.setUser(userDAO.getUser(lessonDtl.getUser_id()));
						lessonDtl.setTutorUser(userDAO.getUserByTutorID(lessonDtl.getTutor_id()));
						lessonDtl.setSubject(subjectDAO.getSubject(lessonDtl.getSubject_id()));
						lessons.add(lessonDtl);
					}
					responseJSON = new Gson().toJson(lessons);
					out.write(responseJSON);
					break;
				case "loadScheduledLessons":
					int tutor_id = Integer.parseInt(request.getParameter("tutor_id"));
					responseJSON="[]";
					response.setContentType("application/json");
					responseJSON = new Gson().toJson(lessonDAO.getLessonsTutorID(tutor_id));
					out.write(responseJSON);
					break;
				default:
					out.write("Invalid Request");
				}
			}catch(Exception e) {
				e.printStackTrace(out);
			}
		}else
			out.write("User Session Expired");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		if(session.getAttribute("USER")!=null) {
			try {
				if(request.getParameter("cmd")==null)
					out.write("request has no command");
				else
				switch(request.getParameter("cmd")) {
				case"scheduleLesson":
					int lesson_id = Integer.parseInt(request.getParameter("lesson_id"));
					String date = request.getParameter("date");
					String time_from = request.getParameter("time_from");
					String time_to = request.getParameter("time_to");
					LessonDetails lessonDetails = lessonDAO.getLesson(lesson_id);
					lessonDetails.setTime_from(time_from);
					lessonDetails.setTime_to(time_to);
					lessonDetails.setDate(date);
					lessonDetails.setStatus("Scheduled");
					if(lessonDAO.updateLesson(lessonDetails)) {
						sendNotification(lessonDetails.getTutor_id(),"Lesson ID:"+lessonDetails.getLesson_id()+" is scheduled by learner. Click to see details","./Lessons",true);
						out.write("Lesson Scheduled");
					}
					else
						out.write("Failed to Schedule Lesson");
					break;
				default:
					out.write("Invalid Request");
				}
			}catch(Exception e) {
				e.printStackTrace(out);
			}
		}else
			out.write("User Session Expired");
	}
	private boolean sendNotification(int id,String message,String link,boolean toTutor)throws Exception{
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
		Instant instant = Instant.now();
		String datetime = dateTimeFormatter.format(instant);
		if(toTutor)
			return notificationDAO.addNotification(new Notification(message,link,datetime,-1,id,false,false));
		else
			return notificationDAO.addNotification(new Notification(message,link,datetime,id,-1,false,false));
	}
}
