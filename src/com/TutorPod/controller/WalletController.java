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
import com.TutorPod.dao.NotificationDAO;
import com.TutorPod.dao.TransactionDAO;
import com.TutorPod.dao.UserDAO;
import com.TutorPod.dao.WalletDAO;
import com.TutorPod.dao.WithdrawRequestDAO;
import com.TutorPod.model.BankAcc;
import com.TutorPod.model.Notification;
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
	NotificationDAO notificationDAO;
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
			 notificationDAO = new NotificationDAO(dataSource);
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
					Tutor tutor = (Tutor)session.getAttribute("TUTOR");
					double withdrawable = withdrawRequestDAO.getRequestedAmount(user.getUser_id());
					if(tutor!=null)
						withdrawable += withdrawRequestDAO.getPendingLessonsAmount(tutor.getTutor_id());
					withdrawable = wallet.getBalance() - withdrawable;
					response.setContentType("application/json");
					out.write("{\"balance\":"+wallet.getBalance()+",\"withdrawable\":"+withdrawable+"}");
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
				case"loadPendingRequestCount":
					out.write(""+withdrawRequestDAO.getWithdrawRequests("Pending").size());
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
				else
				switch(request.getParameter("cmd")) {
				case "addMoney":
					if(adminBankAccDAO.getSelectedAdminBankAcc()==null) {
						out.write("Error! Admin Bank Acc not configured");
						return;
					}
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
					if(amount<1) {
						out.write("Amount cannot be less than Rs.1");
						return;
					}
					user  = (User)session.getAttribute("USER");
					if(user.getBank_acc_id()<1) {
						out.write("Error! No bank acc details found");
						return;
					}
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
							out.write("Insufficient Withdrawable Balance");
							return;
						}
					if(tutor!=null) {
						pendingLessonAmt = withdrawRequestDAO.getPendingLessonsAmount(tutor.getTutor_id());
						if(pendingLessonAmt>0)
							if(wallet.getBalance()<amount+pendingLessonAmt) {
								out.write("Insufficient Withdrawable Balance");
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
					if(session.getAttribute("ADMIN")!=null) {
						int request_id = Integer.parseInt(request.getParameter("request_id"));
					 	WithdrawRequest wRequest =  withdrawRequestDAO.getWithdrawRequest(request_id);
						WithdrawRequestDetails rqst = createRequestDetails(wRequest);
						dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd").withZone(ZoneId.systemDefault());
						instant = Instant.now();
						date = dateTimeFormatter.format(instant);
						wallet = walletDAO.getWalletByUserID(rqst.getUser().getUser_id());
						WalletTransaction walletTxn = walletDAO.getWalletTransaction(rqst.getWallet_transaction_id());
						dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
						instant = Instant.now();
						datetime = dateTimeFormatter.format(instant);
						adminBankAcc = bankAccDAO.getBankAcc(adminBankAccDAO.getSelectedAdminBankAcc().getBank_acc_id());
						BankAcc userBankAcc = bankAccDAO.getBankAcc(rqst.getUser().getBank_acc_id());
						if(wallet.getBalance()<rqst.getAmount()) {
							out.write("Insufficient Balance in User Wallet");
							return;
						}
						if(adminBankAcc.getBalance()<rqst.getAmount()) {
							out.write("Insufficient balance admin bank account");
							return;
						}
						walletDAO.Rollback();
						walletDAO.setAutoCommit(0);
						if(transactionDAO.addTransaction(new Transaction("AdminBankAcc",adminBankAcc.getBank_acc_id(),"User",rqst.getUser().getUser_id(), rqst.getAmount(),"Money withdrawn by User ID:"+rqst.getUser().getUser_id(), date, datetime))) {
							adminBankAcc.setBalance(adminBankAcc.getBalance()-(long)rqst.getAmount());
							userBankAcc.setBalance(userBankAcc.getBalance()+(long)rqst.getAmount());
							walletTxn.setStatus("Completed");
							wallet.setBalance(wallet.getBalance()-rqst.getAmount());
							wRequest.setStatus("Completed");
							if(bankAccDAO.updateBankAcc(adminBankAcc)
							&& bankAccDAO.updateBankAcc(userBankAcc)
							&& walletDAO.updateWalletTransaction(walletTxn)
							&& walletDAO.updateWallet(wallet)
							&& withdrawRequestDAO.updateWithdrawRequest(wRequest)) {
								sendNotification(rqst.getUser().getUser_id(),
								"Withdrawal request of Rs."+rqst.getAmount()+" has been approved, amount is transferred to your bank account.",
								"./Notifications",false);
								walletDAO.Commit();
								walletDAO.setAutoCommit(1);
								out.write("Request Approved");
								return;
							}
						}
					}
					break;
				case "dismissWithdrawRequest":
						if(session.getAttribute("ADMIN")!=null) {
						String message = request.getParameter("message");
						int request_id = Integer.parseInt(request.getParameter("request_id"));
					 	WithdrawRequest wRequest =  withdrawRequestDAO.getWithdrawRequest(request_id);
						WithdrawRequestDetails rqst = createRequestDetails(wRequest);
						WalletTransaction walletTxn = walletDAO.getWalletTransaction(rqst.getWallet_transaction_id());
						wRequest.setStatus("Dimissed");
						walletTxn.setStatus("Failed");
						if(withdrawRequestDAO.updateWithdrawRequest(wRequest) && walletDAO.updateWalletTransaction(walletTxn)) {
							sendNotification(rqst.getUser().getUser_id(),
									"Your Withdrawal Request of Rs."+rqst.getAmount()+" has been dismissed. Reason: "+message,
									"./Notifications",false);
							out.write("Request Dismissed");
							return;
						}
						out.write("Failed to Dismiss Request");
					}
					break;
				default:
					out.write("Invalid Request");
				}
			}catch(Exception e) {
				e.printStackTrace(out);
			}
	}
	private WithdrawRequestDetails createRequestDetails(WithdrawRequest withRqst)throws Exception{
		User user = userDAO.getUser(walletDAO.getWallet(withRqst.getWallet_id()).getUser_id());
		user.setPassword("**************");
		BankAcc bankAcc= bankAccDAO.getBankAcc(user.getBank_acc_id());
		return new WithdrawRequestDetails(withRqst.getRequest_id(), withRqst.getWallet_id(), withRqst.getWallet_transaction_id(), withRqst.getAmount(), withRqst.getStatus(), withRqst.getDate(), withRqst.getRemarks(), user, bankAcc);
	}
	private boolean sendNotification(int id,String message,String link,boolean toTutor)throws Exception{
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
		Instant instant = Instant.now();
		String datetime = dateTimeFormatter.format(instant);
		if(toTutor)
			return notificationDAO.addNotification(new Notification(message,link,datetime,-1,id,false,false));
		else
			return notificationDAO.addNotification(new Notification(message,link,datetime,id,-1,false,false));
	}
}
