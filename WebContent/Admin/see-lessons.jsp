<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
	<div class="main__preview main__table">
		<table aria-label="Course Preview">
			<h1 class="main__heading">Lessons Details</h1>
			<thead>
				<tr>
					<th scope="...">S.No.</th>
					<th scope="...">Lesson ID</th>
					<th scope="...">Student</th>
					<th scope="...">Tutor</th>
					<th scope="...">Details</th>
					<th scope="...">Status</th>
					<th scope="...">Schedule</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</main>

<script type="text/javascript">
	$("document").ready(() => {
		loadLessons();
	});
	function loadLessons() {
		showLoading();
		$.ajax({
			url: "../LessonController",
			data: "cmd=loadAllLessons&filter=<%=request.getParameter("filter")%>",
			dataType: "json",
			processData: true,
			success: function (res) {
				hideLoading();
				if (res.length < 1) {
					$("thead").hide();
					$(".main__preview").append(
						"<p style=\"text-align:center\" id=\"NoData\">No Lessons Found</p>");
				} else {
					$("thead").show();
					$("#NoData").remove();
				}
				$("tbody").empty();
				$("th").css("text-align","left");
				$.each(res, function (index, lesson) {
					let tr = $("<tr>").appendTo($("tbody"))
						.append($("<td>").text(index + 1).css("padding-left","2rem"))
						.append($("<td>").text(lesson.lesson_id))
						.append($("<td>").text(lesson.user.fname+" "+lesson.user.lname))
						.append($("<td>").text(lesson.tutorUser.fname+" "+lesson.tutorUser.lname))
						.append($("<td>").html("Subject: "+lesson.subject.subject_name+
											 "<br>Duration: "+lesson.duration+" Hr"))
						.append($("<td>").text(lesson.status));
                    if(lesson.date!=null)
					    tr.append($("<td>").html("Date: "+lesson.date+"<br>"+
                                                "Time: "+lesson.time_from+" - "+lesson.time_to));
                    else
                        tr.append($("<td>").text("NA"));
				});
				$("td").css("text-align","left");
			}
		});
	}
</script>
<%@include file="footer.jsp" %>