package com.TutorPod.controller;

import java.io.IOException;

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
		response.getWriter().append("Served at: ").append(request.getContextPath());
		try {
			switch(request.getParameter("cmd")) {
				case "logout":
						request.getSession().removeAttribute("ADMIN");
						response.sendRedirect("./Admin/Login");
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
						response.getWriter().write("Invalid Password");
				}else 
					response.getWriter().write("Invalid Name");
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
