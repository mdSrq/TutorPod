<%if(session.getAttribute("USER")==null){ response.sendRedirect("./");return;}%>
<%@include file="header.jsp" %>
 <div class="flex-container">
 <%@include file="sidebar.jsp" %>
 <%
 	String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
 %>
<main class="main">
            <h1 class="main__heading">Dashboard</h1>
            <%if(dashboardType.equals("USER")){
		    if(session.getAttribute("TUTOR")!=null){ %>
			<a href="./UserController?cmd=switchToTutor&page=Dashboard" class="button float-right-btn float-equally">Switch to Tutor &gt;&gt;</a>
		    <%}}else{%>
			<a href="./UserController?cmd=switchToUser&page=Dashboard" class="button float-right-btn float-equally">Switch to User &gt;&gt;</a>
		    <%}%> 
            <div class="main__dashboard-container">
            <%if(dashboardType.equals("USER")){ %>
                <div class="main__tile">
                    <div class="main__tile_img">
                        <img src="./images/calendar.png" alt="">
                    </div>
                    <div class="main__wallet__tile_balance">
                        <span class="main__wallet__tile_title">Lessons Scheduled</span>
                        <span class="main__wallet__tile_num" id="upcoming_lessons"></span>
                    </div>
                </div>
            <%}else{%>
                <div class="main__tile">
                    <div class="main__tile_img ">
                        <img src="./images/income.png" alt="">
                    </div>
                    <div class="main__wallet__tile_balance">
                        <span class="main__wallet__tile_title">Total Earning</span>
                        <span class="main__wallet__tile_num" id="total_earning"></span>
                    </div>
                </div>
            <%}%>
            <div class="main__tile">
                <div class="main__tile_img">
                    <img src="./images/document.png" alt="">
                </div>
                <div class="main__wallet__tile_balance">
                    <span class="main__wallet__tile_title">Total Lessons</span>
                    <span class="main__wallet__tile_num" id="total_lessons"></span>
                </div>
            </div>
            <div class="main__tile">
                <div class="main__tile_img main__tile_img_wallet">
                    <img src="./images/wallet.png" alt="">
                </div>
                <div class="main__wallet__tile_balance">
                    <span class="main__wallet__tile_title">Wallet</span>
                    <span class="main__wallet__tile_num" id="wallet_balance"></span>
                </div>
            </div>
            <div class="main__big-tile" id="upcommingTile">
                <h2 class="main__sub-heading">Upcoming Lessons</h2>
                <p>No Upcoming Lessons Today</p>
            </div>
            <div class="main__big-tile" id="recentTile">
                <h2 class="main__sub-heading">Recent Lessons</h2>
                <p>No lessons taken yet </p>
            </div>
            </div>
        </main>
</div>
<script type="text/javascript">
    function tConvert(start_time, format) {
        const start_mins = Math.floor((start_time / 1000) / 60);
        const start_min = Math.floor(start_mins % 60);
        const start_hr = Math.floor((start_mins - start_min) / 60);
        let time = "";
        start_hr < 10 ? time = "0" : time += "";
        time += start_hr + ":";
        start_min < 10 ? time += "0" : time += "";
        time += start_min;
        if (format === 24) {
            return time;
        } else {
            // Check correct time format and split into components
            time = time.match(/^([01]\d|2[0-3])(:)([0-5]\d)(:[0-5]\d)?$/) || [time];

            if (time.length > 1) { // If time format correct
                time = time.slice(1);  // Remove full string match value
                time[5] = +time[0] < 12 ? 'AM' : 'PM'; // Set AM/PM
                time[0] = +time[0] % 12 || 12; // Adjust hours
            }
            return time.join(''); // return adjusted time or original string
        }
    }
    function loadDashboardData() {
        showLoading();
        $.ajax({
            url: "./ReportController",
            data: "cmd=getUserDashboardData",
            success: function (response) {
                $("#upcoming_lessons").text(response.upcoming_lessons.length);
                $("#total_lessons").text(response.total_lessons);
                $("#wallet_balance").html("&#8377; " + response.wallet_balance);
                $("#total_earning").html("&#8377; " + response.total_earning);
                if(response.upcoming_lessons.length!==undefined)
                for (let i = 0; i < response.upcoming_lessons.length; i++) {
                    if(i>5)
                        break;
                    const lesson = response.upcoming_lessons[i];
                    $("#upcommingTile p").remove();
                    const lessonDiv = $("<div>").addClass("main__big-tile_lesson").appendTo($("#upcommingTile"))
                        .append($("<div>").addClass("main__big-tile_info")
                            .append($("<span>").addClass("main__big-tile_subject").text(lesson.subject.subject_name))
                            .append($("<span>").addClass("main__big-tile_tutor")));
                    <%if(dashboardType.equals("USER")){%>
                        lessonDiv.find(".main__big-tile_tutor").text("Tutor: "+lesson.tutorUser.fname + " " + lesson.tutorUser.lname);
                    <%}else{%>
                        lessonDiv.find(".main__big-tile_tutor").text("Student: "+lesson.user.fname + " " + lesson.user.lname);
                    <%}%>
                    let dateParts = lesson.date.split('-');
                    let timeParts1 = lesson.time_from.split(':');
                    let timeParts2 = lesson.time_to.split(':');
                    const datetime1 = new Date(dateParts[0],
                    dateParts[1]-1,dateParts[2],timeParts1[0],timeParts1[1],timeParts1[2]);
                    let time_from = (parseInt(timeParts1[0])*1000*60*60)+(parseInt(timeParts1[1])*1000*60);
                    let time_to = (parseInt(timeParts2[0])*1000*60*60)+(parseInt(timeParts2[1])*1000*60);
                    lessonDiv.append($("<div>").addClass("main__big-tile_schedule")
                        .append($("<span>").addClass("main__big-tile_time").text(tConvert(time_from,12)+" to "+tConvert(time_to,12)))
                        .append($("<span>").addClass("main__big-tile_date").text(datetime1.toDateString()))
                        );
                }
                for (let i = 0; i < response.recent_lessons.length; i++) {
                    if(i>5)
                        break;
                    $("#recentTile p").remove();
                    const lesson = response.recent_lessons[i];
                    const lessonDiv = $("<div>").addClass("main__big-tile_lesson").appendTo($("#recentTile"))
                        .append($("<div>").addClass("main__big-tile_info")
                            .append($("<span>").addClass("main__big-tile_subject").text(lesson.subject.subject_name))
                            .append($("<span>").addClass("main__big-tile_tutor")))
                        .append($("<span>").text(lesson.status));
                    <%if(dashboardType.equals("USER")){%>
                        lessonDiv.find(".main__big-tile_tutor").text("Tutor: "+lesson.tutorUser.fname + " " + lesson.tutorUser.lname);
                    <%}else{%>
                        lessonDiv.find(".main__big-tile_tutor").text("Student: "+lesson.user.fname + " " + lesson.user.lname);
                    <%}%>
                    let dateParts = lesson.date.split('-');
                    let timeParts1 = lesson.time_from.split(':');
                    let timeParts2 = lesson.time_to.split(':');
                    const datetime1 = new Date(dateParts[0],
                    dateParts[1]-1,dateParts[2],timeParts1[0],timeParts1[1],timeParts1[2]);
                    let time_from = (parseInt(timeParts1[0])*1000*60*60)+(parseInt(timeParts1[1])*1000*60);
                    let time_to = (parseInt(timeParts2[0])*1000*60*60)+(parseInt(timeParts2[1])*1000*60);
                    lessonDiv.find(".main__big-tile_info").append($("<span>").addClass("main__big-tile_tutor")
                        .text(tConvert(time_from,12)+" to "+tConvert(time_to,12)+" "+datetime1.toDateString()));
                }
                hideLoading();
            }
        });
    }
    $(document).ready(function (event) {
        loadDashboardData();
    });
</script>
<%@include file="footer.jsp" %>