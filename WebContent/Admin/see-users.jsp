<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
	<div class="main__preview main__table">
		<table aria-label="Course Preview">
			<h1 class="main__heading">Users Details</h1>
			<thead>
				<tr>
					<th scope="...">S.No.</th>
					<th scope="...">Photo</th>
					<th scope="...">Personal Details</th>
					<th scope="...">Contact Info</th>
					<th scope="...">User Type</th>
					<th scope="...">Joining Date</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</main>
<script type="text/javascript">
	$("document").ready(() => {
		fetchUserData();
	});
	function fetchUserData() {
		showLoading();
		$.ajax({
			url: "../UserController",
			data: "cmd=loadUsers",
			dataType: "json",
			processData: true,
			success: function (res) {
				hideLoading();
				if (res.length < 1) {
					$("thead").hide();
					$(".main__preview").append(
						"<p style=\"text-align:center\" id=\"NoData\">No Users Found</p>");
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
						tr.append($("<td>").append($("<img>").prop({"src":"/TutorPod_Photos/Users/"+list.photo+".jpg","alt":"user photo"})));
					else
						tr.append($("<td>").append($("<img>").prop({"src":"../images/user.png","alt":"user photo"})));
					tr.append($("<td>").html("Username: "+list.username+"<br>"+
											"Name: "+list.fname+" "+list.lname+"<br>"+
											"Gender: "+list.gender+"<br>"))
					.append($("<td>").html("Email ID: "+list.email_id+"<br>"+
											"Mobile No.: "+list.mobile_no));
					if(list.tutor_id>0)
						tr.append($("<td>").html("Student <br> Tutor"));
					else
						tr.append($("<td>").html("Student"));
					tr.append($("<td>").text(list.joining_date));
				});
				$("td").css("text-align","left");
			}
		});
	}
</script>
<%@include file="footer.jsp" %>