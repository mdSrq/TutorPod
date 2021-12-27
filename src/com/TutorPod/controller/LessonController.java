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
import com.TutorPod.model.Lesson;
import com.TutorPod.model.LessonDetails;
import com.TutorPod.model.Notification;
import com.TutorPod.model.Transaction;
import com.TutorPod.model.User;
import com.TutorPod.model.Wallet;
import com.TutorPod.model.WalletTransaction;
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
					while(itr.hasNext())				
						lessons.add(createLessonDetails(itr.next()));
					
					responseJSON = new Gson().toJson(lessons);
					out.write(responseJSON);
					break;
				case"loadAllLessons":
					selector = request.getParameter("filter");
					responseJSON="[]";
					response.setContentType("application/json");
					itr=lessonDAO.getLessons(selector).listIterator();
					lessons = new ArrayList<>();
					while(itr.hasNext())				
						lessons.add(createLessonDetails(itr.next()));
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
					LessonDetails lessonDetails = createLessonDetails(lessonDAO.getLessonDetails(lesson_id));
					lessonDetails.setTime_from(time_from);
					lessonDetails.setTime_to(time_to);
					lessonDetails.setDate(date);
					lessonDetails.setStatus("Scheduled");
					if(lessonDAO.updateLesson(lessonDetails)) {
						sendNotification(lessonDetails.getTutor_id(),lessonDetails.getUser().getFname()+" "+lessonDetails.getUser().getLname()+" has scheduled their lesson. Click to see details","./Lessons",true);
						out.write("Lesson Scheduled");
					}
					else
						out.write("Failed to Schedule Lesson");
					break;
				case"addMeetingLink":
					lesson_id = Integer.parseInt(request.getParameter("lesson_id"));
					String meeting_link = request.getParameter("meeting_link");
					Lesson lesson = lessonDAO.getLesson(lesson_id);
					lesson.setMeeting_link(meeting_link);
					if(lessonDAO.updateLesson(lesson))
						out.write("Meeting Link Added");
					else
						out.write("Faield to add meeting link");
					break;
				case"requestSchedule":
					lesson_id = Integer.parseInt(request.getParameter("lesson_id"));
					String message = request.getParameter("message");
					lessonDetails = createLessonDetails(lessonDAO.getLessonDetails(lesson_id));
					lessonDetails.setStatus("Need Re-Scheduling");
					lessonDetails.setTime_from(null);
					lessonDetails.setTime_to(null);
					if(
					lessonDAO.updateLesson(lessonDetails)
					&&
					sendNotification(lessonDetails.getUser_id(),
					"Re-Schedule Request from "+
					lessonDetails.getTutorUser().getFname()+" "+
					lessonDetails.getTutorUser().getLname()+": "+message +" Click to go to lessons",
					"./Lessons",false)
					)
						out.write("Notification Sent");
					else
						out.write("Failed to send Notification");
					break;
				case"cancelLesson":
					lesson_id = Integer.parseInt(request.getParameter("lesson_id"));
					message = request.getParameter("message");
					String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
					lessonDetails = createLessonDetails(lessonDAO.getLessonDetails(lesson_id));
					Wallet userWallet = walletDAO.getWalletByUserID(lessonDetails.getUser_id());
					Wallet tutorWallet = walletDAO.getWallet(lessonDetails.getTutorUser().getWallet_id());
					DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
					DateTimeFormatter dateTimeFormatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd").withZone(ZoneId.systemDefault());
					Instant instant = Instant.now();
					String datetime = dateTimeFormatter.format(instant);
					date = dateTimeFormatter1.format(instant);
					double totalRefund = lessonDetails.getPrice()*lessonDetails.getDuration();
					double tutorRefundValue = totalRefund - (totalRefund/100)*2.5;
					walletDAO.Rollback();
					walletDAO.setAutoCommit(0);
					if(transactionDAO.addTransaction(new Transaction("User",lessonDetails.getTutor_id(),"User",lessonDetails.getUser_id(),totalRefund,"Refund for Lesson ID:"+lessonDetails.getLesson_id(),date,datetime))) {
						if(walletDAO.addWalletTransaction(new WalletTransaction(tutorWallet.getWallet_id(),tutorRefundValue,false,true,tutorWallet.getBalance()-tutorRefundValue,"Refund Paid for Lesson ID:"+lessonDetails.getLesson_id(),"Completed",datetime))) {
							tutorWallet.setBalance(tutorWallet.getBalance()-tutorRefundValue);
							walletDAO.updateWallet(tutorWallet);
							if(walletDAO.addWalletTransaction(new WalletTransaction(userWallet.getWallet_id(),totalRefund,true,false,userWallet.getBalance()+totalRefund,"Refund Received for Lesson ID:"+lessonDetails.getLesson_id(),"Completed",datetime))) {
								userWallet.setBalance(userWallet.getBalance()+totalRefund);
								walletDAO.updateWallet(userWallet);
								lessonDetails.setDate(null);
								lessonDetails.setTime_from(null);
								lessonDetails.setTime_to(null);
								lessonDetails.setMeeting_link(null);
								lessonDetails.setStatus("Cancelled");
								if(lessonDAO.updateLesson(lessonDetails)) {
									if(dashboardType.equals("USER")) {
										sendNotification(lessonDetails.getTutor_id(),
										lessonDetails.getUser().getFname()+" "+lessonDetails.getUser().getLname()
										+" has cancelled lesson (Lesson ID:"+lessonDetails.getLesson_id()+"). Cancellation Reason: "+message,"./Notifications",true);
										
									}
									else {
										sendNotification(lessonDetails.getUser_id(),
										lessonDetails.getTutorUser().getFname()+" "+lessonDetails.getTutorUser().getLname()
										+" has cancelled lesson (Lesson ID:"+lessonDetails.getLesson_id()+"). Cancellation Reason: "+message,"./Notifications",false);
									}
									sendNotification(lessonDetails.getUser_id(),"Refund amount of Rs."+totalRefund+" for Lesson ID:"+lessonDetails.getLesson_id()+" has been transfered to your wallet. Click to see details","./Wallet",false);
									walletDAO.Commit();
									walletDAO.setAutoCommit(1);
									out.write("Lesson Cancelled");
									return;
								}
							}
						}
					}
					
					break;
				case"markLessonCompleted":
					lesson_id = Integer.parseInt(request.getParameter("lesson_id"));
					message = request.getParameter("message");
					if(!message.isEmpty()) {
						lessonDetails = createLessonDetails(lessonDAO.getLessonDetails(lesson_id));
						lessonDetails.setStatus("Completed");
						if(lessonDAO.updateLesson(lessonDetails)) {
							sendNotification(lessonDetails.getTutor_id(),lessonDetails.getUser().getFname()+" "+lessonDetails.getUser().getLname()+" wrote feedback for Lesson ID:"+lessonDetails.getLesson_id()+". Feeback: "+message,"./Notification",true);
							out.write("Lesson Marked As Completed");
						}
					}else {
						lesson = lessonDAO.getLesson(lesson_id);
						lesson.setStatus("Completed");
						if(lessonDAO.updateLesson(lesson))
							out.write("Lesson Marked As Completed");
					}
					
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
	private LessonDetails createLessonDetails(LessonDetails lessonDtl)throws Exception{
		lessonDtl.setUser(userDAO.getUser(lessonDtl.getUser_id()));
		lessonDtl.setTutorUser(userDAO.getUserByTutorID(lessonDtl.getTutor_id()));
		lessonDtl.setSubject(subjectDAO.getSubject(lessonDtl.getSubject_id()));
		return lessonDtl;
	}
	
}
