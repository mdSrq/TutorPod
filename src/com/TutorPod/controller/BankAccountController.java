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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.TutorPod.dao.AdminBankAccDAO;
import com.TutorPod.dao.AdminBankAccountDAO;
import com.TutorPod.dao.BankAccDAO;
import com.TutorPod.dao.UserDAO;
import com.TutorPod.model.AdminBankAcc;
import com.TutorPod.model.BankAcc;
import com.TutorPod.model.User;
import com.google.gson.Gson;

@WebServlet("/BankAccountController")
public class BankAccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	private BankAccDAO bankAccDAO;
	private AdminBankAccDAO adminBankAccDAO;
	private AdminBankAccountDAO adminBankAccountDAO;
	private UserDAO userDAO;
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		try {
			bankAccDAO = new BankAccDAO(dataSource);
			adminBankAccDAO = new AdminBankAccDAO(dataSource);
			adminBankAccountDAO = new AdminBankAccountDAO(dataSource);
			userDAO = new UserDAO(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}
	
    public BankAccountController() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {
			if(request.getParameter("cmd")==null)
				out.write("request has no command");
			switch(request.getParameter("cmd")) {
			case"seeAdminBankAccounts":
				response.setContentType("application/json");
				String responseJSON = new Gson().toJson(adminBankAccountDAO.getAdminBankAcccounts());
				out.write(responseJSON);
				break;
			case"deleteAdminBankAccount":
				int admin_bank_acc_id = Integer.parseInt(request.getParameter("admin_bank_acc_id"));
				boolean bankAccProcessed = false;
				boolean adminBankAccProcessed = false;
				bankAccProcessed = bankAccDAO.deleteBankAcc(adminBankAccDAO.getAdminBankAcc(admin_bank_acc_id).getBank_acc_id());
				adminBankAccProcessed = adminBankAccDAO.deleteBankAcc(admin_bank_acc_id);
				if(bankAccProcessed && adminBankAccProcessed)
					out.write("Deleted");
				else
					out.write("Failed to delete");
				break;
			case"editAdminBankAccount":
				response.setContentType("application/json");
				admin_bank_acc_id = Integer.parseInt(request.getParameter("admin_bank_acc_id"));
				responseJSON = new Gson().toJson(adminBankAccountDAO.getAdminBankAccount(admin_bank_acc_id));
				out.write(responseJSON);
				break;
			case"selectAdminBankAccount":
				admin_bank_acc_id = Integer.parseInt(request.getParameter("admin_bank_acc_id"));
				if(adminBankAccDAO.selectBankAcc(admin_bank_acc_id))
					out.write("Bank Account Selected");
				else
					out.write("Failed to select bank account");
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
			case"addAdminBankAcc":
				int admin_id = Integer.parseInt(request.getParameter("admin_id"));
				String bank_name = request.getParameter("bank_name").strip();
				String acc_no = request.getParameter("acc_no").strip();
				String holder_name = request.getParameter("holder_name").strip();
				String ifsc_code = request.getParameter("ifsc_code").strip();
				long balance = Long.parseLong(request.getParameter("balance").strip());
				int bank_acc_id=0;
				boolean bankAccProcessed = false;
				boolean adminBankAccProcessed = false;
				bankAccProcessed = bankAccDAO.addBankAcc(new BankAcc(bank_name,acc_no,holder_name,ifsc_code,balance));
				if(bankAccProcessed) {
					bank_acc_id = bankAccDAO.getMostRecentBankAcc().getBank_acc_id();
					adminBankAccProcessed = adminBankAccDAO.addBankAcc(new AdminBankAcc(admin_id,bank_acc_id,false));
				}
				if(bankAccProcessed && adminBankAccProcessed)
					out.write("Bank Account Added");
				else
					out.write("Failed to add bank account");
				break;
			case "saveBankAcc":
				String password = request.getParameter("password");
				User user = (User)session.getAttribute("USER");
				if(user.getPassword().equals(password)) {
					bank_name = request.getParameter("bank_name").strip();
					acc_no = request.getParameter("acc_no").strip();
					holder_name = request.getParameter("holder_name").strip();
					ifsc_code = request.getParameter("ifsc_code").strip();
					balance = 0;
					bank_acc_id=0;
					bankAccProcessed = false;
					BankAcc bankAcc=null;
					boolean accountExists=user.getBank_acc_id()>0;
					if(accountExists) {
						bank_acc_id = user.getBank_acc_id();
						bankAccProcessed = bankAccDAO.updateBankAcc(new BankAcc(bank_acc_id,bank_name,acc_no,holder_name,ifsc_code,balance));
					
					}
					else {
						bankAccProcessed = bankAccDAO.addBankAcc(new BankAcc(bank_name,acc_no,holder_name,ifsc_code,balance));
						if(bankAccProcessed) {
							bankAcc = bankAccDAO.getMostRecentBankAcc();
							bank_acc_id = bankAcc.getBank_acc_id();
						}
					}
					if(bankAccProcessed) {
						if(accountExists)
							out.write("Bank Details Saved");
						else {
						if(userDAO.updateUserField("bank_acc_id", ""+bank_acc_id, true, user.getUser_id())) {
							user.setBank_acc_id(bank_acc_id);
							session.setAttribute("USER", user);
							session.setAttribute("BANK_ACC", bankAcc);
							out.write("Bank Details Saved");
						}else
							out.write("Failed to update user details");
						}
					}else
						out.write("Failed to add bank account");
				}else
					out.write("Wrong Password");
				break;
			case"editAdminBankAccount":
				int admin_bank_acc_id = Integer.parseInt(request.getParameter("admin_bank_acc_id"));
				admin_id = Integer.parseInt(request.getParameter("admin_id").strip());
				bank_name = request.getParameter("bank_name").strip();
				acc_no = request.getParameter("acc_no").strip();
				holder_name = request.getParameter("holder_name").strip();
				ifsc_code = request.getParameter("ifsc_code").strip();
				balance = Long.parseLong(request.getParameter("balance").strip());
				bank_acc_id=Integer.parseInt(request.getParameter("bank_acc_id").strip());
				bankAccProcessed = false;
				adminBankAccProcessed = false;
				bankAccProcessed = bankAccDAO.updateBankAcc(new BankAcc(bank_acc_id,bank_name,acc_no,holder_name,ifsc_code,balance));
				if(bankAccProcessed) {
					bank_acc_id = bankAccDAO.getMostRecentBankAcc().getBank_acc_id();
					adminBankAccProcessed = adminBankAccDAO.updateBankAcc(new AdminBankAcc(admin_bank_acc_id,admin_id,bank_acc_id,false));
				}
				if(bankAccProcessed && adminBankAccProcessed)
					out.write("Bank Account Updated");
				else
					out.write("Failed to update bank account");
				break;
			default:
				out.write("Invalid Request");
			}
		}catch(Exception e) {
			e.printStackTrace(out);
		}
	}
}
