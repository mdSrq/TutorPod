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
            </div>
        </main>
       </div>
<script type="text/javascript">
    function loadLessons(selector){
        $.ajax({
            url:"./LessonController",
            data:"cmd=loadLessons&filter="+selector,
            success: function(response){
                if(response.length<1){
                    $(".main__dashboard-container").empty().append('<h2 class="main__sub-heading" id="noNotif">No Lessons Found</h2>');
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
                                .append($("<span>").addClass("main__lesson_info_tag").text("Length: "+lesson.duration+" Hr"))
                                .append($("<span>").addClass("main__lesson_info_tag").text(lesson.status)))
                            .append($("<div>").addClass("main__lesson_profile")
                                .append($("<div>").addClass("main__lesson_profile_img"))
                                .append($("<div>").addClass("main__lesson_profile_info")
                                    .append($("<div>").addClass("main__lesson_profile_name"))
                                    .append($("<div>").addClass("main__lesson_profile_buttons")
                                        .append($("<button>").addClass("joinBtn").prop("title","Join Meeting").append('<img src="./images/enter.png" alt="">'))
                                            .append($("<button>").addClass("cancelBtn").prop("title","Cancel Lesson").append('<img src="./images/cancel.png" alt="">'))
                                            .append($("<button>").addClass("scheduleBtn").prop("title","Schedule Lesson").append('<img src="./images/clock.png" alt="">'))
                                    )
                                )
                            );
                            <%if(dashboardType.equals("TUTOR")){%>
                            if(lesson.user.photo===undefined)
                            	tile.children(".main__lesson_profile").children(".main__lesson_profile_img").append('<img src="./images/user.png" alt="Tutor Photo">');
                            else
                            	tile.children(".main__lesson_profile").children(".main__lesson_profile_img").append('<img src="/TutorPod_Photos/Users/"'+lesson.user.photo+' alt='+lesson.user.fname+" "+lesson.user.lname+"'s Photo>");
                            tile.children(".main__lesson_profile").children(".main__lesson_profile_info").children(".main__lesson_profile_name").append("<span>"+lesson.user.fname+" "+lesson.user.lname+"</span>");
                            tile.children(".main__lesson_profile").children(".main__lesson_profile_info").children(".main__lesson_profile_buttons").append('<button class="linkBtn" title="Add Meeting Link"><img src="./images/link.png" alt=""></button>');
                            <%}else{%>
                            if(lesson.tutorUser.photo===undefined)
                            	tile.children(".main__lesson_profile").children(".main__lesson_profile_img").append('<img src="./images/user.png" alt="Student Photo">');
                            else
                            	tile.children(".main__lesson_profile").children(".main__lesson_profile_img").append('<img src="/TutorPod_Photos/Users/"'+lesson.tutorUser.photo+' alt='+lesson.tutorUser.fname+" "+lesson.tutorUser.lname+"'s Photo>");
                            tile.children(".main__lesson_profile").children(".main__lesson_profile_info").children(".main__lesson_profile_name").append("<span>"+lesson.tutorUser.fname+" "+lesson.tutorUser.lname+"</span>");
                            <%}%>
                    });
                }
            }
        });
    }
    $(document).ready(function(event){
        loadLessons("All");
        $("#filterSelector").change(function(event){
            loadLessons($(this).val());
        });
    });
</script>
<%@include file="footer.jsp"%>