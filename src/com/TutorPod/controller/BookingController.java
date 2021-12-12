package com.TutorPod.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

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
import com.TutorPod.dao.WalletDAO;
import com.TutorPod.dao.WithdrawRequestDAO;
import com.TutorPod.model.Booking;
import com.TutorPod.model.User;
import com.TutorPod.model.Wallet;
import com.TutorPod.model.WalletTransaction;
import com.TutorPod.model.WithdrawRequest;
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
    public BookingController() {
        super();
    }
    public void init(ServletConfig config) throws ServletException {
		
		super.init();
		try {
			 walletDAO = new WalletDAO(dataSource);
			 withdrawRequestDAO = new WithdrawRequestDAO(dataSource);
			 bookingDAO = new BookingDAO(dataSource);
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
					int subject_id = Integer.parseInt(request.getParameter("subject_id"));
					double price = Double.parseDouble(request.getParameter("price"));
					double duration = Double.parseDouble(request.getParameter("duration"));
					int no_of_lesson = Integer.parseInt(request.getParameter("no_of_lesson"));
					User user  = (User)session.getAttribute("USER");
					walletDAO.Rollback();
					walletDAO.setAutoCommit(0);
					if(bookingDAO.addBooking(new Booking(tutor_id,user.getUser_id(),subject_id,price,duration,no_of_lesson,-1,"Incomplete"))) {
						session.setAttribute("BOOKING", bookingDAO.getRecentBooking(user.getUser_id()));
						out.write("Booking Saved");
					}else
						out.write("Failed to add booking");
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
			out.write("User Session Expired");
	}

}
