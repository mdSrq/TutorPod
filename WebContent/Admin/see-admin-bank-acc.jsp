<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
	<div class="main__preview">
		<table aria-label="Course Preview">
			<h1 class="main__heading">Admin Bank Accounts Details</h1>
			<thead>
				<tr>
					<th scope="...">S.No.</th>
					<th scope="...">Admin Name</th>
					<th scope="...">Bank Name</th>
					<th scope="...">Account No.</th>
					<th scope="...">Holder Name</th>
					<th scope="...">IFSC Code</th>
					<th scope="...">Balance</th>
					<th scope="...">Transactions</th>
					<th scope="...">Selected</th>
					<th scope="...">Action</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</main>
<script type="text/javascript">
	showLoading();
	fetchBankAccData();
	hideLoading();

	function fetchBankAccData() {
		$.ajax({
			url: "../BankAccountController",
			data: "cmd=seeAdminBankAccounts",
			dataType: "json",
			processData: true,
			success: function (res) {
				if (res.length < 1) {
					$("thead").hide();
					$(".float-right-btn").hide();
					$(".main__preview").append(
						"<p style=\"text-align:center\" id=\"NoData\">No Bank Account Found</p>");
				} else {
					$("thead").show();
					$(".float-right-btn").show();
					$("#NoData").remove();
				}
				$("tbody").empty();
				$.each(res, function (index, list) {
					$("<tr>").appendTo($("tbody"))
						.append($("<td>").text(index + 1))
						.append($("<td>").text(list.name))
						.append($("<td>").text(list.bank_name))
						.append($("<td>").text(list.acc_no))
						.append($("<td>").text(list.holder_name))
						.append($("<td>").text(list.ifsc_code))
						.append($("<td>").text(list.balance))
						.append($("<td>").append($("<a>").attr({
							href: "#",
							onclick: "showTransactions(" + list.bank_acc_id + ")"
						}).text("See Transactions")))
						.append($("<td>").append($("<span>").attr({
							class: "checkmark",
							id: "checkmark_" + list.admin_bank_acc_id,
							onclick: "selectBankAccount(" + list.admin_bank_acc_id + ")"
						})))
						.append($("<td>").addClass("main__preview_action")
							.append($("<a>").attr({
								href: "./EditAdminBankAcc?=" + list.admin_bank_acc_id,
								class: "button small-round-button edit-button",
							}).text("Edit"))
							.append($("<a>").attr({
								href: "#",
								class: "button small-round-button delete-button",
								onclick: "deleteAcc(" + list.admin_bank_acc_id + ")"
							}).text("Delete"))
						);
					if (list.selected)
						$("#checkmark_" + list.admin_bank_acc_id).addClass("checkmark_selected");
				});
			}
		});
	}

	function deleteAcc(admin_bank_acc_id) {
		if (confirm("Are you sure you want to delete this bank account? ")) {
			showLoading();
			$.ajax({
				url: "../BankAccountController",
				data: "cmd=deleteAdminBankAccount&admin_bank_acc_id=" + admin_bank_acc_id,
				success: function (response) {
					hideLoading();
					$("#snackbar").html(response);
					console.log(response);
					showToast();
					fetchBankAccData();
				}
			});
		}
	}

	function selectBankAccount(admin_bank_acc_id) {
		if (confirm("All the payments made by users will now be credited to selected account. Continue?")) {
			showLoading();
			$.ajax({
				url: "../BankAccountController",
				data: "cmd=selectAdminBankAccount&admin_bank_acc_id=" + admin_bank_acc_id,
				success: function (response) {
					hideLoading();
					$("#snackbar").html(response);
					console.log(response);
					showToast();
					if ($(".checkmark_selected") != null)
						$(".checkmark_selected").removeClass("checkmark_selected");
					$("#checkmark_" + admin_bank_acc_id).addClass("checkmark_selected");
				}
			});
		}
	}
</script>
<%@include file="footer.jsp" %>