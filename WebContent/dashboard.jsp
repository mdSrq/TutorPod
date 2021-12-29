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
            <div class="main__big-tile">
                <h2 class="main__sub-heading">Upcoming Lessons</h2>
                <p>No Upcoming Lessons Today</p>
            </div>
            <div class="main__big-tile">
                <h2 class="main__sub-heading">Recent Lessons</h2>
                <p>No lessons taken yet </p>
            </div>
            </div>
        </main>
</div>
<script type="text/javascript">
    function loadDashboardData(){
        showLoading();
        $.ajax({
            url:"./ReportController",
            data:"cmd=getUserDashboardData",
            success: function(response){
                $("#upcoming_lessons").text(response.upcoming_lessons.length);
                $("#total_lessons").text(response.total_lessons);
                $("#wallet_balance").html("&#8377; "+response.wallet_balance);
                $("#total_earning").html("&#8377; "+response.total_earning);
                for(let i=0;i<5;i++){
                    const lesson = response.upcoming_lessons[0];
                    
                }
                hideLoading();
            }
        });
    }
    $(document).ready(function(event){
        loadDashboardData();    
    });
</script>
<%@include file="footer.jsp" %>