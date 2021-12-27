
<%
if (session.getAttribute("ADMIN") == null) {
	response.sendRedirect("./Login");
}
%>
<%@include file="header.jsp"%>
<%@include file="sidebar.jsp"%>
<main class="main">
	<div class="main__preview main__table">
		<table aria-label="Course Data" id="default_table">
			<h1 class="main__heading">Withdraw Requests</h1>
			<thead>
				<tr>
					<th scope="...">ID</th>
					<th scope="...">User Details</th>
					<th scope="...">Amount</th>
					<th scope="...">Bank Details</th>
					<th scope="...">Date</th>
					<th scope="...">Status</th>
					<th scope="..." id="actionTh">Action</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
	<div class="main_overlayform" tabindex="-1">
		<a href="#" class="main_overlayform_cross" onclick="hideOverlayForm()">X</a>
		<h2 class="main__sub-heading">Dismiss Request</h2>
		<form action="../WalletController" method="post" class="scrollable" id="dimissForm">
			<div class="form-unit form-unit-full">
				<label for="message">Dismiss Message</label>
				<textarea name="message" id="message" class="input-with-icon input-with-icon_no-icon" placeholder="Enter reason for dismissing request" required></textarea>
			</div>
			<input type="hidden" name="cmd" value="dismissWithdrawRequest">
			<input type="hidden" name="request_id" id="request_id">
			<input type="submit" class="button flat-wide-button red-button" value="Dismiss Request">
		</form>
	</div>
</main>
<script type="text/javascript">
	function showOverlayForm(){
        $("<div>").addClass("overlay-background").css("display", "block").appendTo($("body"));
        $(".main_overlayform").css("display", "block");
        $(".main_overlayform").focus();
    }
    function hideOverlayForm() {
        $(".main_overlayform").removeAttr("style");
        $(".overlay-background").remove();
    }
	function loadWithdrawRequests(){
		showLoading();
		$.ajax({
            url: "../WalletController",
            data: "cmd=loadWithdrawRequests&status=<%=request.getParameter("status")%>",
            success: function (response) {
                hideLoading();
				if (response.length < 1) {
                    $("thead").hide();
                    $("#NoData").remove();
                    $(".main__preview").append(
                        "<p style=\"text-align:center\" id=\"NoData\">No Request Found</p>");
                } else {
                    $("thead").show();
                    $("#NoData").remove();
                }
				$("tbody").empty();
                $.each(response,function(i,rqst){
					const tr =
					$("<tr>").appendTo($("#default_table tbody"))
						.append($("<td>").text(rqst.request_id))
						.append($("<td>").html("Name: "+rqst.user.fname+" "+rqst.user.lname+"<br>"+
											   "Email ID: "+rqst.user.email_id+"<br>"+
											   "Mobile No.: "+rqst.user.mobile_no+"<br>").css("text-align","left"))
						.append($("<td>").text(rqst.amount))
						.append($("<td>").html("Bank: "+rqst.bankAcc.bank_name+"<br>"+
											   "Holder: "+rqst.bankAcc.holder_name+"<br>"+
											   "Acc No.: "+rqst.bankAcc.acc_no+"<br>"+
											   "IFSC: "+rqst.bankAcc.ifsc_code+"<br>").css("text-align","left"))
						.append($("<td>").text(rqst.date))
						.append($("<td>").text(rqst.status))
					if(rqst.status==="Pending"){
						$("<td>").appendTo(tr)
							.append($("<span>").html("&nbsp;&nbsp; &#10004; &nbsp;&nbsp;").prop({
								"class":"button small-round-button green-button",
								"title":"Approve"
							}).click(()=>{approveRequest(rqst.request_id)}))
							.append($("<span>").html("&nbsp;&nbsp; &#10006; &nbsp;&nbsp;").prop({
								"class":"button small-round-button delete-button",
								"title":"Dismiss"
							}).click(()=>{dismissRequest(rqst.request_id)}));
					}else{
						$("#actionTh").remove();
					}
				});
            }
        });
	}
	function approveRequest(request_id){
		if(!confirm("Are you sure to approve this withdrawal request?"))
			return;
		$.post("../WalletController","cmd=approveWithdrawRequest&request_id="+request_id,function(response){
			if(response.includes("Approved")){
				loadWithdrawRequests();
				$("#snackbar").html(response);
				showToast();
			}else{
				$("#snackbar").html(response);
				showToast();
				console.log(response);
			}
		});
	}
	function dismissRequest(request_id){
		$("#request_id").val(request_id);
		showOverlayForm();
	}
	$(document).ready(()=>{
		loadWithdrawRequests();
		$(".main_overlayform").focusout(function () {
            if ($(".main_overlayform :hover").length > 0)
                return;
            hideOverlayForm();
        });
		$(document).on("submit", "#dimissForm", function (event) {
            event.preventDefault();
            var $form = $(this);
            showLoading();
            $.post($form.attr("action"), $form.serialize(), function (response) {
                hideLoading();
                $form.trigger("reset");
                if (response.includes("Exception")) {
                    $("<pre>").addClass("overlay-background").css({
                        "display": "block",
                        "background-color": "rgba(0, 0, 0, 0.85)"
                    }).html(response).appendTo("body");
                    $(".overlay-background").click(() => {
                        $(".overlay-background").remove();
                    });
                }
                if (response.includes("Dismissed")) {
                   hideOverlayForm();
				   loadWithdrawRequests();
				   $("#snackbar").html(response);
				   showToast();
                } else {
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
                }
            });
        });
	});
</script>
<%@include file="footer.jsp"%>