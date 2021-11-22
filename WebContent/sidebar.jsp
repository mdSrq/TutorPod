<div class="sidebar" tabindex="-1">
		<%boolean isUser = session.getAttribute("DASHBOARD_TYPE").equals("USER");%>
            <div class="sidebar__body">
                <a href="./Dashboard" class="sidebar__link">
                    <div class="sidebar__link_icon">
                        <img src="./images/dashboard.png" alt="" />
                    </div>
                    Dashboard
                </a>
                <a href="./AccountSettings" class="sidebar__link">
                    <div class="sidebar__link_icon">
                        <img src="./images/settings.png" alt="" />
                    </div>
                    Account Settings
                </a>
                <%if(!isUser){ %>
                     <a href="./Availability" class="sidebar__link">
                    	<div class="sidebar__link_icon">
                        	<img src="./images/calendar.png" alt="" />
                    	</div>
                   	 	Availability
                	</a>
               <%}%>
                <a href="#" class="sidebar__link">
                    <div class="sidebar__link_icon">
                        <img src="./images/document.png" alt="" />
                    </div>
                    Lessons
                </a>
                <a href="#" class="sidebar__link">
                    <div class="sidebar__link_icon">
                        <img src="./images/group.png" alt="" />
                    </div>
                    Students
                </a>
                <%}%>
                <%if(isUser){ %>
                <a href="#" class="sidebar__link">
                    <div class="sidebar__link_icon">
                        <img src="./images/group.png" alt="" />
                    </div>
                    Teachers
                </a>
                <%}%>
                <a href="./Notifications" class="sidebar__link">
                    <div class="sidebar__link_icon">
                        <img src="./images/bell.png" alt="" />
                    </div>
                    Notifications
                </a>
                <a href="#" class="sidebar__link">
                    <div class="sidebar__link_icon">
                        <img src="./images/order.png" alt="" />
                    </div>
                    Orders
                </a>
                <a href="#" class="sidebar__link">
                    <div class="sidebar__link_icon">
                        <img src="./images/wallet.png" alt="" />
                    </div>
                    Wallet
                </a>
            </div>
        </div>
<script>
    if($("#dash_menu_icon").length<1){
        $(".header-controls").prepend('<div class="header-controls__dash-menu" id="dash_menu_icon"> <a href="#"><img src="./images/dash_menu.png" alt=""></a> </div>');
    }
</script>