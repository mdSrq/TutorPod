package com.TutorPod.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.TutorPod.dao.AdminDAO;
import com.TutorPod.model.Admin;
import com.google.gson.Gson;

@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	AdminDAO adminDAO;
    public AdminController() {
        super();
       
    }
    public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		try {
			 adminDAO = new AdminDAO(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		try {
			if(request.getParameter("cmd")==null)
				out.write("request has no command");
			else
			switch(request.getParameter("cmd")) {
				case "logout":
					request.getSession().removeAttribute("ADMIN");
					response.sendRedirect("./Admin/Login");
					break;
				case "seeRecentAdmins":
					response.setContentType("application/json");
					String responseJSON = new Gson().toJson(adminDAO.getAdmins("Recent"));
					out.write(responseJSON);
					break;
				case "seeAdmins":
					response.setContentType("application/json");
					responseJSON = new Gson().toJson(adminDAO.getAdmins("All"));
					out.write(responseJSON);
					break;
				case "deleteAdmin":
					int admin_id = Integer.parseInt(request.getParameter("admin_id"));
					if(adminDAO.deleteAdmin(admin_id))
						response.getWriter().write("Deleted");
					else
						response.getWriter().write("Failed to delete Admin");
					break;
				case "editAdmin":
					response.setContentType("application/json");
					admin_id = Integer.parseInt(request.getParameter("admin_id"));
					Admin admin = adminDAO.getAdmin(admin_id);
					admin.setPassword("********");
					responseJSON = new Gson().toJson(admin);
					out.write(responseJSON);
					break;
				default:
					response.getWriter().print("Invalid Request");
			}
		}catch(Exception e) {
			e.printStackTrace(response.getWriter());
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			switch(request.getParameter("cmd")) {
			case "login":
				String name = request.getParameter("name");
				String password = request.getParameter("password");
				Admin admin = adminDAO.getAdmin(name);
				response.setContentType("text/plain");     
			    response.setCharacterEncoding("UTF-8"); 
				if(admin!=null) {
					if(admin.getPassword().equals(password)) {
						request.getSession().setAttribute("ADMIN", name);
					    response.getWriter().write("Login Success");  
					}else 
						response.getWriter().write("Wrong Password");
				}else 
					response.getWriter().write("Invalid Name");
				break;
			case "addAdmin":
				name = request.getParameter("name").strip();
				password = request.getParameter("password");
				if(adminDAO.addAdmin(new Admin(name,password)))
					response.getWriter().write("Admin Added");
				else
					response.getWriter().write("Failed to Add Admin");
				break;
			case "editAdmin":
				int admin_id = Integer.parseInt(request.getParameter("admin_id"));
				name = request.getParameter("name").strip();
				password = request.getParameter("password");
				String new_password = request.getParameter("new-password");
				admin = adminDAO.getAdmin(admin_id);
				if(admin.getPassword().equals(password)) {
					admin.setPassword(new_password);
					boolean adminProcessed=false;
					if(admin.getName()!=name) {
						admin.setName(name);
						adminProcessed = adminDAO.updateAdmin(admin);
					}
					else
						adminProcessed = adminDAO.updatePassword(admin);
					if(adminProcessed)
						response.getWriter().write("Admin Updated");
					else
						response.getWriter().write("Failed to Updated Admin");
				}else
					response.getWriter().write("Incorrect Current Password");
				break;
			default:
				response.getWriter().print("Invalid Request");   
				break;
			}
	}catch(Exception e) {
		e.printStackTrace(response.getWriter());
	}

}
}
