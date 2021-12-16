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
import com.TutorPod.dao.NotificationDAO;
import com.TutorPod.dao.SubjectDAO;
import com.TutorPod.dao.TransactionDAO;
import com.TutorPod.dao.UserDAO;
import com.TutorPod.dao.WalletDAO;
import com.TutorPod.dao.WithdrawRequestDAO;
import com.TutorPod.model.LessonDetails;
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
					String responseJSON="[]";
					response.setContentType("application/json");
					User user  = (User)session.getAttribute("USER");
					String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
					ListIterator<LessonDetails> itr;
					List<LessonDetails> lessons = new ArrayList<>();
					if(dashboardType.equals("USER")) {
						itr = lessonDAO.getLessonByUserID(user.getUser_id(),"All").listIterator();
					}
					else {
						itr = lessonDAO.getLessonByTutorID(user.getTutor_id(),"All").listIterator();
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
				default:
					out.write("Invalid Request");
				}
			}catch(Exception e) {
				e.printStackTrace(out);
			}
		}else
			out.write("User Session Expired");
	}

}
