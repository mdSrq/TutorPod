
<%
if (session.getAttribute("USER") == null) {
	response.sendRedirect("./");
	return;
}
%>
<%@include file="header.jsp"%>
<%
	User currentUser = (User)session.getAttribute("USER");
	String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
%>
<div class="flex-container">
	<%@include file="sidebar.jsp"%>
	<main class="main">
		<h1 class="main__heading">Notifications</h1>
		<%if(dashboardType.equals("USER")){
		  if(session.getAttribute("TUTOR")!=null){ %>
			<a href="./UserController?cmd=switchToTutor&page=Notifications" class="button float-right-btn float-equally">Switch to Tutor &gt;&gt;</a>
		<%}}else{%>
			<a href="./UserController?cmd=switchToUser&page=Notifications" class="button float-right-btn float-equally">Switch to User &gt;&gt;</a>
		<%}%>
		<form action="./NotificationController" class="main__notifications-container" method="post" id="notificationForm">
			<div class="main__notification_header">
				<div class="main__notification_left">
					<label class="check-container">
						<input type="checkbox" name="selectAll" value="selectAll" id="selectAll">
						<span class="check"></span>
					</label>
				</div>
				<div class="main__notification_middle">
					<input type="hidden" name="cmd" value="deleteNotifications">
					<a href="#" class="delete-button_with-img" id="deleteBtn" title="Delete Selected"><img src="./images/bin.png" alt=""></a>
					<a href="#" class="delete-button_with-img" id="reloadBtn" title="Refresh"><img src="./images/refresh.png" alt=""></a>
				</div>
			</div>
			<h2 class="main__sub-heading" id="noNotif">No Notifications</h2>
		</form>
	</main>
</div>
<script>
	function loadAllNotifications() {
		showLoading();
		$.ajax({
			url: "./NotificationController",
			data: "cmd=seeAllNotifications",
			success: function (response) {
				hideLoading();
				if (response.length < 1) {
					$("#noNotif").show();
					$(".main__notification_header").hide();
					$(".main__notification").remove();
				}else{
					$("#noNotif").hide();	
					$(".main__notification").remove();
					$.each(response,function(i,notif){
						$("<div>").addClass("main__notification").appendTo(".main__notifications-container")
							.append($("<div>").addClass("main__notification_left")
								.append($("<label>").addClass("check-container")
									.append($('<input>').prop({
										"type" : "checkbox",
										"name" : "notification_ids",
										"value" : notif.notification_id,
										"class" : "notif_check"
									}))
									.append($("<span>").addClass("check"))))
							.append($("<div>").addClass("main__notification_middle")
								.append($("<a>").prop("href",notif.link).text(notif.notification)))
							.append($("<div>").addClass("main__notification_right")
								.append($("<span>").text(notif.datetime)));
					});
				}
			}
		});
	}
	$(document).ready(()=>{
		loadAllNotifications();
		$("#deleteBtn").click(function (event) {
			event.preventDefault();
			var $form = $("#notificationForm");
			showLoading();
			$.post($form.prop("action"),$form.serialize(),function(response){
				hideLoading();
				if (response.includes("Exception")) {
                        $("<pre>").addClass("overlay-background").css({
                            "display": "block",
                            "background-color": "rgba(0, 0, 0, 0.85)"
                        }).html(response).appendTo("body");
                        $(".overlay-background").click(() => {
                            $(".overlay-background").remove();
                        });
                    }
				if(response.includes("Deleted")){
					loadAllNotifications();
					$("#snackbar").html(response);
					showToast();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
			});
		})
		$("#selectAll").click(function(event){
			if($(this).prop("checked")){
				$(".notif_check").prop("checked",true);
			}else{
				$(".notif_check").prop("checked",false);
			}
		});
		$("#reloadBtn").click(function(event){
			event.preventDefault();
			loadAllNotifications();
			$("#snackbar").html("Refreshed");
			showToast();
		});
	});
</script>
<%@include file="footer.jsp"%>