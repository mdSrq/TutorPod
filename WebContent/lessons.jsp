<%if(session.getAttribute("USER")==null){ response.sendRedirect("./");return;}%>
<%
	User currentUser = (User)session.getAttribute("USER");
	String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
%>
<%@include file="header.jsp" %>
 <div class="flex-container">
 <%@include file="sidebar.jsp" %>
	<main class="main">
            <h1 class="main__heading">Lessons</h1>
            <select name="filterSelector" id="filterSelector" class="float-right float-equally">
                <option value="All" selected>All</option>
                <option value="Completed">Completed</option>
                <option value="Scheduled">Scheduled</option>
                <option value="Unscheduled">Unscheduled</option>
                <option value="Cancelled">Cancelled</option>
            </select>
            <%if(dashboardType.equals("USER")){
		    if(session.getAttribute("TUTOR")!=null){ %>
			<a href="./UserController?cmd=switchToTutor&page=Lessons" class="button float-right-btn float-equally">Switch to Tutor &gt;&gt;</a>
		    <%}}else{%>
			<a href="./UserController?cmd=switchToUser&page=Lessons" class="button float-right-btn float-equally">Switch to User &gt;&gt;</a>
		    <%}%>            
            <div class="main__dashboard-container">
                <div class="main__tile main__lesson_tile">
                    <div class="main__lesson_schedule">
                        <div class="main__lesson_schedule_time">
                            06:00 PM to 7:00 PM
                        </div>
                        <div class="main__lesson_schedule_date">
                            Saturday, December 18, 2021
                        </div>
                        <div class="main__lesson_schedule_timer">
                            20Hr 5min 3s
                        </div>
                    </div>
                    <div class="main__lesson_info">
                        <span class="main__lesson_info_text">BCS-011 - Computer Basics and PC Software</span>
                        <span class="main__lesson_info_tag">Length: 1 Hr</span>
                        <span class="main__lesson_info_tag">Unscheduled</span>
                    </div>
                    <div class="main__lesson_profile">
                        <div class="main__lesson_profile_img">
                            <img src="./images/user.png" alt="User Photo">
                        </div>
                        <div class="main__lesson_profile_info">
                            <div class="main__lesson_profile_name">
                                <span>Mohd Shariq</span>
                            </div>
                            <div class="main__lesson_profile_buttons">
                                <button class="joinBtn" title="Join Meeting"><img src="./images/enter.png" alt=""></button>
                                <button class="cancelBtn" title="Cancel Lesson"><img src="./images/cancel.png" alt=""></button>
                                <button class="scheduleBtn" title="Schedule Lesson"><img src="./images/clock.png" alt=""></button>
                                <button class="linkBtn" title="Add Meeting Link"><img src="./images/link.png" alt=""></button>
                            </div>
                        </div>
                    </div>
                </div>
                <h2 class="main__sub-heading" id="noNotif">No Orders</h2>
            </div>
        </main>
       </div>
<script type="text/javascript">
    function loadLessons(){
        $.ajax({
            url:"./LessonController",
            data:"cmd=loadLessons",
            success: function(response){
                if(response.length<1){
                    $(".main__dashboard-container").empty();
                    $("#noNotif").show();
                    return;
                }else{
                    $("#noNotif").hide();
                    $.each(response,function(i,lesson){
                        const tile = $("<div>").addClass("main__tile main__lesson_tile").appendTo($(".main__dashboard-container"))
                            .append($("<div>").addClass("main__lesson_schedule")
                                .append($("<div>").addClass("main__lesson_schedule_time"))
                                .append($("<div>").addClass("main__lesson_schedule_date"))
                                .append($("<div>").addClass("main__lesson_schedule_timer")))
                            .append($("<div>").addClass("main__lesson_info")
                                .append($("<span>").addClass("main__lesson_info_text").text(lesson.subject.subject_name))
                                .append($("<span>").addClass("main__lesson_info_tag").text(lesson.duration))
                                .append($("<span>").addClass("main__lesson_info_tag").text(lesson.status)))
                            .append($("<div>").addClass("main__lesson_profile")
                                .append($("<div>").addClass("main__lesson_profile_img").append($("<img>")))
                                .append($("<div>").addClass("main__lesson_profile_info")
                                    .append($("<div>").addClass("main__lesson_profile_name"))
                                    .append($("<div>").addClass("main__lesson_profile_buttons")
                                        .append($("<button>").addClass("joinBtn").prop("title","Join Meeting").append('<img src="./images/enter.png" alt="">'))
                                            .append($("<button>").addClass("cancelBtn").prop("title","Cancel Lesson").append('<img src="./images/cancel.png" alt="">'))
                                            .append($("<button>").addClass("scheduleBtn").prop("title","Schedule Lesson").append('<img src="./images/clock.png" alt="">'))
                                            .append($("<button>").addClass("linkBtn").prop("title","Add Meeting Link").append('<img src="./images/link.png" alt="">'))
                                    )
                                )
                            );
                    });
                }
            }
        });
    }
    $(document).ready(function(event){
        loadLessons();
    });
</script>
<%@include file="footer.jsp"%>