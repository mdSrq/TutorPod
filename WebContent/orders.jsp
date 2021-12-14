<%if(session.getAttribute("USER")==null){ response.sendRedirect("./");return;}%>
<%
	User currentUser = (User)session.getAttribute("USER");
	String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
%>
<%@include file="header.jsp" %>
 <div class="flex-container">
 <%@include file="sidebar.jsp" %>
	<main class="main">
            <h1 class="main__heading">My Orders</h1>
            <%if(dashboardType.equals("USER")){
		    if(session.getAttribute("TUTOR")!=null){ %>
			<a href="./UserController?cmd=switchToTutor&page=Orders" class="button float-right-btn float-equally">Switch to Tutor &gt;&gt;</a>
		    <%}}else{%>
			<a href="./UserController?cmd=switchToUser&page=Orders" class="button float-right-btn float-equally">Switch to User &gt;&gt;</a>
		    <%}%>
            <div class="main__dashboard-container">
                <div class="table-wrapper">
                    <table class="white-table" id="bookingsTable">
                        <thead>
                            <th>S.No.</th>
                            <th>Booking ID</th>
                            <%if(dashboardType.equals("USER")){%>
                            <th>Tutor</th>
                            <%}else{%>
                            <th>Student</th>
                            <%} %>
                            <th>Details</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
       </div>
<script type="text/javascript">
    function loadBookings(){
        $.ajax({
            url:"./BookingController",
            data:"cmd=loadBookingDetails",
            success: function(response){
                if(response.length<1){
                    $(".table-wrapper").hide();
                    return;
                }
                $.each(response,function(i,bkn){
                    $("<tr>").appendTo( $("#bookingsTable tbody"))
                        .append($("<td>").text((i+1)))
                        .append($("<td>").text(bkn.booking.booking_id))
                        <%if(dashboardType.equals("USER")){%>
                        .append($("<td>").text(bkn.user.fname+" "+bkn.user.lname))
                        <%}else{%>
                        .append($("<td>").text(bkn.tutorUser.fname+" "+bkn.tutorUser.lname))
                        <%}%>
                        .append($("<td>").html("Subject: "+bkn.subject.subject_name+"<br>Duration: "+bkn.booking.duration+" Hr <br>No. of Lessons: "+bkn.booking.no_of_lesson))
                        <%if(dashboardType.equals("USER")){%>
                        .append($("<td>").html("&#8377; " +bkn.totalForUser))
                        <%}else{%>
                        .append($("<td>").html("&#8377; " +bkn.totalForTutor))
                        <%}%>
                        .append($("<td>").text(bkn.booking.status))
                });
            }
        });
    }
    $(document).ready(function(event){
        loadBookings();
    });
</script>
<%@include file="footer.jsp"%>