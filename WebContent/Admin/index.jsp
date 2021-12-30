<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
        <div class="dashboard">
            <div class="dashboard__tile">
                <div class="dashboard__tile_img">
                    <img src="../images/rupee.png" alt="" srcset="">
                </div>
                <div class="dashboard__tile_info">
                    <span class="dashboard__tile_title">Total Sales</span>
                    <span class="dashboard__tile_num" id="total_sales">&#8377; 10</span>
                </div>
            </div>
            <div class="dashboard__tile">
                <div class="dashboard__tile_img">
                    <img src="../images/income.png" alt="" srcset="">
                </div>
                <div class="dashboard__tile_info">
                    <span class="dashboard__tile_title">Admin Profit</span>
                    <span class="dashboard__tile_num" id="admin_profit">&#8377; 10</span>
                </div>
            </div>
            <div class="dashboard__tile">
                <div class="dashboard__tile_img">
                    <img src="../images/group.png" alt="" srcset="">
                </div>
                <div class="dashboard__tile_info">
                    <span class="dashboard__tile_title">Total Users</span>
                    <span class="dashboard__tile_num" id="total_users">10</span>
                </div>
            </div>
            <div class="dashboard__tile">
                <div class="dashboard__tile_img">
                    <img src="../images/group.png" alt="" srcset="">
                </div>
                <div class="dashboard__tile_info">
                    <span class="dashboard__tile_title">Tutors</span>
                    <span class="dashboard__tile_num" id="total_tutors">10</span>
                </div>
            </div>
            <div class="dashboard__tile dashboard__big-tile">
                <div class="dashboard__tile_img">
                    <img src="../images/marketplace-vector.svg" style="filter: invert(1);" alt="" srcset="">
                </div>
                <div class="dashboard__tile_info">
                    <div>
                        <span class="dashboard__tile_title">Total Bookings</span>
                        <span class="dashboard__tile_num" id="total_bookings">10</span>
                    </div>
                    <div>
                        <span class="dashboard__tile_title">Total Lessons Sold</span>
                        <span class="dashboard__tile_num" id="total_lessons">10</span>
                    </div>
                </div>
            </div>
            <div class="dashboard__tile dashboard__big-tile">
                <div class="dashboard__tile_img">
                    <img src="../images/document.png" alt="" srcset="">
                </div>
                <div class="dashboard__tile_info">
                    <div>
                        <span class="dashboard__tile_title">Scheduled Lessons</span>
                        <span class="dashboard__tile_num" id="scheduled_lessons">10</span>
                    </div>
                    <div>
                        <span class="dashboard__tile_title">Completed Lessons</span>
                        <span class="dashboard__tile_num" id="completed_lessons">10</span>
                    </div>
                </div>
            </div>
            <div class="dashboard__tile dashboard__big-tile dashboard__big-tile_block" id="bookingDiv">
            <span class="caption">Recent Bookings</span>
                <table id="bookingTable">
                    <thead>
                        <th>ID</th>
                        <th>Details</th>
                        <th>Users</th>
                        <th>Amount</th>
                    </thead>
                    <tbody>
                        
                    </tbody>
                </table>
            </div>
            <div class="dashboard__tile dashboard__big-tile dashboard__big-tile_block" id="lessonDiv">
            <span class="caption">Recent Completed Lessons</span>
                <table id="lessonTable">
                    <thead>
                        <th>ID</th>
                        <th>Details</th>
                        <th>Users</th>
                        <th>Status</th>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
    </main>
    <script>
        function loadDashboardData(){
            $.ajax({
                url:"../ReportController",
                data:"cmd=getAdminDashboardData",
                success: function(response){
                    $("#total_sales").html("&#8377; "+response.total_sales);
                    $("#admin_profit").html("&#8377; "+response.admin_profit);
                    $("#total_users").text(response.total_users);
                    $("#total_tutors").text(response.total_tutors);
                    $("#total_bookings").text(response.total_bookings);
                    $("#total_lessons").text(response.total_lessons);
                    $("#scheduled_lessons").text(response.scheduled_lessons);
                    $("#completed_lessons").text(response.completed_lessons);
                    if(response.recentBookings.length!==undefined)
                    if(response.recentBookings.length>0)
                    for(let i=0;i<response.recentBookings.length;i++){
                        if(i>5)
                            break;
                        const booking = response.recentBookings[i];
                        $("<tr>").appendTo($("#bookingTable tbody"))
                            .append($("<td>").text(booking.booking.booking_id))
                            .append($("<td>").html(booking.subject.subject_name+"<br>"+
                                                   "Duration: "+booking.booking.duration+"Hr<br>"+
                                                   "Lessons Count: "+booking.booking.no_of_lesson))
                            .append($("<td>").html("Student: "+booking.user.fname+" "+booking.user.lname+"<br>"+
                                                    "Tutor: "+booking.tutorUser.fname+" "+booking.tutorUser.lname))
                            .append($("<td>").html("&#8377; "+booking.totalForUser));
                    }
                    else{
                        $("#bookingTable").remove();
                        $("#bookingDiv").append($("<p>").text("No Bookings Found"));
                    }
                    if(response.recentsLessons.length!==undefined)
                    if(response.recentsLessons.length>0)
                    for(let i=0;i<response.recentsLessons.length;i++){
                        if(i>5)
                        break;
                        const lesson = response.recentsLessons[i];
                        $("<tr>").appendTo($("#lessonTable tbody"))
                            .append($("<td>").text(lesson.lesson_id))
                            .append($("<td>").html(lesson.subject.subject_name+"<br>"+
                                                    "Duration: "+lesson.duration+"<br>"+
                                                    lesson.date+" "+lesson.time_from+" "+lesson.time_to))
                            .append($("<td>").html("Student: "+lesson.user.fname+" "+lesson.user.lname+"<br>"+
                                                    "Tutor: "+lesson.tutorUser.fname+" "+lesson.tutorUser.lname))
                            .append($("<td>").text(lesson.status));
                    }
                    else{
                        $("#lessonTable").remove();
                        $("#lessonDiv").append($("<p>").text("No Lessons Found"));
                    }
                }
            });
        }
        $(document).ready(function(event){
            loadDashboardData();
        });
    </script>
<%@include file="footer.jsp" %>