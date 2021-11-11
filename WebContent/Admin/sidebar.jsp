<section class="sidebar">
    <div class="sidebar__user">
        <div class="sidebar__user_avatar">
            <img src="../images/avatar.png" alt="Admin">
        </div>
        <div class="sidebar__user_info">
            <span style="font-size:1.4rem"><strong><%=session.getAttribute("ADMIN")%></strong></span>
            <span><em>Administrator</em></span>
        </div>
    </div>
    <ul class="sidebar__dropdown">
        <li class="sidebar__dropdown_title"><a href="./Dashboard">Dashboard</a></li>
    </ul>
    <ul class="sidebar__dropdown">
        <li class="sidebar__dropdown_title">Courses <span class="sidebar__dropdown_title_arrow">></span></li>
        <ul class="sidebar__dropdown_items">
            <li><a href="./AddCourse">Add Course</a></li>
            <li><a href="./SeeCourses">See Courses</a></li>
            <li><a href="./AddSubject">Add Subjects</a></li>
            <li><a href="./SeeSubjects">See Subjects</a></li>
        </ul>
    </ul>
    <ul class="sidebar__dropdown">
        <li class="sidebar__dropdown_title">Users <span class="sidebar__dropdown_title_arrow">></span></li>
        <ul class="sidebar__dropdown_items">
            <li><a href="#">See All Users</a></li>
        </ul>
    </ul>
    <ul class="sidebar__dropdown">
        <li class="sidebar__dropdown_title">Tutors <span class="sidebar__dropdown_title_arrow">></span></li>
        <ul class="sidebar__dropdown_items">
            <li><a href="#">Tutor Applications</a></li>
            <li><a href="#">See All Tutors</a></li>
        </ul>
    </ul>
    <ul class="sidebar__dropdown">
        <li class="sidebar__dropdown_title">Orders <span class="sidebar__dropdown_title_arrow">></span></li>
        <ul class="sidebar__dropdown_items">
            <li><a href="#">See Placed Orders</a></li>
            <li><a href="#">Pending Lessons</a></li>
            <li><a href="#">See All Lessons</a></li>
        </ul>
    </ul>
    <ul class="sidebar__dropdown">
        <li class="sidebar__dropdown_title">Banks Accounts <span class="sidebar__dropdown_title_arrow">></span></li>
        <ul class="sidebar__dropdown_items">
            <li><a href="./AddAdminBankAcc">Add Admin Bank Acc</a></li>
            <li><a href="./SeeAdminBankAcc">See Admins Bank Acc(s)</a></li>
            <li><a href="#">See User Bank Acc(s)</a></li>
        </ul>
    </ul>
    <ul class="sidebar__dropdown acc_dropdown">
        <li class="sidebar__dropdown_title">Withdraw Requests <span class="sidebar__dropdown_title_arrow">></span></li>
        <ul class="sidebar__dropdown_items">
            <li><a href="#">Pending Requests</a></li>
            <li><a href="#">Approved Requests</a></li>
            <li><a href="#">Rejected Requests</a></li>
        </ul>
    </ul>
    <ul class="sidebar__dropdown">
        <li class="sidebar__dropdown_title">Reports <span class="sidebar__dropdown_title_arrow">></span></li>
        <ul class="sidebar__dropdown_items">
            <li><a href="#">Daily Report</a></li>
            <li><a href="#">Monthly Report</a></li>
            <li><a href="#">Yearly Report</a></li>
        </ul>
    </ul>
    <ul class="sidebar__dropdown acc_dropdown">
        <li class="sidebar__dropdown_title">Account Settings <span class="sidebar__dropdown_title_arrow">></span></li>
        <ul class="sidebar__dropdown_items">
            <li><a href="./AddAdmin">Add new Admin</a></li>
            <li><a href="./SeeAdmins">Show All Admins</a></li>
        </ul>
    </ul>
    <div class="sidebar__footer">
        <a href="../" class="sidebar__footer_icon" title="TutorPod FrontEnd"><img src="../images/marketplace-vector.svg"
                alt=""></a>
        <a href="../AdminController?cmd=logout" class="sidebar__footer_icon" title="Log Out"><img
                src="../images/logout-vector.svg" alt=""></a>
    </div>
</section>