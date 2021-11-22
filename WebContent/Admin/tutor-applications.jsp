
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
			<h1 class="main__heading">Tutor Applications</h1>
			<thead>
				<tr>
					<th scope="...">S.No.</th>
					<th scope="...">Full Name</th>
					<th scope="...">Contact Info</th>
					<th scope="...">Bio</th>
					<th scope="...">Status</th>
					<th scope="...">Details</th>
					<th scope="...">Action</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
	<div class="main_overlayform" tabindex="-1">
		<a href="#" class="main_overlayform_cross" onclick="hideOverlayForm()">X</a>
		<h2 class="main__sub-heading">Dismiss Application</h2>
		<form action="../TutorController" method="post" class="scrollable" id="dimissForm">
			<div class="form-unit form-unit-full">
				<label for="message">Dimiss Message</label>
				<input type="text" class="input-with-icon input-with-icon_no-icon" name="message"
					placeholder="Enter reasons for dismissing application" id="message" required />
			</div>
			<div class="form-unit form-unit-full">
				<label for="link">Link</label>
				<input type="text" class="input-with-icon input-with-icon_no-icon" name="link" placeholder="Enter link for user to address the issue"
					id="link" required />
			</div>
			<input type="hidden" name="cmd" value="dismissApplication">
			<input type="hidden" name="tutor_id" id="tutor_id">
			<input type="submit" class="button flat-wide-button red-button" value="Dismiss Application">
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
	function dismissTutor(tutor_id){
		showOverlayForm();
		$("#tutor_id").val(tutor_id);
	}
	function loadAppliedTutors(){
		showLoading();
		$.ajax({
            url: "../TutorController",
            data: "cmd=loadAppliedTutors",
            success: function (response) {
                hideLoading();
				if (response.length < 1) {
                    $("thead").hide();
                    $("#NoData").remove();
                    $(".main__preview").append(
                        "<p style=\"text-align:center\" id=\"NoData\">No Applications Found</p>");
                } else {
                    $("thead").show();
                    $("#NoData").remove();
                }
				$("tbody").empty();
                $.each(response,function(i,tutor){
					$("<tr>").appendTo($("#default_table tbody"))
						.append($("<td>").text(i+1))
						.append($("<td>").text(tutor.fname+" "+tutor.lname))
						.append($("<td>").html(tutor.mobile_no+"<br>"+tutor.email_id))
						.append($("<td>").text(tutor.bio))
						.append($("<td>").text(tutor.profile_status))
						.append($("<td>")
							.append($("<a>").text("See Details").prop({
								"href":"#",
								"onlick":"showDetails("+tutor.tutor_id+")"
							})))
						.append($("<td>")
							.append($("<a>").html("&nbsp;&nbsp; &#10004; &nbsp;&nbsp;").prop({
								"href":"#",
								"class":"button small-round-button green-button",
								"title":"Approve"
							}).attr("onclick","approveTutor("+tutor.tutor_id+")"))
							.append($("<a>").html("&nbsp;&nbsp; &#10006; &nbsp;&nbsp;").prop({
								"href":"#",
								"class":"button small-round-button delete-button",
								"title":"Dimiss"
							}).attr("onclick","dismissTutor("+tutor.tutor_id+")")))
				});
            }
        });
	}
	function approveTutor(tutor_id){
		$.post("../TutorController","cmd=approveApplication&tutor_id="+tutor_id,function(response){
			if(response.includes("Approved")){
				loadTutorApplied();
				loadAppliedTutors();
				$("#snackbar").html(response);
				showToast();
			}else{
				$("#snackbar").html(response);
				showToast();
				console.log(response);
			}
		});
	}
	$(document).ready(()=>{
		loadAppliedTutors();
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
				   loadTutorApplied();
				   loadAppliedTutors();
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