<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
	<div class="main__preview main__table">
		<table aria-label="Course Preview">
			<h1 class="main__heading">Tutors Details</h1>
			<thead>
				<tr>
					<th scope="...">S.No.</th>
					<th scope="...">Photo</th>
					<th scope="...">Personal Details</th>
					<th scope="...">Contact Info</th>
					<th scope="...">Status</th>
					<th scope="...">Approval Date</th>
					<th scope="...">Profile</th>
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
			url: "../TutorController",
			data: "cmd=loadBasicTutorInfo",
			dataType: "json",
			processData: true,
			success: function (res) {
				hideLoading();
				if (res.length < 1) {
					$("thead").hide();
					$(".main__preview").append(
						"<p style=\"text-align:center\" id=\"NoData\">No Tutors Found</p>");
				} else {
					$("thead").show();
					$("#NoData").remove();
				}
				$("tbody").empty();
				$("th").css("text-align","left");
				$.each(res, function (index, list) {
					let tr = $("<tr>").appendTo($("tbody"));
					tr.append($("<td>").text(index + 1).css("padding-left","2rem"));
					if(list.photo!=null)
						tr.append($("<td>").append($("<img>").prop({"src":"/TutorPod_Photos/Users"+list.photo,"alt":"user photo"})));
					else
						tr.append($("<td>").append($("<img>").prop({"src":"../images/user.png","alt":"user photo"})));
					tr.append($("<td>").html("Username: "+list.username+"<br>"+
											"Name: "+list.fname+" "+list.lname+"<br>"+
											"Gender: "+list.gender+"<br>"+
											"Bio: "+list.bio))
					.append($("<td>").html("Email ID: "+list.email_id+"<br>"+
											"Mobile No.: "+list.mobile_no));
					let status;
					switch(list.profile_status){
						case"NewApply": status="Incomplete Application";break;
						case"Applied": status="Approval Awaited";break;
						case"Tutor": status="Approved Tutor";break;
					}
					tr.append($("<td>").text(status));
					if(list.approval_date!=null)
						tr.append($("<td>").text(list.approval_date));
					else
						tr.append($("<td>").text("NA"));
					tr.append($("<td>").append($("<a>").prop("href","../TutorProfile?tutor_id="+list.tutor_id).css("cursor","pointer").text("View Profile")));
				});
				$("td").css("text-align","left");
			}
		});
	}
</script>
<%@include file="footer.jsp" %>