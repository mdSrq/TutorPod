package com.TutorPod.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import com.TutorPod.dao.SubjectDAO;
import com.TutorPod.dao.UserDAO;
import com.TutorPod.dao.WalletDAO;
import com.TutorPod.model.Booking;
import com.TutorPod.model.DashboardInfo;
import com.TutorPod.model.LessonDetails;
import com.TutorPod.model.User;
import com.google.gson.Gson;


@WebServlet("/ReportController")
public class ReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	WalletDAO walletDAO;
	LessonDAO lessonDAO;
	SubjectDAO subjectDAO;
	UserDAO userDAO;
	BookingDAO bookingDAO;
    public ReportController() {
        super();
    }
    public void init(ServletConfig config) throws ServletException {
		
		super.init();
		try {
			 walletDAO = new WalletDAO(dataSource);
			 lessonDAO = new LessonDAO(dataSource);
			 subjectDAO = new SubjectDAO(dataSource);
			 userDAO = new UserDAO(dataSource);
			 bookingDAO = new BookingDAO(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
			try {
				if(request.getParameter("cmd")==null)
					out.write("request has no command");
				else
				switch(request.getParameter("cmd")) {
				case"getUserDashboardData":
					User user = (User)session.getAttribute("USER");
					String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
					if(user!=null) {
						double totalEarning;
						double balance = walletDAO.getWallet(user.getWallet_id()).getBalance();
						int totalLesson;
						int completedLesson;
						DashboardInfo dashboardInfo;
						if(dashboardType.equals("USER")) {
							totalEarning = 0;
							totalLesson = lessonDAO.getLessonByUserID(user.getUser_id(), "All", -1).size();
							List<LessonDetails> upcoming_lessons = new ArrayList<>();
							List<LessonDetails> recent_lessons = new ArrayList<>();
							ListIterator<LessonDetails> itr = lessonDAO.getLessonByUserID(user.getUser_id(), "Scheduled", -1).listIterator();
							while(itr.hasNext()) {
								upcoming_lessons.add(createLessonDetails(itr.next()));
							}
							recent_lessons = lessonDAO.getLessonByUserID(user.getUser_id(), "Completed", -1);
							completedLesson = recent_lessons.size();
							itr = recent_lessons.listIterator();
							recent_lessons = new ArrayList<>();
							while(itr.hasNext()) {
								recent_lessons.add(createLessonDetails(itr.next()));
							}
							dashboardInfo = new DashboardInfo(totalEarning,totalLesson,completedLesson,balance,upcoming_lessons,recent_lessons);
						}else {
							ListIterator<Booking> itr = bookingDAO.getBookings(user.getUser_id()).listIterator();
							totalEarning=0;
							while(itr.hasNext()) {
								Booking bkn = itr.next();
								double subTotal = bkn.getPrice()*bkn.getDuration()*bkn.getNo_of_lesson();
								double total = subTotal - (subTotal/100)*2.5;
								totalEarning+=total;
							}
							totalLesson = lessonDAO.getLessonByTutorID(user.getTutor_id(), "All", -1).size();
							List<LessonDetails> upcoming_lessons = new ArrayList<>();
							List<LessonDetails> recent_lessons = new ArrayList<>();
							ListIterator<LessonDetails> itr1 = lessonDAO.getLessonByTutorID(user.getTutor_id(), "Scheduled", -1).listIterator();
							while(itr.hasNext()) {
								upcoming_lessons.add(createLessonDetails(itr1.next()));
							}
							recent_lessons = lessonDAO.getLessonByTutorID(user.getTutor_id(), "Completed", -1);
							completedLesson = recent_lessons.size();
							itr1 = recent_lessons.listIterator();
							recent_lessons = new ArrayList<>();
							while(itr.hasNext()) {
								recent_lessons.add(createLessonDetails(itr1.next()));
							}
							dashboardInfo = new DashboardInfo(totalEarning,totalLesson,completedLesson,balance,upcoming_lessons,recent_lessons);
						}
						String responseJSON="[]";
						response.setContentType("application/json");
						responseJSON = new Gson().toJson(dashboardInfo);
						out.write(responseJSON);
					}
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
				else
				switch(request.getParameter("cmd")) {
				
				default:
					out.write("Invalid Request");
				}
			}catch(Exception e) {
				e.printStackTrace(out);
			}
	}
	private LessonDetails createLessonDetails(LessonDetails lessonDtl)throws Exception{
		lessonDtl.setUser(userDAO.getUser(lessonDtl.getUser_id()));
		lessonDtl.setTutorUser(userDAO.getUserByTutorID(lessonDtl.getTutor_id()));
		lessonDtl.setSubject(subjectDAO.getSubject(lessonDtl.getSubject_id()));
		return lessonDtl;
	}
}
