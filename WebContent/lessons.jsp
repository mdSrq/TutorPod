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
            <div class="main__form_overlayform main__lesson__overlay " tabindex="-1" id="scheduleOverlay">
                    <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
                    <h2 class="main__sub-heading">Schedule Lesson</h2>
                    <form action="./LessonController" method="post" class="main__lesson__overlay_form">
                        <div class="form-unit-half-container">
                            <div class="form-unit  form-unit-half">
                                <label for="date">Select Date</label>
                                <input type="date" name="date" id="date" class="input-with-icon input-with-icon_no-icon">
                            </div>
                            <div class="form-unit  form-unit-half">
                                <div class="form-unit  form-unit-half">
                                    <label for="time_from">From</label>
                                    <input type="time" name="time_from" readonly id="time_from" class="input-with-icon input-with-icon_no-icon">
                                </div>
                                <div class="form-unit form-unit-half">
                                    <label for="time_to">To</label>
                                    <input type="time" name="time_to" readonly id="time_to" class="input-with-icon input-with-icon_no-icon">
                                </div>
                            </div>
                            <div class="form-unit form-unit-full">
                                <div class="main__lesson__overlay_label">
                                    <label for="">Select Start Time</label>
                                    <div>
                                        <span><span class="dot green_unit"></span> Available</span>
                                        <span><span class="dot red_unit"></span> Booked</span>
                                        <span><span class="dot"></span> Not Available</span>
                                    </div>
                                </div>
                                <div class="main__lesson__overlay_avail scrollable">
                                    <div class="avail_unit green_unit" id="12"><span>12:00</span></div>
                                    <div class="avail_unit red_unit" id="12.5"><span>12:30</span></div>
                                </div>
                                <input type="submit" class="button flat-wide-button" id="scheduleBtn" value="Schedule Lesson">
                            </div>
                        </div>
                    </form>
                </div>
        </main>
       </div>
<script type="text/javascript">
    let lessonsMap = new Map();
    let days_of_week = new Array();
    let availMap = new Map();
    daysObj = {
        1:"Monday",
        2:"Tuesday",
        3:"Wednesday",
        4:"Thrusday",
        5:"Friday",
        6:"Saturday",
        7:"Sunday"
    }

    function loadLessons(selector,booking_id){
        showLoading();
    	let data = "cmd=loadLessons&filter="+selector;
    	if(booking_id!=null)
    		data += "&booking_id="+booking_id;
        $.ajax({
            url:"./LessonController",
            data: data,
            success: function(response){
                hideLoading();
                if(response.length<1){
                    $(".main__dashboard-container").empty().append('<h2 class="main__sub-heading" id="noNotif">No Lessons Found</h2>');
                    return;
                }else{
                    $("#noNotif").hide();
                    $(".main__dashboard-container").empty()
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
                                            .append($("<button>").addClass("scheduleBtn").prop("title","Schedule Lesson").attr("onclick","showScheduleLessonForm("+lesson.lesson_id+")") .append('<img src="./images/clock.png" alt="">'))
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
                            lessonsMap.set(lesson.lesson_id,lesson);
                    });
                }
            }
        });
    }
    function showOverlayForm(overlayID) {
        $("<div>").addClass("overlay-background").css("display", "block").appendTo($("body"));
        $("#"+overlayID).css("display", "block");
        $("#"+overlayID).focus();
    }

    function hideOverlayForm() {
        $(".main__form_overlayform").removeAttr("style");
        $(".overlay-background").remove();
    }
    function showScheduleLessonForm(lesson_id){
        showLoading();
        $.ajax({
            url:"./AvailabilityController",
            data:"cmd=loadWeeklyAvailability",
            success: function(response){    
                hideLoading();
                $.each(response,function(i,av){
                    days_of_week.push(daysObj[av.day_of_week]);
                    availMap.set(av.day_of_week,av);
                });
            }
        });
        showOverlayForm("scheduleOverlay");
    }
    function validateDate(date){
        const day = (new Date(date)).toLocaleDateString('en-US', { weekday: 'long' });
        if(days_of_week.indexOf(day)===-1)
            return false;
        else
            return true;
    }
    $(document).ready(function(event){
    	<%if(request.getParameter("booking_id")!=null){%>
    	loadLessons("All",<%=request.getParameter("booking_id")%>);
        $("#filterSelector").prepend('<option value="default" selected disabled>Booking ID : <%=request.getParameter("booking_id")%> </option>');
    	<%}else{%>
        loadLessons("All",null);
        <%}%>
        $("#filterSelector").change(function(event){
            loadLessons($(this).val(),null);
        });
        var d = new Date();
        var date = d.getFullYear() + "-" + (d.getMonth()+1) + "-" + d.getDate();
        $("#date").prop("min",date);
        $("#date").change(function(event){
            if(!validateDate($(this).val())){
                $(this).val('');
                let alertMsg = "Tutor is not available on this day. Choose a date on following days: ";
                $.each(days_of_week,function(i,day){
                    alertMsg += day+" ";
                });
                alert(alertMsg);
                alertMsg = "Tutor is not available on this day. Choose a date on following days: ";
            }
        });
    });
</script>
<%@include file="footer.jsp"%>