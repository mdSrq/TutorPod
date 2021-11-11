<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
	<div class="main__preview main__table">
		<table aria-label="Course Preview">
			<h1 class="main__heading">Subjects Details</h1>
			<thead>
				<tr>
					<th scope="...">S.No.</th>
					<th scope="...">Course Name</th>
					<th scope="...">Year/Sem</th>
					<th scope="...">Subject Name</th>
					<th scope="...">Subject Code</th>
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
		fetchSubjectData();
		hideLoading();
	});

	function fetchSubjectData() {
		$.ajax({
			url: "../SubjectController",
			data: "cmd=seeSubjects",
			dataType: "json",
			processData: true,
			success: function (res) {
				if (res.length < 1) {
					$("thead").hide();
					$(".main__preview").append(
						"<p style=\"text-align:center\" id=\"NoData\">No Subjects Found</p>");
				} else {
					$("thead").show();
					$("#NoData").remove();
				}
				$("tbody").empty();
				var data = ""
				$.each(res, function (index, list) {
					$("<tr>").appendTo($("tbody"))
						.append($("<td>").text(index + 1))
						.append($("<td>").text(list.course_name))
						.append($("<td>").text(list.duration_no))
						.append($("<td>").text(list.subject_name))
						.append($("<td>").text(list.subject_code))
						.append($("<td>").addClass("main__preview_action")
							.append($("<a>").attr({
								href: "./EditSubject?course_sub_id=" + list.course_sub_id,
								class: "button small-round-button edit-button",
							}).text("Edit"))
							.append($("<a>").attr({
								href: "#",
								class: "button small-round-button delete-button",
								onclick: "deleteSubject(" + list.course_sub_id + "," + list
									.subject_id + ")"
							}).text("Delete"))
						);
				});
			}
		});
	}

	function deleteSubject(course_sub_id, subject_id) {
		if (confirm("Are you sure you want to delete this course? ")) {
			showLoading();
			$.ajax({
				url: "../SubjectController",
				data: "cmd=deleteSubject&course_sub_id=" + course_sub_id + "&subject_id=" + subject_id,
				success: function (response) {
					hideLoading();
					$("#snackbar").html(response);
					showToast();
					fetchSubjectData();
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