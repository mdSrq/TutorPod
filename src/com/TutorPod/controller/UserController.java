package com.TutorPod.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.annotation.Resource;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.TutorPod.dao.UserDAO;
import com.TutorPod.dao.WalletDAO;
import com.TutorPod.model.User;
import com.TutorPod.model.Wallet;


@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	private UserDAO userDAO;
	private WalletDAO walletDAO;
	public void init(ServletConfig config) throws ServletException {
		super.init();
		try {
			userDAO = new UserDAO(dataSource);
			walletDAO = new WalletDAO(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}
    public UserController() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		try {
			if(request.getParameter("cmd")==null)
				out.write("request has no command");
			switch(request.getParameter("cmd")) {
			case"logout":
				session.removeAttribute("USER_ID");
				response.sendRedirect("./");
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
			case"signin":
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				User user = userDAO.getUser(username);
				if(user!=null) {
					if(user.getPassword().equals(password)) {
						user.setPassword("********");
						session.setAttribute("USER", user);
						out.write("Signup Success");
					}else
						out.write("Wrong Password");
				}else
					out.write("Username doesn't exist");
				break;
			case"signup":
				String fname = request.getParameter("fname");
				String lname = request.getParameter("lname");
				username = request.getParameter("username");
				password = request.getParameter("password");
				String gender = request.getParameter("gender");
				String email_id = request.getParameter("email_id");
				String mobile_no = request.getParameter("mobile_no");
				String profile_status = "New";
				String joining_date = new java.text.SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
				user = new User(fname,lname,username,password,email_id,mobile_no,gender,profile_status,joining_date);
				if(userDAO.addUser(user)) {
					int user_id = userDAO.getRecentUser().getUser_id();
					if(walletDAO.addWallet(new Wallet(0.0,user_id))) {
						int wallet_id = walletDAO.getRecentWallet().getWallet_id();
						if( userDAO.updateUserField("wallet_id", ""+wallet_id, true, user_id)) {
							user.setPassword("********");
							session.setAttribute("USER", user);
							out.write("Account Created");
							break;
						}
					}	
				}
				out.write("Failed to create account");
				break;
			default:
				out.write("Invalid Request");
				break;
			}
			
		}catch(Exception e) {
			e.printStackTrace(out);
		}
	}
}
