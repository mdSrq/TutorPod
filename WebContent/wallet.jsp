<%if(session.getAttribute("USER")==null){ response.sendRedirect("./");return;}%>
<%@include file="header.jsp" %>
 <div class="flex-container">
 <%@include file="sidebar.jsp" %>
<main class="main">
            <h1 class="main__heading">My Wallet</h1>
            <div class="main__dashboard-container">
                <div class="main__tile main__wallet__tile">
                    <div class="main__tile_img">
                        <img src="./images/wallet.png" alt="">
                    </div>
                    <div class="main__wallet__tile_balance">
                        <span class="main__wallet__tile_title">Wallet Balance</span>
                        <span class="main__wallet__tile_num"></span>
                    </div>
                    <div class="main__wallet__tile_btnunit">
                        <button class=" button round-single-button addBtn" id="addBtn">+</button>
                        <label for="addBtn">Add Money </label>
                    </div>
                    <div class="main__wallet__tile_btnunit">
                        <button class=" button round-single-button subBtn" id="subBtn">-</button>
                        <label for="subBtn">Request Withdrawal</label>
                    </div>
                </div>
                <div class="table-wrapper">
                    <table class="white-table" id="transactionsTable">
                        <thead>
                            <th>S.No</th>
                            <th>Date & Time</th>
                            <th>Txn Amount</th>
                            <th>Balance</th>
                            <th>Comment</th>
                            <th>Status</th>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                </div>
                <div class="main__form_overlayform" tabindex="-1" id="addOverlay">
                    <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
                    <h2 class="main__sub-heading">Add Money </h2>
                    <form action="./WalletController" method="post" class="scrollable" id="addMoneyForm">
                        <div class="form-unit form-unit-full">
                            <label for="amount">Amount</label>
                            <input type="number" class="input-with-icon input-with-icon rupee" name="amount"
                                placeholder="Enter amount to add" required />
                        </div>
                        <input type="hidden" name="cmd" value="addMoney">
                        <input type="submit" class="button flat-wide-button" value="Add Money to Wallet">
                    </form>
                </div>
                <div class="main__form_overlayform" tabindex="-1" id="subOverlay">
                    <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
                    <h2 class="main__sub-heading">Request Withdrawal </h2>
                    <form action="./WalletController" method="post" class="scrollable" id="withdrawRequestForm">
                        <div class="form-unit form-unit-full">
                            <label for="amount">Amount</label>
                            <input type="number" class="input-with-icon input-with-icon rupee" name="amount"
                                placeholder="Enter amount to withdraw" required />
                        </div>
                        <input type="hidden" name="cmd" value="withdrawRequest">
                        <input type="submit" class="button flat-wide-button" value="Request Withdrawal">
                    </form>
                </div>
            </div>
        </main>
       </div>
<script type="text/javascript">
	function loadBalance(){
        $.ajax({
            url:"./WalletController?cmd=loadBalance",
            success:function(response){
                if (response.includes("Exception")) {
                    $("<pre>").addClass("overlay-background").css({
                        "display": "block",
                        "background-color": "rgba(0, 0, 0, 0.85)"
                    }).html(response).appendTo("body");
                    $(".overlay-background").click(() => {
                        $(".overlay-background").remove();
                    });
                }else
                    $(".main__wallet__tile_num").html("&#8377; "+response);
            }
        });
    }
    function loadTransactions(){
        $.ajax({
            url:"./WalletController?cmd=loadWalletTransactions",
            success:function(response){
                if(response.length<1)
                    $(".table-wrapper").hide();
                else{
                    $(".table-wrapper").show();
                    $("#transactionsTable tbody").empty();
                    $.each(response,function(i,txn){
                        let sign="";
                        txn.credit ? sign="+" : sign="-";
                        $("<tr>").appendTo($("#transactionsTable tbody"))
                            .append($("<td>").text(i+1))
                            .append($("<td>").text(txn.datetime))
                            .append($("<td>").html(sign+" &#8377; "+txn.amount))
                            .append($("<td>").html("&#8377; "+txn.balance))
                            .append($("<td>").text(txn.comment))
                            .append($("<td>").text(txn.status))
                    });
                }
            }
        });
    }
    function showOverlayForm(divID){
        $("<div>").addClass("overlay-background").css("display", "block").appendTo($("body"));
        $("#"+divID).css("display", "block");
        $("#"+divID).focus();
    }
    function hideOverlayForm() {
        $(".main__form_overlayform").removeAttr("style");
        $(".overlay-background").remove();
    }
    $(document).ready(function(event){
        loadBalance();
        loadTransactions();
        $("#addBtn").click(function(evnt){
            showOverlayForm("addOverlay");
        });
        $("#subBtn").click(function(evnt){
            showOverlayForm("subOverlay");
        });
        $(document).on("submit", "#addMoneyForm", function (event) {
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
                if (response.includes("Added")) {
					$("#snackbar").html(response);
					showToast();
                    loadBalance();
                    loadTransactions();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
            });
        });
        $(document).on("submit", "#withdrawRequestForm", function (event) {
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
                if (response.includes("Requested")) {
					$("#snackbar").html(response);
					showToast();
                    loadBalance();
                    loadTransactions();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
            });
        });
    });
</script>
<%@include file="footer.jsp" %>