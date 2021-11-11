package com.TutorPod.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.sql.DataSource;

import com.TutorPod.dao.BankAccDAO;
import com.TutorPod.dao.NotificationDAO;
import com.TutorPod.dao.UserDAO;
import com.TutorPod.dao.WalletDAO;
import com.TutorPod.model.Notification;
import com.TutorPod.model.User;
import com.TutorPod.model.Wallet;


@WebServlet("/UserController")
@MultipartConfig(fileSizeThreshold = 10*1024*1024,maxFileSize = 50*1024*1024,maxRequestSize = 100*1024*1024)
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	private UserDAO userDAO;
	private WalletDAO walletDAO;
	private NotificationDAO notifDAO;
	private BankAccDAO bankAccDAO;
	public void init() throws ServletException {
		super.init();
		try {
			userDAO = new UserDAO(dataSource);
			walletDAO = new WalletDAO(dataSource);
			notifDAO = new NotificationDAO(dataSource);
			bankAccDAO = new BankAccDAO(dataSource);
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
				session.removeAttribute("USER");
				session.removeAttribute("TUTOR");
				session.removeAttribute("DASHBOARD_TYPE");
				response.sendRedirect("./");
				break;
			case"checkUsername":
				String username = request.getParameter("username");
				if(userDAO.getUser(username)!=null)
					out.write("Username Exists");
				else
					out.write("Valid Username");
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
				String username = request.getParameter("username").strip();
				String password = request.getParameter("password");
				User user = userDAO.getUser(username);
				if(user!=null) {
					if(user.getPassword().equals(password)) {
						session.setAttribute("USER", user);
						session.setAttribute("DASHBOARD_TYPE", "USER");
						if(user.getBank_acc_id()>0)
							session.setAttribute("BANK_ACC", bankAccDAO.getBankAcc(user.getBank_acc_id()));
						out.write("Signup Success");
					}else
						out.write("Wrong Password");
				}else
					out.write("Username doesn't exist");
				break;
			case"signup":
				String fname = request.getParameter("fname").strip();
				String lname = request.getParameter("lname").strip();
				username = request.getParameter("username").strip();
				password = request.getParameter("password");
				String gender = request.getParameter("gender").strip();
				String email_id = request.getParameter("email_id").strip();
				String mobile_no = request.getParameter("mobile_no").strip();
				String profile_status = "New";
				DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
				DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd").withZone(ZoneId.systemDefault());
				Instant instant = Instant.now();
				String joining_date = dateFormatter.format(instant);
				String datetime = dateTimeFormatter.format(instant);
				user = new User(fname,lname,username,password,email_id,mobile_no,gender,profile_status,joining_date);
				if(userDAO.addUser(user)) {
					int user_id = userDAO.getRecentUser().getUser_id();
					user.setUser_id(user_id);
					if(walletDAO.addWallet(new Wallet(0.0,user_id))) {
						int wallet_id = walletDAO.getRecentWallet().getWallet_id();
						if( userDAO.updateUserField("wallet_id", ""+wallet_id, true, user_id)) {
							session.setAttribute("USER", user);
							session.setAttribute("DASHBOARD_TYPE", "USER");
							out.write("Account Created");
							notifDAO.addNotification(new Notification("Welcome to TutorPod!. We're happy to see you here. Happy Learning :)","#",datetime,user_id,-1,false,false));
							notifDAO.addNotification(new Notification("Complete your profile to begin your learning journey.","./AccountSettings",datetime,user_id,-1,false,false));
							break;
						}
					}	
				}
				out.write("Failed to create account");
				break;
			case"changePhoto":
				Part photo = request.getPart("photo");
				user = (User)session.getAttribute("USER");
				String filename = user.getFname()+"_"+user.getLname()+"_"+user.getUser_id();
				String path = getServletContext().getInitParameter("upload.location");
				File file = new File(path, filename+"_temp.jpg");
				InputStream input = photo.getInputStream();
				Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
				File tempFile = new File(path, filename+"_temp.jpg");
				BufferedImage fullFrame = ImageIO.read(tempFile);
                int height = fullFrame.getHeight();
                int width = fullFrame.getWidth();
                if (height > width)
                    ImageIO.write( fullFrame.getSubimage(0, (height-width)/2, width, width), "jpg", new File(path, filename+".jpg"));
                else if(width > height)
                    ImageIO.write( fullFrame.getSubimage((width-height)/2, 0, height, height), "jpg", new File(path, filename+".jpg"));

                tempFile.delete();
				if( userDAO.updateUserField("photo", filename, false, user.getUser_id()) ) {
					user.setPhoto(filename+".jpg");
					session.setAttribute("USER", user);
					out.write("Photo Changed");
				}else
					out.write("Failed to change photo");
				
				break;
			case "removePhoto":
				user = (User)session.getAttribute("USER");
				if( userDAO.updateUserField("photo", null, false, user.getUser_id()) ) {
					user.setPhoto(null);
					filename = user.getFname()+user.getLname()+"_"+user.getUser_id()+".jpg";
					path = getServletContext().getInitParameter("upload.location");
					file = new File(path,filename);
					file.delete();
					out.write("Photo Removed");
				}else
					out.write("Failed to remove photo");
				break;
			case "changePersonalInfo":
				fname = request.getParameter("fname").strip();
				lname = request.getParameter("lname").strip();
				gender = request.getParameter("gender").strip();
				mobile_no = request.getParameter("mobile_no").strip();
				user = (User)session.getAttribute("USER");
				user.setFname(fname);
				user.setLname(lname);
				user.setGender(gender);
				user.setMobile_no(mobile_no);
				if(userDAO.updateUser(user)) {
					session.setAttribute("USER", user);
					out.write("Changes Saved");
				}else
					out.write("Failed to save changes");
					
				break;
			case "changeUsernameOrEmail":
				username = request.getParameter("username");
				email_id = request.getParameter("email_id");
				password = request.getParameter("password");
				user = (User)session.getAttribute("USER");
				if(user.getPassword().equals(password)) {
					user.setUsername(username);
					user.setEmail_id(email_id);
					if(userDAO.updateUser(user)) {
						session.setAttribute("USER", user);
						out.write("Changes Saved");
					}else
						out.write("Failed to save changes");	
				}else
					out.write("Wrong Password");
				break;
			case "changePassword":
				password = request.getParameter("password");
				String newPassword = request.getParameter("newPassword");
				user = (User)session.getAttribute("USER");
				if(user.getPassword().equals(password)) {
					user.setPassword(newPassword);
					if(userDAO.updateUser(user)) {
						out.write("Changes Saved");
					}else
						out.write("Failed to save changes");
				}else
					out.write("Wrong Password");
				break;
			default:
				out.write("Invalid Request");
				break;
			}
			
		}catch(java.sql.SQLIntegrityConstraintViolationException e) {
			String excMsg = e.toString();
			if(excMsg.contains("user.username"))
				out.write("This Username Already Exists");
			else if(excMsg.contains("user.email_id"))
				out.write("This Email ID Already Exists");
			else if(excMsg.contains("user.mobile_no"))
				out.write("This Mobile Number Already Exists");
			else
				out.write(excMsg);
		}catch(com.mysql.cj.jdbc.exceptions.MysqlDataTruncation e) {
			String excMsg = e.toString();
			if(excMsg.contains("username"))
				out.write("Username is longer than allowed limit(20 characters)");
			else if(excMsg.contains("fname"))
				out.write("First Name is longer than allowed limit (25 characters)");
			else if(excMsg.contains("lname"))
				out.write("Last Name is longer than allowed limit (25 characters)");
			else if(excMsg.contains("password"))
				out.write("Password is longer than allowed limit (20 characters)");
			else if(excMsg.contains("email_id"))
				out.write("Email ID is longer than allowed limit(254 characters)");
			else if(excMsg.contains("mobile_no"))
				out.write("Invalid Mobile Numeber");
			else
				out.write(excMsg);
		}
		catch(Exception e) {
			e.printStackTrace(out);
		}
	}
}
