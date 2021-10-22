<%
	if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }
	if(request.getParameter("admin_bank_acc_id")==null){response.sendRedirect("./Dashboard"); }
%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
        <h1 class="main__heading">Update Admin Bank Account</h1>
        <form action="../BankAccountController" method="POST" class="main__form main__form_wide" id="editAdminBankAccForm">
            <span class="caption">Enter Bank Details</span>
            <div class="form_group">
                <label for="admin_id">Select Admin</label>
                <select name="admin_id" id="admin_id">
                    <option value="default" selected disabled>Select an Admin </option>
                </select>
            </div>
            <div class="form_group">
                <label for="bank_name">Bank Name</label>
                <input type="text" name="bank_name" id="bank_name" required placeholder="Enter bank name ">
            </div>
            <div class="form_group">
                <label for="acc_no">Account Number</label>
                <input type="text" name="acc_no" id="acc_no" required placeholder="Enter account number">
            </div>
             <div class="form_group">
                <label for="holder_name">Account Holder</label>
                <input type="text" name="holder_name" id="holder_name" required placeholder="Enter holder's name">
            </div>
            <div class="form_group">
                <label for="ifsc_code">IFSC Code</label>
                <input type="text" name="ifsc_code" id="ifsc_code" required placeholder="Enter IFSC code">
            </div>
            <div class="form_group">
                <label for="balance">Initial Balance</label>
                <input type="number" name="balance" id="balance" required placeholder="Enter initial balance">
            </div>
            <input type="hidden" name="bank_acc_id" id="bank_acc_id">
            <input type="hidden" name="admin_bank_acc_id" id="admin_bank_acc_id">
            <input type="hidden" name="cmd" id="cmd" value="editAdminBankAccount">
            <div class="form_group form_group_submit">
                <input type="submit" class="button flat-wide-button" value="Update Bank Account">
            </div>
        </form>
</main>
<div id="snackbar"><span></span></div>
<script src="../app/js/jquery-3.6.0.min.js"></script>
<script src="../app/js/admin-script.js"></script>
<script type="text/javascript">
$("document").ready(()=>{
showLoading();
fetchAdminData();
fetchBankAccData();
hideLoading();
});
function fetchBankAccData() {
    $.ajax({
           url:"../BankAccountController",
           data:"cmd=editAdminBankAccount&admin_bank_acc_id=<%=request.getParameter("admin_bank_acc_id")%>",
           dataType:"json",
           processData: true,
           success:function(res){
               $("#admin_bank_acc_id").val(res.admin_bank_acc_id);
               $("#bank_acc_id").val(res.bank_acc_id);
               $("#admin_id option[value=\""+res.admin_id+"\"]").prop('selected', true);
               $("#bank_name").val(res.bank_name);
               $("#acc_no").val(res.acc_no);
               $("#holder_name").val(res.holder_name);
               $("#ifsc_code").val(res.ifsc_code);
               $("#balance").val(res.balance);               
           }
       });
}
function fetchAdminData() {
    $.ajax({
           url:"../AdminController",
           data:"cmd=seeAdmins",
           dataType:"json",
           success:function(res){
        	   $("#admin_id").empty();
        	   $("#admin_id").append($("<option>").attr({selected:true,disabled:true}).text("Select an Admin"));
        	   $.each(res, function(index, list) {   
        		   $("#admin_id").append($("<option>").val(list.admin_id).text(list.name));
        	   });
           }
       });
}
$(document).on("submit", "#editAdminBankAccForm", function(event) {
    var $form = $(this);
    if($("#admin_id").val()==null){
        $("#snackbar").html("Select an Admin");
        showToast();
        return false; 
    }
    showLoading();
    $.post($form.attr("action"), $form.serialize(), function(response) {
    		hideLoading();
        	$("#snackbar").html(response); 
            showToast();
            console.log(response);
            fetchBankAccData();
            $form.trigger("reset");
    });  
    event.preventDefault();
});
$( document ).ajaxError(function(event, jqxhr, settings, thrownError ) {
	$("#snackbar").html("Some error occured see the log"); 
	  console.log(jqxhr.responseText+"\n"+thrownError);
	    showToast(); 
}); 
</script>
<%@include file="footer.jsp" %>