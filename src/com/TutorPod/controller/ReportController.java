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
import com.TutorPod.dao.TutorDAO;
import com.TutorPod.dao.UserDAO;
import com.TutorPod.dao.WalletDAO;
import com.TutorPod.model.AdminDashboardInfo;
import com.TutorPod.model.Booking;
import com.TutorPod.model.BookingDetails;
import com.TutorPod.model.DashboardInfo;
import com.TutorPod.model.LessonDetails;
import com.TutorPod.model.Subject;
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
	TutorDAO tutorDAO;
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
			 tutorDAO = new TutorDAO(dataSource);
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
							ListIterator<Booking> itr = bookingDAO.getBookingsForTutor(user.getTutor_id()).listIterator();
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
							while(itr1.hasNext()) {
								upcoming_lessons.add(createLessonDetails(itr1.next()));
							}
							recent_lessons = lessonDAO.getLessonByTutorID(user.getTutor_id(), "Completed", -1);
							completedLesson = recent_lessons.size();
							itr1 = recent_lessons.listIterator();
							recent_lessons = new ArrayList<>();
							while(itr1.hasNext()) {
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
				case"getAdminDashboardData":
					if(session.getAttribute("ADMIN")!=null) {
						double total_sales = 0;
						double admin_profit = 0;
						int total_users = userDAO.getUsers().size();
						int total_tutors = tutorDAO.getTutors().size();
						int total_bookings = 0;
						int total_lessons = 0;
						int scheduled_lessons = 0;
						int completed_lessons = 0;
						List<BookingDetails> recentBookings = new ArrayList<>();
						List<LessonDetails> recentsLessons = new ArrayList<>();
						ListIterator<Booking> itr = bookingDAO.getBookings().listIterator();
						ListIterator<LessonDetails> l_itr = lessonDAO.getLessons("All").listIterator();
						while(itr.hasNext()) {
							total_bookings++;
							Booking bkn = itr.next();
							total_lessons += bkn.getNo_of_lesson();
							total_sales += (bkn.getPrice()*bkn.getDuration()*bkn.getNo_of_lesson())*1.025;
							admin_profit += (bkn.getPrice()*bkn.getDuration()*bkn.getNo_of_lesson())*0.05;
							User tutorUser = userDAO.getUser(bkn.getTutor_id());
							user = userDAO.getUser(bkn.getUser_id());
							Subject subject = subjectDAO.getSubject(bkn.getSubject_id());
							recentBookings.add(new BookingDetails(bkn,user,tutorUser,subject));
						}
						while(l_itr.hasNext()) {
							LessonDetails tmpL = l_itr.next();
							if(tmpL.getStatus().equals("Scheduled")) {
								scheduled_lessons++;
								continue;
							}
							if(tmpL.getStatus().equals("Completed")) {
								completed_lessons++;
								recentsLessons.add(createLessonDetails(tmpL));
							}
								
						}
						AdminDashboardInfo admininfo = new AdminDashboardInfo(total_sales, admin_profit, total_users, total_tutors, total_bookings, total_lessons, scheduled_lessons, completed_lessons, recentBookings, recentsLessons);
						String responseJSON="[]";
						response.setContentType("application/json");
						responseJSON = new Gson().toJson(admininfo);
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
	private LessonDetails createLessonDetails(LessonDetails lessonDtl)throws Exception{
		lessonDtl.setUser(userDAO.getUser(lessonDtl.getUser_id()));
		lessonDtl.setTutorUser(userDAO.getUserByTutorID(lessonDtl.getTutor_id()));
		lessonDtl.setSubject(subjectDAO.getSubject(lessonDtl.getSubject_id()));
		return lessonDtl;
	}
}
