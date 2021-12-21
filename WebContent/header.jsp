<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.TutorPod.model.User"%>
<%@page import="com.TutorPod.model.Tutor"%>
<%
User user = null;
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./app/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">
    <title>Tutor Pod</title>
</head>

<body>
    <header class="header" id="header">
        <nav class="container flex flex-jc-sb flex-ai-c">
            <a href="./" class="header__logo flex flex-ai-c"> <img src="./images/TutorPod1.svg" alt="TutorPod" /> <span
                    class="header__logo_title">Tutor<span class="header__logo_title_part">Pod</span>
                </span>
            </a> <a href="#" id="btnHamburger" class="header__menu hide-for-desktop">
                <span></span> <span></span> <span></span>
            </a>
            <div class="header__links hide-for-mobile">
                <a href="#" class="underlined header__links_dropdown">Subjects <span class="dropdown-arrow">></span></a>
                <a href="./TutorApplication" class="underlined">Apply to Teach</a>
                <a href="./SearchTutor" class="underlined">Search Tutors</a> <a href="#" class="underlined">Contact
                    Us</a>
                <div class="nav-dd" tabindex="99">
                    <ul class="nav-dd_courses scrollable">
                        <li><a href="#" class="dropdown-caption">Select Course</a></li>
                    </ul>
                    <ul class="nav-dd_durations">
                        <li><a href="#" class="dropdown-caption">Select Year/Sem</a>
                        </li>
                    </ul>
                    <ul class="nav-dd_subjects scrollable">
                        <li><a href="#" class="dropdown-caption">Select Subject</a></li>
                    </ul>
                </div>
            </div>
            <%
			if (session.getAttribute("USER") != null) {
				user = (User) session.getAttribute("USER");
			%>
            <div class="header-controls">
                <div class="header-controls__home">
                    <a href="./"><img src="./images/home.png" alt=""></a>
                </div>
                <div class="header-controls__menu">
                    <a href="#"><img src="./images/menu.png" alt=""></a>
                </div>
                <div class="header-controls__notifications">
                    <a href="#">
                        <div class="notification_bell">
                            <img src="./images/bell.png" alt="notification-icon">
                        </div>
                    </a>
                    <div class="notifications scrollable" tabindex="97">
                        <div class="notifications__header">
                            <span class="notifications__header_title">Notifications</span> <a href="#"
                                class="notifications__header_link_l" onclick="markAllAsSeen()">Mark all as
                                seen</a> 
                                <a href="./Notifications" class="notifications__header_link_r">See all</a>
                        </div>
                        <div class="notifications__body"></div>
                    </div>
                </div>
                <div class="header-controls__user-profile">
                    <div class="avatar">
                        <%if(user.getPhoto()==null){ %>
                        <img src="./images/user.png" alt="profile-pic">
                        <%}else{ %>
                        <img src="<%= pageContext.getServletContext().getInitParameter("usersphoto.location")
									+ user.getPhoto()%>" alt="profile pic">
                        <%}%>
					</div>
					<div class="header-controls__user-profile_dropdown" tabindex="98">
						<a href="./Dashboard">Dashboard</a>
						<%
						boolean isTutor = session.getAttribute("DASHBOARD_TYPE").equals("TUTOR");
						if(session.getAttribute("TUTOR")!=null){ 
							if(isTutor){
						%>
                        <a href="./UserController?cmd=switchToUser">Switch to Learner</a>
                        <%}else{%>
                        <a href="./UserController?cmd=switchToTutor">Switch to Tutor</a>
                        <%}}%>
                        <%if(isTutor){ %>
                        <a href="#">My Students</a>
                        <%}else{%>
                        <a href="#">My Teachers</a>
                        <%} %>
                        <a href="./Lessons">Lessons</a>
                        <a href="./AccountSettings">Settings</a>
                        <a href="./UserController?cmd=logout">Logout</a>
                    </div>
                </div>
            </div>
            <%
			} else {
			%>
            <div class="header-controls header-controls-hidden">
                <div class="header-controls__home">
                    <a href="./"><img src="./images/home.png" alt=""></a>
                </div>
                <div class="header-controls__menu">
                    <a href="#"><img src="./images/menu.png" alt=""></a>
                </div>
            </div>
            <a href="#" class="button hide-for-mobile" onclick="showSignIn()" id="signinBtn">Sign In</a>
            <%
			}
			%>
        </nav>
        <div class="overlay toggle-on"></div>
        <div class="header__overlay_menu hide-for-desktop toggle-on">
            <a href="./TutorApplication">Apply to Teach</a> <a href="#">Search Tutors</a> <a href="#">Study Resources</a>
            <%
			if (session.getAttribute("USER") == null) {
			%>
            <a href="#" id="signinBtnNav">Sign In</a>
            <%
			}
			%>
        </div>
        <div class="overlaydiv">
            <div id="btnCross" class="header__menu cross">
                <span></span>
                <span></span>
                <span></span>
            </div>
            <div class="signup-form">
                <div class="scrollable signup-container">
                    <div class="tab-selector">
                        <span href="#" class="tab-selector_tab tab-selector_signin">Sign In</span>
                        <span href="#" class="tab-selector_tab tab-selector_signup">New Account</span>
                    </div>
                    <div class="signin">
                        <form action="./UserController" method="post" id="signinForm">
                            <div class="form-unit form-unit-full">
                                <label for="usernameSignIn">Username</label>
                                <input type="text" class="input-with-icon user_id" name="username" id="usernameSignIn"
                                    placeholder="Username or email address" required />
                            </div>
                            <div class="form-unit form-unit-full">
                                <label for="passwordSignIn">Password</label>
                                <input type="password" class="input-with-icon user_pass" name="password"
                                    id="passwordSignIn" placeholder="Password" required />
                            </div>
                            <input type="hidden" name="cmd" value="signin" />
                            <input type="submit" class="button flat-wide-button" value="Sign In" />
                        </form>
                        <p><a href="#">Forgot Password ?</a></p>
                    </div>
                    <div class="signup">
                        <form action="./UserController" method="post" id="signupForm">
                            <div class="form-unit form-unit-full">
                                <label for="username">Username</label>
                                <input type="text" class="input-with-icon user_id" name="username"
                                    placeholder="Enter Username" required />
                            </div>
                            <div class="form-unit-half-container">
                                <div class="form-unit form-unit-half">
                                    <label for="fname">First Name</label>
                                    <input type="text" class="input-with-icon user_name user_fname" name="fname"
                                        placeholder="Enter First Name" required />
                                </div>
                                <div class="form-unit form-unit-half">
                                    <label for="lname">Last Name</label>
                                    <input type="text" class="input-with-icon user_name user_lname" name="lname"
                                        placeholder="Enter Last Name" required />
                                </div>
                            </div>
                            <div class="form-unit form-unit-full">
                                <label for="password">Password</label>
                                <input type="password" class="input-with-icon user_pass" name="password"
                                    placeholder="Enter Password" required />
                            </div>
                            <div class="form-unit form-unit-full">
                                <label for="gender">Gender</label>
                                <select name="gender" class="input-with-icon user_gender">
                                    <option value="default" selected disabled>Select Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="form-unit form-unit-full">
                                <label for="email_id">Email ID</label>
                                <input type="text" class="input-with-icon user_email" name="email_id"
                                    placeholder="Enter Email Adderss" required />
                            </div>
                            <div class="form-unit form-unit-full">
                                <label for="mobile_no">Mobile Number</label>
                                <input type="tel" class="input-with-icon user_tel" name="mobile_no"
                                    placeholder="Enter Mobile Number" required />
                            </div>
                            <input type="hidden" name="cmd" value="signup" />
                            <input type="submit" class="button flat-wide-button" value="Sign Up" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div id="snackbar"></div>
    <script src="./app/js/jquery-3.6.0.min.js"></script>
    <script src="./app/js/script.js"></script>
    <script>
        var mostRecentNotificationID; 
        <%if (session.getAttribute("USER") != null) { %>
            loadNotifications();
            setInterval(loadNotifications, 1000 * 5); 
        <%}%>
        function showSubjectsDropdown() {
                    $(".nav-dd").css("display", "block");
                    showCourses();
                    $(".nav-dd").focus();
                }

            function showCourses() {
                $(".nav-dd_courses").css("display", "block");
                if (!$(".header-controls__menu > .nav-dd").length) {
                    $(".nav-dd_durations").removeAttr("style");
                    $(".nav-dd_subjects").removeAttr("style");
                }
            }

            function showSignInDiv() {
                $("body").css("overflow-y", "hidden");
                $(".overlaydiv").css("animation", "fade-in ease-in 0.3s forwards");
                $(".overlaydiv").css("visibility", "visible");
            }

            function hideSignInDiv() {
                $("body").css("overflow-y", "unset");
                $(".overlaydiv").css("animation", "fade-out ease-in 0.3s forwards");
                $(".overlaydiv").css("visibility", "hidden");
            }

            function showSignIn() {
                $(".signup").hide();
                $(".signin").show();
                $(".tab-selector_signin").addClass("tab-selector_selected");
                $(".tab-selector_signup").removeClass("tab-selector_selected");
            }

            function showSignUp() {
                $(".signin").hide();
                $(".signup").show();
                $(".tab-selector_signup").addClass("tab-selector_selected");
                $(".tab-selector_signin").removeClass("tab-selector_selected");
            }

            function loadNotifications() {
                $.ajax({
                    url: "./NotificationController",
                    data: "cmd=seeNotifications",
                    success: function (response) {
                        if (response.length <= 0) {
                            $("<a>").addClass("notifications__item").attr("href", "#").appendTo($(
                                ".notifications__body"))
                                .append($("<span>").addClass("notifications__item_text").text(
                                    "No Notifications"))
                                .append($("<span>").addClass("notifications__item_time").text(""));
                            return;
                        }
                        var unSeenNotifications = 0;
                        mostRecentNotificationID = response[0].notification_id;
                        $(".notifications__body").empty();
                        $.each(response, function (i, notification) {
                            var date = new Date(Date.parse(notification.datetime));
                            var currentDate = new Date();
                            var delta = parseInt((currentDate.getTime() - date) / 1000);
                            delta = (delta < 2) ? 2 : delta;
                            var aboutTime = '';
                            if (delta < 60) {
                                aboutTime = 'Just Now';
                            } else if (delta < 120) {
                                aboutTime = 'a min ago';
                            } else if (delta < (45 * 60)) {
                                aboutTime = (parseInt(delta / 60, 10)).toString() + ' mins ago';
                            } else if (delta < (2 * 60 * 60)) {
                                aboutTime = 'an hour ago';
                            } else if (delta < (24 * 60 * 60)) {
                                aboutTime = '' + (parseInt(delta / 3600, 10)).toString() + ' hrs ago';
                            } else if (delta < (48 * 60 * 60)) {
                                aboutTime = 'a day ago';
                            } else {
                                aboutTime = (parseInt(delta / 86400, 10)).toString() + ' days ago';
                            }
                            $("<a>").addClass("notifications__item").attr({
                                href: notification.link,
                                id: "notif_" + notification.notification_id,
                                onclick: "clickedNotification(" + notification.notification_id +
                                    ")"
                            }).appendTo($(".notifications__body"))
                                .append($("<span>").addClass("notifications__item_text").text(
                                    notification.notification))
                                .append($("<span>").addClass("notifications__item_time").text(
                                    aboutTime));
                            if (!notification.seen) {
                                unSeenNotifications++;
                                $("#notif_" + notification.notification_id).addClass(
                                    "notifications__item_unseen");
                            }
                            if (!notification.clicked) {
                                $("#notif_" + notification.notification_id).addClass(
                                    "notifications__item_unclicked");
                            }
                        });
                        if (unSeenNotifications > 0) {
                            if ($(".notification_badge") != null)
                                $(".notification_badge").remove();
                            $("<span>").addClass("notification_badge").appendTo($(".notification_bell"))
                                .append($("<span>").html(unSeenNotifications));
                        }
                    }
                });
            }

            function clickedNotification(notification_id) {
                $.ajax({
                    url: "./NotificationController",
                    data: "cmd=clickedNotification&notification_id=" + notification_id,
                    success: function (response) {
                        $("#notif_" + notification_id).css({
                            "font-weight": "normal",
                            "color": "#222"
                        });
                    }
                });
            }

            function seenNotifications() {
                $.ajax({
                    url: "./NotificationController",
                    data: "cmd=seenNotifications&notification_id=" + mostRecentNotificationID,
                    success: function (response) {
                        if (response.includes("Success")) {
                            $(".notification_badge").remove();
                        }
                    }
                });
            }

            function markAllAsSeen() {
                $.ajax({
                    url: "./NotificationController",
                    data: "cmd=markAllAsSeen&notification_id=" + mostRecentNotificationID,
                    success: function (response) {
                        if (response.includes("Success")) {
                            loadNotifications();
                        }
                    }
                });
            }

            function dropDurations(course_id) {
                if ($(".header-controls__menu > .nav-dd").length != 0) {
                    $(".header-controls__menu > .nav-dd > .nav-dd_courses").removeAttr("style");
                }
                $(".nav-dd_durations").css("display", "block");
                removeAllDurations();
                removeAllSubjects();
                $(".nav-dd_subjects").removeAttr("style");
                $(".nav-dd_duration_" + course_id)
                    .each(function (i, duration) {
                        duration.style = "display:block";
                    });
            }

            function removeAllDurations() {
                $(".nav-dd_duration").each(function (i, duration) {
                    duration.removeAttribute("style");
                });
            }

            function dropSubjects(course_id, duration_no) {
                if ($(".header-controls__menu > .nav-dd").length != 0) {
                    $(".header-controls__menu > .nav-dd > .nav-dd_durations").removeAttr("style");
                    $(".header-controls__menu > .nav-dd > .nav-dd_courses").removeAttr("style");
                }
                $(".nav-dd_subjects").css("display", "block");
                removeAllSubjects();
                $(".nav-dd_subject_" + course_id + "_" + duration_no)
                    .each(function (i, subject) {
                        subject.style = "display:block";
                    });
            }

            function removeAllSubjects() {
                $(".nav-dd_subject").each(function (i, duration) {
                    duration.removeAttribute("style");
                });
            }
            async function isValidUsername(username) {
                return await $.ajax({
                    url: "./UserController",
                    data: "cmd=checkUsername&username=" + username,
                    success: function (response) {
                        if (response.includes("Valid"))
                            return true;
                        else
                            return false;
                    }
                });
            }
        $(document).ready(() => {
            showSignIn(); 
            $("#signinBtn").click(showSignInDiv);
            $("#signinBtnNav").click(showSignInDiv);
            $("#btnCross").click(hideSignInDiv);
            $(".tab-selector_signin").click(showSignIn);
            $(".tab-selector_signup").click(showSignUp);
            $(".header-controls__dash-menu").click(() => {
                var $sidebar = $(".sidebar");
                if ($sidebar.hasClass("slide-in")) {
                    $(".overlay-background").remove();
                    $sidebar.removeClass("slide-in");
                    $sidebar.addClass("slide-out");
                } else {
                    $sidebar.removeClass("slide-out");
                    $("<div>").addClass("overlay-background").appendTo($("body"));
                    $sidebar.addClass("slide-in");
                    $sidebar.focus();
                }
            });
            $(".sidebar").focusout(function () {
                if ($(".header-controls__dash-menu :hover").length > 0 || $(".sidebar :hover").length >
                    0) {
                    return;
                }
                $(".overlay-background").remove();
                $(".sidebar").removeClass("slide-in");
                $(".sidebar").addClass("slide-out");
            });
            $(".header-controls__user-profile").click(() => {
                var $dropdown = $(".header-controls__user-profile_dropdown");
                if ($dropdown.css("display") == "none") {
                    $("<div>").addClass("overlay-background").appendTo($("body"));
                    $dropdown.css("display", "block");
                    $dropdown.focus();
                } else {
                    $dropdown.removeAttr("style");
                    $(".overlay-background").remove();
                }
            });
            $(".header-controls__user-profile_dropdown").focusout(() => {
                if ($(".header-controls__user-profile:hover").length > 0 || $(
                        ".header-controls__user-profile_dropdown a:hover").length > 0) {
                    return;
                }
                $(".header-controls__user-profile_dropdown").removeAttr("style");
                $(".overlay-background").remove();
            });
            $(".header-controls__notifications").click(() => {
                var $notifications = $(".notifications");
                if ($notifications.css("display") == "none") {
                    $notifications.css("display", "block");
                    $notifications.focus();
                    $("<div>").addClass("overlay-background").appendTo($("body"));
                    seenNotifications();
                } else {
                    $notifications.removeAttr("style");
                    $(".overlay-background").remove();
                }
            });
            $(".notifications").focusout(() => {
                if ($(".notifications a:hover").length > 0 || $(".header-controls__notifications:hover")
                    .length >
                    0) {
                    return;
                }
                $(".notifications").removeAttr("style");
                $(".overlay-background").remove();
            });
            $(".header__links_dropdown").click(showSubjectsDropdown);
            $(".header-controls__menu img").click(function (e) {
                if (e.target !== this) return;
                if ($(".header-controls__menu > .nav-dd").length == 0) {
                    $("<div>").addClass("overlay-background").appendTo($("body"));
                    $(".nav-dd").clone(true, true).appendTo($(".header-controls__menu"));
                    showSubjectsDropdown();
                } else {
                    $(".header-controls__menu > .nav-dd").remove();
                    $(".overlay-background").remove();
                }
            });
            $(".nav-dd").focusout(function () {
                if ($(".nav-dd_subject" + ":hover").length || $(".header-controls__menu img:hover")
                    .length) {
                    return;
                }
                $(".header-controls__menu > .nav-dd").remove();
                $(".overlay-background").remove();

                $(".nav-dd").removeAttr("style");
                $(".nav-dd_courses").removeAttr("style");
                removeAllDurations();
                $(".nav-dd_durations").removeAttr("style");
                removeAllSubjects();
                $(".nav-dd_subjects").removeAttr("style");
            });
            $.ajax({
                url: "./SubjectController",
                data: "cmd=seeCourseAndSubjects",
                success: function (response) {
                    $.each(response, function (i, courses) {
                        if (courses.courseSubjects[0] == null)
                            return;
                        $(".nav-dd_courses").append($("<li>").addClass("nav-dd_course")
                            .append($("<a>").attr({
                                onclick: "dropDurations(" + courses
                                    .courseSubjects[0]
                                    .course_id + ")"
                            }).text(courses.courseSubjects[0].name_abbr)));

                        for (var k = 0; k < courses.courseSubjects[0].duration; k++) {
                            $("<li>").addClass("nav-dd_duration nav-dd_duration_" + courses
                                    .courseSubjects[0].course_id).appendTo($(
                                    ".nav-dd_durations"))
                                .append($("<a>").attr({
                                    onclick: "dropSubjects(" + courses
                                        .courseSubjects[0]
                                        .course_id + "," + (k + 1) + ")"
                                }).text(courses.courseSubjects[0].duration_type + " " +
                                    (k + 1)));
                        }
                        $.each(courses.courseSubjects, function (j, subjects) {
                            $("<li>").addClass("nav-dd_subject nav-dd_subject_" +
                                    subjects.course_id + "_" + subjects.duration_no)
                                .appendTo($(".nav-dd_subjects"))
                                .append($("<a>").attr({
                                    href: "./SearchTutor?searchBy=subject&subject_id="+subjects.subject_id,
                                }).text(subjects.subject_code + " - " + subjects.subject_name));
                        });
                    });
                }
            });
            $(document).on("submit", "#signupForm", function (event) {
                event.preventDefault();
                var $form = $(this);
                if ($("#signupForm .user_gender").val() == null) {
                    $("#snackbar").html("Select a gender");
                    showToast();
                    return false;
                }
                showLoading();
                if (isValidUsername($("#signupForm .user_id").val())) {
                    $.post($form.attr("action"), $form.serialize(), function (response) {
                        hideLoading();
                        $("#snackbar").html(response);
                        showToast();
                        console.log(response);
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
                        if (response.includes("Created")) {
                            location.reload();
                        }
                    });
                } else {
                    $("#snackbar").html("Username Already Exists");
                    showToast();
                }
            });
            $(document).on("submit", "#signinForm", function (event) {
                event.preventDefault();
                var $form = $(this);
                showLoading();
                $.post($form.attr("action"), $form.serialize(), function (response) {
                    hideLoading();
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
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
                    if (response.includes("Success")) {
                        location.reload();
                    }
                });
            });
            $(document).ajaxError(function (event, jqxhr, settings, thrownError) {
                $("#snackbar").html("Some Error Occured");
                showToast();
                console.log(jqxhr.responseText);
            });
        });
        
    </script>