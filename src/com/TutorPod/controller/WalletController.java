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

import com.TutorPod.dao.WalletDAO;
import com.TutorPod.dao.WithdrawRequestDAO;
import com.TutorPod.model.User;
import com.TutorPod.model.Wallet;
import com.TutorPod.model.WalletTransaction;
import com.TutorPod.model.WithdrawRequest;
import com.google.gson.Gson;


@WebServlet("/WalletController")
public class WalletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	WalletDAO walletDAO;
	WithdrawRequestDAO withdrawRequestDAO;
    public WalletController() {
        super();
    }
    public void init(ServletConfig config) throws ServletException {
		
		super.init();
		try {
			 walletDAO = new WalletDAO(dataSource);
			 withdrawRequestDAO = new WithdrawRequestDAO(dataSource);
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
				case "addMoney":
					double amount = Double.parseDouble(request.getParameter("amount"));
					User user  = (User)session.getAttribute("USER");
					Wallet wallet = walletDAO.getWalletByUserID(user.getUser_id());
					DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
					Instant instant = Instant.now();
					String datetime = dateTimeFormatter.format(instant);
					if(walletDAO.addWalletTransaction(new WalletTransaction(wallet.getWallet_id(),amount,true,false,wallet.getBalance()+amount,"Money Added by Self","Completed",datetime))) {
						wallet.setBalance(wallet.getBalance()+amount);
						walletDAO.updateWallet(wallet);
						out.write("Money Added");
					}else
						out.write("Failed to Add Money");
					break;
				case"withdrawRequest":
					amount = Double.parseDouble(request.getParameter("amount"));
					user  = (User)session.getAttribute("USER");
					wallet = walletDAO.getWalletByUserID(user.getUser_id());
					dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
					instant = Instant.now();
					datetime = dateTimeFormatter.format(instant);
					if(wallet.getBalance()<amount) {
						out.write("Insufficient Balance");
						return;
					}
					walletDAO.Rollback();
					walletDAO.setAutoCommit(0);
					if(walletDAO.addWalletTransaction(new WalletTransaction(wallet.getWallet_id(),amount,false,true,wallet.getBalance(),"Withdrawal Request","Pending",datetime))) {
						if(withdrawRequestDAO.addWithdrawRequest(new WithdrawRequest(wallet.getWallet_id(),walletDAO.getRecentWalletTransaction().getWallet_transaction_id(),amount,"Pending","Withdrawl Request of "+amount+" from "+user.getLname()+" "+user.getLname()+""))) {
							walletDAO.Commit();
							walletDAO.setAutoCommit(1);
							out.write("Withdrawal Requested");
							return;
						}
					}
					out.write("Failed to make request");
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
