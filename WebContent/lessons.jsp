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
                <option value="Need Re-Scheduling">Need Re-Scheduling</option>
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
            <div class="main__form_overlayform" tabindex="-1" id="addLink">
                <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
                <h2 class="main__sub-heading">Add Meeting Link </h2>
                <form action="./LessonController" method="post" style="width: 100%;" class="scrollable"
                    id="addLinkForm">
                    <div class="form-unit form-unit-full">
                        <label for="amount">Link</label>
                        <input type="text" class="input-with-icon input-with-icon_no-icon" name="meeting_link"
                            placeholder="Enter link to the meeting" required />
                    </div>
                    <input type="hidden" name="cmd" value="addMeetingLink" required>
                    <input type="hidden" name="lesson_id" id="addLinkLessonID" required>
                    <input type="submit" class="button flat-wide-button" value="Add Meeting Link">
                </form>
            </div>
            <div class="main__form_overlayform" tabindex="-1" id="reSchedule">
                <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
                <h2 class="main__sub-heading">Re-Schedule Request </h2>
                <form action="./LessonController" method="post" style="width: 100%;" class="scrollable"
                    id="reScheduleForm">
                    <div class="form-unit form-unit-full">
                        <label for="message">Write Message</label>
                        <textarea name="message" id="message" class="input-with-icon input-with-icon_no-icon" placeholder="Write a message to learner." required></textarea>
                    </div>
                    <input type="hidden" name="cmd" value="requestSchedule">
                    <input type="hidden" name="lesson_id" id="reScheduleLessonID">
                    <input type="submit" class="button flat-wide-button" value="Send Re-Schedule Request">
                </form>
            </div>
            <div class="main__form_overlayform" tabindex="-1" id="cancelLesson">
                <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
                <h2 class="main__sub-heading">Cancel Lesson </h2>
                <form action="./LessonController" method="post" style="width: 100%;" class="scrollable"
                    id="cancelLessonForm">
                    <div class="form-unit form-unit-full">
                        <label for="message">Cancelation Reason</label>
                        <textarea name="message"class="input-with-icon input-with-icon_no-icon"
                            placeholder="Write the reason for cancelation." required></textarea>
                    </div>
                    <input type="hidden" name="cmd" value="cancelLesson">
                    <input type="hidden" name="lesson_id" id="cancelLessonID">
                    <input type="submit" class="button flat-wide-button" value="Cancel Lesson">
                </form>
            </div>
            <div class="main__form_overlayform" tabindex="-1" id="markCompleted">
                <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
                <h2 class="main__sub-heading">Lesson Completed </h2>
                <form action="./LessonController" method="post" style="width: 100%;" class="scrollable"
                    id="markCompletedForm">
                    <div class="form-unit form-unit-full">
                        <label for="message">Feedback for tutor (Optional)</label>
                        <textarea name="message" class="input-with-icon input-with-icon_no-icon"
                            placeholder="Write a feedback for the tutor."></textarea>
                    </div>
                    <input type="hidden" name="cmd" value="markLessonCompleted">
                    <input type="hidden" name="lesson_id" id="markCompletedLessonID">
                    <input type="submit" class="button flat-wide-button" value="Mark as Completed">
                </form>
            </div>
            <div class="main__form_overlayform" tabindex="-1" id="reportIssue">
                <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
                <h2 class="main__sub-heading">Report An Issue </h2>
                <form action="./LessonController" method="post" style="width: 100%;" class="scrollable"
                    id="reportIssueForm">
                    <div class="form-unit form-unit-full">
                        <label for="message">Issue Faced</label>
                        <textarea name="message" class="input-with-icon input-with-icon_no-icon" required
                            placeholder="Write the issue that you have faced."></textarea>
                    </div>
                    <input type="hidden" name="cmd" value="reportIssue">
                    <input type="hidden" name="lesson_id" id="reportIssueLessonID">
                    <input type="submit" class="button flat-wide-button" value="Report Issue">
                </form>
            </div>
            <div class="main__form_overlayform main__lesson__overlay " tabindex="-1" id="scheduleOverlay">
                    <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
                    <h2 class="main__sub-heading">Schedule Lesson</h2>
                    <form action="./LessonController" method="post" class="main__lesson__overlay_form" id="scheduleForm">
                        <div class="form-unit-half-container">
                            <div class="form-unit  form-unit-half">
                                <label for="date">Select Date</label>
                                <input type="date" name="date" id="date" class="input-with-icon input-with-icon_no-icon" required>
                            </div>
                            <div class="form-unit  form-unit-half">
                                <div class="form-unit  form-unit-half">
                                    <label for="time_from">From</label>
                                    <input type="time" name="time_from" readonly id="time_from" class="input-with-icon input-with-icon_no-icon" required>
                                </div>
                                <div class="form-unit form-unit-half">
                                    <label for="time_to">To</label>
                                    <input type="time" name="time_to" readonly id="time_to" class="input-with-icon input-with-icon_no-icon" required>
                                </div>
                            </div>
                            <div class="form-unit form-unit-full" id="scheduleDiv">
                                <div class="main__lesson__overlay_label">
                                    <label for="">Select Start Time</label>
                                    <div>
                                        <span><span class="dot green_unit"></span> Available</span>
                                        <span><span class="dot red_unit"></span> Booked</span>
                                        <span><span class="dot"></span> Not Available</span>
                                    </div>
                                </div>
                                <div class="main__lesson__overlay_avail scrollable">
                                    
                                </div>
                            </div>
                            <input type="hidden" name="lesson_id" id="lesson_id">
                            <input type="hidden" name="cmd" value="scheduleLesson">
                            <input type="submit" class="button flat-wide-button" id="scheduleBtn" value="Schedule Lesson">
                        </div>
                    </form>
                </div>
        </main>
       </div>
<script type="text/javascript">
    let lessonsMap = new Map();
    let days_of_week = new Array();
    let availMap = new Map();
    let scheduleMap = new Map();
    daysObj = {
        1:"Monday",
        2:"Tuesday",
        3:"Wednesday",
        4:"Thursday",
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
                                .append($("<span>").addClass("main__lesson_info_tag").text("ID: "+lesson.lesson_id))
                                .append($("<span>").addClass("main__lesson_info_tag").text("Length: "+lesson.duration+" Hr"))
                                .append($("<span>").addClass("main__lesson_info_tag status_tag").text(lesson.status)))
                            .append($("<div>").addClass("main__lesson_profile")
                                .append($("<div>").addClass("main__lesson_profile_img"))
                                .append($("<div>").addClass("main__lesson_profile_info")
                                    .append($("<div>").addClass("main__lesson_profile_name"))
                                    .append($("<div>").addClass("main__lesson_profile_buttons")))
                            );
                            let ongoing =false;
                            let timePassed = false;
                            if(lesson.status==="Scheduled"||lesson.status==="Completed"){
                                let dateParts = lesson.date.split('-');
                                let timeParts1 = lesson.time_from.split(':');
                                let timeParts2 = lesson.time_to.split(':');
                                const datetime1 = new Date(dateParts[0], dateParts[1]-1,dateParts[2],timeParts1[0],timeParts1[1],timeParts1[2]);
                                let time_from = (parseInt(timeParts1[0])*1000*60*60)+(parseInt(timeParts1[1])*1000*60);
                                let time_to = (parseInt(timeParts2[0])*1000*60*60)+(parseInt(timeParts2[1])*1000*60);
                                tile.find(".main__lesson_schedule_time").text(tConvert(time_from,12)+" to "+tConvert(time_to,12));
                                tile.find(".main__lesson_schedule_date").text(datetime1.toDateString());
                                if(lesson.status==="Scheduled"){
                                const lessonTime = (lesson.duration)*1000*60*60;
                                let datetime2 = new Date();
                                let diff = datetime1 - datetime2;
                                if(diff<=0)
                                    ongoing=true;
                                diff = (datetime1-datetime2) + lessonTime;
                                if(diff<=0)
                                    timePassed=true;
                                const interval = setInterval(() => {
                                    datetime2 = new Date();
                                    diff = datetime1 - datetime2;
                                    if(diff<=0){
                                        ongoing=true;
                                        tile.find(".main__lesson_schedule_timer").text("Lesson Ongoing");
                                        diff = (datetime1-datetime2) + lessonTime;
                                        if(diff<=0){
                                            tile.find(".main__lesson_schedule_timer").text("Lesson Time Has Passed");
                                            timePassed=true;
                                            tile.find(".main__lesson_profile_buttons").empty();
                                            tile.find(".main__lesson_profile_buttons")
                                                .append($("<button>").addClass("tickBtn").prop("title","Mark As Completed").attr("onclick","showMarkAsCompletedForm("+lesson.lesson_id+")")
                                                .append('<img src="./images/check.png" alt="">'));
                                            tile.find(".main__lesson_profile_buttons")
                                                .append($("<button>").addClass("issueBtn").prop("title","Report Issue").attr("onclick","showReportIssueForm("+lesson.lesson_id+")")
                                                .append('<img src="./images/exclamation.png" alt="">'));
                                            clearInterval(interval);
                                        }
                                    }else{
                                        const secs = Math.floor(diff/1000);
                                        const sec = Math.floor(secs%60);
                                        const mins = Math.floor(secs/60);
                                        const min = Math.floor(mins%60);
                                        const hours = Math.floor(mins/60);
                                        const hour = Math.floor(hours%60);
                                        if(hours>24){
                                            const days = Math.floor(hours/24);
                                            tile.find(".main__lesson_schedule_timer").text(days+" Days "+hour+"Hr left");
                                        }else
                                            tile.find(".main__lesson_schedule_timer").text(hour+"Hr "+min+"min "+sec+"sec left");
                                    }
                                }, 1000);
                                }
                            }
                            <%if(dashboardType.equals("TUTOR")){%>
                            if(lesson.user.photo===undefined)
                            	tile.find(".main__lesson_profile_img")
                                    .append('<img src="./images/user.png" alt="Student Photo">');
                            else
                            	tile.find(".main__lesson_profile_img")
                                    .append('<img src="/TutorPod_Photos/Users/'+lesson.user.photo+'.jpg" alt='+lesson.user.fname+" "+lesson.user.lname+"'s Photo>");
                            tile.find(".main__lesson_profile_name")
                                .append("<span>"+lesson.user.fname+" "+lesson.user.lname+"</span>");
                            if(!timePassed && lesson.status!=="Cancelled" && lesson.status!=="Completed")
                            tile.find(".main__lesson_profile_buttons")
                                .append($("<button>").addClass("linkBtn").prop("title","Add Meeing Link")
                                .attr("onclick","showAddLinkForm("+lesson.lesson_id+")")
                                .append('<img src="./images/link.png" alt="">'));
                            if(!ongoing)
                            if(lesson.status==="Scheduled")
                                tile.find(".main__lesson_profile_buttons")
                                    .append($("<button>").addClass("scheduleBtn").prop("title","Re-Schedule")
                                    .attr("onclick","showReScheduleForm("+lesson.lesson_id+")") 
                                    .append('<img src="./images/clock.png" alt="">'));
                            if(lesson.meeting_link!==undefined ){
                                if(lesson.meeting_link.search("meet.google")>-1)
                                    tile.find(".main__lesson_info").append($("<span>").addClass("main__lesson_info_tag").text("On: Google Meet"));
                                if(lesson.meeting_link.search("zoom")>-1)
                                    tile.find(".main__lesson_info").append($("<span>").addClass("main__lesson_info_tag").text("On: Zoom"));
                            }
                            <%}else{%>
                            if(lesson.tutorUser.photo===undefined)
                            	tile.find(".main__lesson_profile_img")
                                    .append('<img src="./images/user.png" alt="Tutor Photo">');
                            else
                            	tile.find(".main__lesson_profile_img")
                                    .append('<img src="/TutorPod_Photos/Users/'+lesson.tutorUser.photo+'.jpg" alt='+lesson.tutorUser.fname+" "+lesson.tutorUser.lname+"'s Photo>");
                            tile.find(".main__lesson_profile_name")
                                .append("<span>"+lesson.tutorUser.fname+" "+lesson.tutorUser.lname+"</span>");
                            if(!ongoing)
                            if(lesson.status==="Unscheduled"||lesson.status==="Need Re-Scheduling"||lesson.status==="Scheduled"){
                                const title = lesson.status==="Unscheduled"?"Schedule Lesson":"Re-Schedule Lesson"
                                tile.find(".main__lesson_profile_buttons")
                                    .append($("<button>").addClass("scheduleBtn").prop("title",title)
                                    .attr("onclick","showScheduleLessonForm("+lesson.tutor_id+","+lesson.lesson_id+")") 
                                    .append('<img src="./images/clock.png" alt="">'));
                            }
                            if(timePassed){
                                tile.find(".main__lesson_profile_buttons")
                                    .append($("<button>").addClass("tickBtn").prop("title","Mark As Completed").attr("onclick","showMarkAsCompletedForm("+lesson.lesson_id+")")
                                    .append('<img src="./images/check.png" alt="">'));
                                tile.find(".main__lesson_profile_buttons")
                                    .append($("<button>").addClass("issueBtn").prop("title","Report Issue").attr("onclick","showReportIssueForm("+lesson.lesson_id+")")
                                    .append('<img src="./images/exclamation.png" alt="">'));
                            }
                            if(lesson.meeting_link!==undefined && !timePassed && ongoing){
                                if(lesson.meeting_link.search("meet.google")>-1)
                                    tile.find(".main__lesson_info").append($("<span>").addClass("main__lesson_info_tag").text("On: Google Meet"));
                                if(lesson.meeting_link.search("zoom")>-1)
                                    tile.find(".main__lesson_info").append($("<span>").addClass("main__lesson_info_tag").text("On: Zoom"));
                            }
                            <%}%>
                            if(lesson.meeting_link!==undefined && !timePassed && ongoing)
                                tile.find(".main__lesson_profile_buttons")
                                    .append($("<a>").prop({"href":lesson.meeting_link,"target":"_blank"})
                                        .append($("<button>").addClass("joinBtn").prop("title","Join Meeting")
                                        .append('<img src="./images/enter.png" alt="">')));

                            if(lesson.status!=="Completed" && lesson.status!=="Cancelled" && !ongoing && !timePassed)
                                tile.find(".main__lesson_profile_buttons")
                                    .append($("<button>").addClass("cancelBtn").prop("title","Cancel Lesson").attr("onclick","showCancelForm("+lesson.lesson_id+")")
                                    .append('<img src="./images/cancel.png" alt="">'));
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
    function showScheduleLessonForm(tutor_id,lesson_id){
        showLoading();
        $("#scheduleDiv").hide();
        $(".main__lesson__overlay_avail").empty();
        $("#scheduleForm").trigger("reset");
        $("#lesson_id").val(lesson_id);
        $.ajax({
            url:"./AvailabilityController",
            data:"cmd=loadTutorAvailability&tutor_id="+tutor_id,
            success: function(response){    
                hideLoading();
                $.each(response,function(i,av){
                    days_of_week.push(daysObj[av.day_of_week]);
                    availMap.set(daysObj[av.day_of_week],av);
                });
            }
        });
        showLoading();
        $.ajax({
            url:"./LessonController",
            data:"cmd=loadScheduledLessons&tutor_id="+tutor_id,
            success: function(response){    
                hideLoading();
                $.each(response,function(i,schedule){
                    if(scheduleMap.has(schedule.date)){
                        const scheduleArray = scheduleMap.get(schedule.date);
                        scheduleArray.push(schedule);
                        scheduleMap.set(schedule.date,scheduleArray);
                    }else{
                        let scheduleArray = new Array();
                        scheduleArray.push(schedule);
                        scheduleMap.set(schedule.date,scheduleArray);
                    }
                });
            }
        });
        showOverlayForm("scheduleOverlay");
    }
    function showAddLinkForm(lesson_id){
        $("#addLinkLessonID").val(lesson_id);
        showOverlayForm("addLink");
    }
    function showReScheduleForm(lesson_id){
        $("#reScheduleLessonID").val(lesson_id);
        showOverlayForm("reSchedule");
    }
    function showCancelForm(lesson_id){
        $("#cancelLessonID").val(lesson_id);
        showOverlayForm("cancelLesson");
    }
    function showReportIssueForm(lesson_id){
        $("#reportIssueLessonID").val(lesson_id);
        showOverlayForm("reportIssue");
    }
    function showMarkAsCompletedForm(lesson_id){
        $("#markCompletedLessonID").val(lesson_id);
        showOverlayForm("markCompleted");
    }
    function validateDate(date){
        const parts = date.split('-');
        const day = (new Date(parts[0], parts[1]-1, parts[2])).toLocaleDateString('en-US', { weekday: 'long' });
        if(days_of_week.indexOf(day)===-1)
            return false;
        else
            return true;
    }
    function tConvert (start_time,format) {
        const start_mins = Math.floor((start_time/1000)/60);
        const start_min = Math.floor(start_mins%60);
        const start_hr = Math.floor((start_mins - start_min)/60);
        let time="";
        start_hr<10? time="0":time+="";
        time+=start_hr+":";
        start_min<10? time += "0":time+="";
        time+=start_min;
    if(format===24){
        return time;
    }else{
        // Check correct time format and split into components
            time = time.match(/^([01]\d|2[0-3])(:)([0-5]\d)(:[0-5]\d)?$/) || [time];

            if (time.length > 1) { // If time format correct
                time = time.slice (1);  // Remove full string match value
                time[5] = +time[0] < 12 ? 'AM' : 'PM'; // Set AM/PM
                time[0] = +time[0] % 12 || 12; // Adjust hours
            }
            return time.join (''); // return adjusted time or original string
    }
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
        $("#scheduleDiv").hide();
        var d = new Date();
        var date = d.getFullYear() + "-" + (d.getMonth()+1) + "-" + d.getDate();
        $("#date").prop("min",date);
        $("#date").change(function(event){
            if(!validateDate($(this).val())){
            	$(this).val('');
                let daysAvail = "";
                $.each(days_of_week,function(i,day){
                    daysAvail += day+" ";
                });
                const alertMsg = "Tutor is not available on this day. Choose a date on following days: "+daysAvail;
                daysAvail = "";
                $("#scheduleDiv").hide();
                alert(alertMsg);
            }else{
                const parts = $(this).val().split('-');
                const day = (new Date(parts[0], parts[1]-1, parts[2])).toLocaleDateString('en-US', { weekday: 'long' });
                const avail = availMap.get(day);
                let dateParts = $(this).val().split('-');
                let timeParts1 = avail.time_from.split(':');
                let timeParts2 = avail.time_to.split(':');
                const datetime1 = new Date(dateParts[0], dateParts[1]-1,
                dateParts[2],timeParts1[0],timeParts1[1],timeParts1[2]);
                const datetime2 = new Date(dateParts[0], dateParts[1]-1,
                dateParts[2],timeParts2[0],timeParts2[1]);
                const diff = Math.abs(datetime1 - datetime2);
                const mins = Math.floor((diff/1000)/60);
                const no_of_units = Math.floor(mins/30);
                const avail_div = $(".main__lesson__overlay_avail");
                let start_time = (parseInt(timeParts1[0])*1000*60*60)+(parseInt(timeParts1[1])*1000*60);
                let end_time = (parseInt(timeParts2[0])*1000*60*60)+(parseInt(timeParts2[1])*1000*60);
                avail_div.empty();
                $("#scheduleDiv").show();
                for(let i=0;i<=no_of_units;i++){
                    let avail_unit = $("<div>").addClass("avail_unit green_unit")
                                               .append($("<span>").text(tConvert(start_time,12)))
                                               .append($("<i>").addClass("unit_value").text(start_time).css("display","none"));
                    const lesson = lessonsMap.get(parseInt($("#lesson_id").val()));
                    const lessonTime = (lesson.duration-0.5)*1000*60*60;
                    $.each(scheduleMap.get($(this).val()),function(i,schedule){
                        const time_parts = schedule.time_from.split(":");
                         const time_parts1 = schedule.time_to.split(":");
                        let scheduleStartTime = (parseInt(time_parts[0])*1000*60*60)+(parseInt(time_parts[1])*1000*60);
                        let scheduleEndTime = (parseInt(time_parts1[0])*1000*60*60)+(parseInt(time_parts1[1])*1000*60);
                        if($("#lesson_id").val()!=schedule.lesson_id)
                        if(start_time>=scheduleStartTime && start_time<scheduleEndTime)
                            avail_unit.addClass("red_unit");
                        if(start_time >= (scheduleStartTime - lessonTime) && start_time < scheduleStartTime)
                            avail_unit.addClass("overlapingTime");
                    });
                    if(start_time >= end_time - lessonTime)
                        avail_unit.addClass("overlapingTime");
                    avail_div.append(avail_unit);
                    start_time += 30*1000*60;
                }
            }
        });
        $(document).on("click",".avail_unit",function(event){
            const avail_unit = $(this);
            const lesson = lessonsMap.get(parseInt($("#lesson_id").val()));
            if(avail_unit.hasClass("red_unit"))
                return;
            if(avail_unit.hasClass("overlapingTime"))
                alert("You or Tutor will not be available for "+lesson.duration+" Hr from selected starting time");
            else{
                console.log("clicked");
                const start_time = parseInt(avail_unit.children(".unit_value").text());
                const time_from = tConvert(start_time,24);
                const time_to = tConvert(start_time + lesson.duration*1000*60*60,24);
                $("#time_from").val(time_from);
                $("#time_to").val(time_to);
                let nextUnit = avail_unit;
                $(".selected_unit").removeClass("selected_unit");
                for(i=0;i<lesson.duration*2;i++){
                    nextUnit.addClass("selected_unit");
                    nextUnit = nextUnit.next();
                }
            }
        });
        $(document).on("submit", "#scheduleForm", function (event) {
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
                if(response.includes("Scheduled")) {
                    loadLessons("All",null);
                    $("#snackbar").html(response);
                    showToast();
                    hideOverlayForm();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
            });
        });
        $(document).on("submit", "#addLinkForm", function (event) {
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
                if(response.includes("Added")) {
                     loadLessons("All",null);
                     $("#snackbar").html(response);
                     showToast();
                     hideOverlayForm();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
            });
        });
        $(document).on("submit", "#reScheduleForm", function (event) {
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
                if(response.includes("Sent")) {
                    loadLessons("All",null);
                    $("#snackbar").html("Request Sent");
                    showToast();
                    hideOverlayForm();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
            });
        });
        $(document).on("submit", "#cancelLessonForm", function (event) {
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
                if(response.includes("Cancelled")) {
                    loadLessons("All",null);
                    $("#snackbar").html("Lesson Cancelled");
                    showToast();
                    hideOverlayForm();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
            });
        });
        $(document).on("submit", "#markCompletedForm", function (event) {
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
                if(response.includes("Completed")) {
                    loadLessons("All",null);
                    $("#snackbar").html("Lesson Completed");
                    showToast();
                    hideOverlayForm();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
            });
        });
        $(document).on("submit", "#reportIssueForm", function (event) {
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
                if(response.includes("Reported")) {
                    loadLessons("All",null);
                    $("#snackbar").html("Issue Reported");
                    showToast();
                    hideOverlayForm();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
            });
        });
    });
</script>
<%@include file="footer.jsp"%>