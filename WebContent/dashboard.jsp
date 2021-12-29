<%if(session.getAttribute("USER")==null){ response.sendRedirect("./");return;}%>
<%@include file="header.jsp" %>
 <div class="flex-container">
 <%@include file="sidebar.jsp" %>
 <%
 	String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
 %>
<main class="main">
            <h1 class="main__heading">Dashboard</h1>
            <%if(dashboardType.equals("USER")){ %>
            <div class="main__dashboard-container">
                <div class="main__tile">
                    <span class="main__tile_title">Lessons Scheduled</span>
                    <div class="main__tile_img">
                        <img src="./images/calendar.png" alt="">
                    </div>
                    <div class="main__tile_number">
                        <span id="upcoming_lessons"></span>
                    </div>
                </div>
                <div class="main__tile">
                    <span class="main__tile_title">Total Lessons</span>
                    <div class="main__tile_img">
                        <img src="./images/document.png" alt="">
                    </div>
                    <div class="main__tile_number">
                        <span id="total_lessons"></span>
                    </div>
                </div>
                <div class="main__tile">
                    <span class="main__tile_title">Wallet</span>
                    <div class="main__tile_img">
                        <img src="./images/wallet.png" alt="">
                    </div>
                    <div class="main__tile_number">
                        <span id="wallet_balance"></span>
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
            <%}else{%>
            <div class="main__dashboard-container">
                <div class="main__tile">
                    <span class="main__tile_title">Total Earning</span>
                    <div class="main__tile_img">
                        <img src="./images/income.png" alt="">
                    </div>
                    <div class="main__tile_number">
                        <span id="total_earning"></span>
                    </div>
                </div>
                <div class="main__tile">
                    <span class="main__tile_title">Total Lessons</span>
                    <div class="main__tile_img">
                        <img src="./images/document.png" alt="">
                    </div>
                    <div class="main__tile_number">
                        <span id="total_lessons"></span>
                    </div>
                </div>
                <div class="main__tile">
                    <span class="main__tile_title">Wallet</span>
                    <div class="main__tile_img">
                        <img src="./images/wallet.png" alt="">
                    </div>
                    <div class="main__tile_number">
                        <span id="wallet_balance"></span>
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
            <%}%>
        </main>
</div>
<script type="text/javascript">
    $.ajax({
        url:"./ReportController",
        data:"cmd=getUserDashboardData",
        success:function(response){
            $("#upcoming_lessons").text(response.upcoming_lessons.length);
            $("#total_lessons").text(response.total_lessons);
            $("#wallet_balance").html("&#8377; "+response.wallet_balance);
            $("#total_earning").html("&#8377; "+response.total_earning);
            for(let i=0;i<5;i++){
                const lesson = response.upcoming_lessons[0];
                
            }
        }
    });
</script>
<%@include file="footer.jsp" %>