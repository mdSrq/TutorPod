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

import com.TutorPod.dao.CourseSubDAO;
import com.TutorPod.dao.CourseSubjectDAO;
import com.TutorPod.dao.SubjectDAO;
import com.TutorPod.model.CourseSub;
import com.TutorPod.model.Subject;
import com.google.gson.Gson;


@WebServlet("/SubjectController")
public class SubjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	private CourseSubjectDAO courseSubjectDAO;
	private SubjectDAO subjectDAO;
	private CourseSubDAO courseSubDAO;
    public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		try {
			courseSubjectDAO = new CourseSubjectDAO(dataSource);
			subjectDAO = new SubjectDAO(dataSource);
			courseSubDAO = new CourseSubDAO(dataSource);
			
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}
    public SubjectController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {
			if(request.getParameter("cmd")==null)
				out.write("request has no command");
		    response.setCharacterEncoding("UTF-8");
			switch(request.getParameter("cmd")) {
			case "seeRecentSubjects":
				response.setContentType("application/json");
				String responseJSON = new Gson().toJson(courseSubjectDAO.getCourseSubjects("Recent"));
			    out.write(responseJSON);
				break;
			case "seeSubjects":
				response.setContentType("application/json");
				responseJSON = new Gson().toJson(courseSubjectDAO.getCourseSubjects("All"));
			    out.write(responseJSON);
				break;
			case "seeCourseSubjects":
				response.setContentType("application/json");
				int course_id = Integer.parseInt(request.getParameter("course_id"));
				responseJSON = new Gson().toJson(courseSubjectDAO.getCourseSubjectsByCourseId(course_id));
			    out.write(responseJSON);
				break;
			case "seeCourseAndSubjects":
				response.setContentType("application/json");
				responseJSON = new Gson().toJson(courseSubjectDAO.getCourseSubjects());
			    out.write(responseJSON);
				break;
			case "deleteSubject":
				int course_sub_id =  Integer.parseInt(request.getParameter("course_sub_id"));
				int subject_id =  Integer.parseInt(request.getParameter("subject_id"));
				response.setContentType("text/plain");
				if(courseSubjectDAO.deleteCourseSubject(course_sub_id,subject_id))
					out.write("Deleted");
				else
					out.write("Failed to delete");
				break;
			case "editSubject":
				response.setContentType("application/json");
				course_sub_id =  Integer.parseInt(request.getParameter("course_sub_id")); 
				responseJSON = new Gson().toJson(courseSubjectDAO.getCourseSubject(course_sub_id));
			    out.write(responseJSON);
				break;
			default:
				response.getWriter().write("Invalid Request");
			}
		}catch(Exception e) {
			e.printStackTrace(out);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {
			if(request.getParameter("cmd")==null)
				out.write("request has no command");
			switch(request.getParameter("cmd")) {
			case "addSubject":
				int course_id = Integer.parseInt(request.getParameter("course_id"));
				int duration_no = Integer.parseInt(request.getParameter("duration_no"));
				int subject_id=0;
				String subject_name = request.getParameter("subject_name");
				String subject_code = request.getParameter("subject_code");
				boolean subjectAdded=false;
				boolean courseSubAdded=false;
				if(subjectDAO.getSubject(subject_code)==null)
					subjectDAO.addSubject(new Subject(subject_name,subject_code));
				subject_id = subjectDAO.getSubject(subject_code).getSubject_id();
				subjectAdded=true;
				if(courseSubDAO.addCourseSub(new CourseSub(course_id,duration_no,subject_id)) ){
					courseSubAdded=true;
				}
				if(subjectAdded && courseSubAdded)
					out.write("Subject Added");
				else
					out.write("Failed to add subject");
				break;
			case "editSubject":
				course_id = Integer.parseInt(request.getParameter("course_id"));
				duration_no = Integer.parseInt(request.getParameter("duration_no"));
				subject_name = request.getParameter("subject_name");
				subject_code = request.getParameter("subject_code");
				int course_sub_id = Integer.parseInt(request.getParameter("course_sub_id"));
				subject_id = Integer.parseInt(request.getParameter("subject_id"));
				boolean subjectUpdated=false;
				boolean courseSubUpdated=false;
				if(subjectDAO.getSubject(subject_code)==null) {
					subjectDAO.addSubject(new Subject(subject_name,subject_code));
					if(courseSubDAO.getCourseSubsBySubjectId(subject_id).size()<=1)
						subjectDAO.deleteSubject(subject_id);
				}
				else
					subjectDAO.updateSubject(new Subject(subject_id,subject_name,subject_code));
				subject_id = subjectDAO.getSubject(subject_code).getSubject_id();
				subjectUpdated=true;
				if(courseSubDAO.updateCourseSub(new CourseSub(course_sub_id,course_id,duration_no,subject_id)) ){
					courseSubUpdated=true;
				}
				if(courseSubUpdated && subjectUpdated)
					out.write("Subject Updated");
				else
					out.write("Failed to update subject");
				break;
			default:
				response.getWriter().print("Invalid Request");
			}
			
		}catch(Exception e) {
			e.printStackTrace(out);
		}
	}

}
