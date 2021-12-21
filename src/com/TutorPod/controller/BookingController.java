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
import com.TutorPod.model.Booking;
import com.TutorPod.model.Notification;
import com.TutorPod.model.Subject;
import com.TutorPod.model.Transaction;
import com.TutorPod.model.User;
import com.TutorPod.model.Wallet;
import com.TutorPod.model.WalletTransaction;
import com.TutorPod.model.BookingDetails;
import com.TutorPod.model.Lesson;
import com.google.gson.Gson;

/**
 * Servlet implementation class BookingController
 */
@WebServlet("/BookingController")
public class BookingController extends HttpServlet {
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
    public BookingController() {
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
				case "loadBalance":
					User user  = (User)session.getAttribute("USER");
					Wallet wallet = walletDAO.getWalletByUserID(user.getUser_id());
					out.write(""+wallet.getBalance());
					break;
				case "loadWalletTransactions":
					String responseJSON="[]";
					response.setContentType("application/json");
					user  = (User)session.getAttribute("USER");
					responseJSON = new Gson().toJson(walletDAO.getWalletTransactions(user.getWallet_id()));
					out.write(responseJSON);
					break;
				case "loadBookingDetails":
					user  = (User)session.getAttribute("USER");
					String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
					ListIterator<Booking> bookingItr;
					if(dashboardType.equals("USER"))
						bookingItr = bookingDAO.getBookings(user.getUser_id()).listIterator();
					else
						bookingItr = bookingDAO.getBookingsForTutor(user.getTutor_id()).listIterator();
					List<BookingDetails> bookingDetails= new ArrayList<>();
					Booking tempBooking=null;
					while(bookingItr.hasNext()) {
						tempBooking = bookingItr.next();
						User tutorUser = null;
						if(dashboardType.equals("USER")) {
							tutorUser = userDAO.getUser(tempBooking.getTutor_id());
						}else {
							tutorUser = user;
							user = userDAO.getUser(tempBooking.getUser_id());
						}
						Subject subject = subjectDAO.getSubject(tempBooking.getSubject_id());
						bookingDetails.add(new BookingDetails(tempBooking,user,tutorUser,subject));
					}
					responseJSON="[]";
					response.setContentType("application/json");
					responseJSON = new Gson().toJson(bookingDetails);
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
				case "addBooking":
					int tutor_id = Integer.parseInt(request.getParameter("tutor_id"));
					User tutorUser = userDAO.getUserByTutorID(tutor_id);
					int subject_id = Integer.parseInt(request.getParameter("subject_id"));
					double price = Double.parseDouble(request.getParameter("price"));
					double duration = Double.parseDouble(request.getParameter("duration"));
					int no_of_lesson = Integer.parseInt(request.getParameter("no_of_lesson"));
					double subTotal = price*duration*no_of_lesson;
					double totalPaid = subTotal+(subTotal/100)*(2.5);
					double totalReceived = subTotal-(subTotal/100)*(2.5);
					User user  = (User)session.getAttribute("USER");
					Wallet useWallet = walletDAO.getWalletByUserID(user.getUser_id());
					Wallet tutorWallet = walletDAO.getWallet(tutorUser.getWallet_id());
					DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
					DateTimeFormatter dateTimeFormatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd").withZone(ZoneId.systemDefault());
					Instant instant = Instant.now();
					String datetime = dateTimeFormatter.format(instant);
					String date = dateTimeFormatter1.format(instant);
					walletDAO.Rollback();
					walletDAO.setAutoCommit(0);
					if(transactionDAO.addTransaction(new Transaction("User",user.getUser_id(),"User",tutor_id,totalReceived,"Booking payment - 2.5%(TutorPod fee)",date,datetime))) {
						int transaction_id = transactionDAO.getRecentTransaction("User",user.getUser_id()).getTransaction_id();
						if(bookingDAO.addBooking(new Booking(tutor_id,user.getUser_id(),subject_id,price,duration,no_of_lesson,transaction_id,"Completed"))) {
							int booking_id = bookingDAO.getRecentBooking(user.getUser_id()).getBooking_id();
							if(walletDAO.addWalletTransaction(new WalletTransaction(useWallet.getWallet_id(),totalPaid,false,true,useWallet.getBalance()-totalPaid,"Booking Made with ID:"+booking_id,"Completed",datetime))) {
								useWallet.setBalance(useWallet.getBalance()-totalPaid);
								walletDAO.updateWallet(useWallet);
								if(walletDAO.addWalletTransaction(new WalletTransaction(tutorWallet.getWallet_id(),totalReceived,true,false,tutorWallet.getBalance()+totalReceived,"Booking payment - 2.5%(TutorPod fee) for Booking ID:"+booking_id,"Completed",datetime))) {
									tutorWallet.setBalance(tutorWallet.getBalance()+totalReceived);
									walletDAO.updateWallet(tutorWallet);
									if(transactionDAO.addTransaction(new Transaction("Booking",booking_id,"Admin",-1,(subTotal/100)*5,"Booking payment ID:"+booking_id,date,datetime))) {
										sendNotification(user.getUser_id(),"Your booking ( Booking ID:"+booking_id+" ) is completed. Click here to see your bookings.","./Orders",false);
										sendNotification(tutor_id,"You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details","./Orders",true);
										for(int i=0;i<no_of_lesson;i++)
											lessonDAO.addLesson(new Lesson(booking_id,null,null,null,null,null,"Unscheduled"));
										walletDAO.Commit();
										walletDAO.setAutoCommit(1);
										out.write("Lesson Booked");
										return;
									}
								}
							}
						}
					}
					out.write("Failed to book lesson");
					walletDAO.Rollback();
					break;
				case"withdrawRequest":
					break;
				default:
					out.write("Invalid Request");
				}
			}catch(Exception e) {
				e.printStackTrace(out);
			}
		}else
			out.write("Please Login First");
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
