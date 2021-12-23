package com.TutorPod.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

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
import com.TutorPod.dao.BankAccDAO;
import com.TutorPod.dao.TransactionDAO;
import com.TutorPod.dao.UserDAO;
import com.TutorPod.dao.WalletDAO;
import com.TutorPod.dao.WithdrawRequestDAO;
import com.TutorPod.model.BankAcc;
import com.TutorPod.model.Transaction;
import com.TutorPod.model.Tutor;
import com.TutorPod.model.User;
import com.TutorPod.model.Wallet;
import com.TutorPod.model.WalletTransaction;
import com.TutorPod.model.WithdrawRequest;
import com.TutorPod.model.WithdrawRequestDetails;
import com.google.gson.Gson;


@WebServlet("/WalletController")
public class WalletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Resource(name="tutorpod")
	private DataSource dataSource;
	WalletDAO walletDAO;
	WithdrawRequestDAO withdrawRequestDAO;
	AdminBankAccDAO adminBankAccDAO;
	BankAccDAO bankAccDAO;
	TransactionDAO transactionDAO;
	UserDAO userDAO;
    public WalletController() {
        super();
    }
    public void init(ServletConfig config) throws ServletException {
		
		super.init();
		try {
			 walletDAO = new WalletDAO(dataSource);
			 withdrawRequestDAO = new WithdrawRequestDAO(dataSource);
			 bankAccDAO = new BankAccDAO(dataSource);
			 adminBankAccDAO = new AdminBankAccDAO(dataSource);
			 transactionDAO = new TransactionDAO(dataSource);
			 userDAO = new UserDAO(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
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
				case"loadWithdrawRequests":
					String status = request.getParameter("status");
					ListIterator<WithdrawRequest> itr = withdrawRequestDAO.getWithdrawRequests(status).listIterator();
					List<WithdrawRequestDetails> rqsts = new ArrayList<>();
					while(itr.hasNext())
						rqsts.add(createRequestDetails(itr.next()));
					responseJSON="[]";
					response.setContentType("application/json");
					responseJSON = new Gson().toJson(rqsts);
					out.write(responseJSON);
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
					DateTimeFormatter dateTimeFormatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd").withZone(ZoneId.systemDefault());
					Instant instant = Instant.now();
					String datetime = dateTimeFormatter.format(instant);
					String date = dateTimeFormatter1.format(instant);
					BankAcc adminBankAcc = bankAccDAO.getBankAcc(adminBankAccDAO.getSelectedAdminBankAcc().getBank_acc_id());
					walletDAO.Rollback();
					walletDAO.setAutoCommit(0);
					if(transactionDAO.addTransaction(new Transaction("User", user.getUser_id(),"AdminBankAcc", adminBankAcc.getBank_acc_id(), amount,"Money added to wallet by User ID:"+user.getUser_id(), date, datetime))) {
						adminBankAcc.setBalance(adminBankAcc.getBalance()+(long)amount);
						if(bankAccDAO.updateBankAcc(adminBankAcc))
						if(walletDAO.addWalletTransaction(new WalletTransaction(wallet.getWallet_id(),amount,true,false,wallet.getBalance()+amount,"Money Added by Self","Completed",datetime))) {
							wallet.setBalance(wallet.getBalance()+amount);
							walletDAO.updateWallet(wallet);
							walletDAO.Commit();
							walletDAO.setAutoCommit(1);
							out.write("Money Added");
							return;
						}
					}
					out.write("Failed to Add Money");
					break;
				case"withdrawRequest":
					amount = Double.parseDouble(request.getParameter("amount"));
					user  = (User)session.getAttribute("USER");
					Tutor tutor  = (Tutor)session.getAttribute("TUTOR");
					dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd").withZone(ZoneId.systemDefault());
					instant = Instant.now();
					date = dateTimeFormatter.format(instant);
					wallet = walletDAO.getWalletByUserID(user.getUser_id());
					dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
					instant = Instant.now();
					datetime = dateTimeFormatter.format(instant);
					if(wallet.getBalance()<amount) {
						out.write("Insufficient Balance");
						return;
					}
					double prevRqsts = withdrawRequestDAO.getRequestedAmount(user.getUser_id());
					double pendingLessonAmt=0;
					if(prevRqsts>0)
						if(wallet.getBalance()<amount+prevRqsts) {
							out.write("Insufficient Balance");
							return;
						}
					if(tutor!=null) {
						pendingLessonAmt = withdrawRequestDAO.getPendingLessonsAmount(tutor.getTutor_id());
						if(pendingLessonAmt>0)
							if(wallet.getBalance()<amount+pendingLessonAmt) {
								out.write("Complete Lessons to withdraw amount earned");
								return;
							}
					}
					if(wallet.getBalance()<amount+prevRqsts+pendingLessonAmt) {
						out.write("Insufficient Balance");
						return;
					}
					walletDAO.Rollback();
					walletDAO.setAutoCommit(0);
					if(walletDAO.addWalletTransaction(new WalletTransaction(wallet.getWallet_id(),amount,false,true,wallet.getBalance(),"Withdrawal Request","Pending",datetime))) {
						if(withdrawRequestDAO.addWithdrawRequest(new WithdrawRequest(wallet.getWallet_id(),walletDAO.getRecentWalletTransaction().getWallet_transaction_id(),amount,"Pending","Withdrawl Request of "+amount+" from "+user.getFname()+" "+user.getLname()+"",date))) {
							walletDAO.Commit();
							walletDAO.setAutoCommit(1);
							out.write("Withdrawal Requested");
							return;
						}
					}
					out.write("Failed to make request");
					break;
				case "approveWithdrawRequest":
					int request_id = Integer.parseInt(request.getParameter("request_id"));
					WithdrawRequestDetails rqst = createRequestDetails(withdrawRequestDAO.getWithdrawRequest(request_id));
					dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd").withZone(ZoneId.systemDefault());
					instant = Instant.now();
					date = dateTimeFormatter.format(instant);
					wallet = walletDAO.getWalletByUserID(rqst.getUser().getUser_id());
					dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
					instant = Instant.now();
					datetime = dateTimeFormatter.format(instant);
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
	private WithdrawRequestDetails createRequestDetails(WithdrawRequest withRqst)throws Exception{
		User user = userDAO.getUser(walletDAO.getWallet(withRqst.getWallet_id()).getUser_id());
		user.setPassword("**************");
		BankAcc bankAcc= bankAccDAO.getBankAcc(user.getBank_acc_id());
		return new WithdrawRequestDetails(withRqst.getRequest_id(), withRqst.getWallet_id(), withRqst.getWallet_transaction_id(), withRqst.getAmount(), withRqst.getStatus(), withRqst.getDate(), withRqst.getRemarks(), user, bankAcc);
	}
}
