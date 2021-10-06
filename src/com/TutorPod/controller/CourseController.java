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

import com.TutorPod.dao.CourseDAO;
import com.TutorPod.model.Course;
import com.google.gson.Gson;

/**
 * Servlet implementation class CourseController
 */
@WebServlet("/CourseController")
public class CourseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	private CourseDAO courseDAO;
    public CourseController() {
        super();
        // TODO Auto-generated constructor stub
    }
    public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		try {
			courseDAO = new CourseDAO(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
			switch(request.getParameter("cmd")) {
			case "seeCourses":
				String couresesJSON = new Gson().toJson(courseDAO.getCourses());
			    out.write(couresesJSON);
				break;
			case"deleteCourse":
				int course_id =  Integer.parseInt(request.getParameter("course_id"));
				response.setContentType("text/plain");
				if(courseDAO.deleteCourse(course_id))
					out.write("Deleted");
				else
					out.write("Failed to delete");
				break;
			default:
				response.getWriter().write("Invalid Request");
			}
			
		}catch(Exception e) {
			response.getWriter().write(e.toString());
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			switch(request.getParameter("cmd")) {
			case "addCourse":
				String course_name = request.getParameter("course_name");
				String name_abbr = request.getParameter("name_abbr");
				String duration_type = request.getParameter("duration_type");
				int duration =  Integer.parseInt(request.getParameter("duration"));
				response.setContentType("text/plain");
				if( courseDAO.addCourse(new Course(course_name, name_abbr, duration_type, duration)) )
					out.write("Course Added");
				else
					out.write("Failed to Add");
				break;
			default:
				response.getWriter().print("Invalid Request");
			}
			
		}catch(Exception e) {
			e.printStackTrace(response.getWriter());
		}
	}

}
