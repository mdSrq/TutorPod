<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
	<div class="main__preview main__table">
		<table aria-label="Course Preview">
			<h1 class="main__heading">Orders Details</h1>
			<thead>
				<tr>
					<th scope="...">S.No.</th>
					<th scope="...">Boooking ID</th>
					<th scope="...">Student</th>
					<th scope="...">Tutor</th>
					<th scope="...">Details</th>
					<th scope="...">Total Amount</th>
					<th scope="...">Status</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</main>

<script type="text/javascript">
	$("document").ready(() => {
		fetchTutorsData();
	});
	function fetchTutorsData() {
		showLoading();
		$.ajax({
			url: "../BookingController",
			data: "cmd=loadAllBookingDetails",
			dataType: "json",
			processData: true,
			success: function (res) {
				hideLoading();
				if (res.length < 1) {
					$("thead").hide();
					$(".main__preview").append(
						"<p style=\"text-align:center\" id=\"NoData\">No Orders Found</p>");
				} else {
					$("thead").show();
					$("#NoData").remove();
				}
				$("tbody").empty();
				$("th").css("text-align","left");
				$.each(res, function (index, list) {
					let tr = $("<tr>").appendTo($("tbody"))
						.append($("<td>").text(index + 1).css("padding-left","2rem"))
						.append($("<td>").text(list.booking.booking_id))
						.append($("<td>").text(list.user.fname+" "+list.user.lname))
						.append($("<td>").text(list.tutorUser.fname+" "+list.tutorUser.lname))
						.append($("<td>").html("Subject: "+list.subject.subject_name+
											 "<br>Duration: "+list.booking.duration+
											 " Hr <br>No. of Lessons: "+list.booking.no_of_lesson))
						.append($("<td>").html("&#8377; " +list.totalForUser))
						.append($("<td>").text(list.booking.booking_status));
				});
				$("td").css("text-align","left");
			}
		});
	}
</script>
<%@include file="footer.jsp" %>