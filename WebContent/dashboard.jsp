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
                        <span>15</span>
                    </div>
                </div>
                <div class="main__tile">
                    <span class="main__tile_title">Total Lessons</span>
                    <div class="main__tile_img">
                        <img src="./images/document.png" alt="">
                    </div>
                    <div class="main__tile_number">
                        <span>15</span>
                    </div>
                </div>
                <div class="main__tile">
                    <span class="main__tile_title">Wallet</span>
                    <div class="main__tile_img">
                        <img src="./images/wallet.png" alt="">
                    </div>
                    <div class="main__tile_number">
                        <span>&#8377;1530</span>
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
                        <span>&#8377;500</span>
                    </div>
                </div>
                <div class="main__tile">
                    <span class="main__tile_title">Total Lessons</span>
                    <div class="main__tile_img">
                        <img src="./images/document.png" alt="">
                    </div>
                    <div class="main__tile_number">
                        <span>15</span>
                    </div>
                </div>
                <div class="main__tile">
                    <span class="main__tile_title">Wallet</span>
                    <div class="main__tile_img">
                        <img src="./images/wallet.png" alt="">
                    </div>
                    <div class="main__tile_number">
                        <span>&#8377;1530</span>
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

</script>
<%@include file="footer.jsp" %>