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

import com.TutorPod.dao.NotificationDAO;
import com.TutorPod.dao.TutorDAO;
import com.TutorPod.dao.UserDAO;
import com.TutorPod.dao.WalletDAO;
import com.TutorPod.model.Notification;
import com.TutorPod.model.Tutor;
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
	private TutorDAO tutorDAO;
	public void init() throws ServletException {
		super.init();
		try {
			userDAO = new UserDAO(dataSource);
			walletDAO = new WalletDAO(dataSource);
			notifDAO = new NotificationDAO(dataSource);
			tutorDAO = new TutorDAO(dataSource);
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
			else
			switch(request.getParameter("cmd")) {
			
			case "logout":
				session.removeAttribute("USER");
				session.removeAttribute("TUTOR");
				session.removeAttribute("DASHBOARD_TYPE");
				response.sendRedirect("./");
				break;
				
			case "checkUsername":
				String username = request.getParameter("username");
				if(userDAO.getUser(username)!=null)
					out.write("Username Exists");
				else
					out.write("Valid Username");
				break;
				
			case "switchToTutor":
				session.setAttribute("DASHBOARD_TYPE","TUTOR");
				String requestPage = request.getParameter("page");
				if(requestPage!=null)
					response.sendRedirect("./"+requestPage);
				else
					response.sendRedirect("./Dashboard");
				break;
				
			case "switchToUser":
				session.setAttribute("DASHBOARD_TYPE","USER");
				requestPage = request.getParameter("page");
				if(requestPage!=null)
					response.sendRedirect("./"+requestPage);
				else
					response.sendRedirect("./Dashboard");
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
						user.setPassword(null);
						session.setAttribute("USER", user);
						session.setAttribute("DASHBOARD_TYPE", "USER");
						Tutor tutor = tutorDAO.getTutorByUserID(user.getUser_id());
						session.setAttribute("TUTOR", tutor);
						
						out.write("Signup Success");
					}else
						out.write("Wrong Password");
				}else
					out.write("Username doesn't exist");
				break;
			case"signup":
				out.write(addUser(request,"Complete your profile to begin your learning journey.","./AccountSettings"));
				break;
			case"changePhoto":
				out.write(uploadPhoto(request));
				break;
			case "saveBasicInfo":
				if(request.getParameter("cmd2")!=null) {
					if(request.getParameter("cmd2").equals("addUser")) {
						if(session.getAttribute("USER")==null)
							out.write(
									addUser(request,"Your user profile is created. Click to view settings.","./AccountSettings")
									+" "+
									uploadPhoto(request)
									);
						else
							out.write(updateUser(request,(User)session.getAttribute("USER")));
					}
				}else
					out.write(uploadPhoto(request));
				break;
			case "removePhoto":
				user = (User)session.getAttribute("USER");
				if( userDAO.updateUserField("photo", null, false, user.getUser_id()) ) {
					user.setPhoto(null);
					String filename = user.getFname()+user.getLname()+"_"+user.getUser_id()+".jpg";
					String path = getServletContext().getInitParameter("upload.location");
					File file = new File(path,filename);
					file.delete();
					out.write("Photo Removed");
				}else
					out.write("Failed to remove photo");
				break;
			case "changePersonalInfo":
				String fname = request.getParameter("fname").strip();
				String lname = request.getParameter("lname").strip();
				String gender = request.getParameter("gender").strip();
				String mobile_no = request.getParameter("mobile_no").strip();
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
				String email_id = request.getParameter("email_id");
				password = request.getParameter("password");
				user = (User)session.getAttribute("USER");
				user = userDAO.getUser(user.getUser_id());
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
				user = userDAO.getUser(user.getUser_id());
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
	private String uploadPhoto(HttpServletRequest request)throws Exception{
		Part photo = request.getPart("photo");
		User user = (User)request.getSession().getAttribute("USER");
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
			request.getSession().setAttribute("USER", user);
			return " Photo Changed ";
		}else {
			return " Failed to change photo ";
		}
	}
	private String addUser(HttpServletRequest request,String notification,String link)throws Exception{
		String fname = request.getParameter("fname").strip();
		String lname = request.getParameter("lname").strip();
		String username = request.getParameter("username").strip();
		String password = request.getParameter("password");
		String gender = request.getParameter("gender").strip();
		String email_id = request.getParameter("email_id").strip();
		String mobile_no = request.getParameter("mobile_no").strip();
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd").withZone(ZoneId.systemDefault());
		Instant instant = Instant.now();
		String joining_date = dateFormatter.format(instant);
		String datetime = dateTimeFormatter.format(instant);
		User user = new User(fname,lname,username,password,email_id,mobile_no,gender,joining_date);
		userDAO.Rollback();
		userDAO.setAutoCommit(0);
		if(userDAO.addUser(user)) {
			int user_id = userDAO.getRecentUser().getUser_id();
			user.setUser_id(user_id);
			if(walletDAO.addWallet(new Wallet(0.0,user_id))) {
				int wallet_id = walletDAO.getRecentWallet().getWallet_id();
				if( userDAO.updateUserField("wallet_id", ""+wallet_id, true, user_id)) {
					user.setPassword(null);
					request.getSession().setAttribute("USER", user);
					request.getSession().setAttribute("DASHBOARD_TYPE", "USER");
					userDAO.Commit();
					userDAO.setAutoCommit(1);
					notifDAO.addNotification(new Notification("Welcome to TutorPod :)","#",datetime,user_id,-1,false,false));
					notifDAO.addNotification(new Notification(notification,link,datetime,user_id,-1,false,false));
					return " Account Created ";
				}
			}	
		}
		return(" Failed to create account ");
	}
	private String updateUser(HttpServletRequest request,User user)throws Exception{
		String fname = request.getParameter("fname").strip();
		String lname = request.getParameter("lname").strip();
		String username = request.getParameter("username").strip();
		String gender = request.getParameter("gender").strip();
		String email_id = request.getParameter("email_id").strip();
		String mobile_no = request.getParameter("mobile_no").strip();
		user = userDAO.getUser(user.getUser_id());
		user.setFname(fname);
		user.setLname(lname);
		user.setUsername(username);
		user.setGender(gender);
		user.setEmail_id(email_id);
		user.setMobile_no(mobile_no);
		if(userDAO.updateUser(user)) {
			user.setPassword(null);
			request.getSession().setAttribute("USER", user);
			if(request.getParameter("photo")!=null) {
				uploadPhoto(request);
			}
			return "Update Created ";
		}else
			return "Update Failed ";
		
	}
}
