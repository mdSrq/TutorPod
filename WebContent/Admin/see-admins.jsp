<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
	<div class="main__preview main__table">
		<table aria-label="Course Preview">
			<h1 class="main__heading">Admins Details</h1>
			<thead>
				<tr>
					<th scope="...">S.No.</th>
					<th scope="...">Admin Name</th>
					<th scope="...">Action</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</main>
<div id="snackbar"></div>
<script src="../app/js/jquery-3.6.0.min.js"></script>
<script src="../app/js/admin-script.js"></script>
<script type="text/javascript">
	$("document").ready(() => {
		showLoading();
		fetchAdminData();
		hideLoading();
	});

	function fetchAdminData() {
		$.ajax({
			url: "../AdminController",
			data: "cmd=seeAdmins",
			dataType: "json",
			processData: true,
			success: function (res) {
				$("tbody").empty();
				$.each(res, function (index, list) {
					$("<tr>").appendTo($("tbody"))
						.append($("<td>").text(index + 1))
						.append($("<td>").text(list.name))
						.append($("<td>").addClass("main__preview_action")
							.append($("<a>").attr({
								href: "./EditAdmin?admin_id=" + list.admin_id,
								class: "button small-round-button edit-button",
							}).text("Edit"))
							.append($("<a>").attr({
								href: "#",
								class: "button small-round-button delete-button",
								onclick: "deleteAdmin(" + list.admin_id + ")"
							}).text("Delete"))
						);
				});
				if (res.length < 2)
					$(".delete-button").remove();
			}
		});
	}

	function deleteAdmin(admin_id) {
		if (confirm("Are you sure you want to delete this course? ")) {
			$.ajax({
				url: "../AdminController",
				data: "cmd=deleteAdmin&admin_id=" + admin_id,
				success: function (response) {
					$("#snackbar").html(response);
					showToast();
					fetchAdminData();
				}
			});
		}
	}
	$(document).ajaxError(function (event, jqxhr, settings, thrownError) {
		$("#snackbar").html("Some error occured see the log");
		console.log(thrownError + "\n" + jqxhr.responseText);
		showToast();
	});
</script>
<%@include file="footer.jsp" %>