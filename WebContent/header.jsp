<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
            <a href="/" class="header__logo flex flex-ai-c">
                <img src="./images/TutorPod1.svg" alt="TutorPod" />
                <span class="header__logo_title">Tutor<span class="header__logo_title_part">Pod</span>
                </span>
            </a>
            <a href="#" id="btnHamburger" class="header__menu hide-for-desktop">
                <span></span>
                <span></span>
                <span></span>
            </a>
            <div class="header__links hide-for-mobile">
                <a href="#" class="underlined header__links_dropdown">Subjects <span class="dropdown-arrow">></span></a>
                <a href="#" class="underlined">Apply to Teach</a>
                <a href="#" class="underlined">Search Tutors</a>
                <a href="#" class="underlined">Study Resources</a>
                <div class="nav-dd" tabindex="99">
                    <ul class="nav-dd_courses scrollable">
                    </ul>
                    <ul class="nav-dd_durations">
                    </ul>
                    <ul class="nav-dd_subjects scrollable">
                    </ul>
                </div>
            </div>
            <a href="#" class="button hide-for-mobile" id="signinBtn">Sign In</a>
        </nav>
        <div class="overlay toggle-on"></div>
        <div class="header__overlay_menu hide-for-desktop toggle-on">
            <a href="http://">Home</a>
            <a href="http://">Apply to Teach</a>
            <a href="http://">Other1</a>
            <a href="http://">Other2</a>
            <a href="#" id="signinBtnNav">Sign In</a>
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
                        <span href="#" class="tab-selector_signin">Sign In</span>
                        <span href="#" class="tab-selector_signup">New Account</span>
                    </div>
                    <div class="signin">
                        <form action="./UserController" method="post" id="signinForm">
                            <input type="text" class="input-with-icon user_id" name="username" id="username"
                                placeholder="Username or email address" required />
                            <input type="password" class="input-with-icon user_pass" name="password" id="password"
                                placeholder="Password" required />
                            <input type="hidden" name="cmd" id="cmd" value="signin" />
                            <input type="submit" class="button flat-wide-button" value="Sign In" />
                        </form>
                        <p><a href="#">Forgot Password ?</a></p>
                    </div>
                    <div class="signup">
                        <form action="./UserController" method="post" id="signupForm">
                            <input type="text" class="input-with-icon user_id" name="username" id="username"
                                placeholder="Enter Username" required />
                            <input type="text" class="input-with-icon user_name user_fname" name="fname" id="fname"
                                placeholder="Enter First Name" required />
                            <input type="text" class="input-with-icon user_name user_lname" name="lname" id="lname"
                                placeholder="Enter Last Name" required />
                            <input type="password" class="input-with-icon user_pass" name="password" id="password"
                                placeholder="Enter Password" required />
                            <select name="gender" id="gender" class="input-with-icon user_gender">
                                <option value="default" selected disabled>Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                            <input type="text" class="input-with-icon user_email" name="email_id" id="email_id"
                                placeholder="Enter Email Adderss" required />
                            <input type="tel" class="input-with-icon user_tel" name="mobile_no" id="mobile_no"
                                placeholder="Enter Mobile Number" required />
                            <input type="hidden" name="cmd" id="cmd" value="signup" />
                            <input type="submit" class="button flat-wide-button" value="Sign Up" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div id="snackbar">
    </div>
    <script src="./app/js/jquery-3.6.0.min.js"></script>
    <script src="./app/js/script.js"></script>
    <script>
        $(document).ready(showSignIn);
        $("#signinBtn").click(showSignInDiv);
        $("#signinBtnNav").click(showSignInDiv);
        $("#btnCross").click(hideSignInDiv);
        $(".tab-selector_signin").click(showSignIn);
        $(".tab-selector_signup").click(showSignUp);
        $(".header__links_dropdown").click(() => {
            $(".nav-dd").css("display", "block");
            $(".nav-dd_courses").css("display", "block");
            $(".nav-dd").focus();
        });
        $(".nav-dd").focusout(function () {
            if ($(".nav-dd_subject" + ":hover").length) {
                return;
            }
            $(".nav-dd").removeAttr("style");
            $(".nav-dd_courses").removeAttr("style");
            removeAllDurations();
            $(".nav-dd_durations").removeAttr("style");
            removeAllSubjects();
            $(".nav-dd_subjects").removeAttr("style");
        });

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
        $.ajax({
            url: "./SubjectController",
            data: "cmd=seeCourseAndSubjects",
            success: function (response) {
                console.log(response);
                $.each(response, function (i, courses) {
                    if (courses.courseSubjects[0] == null)
                        return;
                    $(".nav-dd_courses").append($("<li>").addClass("nav-dd_course")
                        .append($("<a>").attr({
                            onclick: "dropDurations(" + courses.courseSubjects[0]
                                .course_id + ")"
                        }).text(courses.courseSubjects[0].name_abbr)));

                    for (var k = 0; k < courses.courseSubjects[0].duration; k++) {
                        $("<li>").addClass("nav-dd_duration nav-dd_duration_" + courses
                                .courseSubjects[0].course_id).appendTo($(".nav-dd_durations"))
                            .append($("<a>").attr({
                                onclick: "dropSubjects(" + courses.courseSubjects[0]
                                    .course_id + "," + (k + 1) + ")"
                            }).text(courses.courseSubjects[0].duration_type + " " + (k + 1)));
                    }
                    $.each(courses.courseSubjects, function (j, subjects) {
                        $("<li>").addClass("nav-dd_subject nav-dd_subject_" + subjects
                                .course_id + "_" + subjects.duration_no).appendTo($(
                                ".nav-dd_subjects"))
                            .append($("<a>").attr({
                                href: "./TutorController?cmd=searchBySubject&course_id=" +
                                    subjects.course_id + "&duration_no=" + subjects
                                    .duration_no + "&subject_id=" + subjects
                                    .subject_id,
                            }).text(subjects.subject_code + " - " + subjects
                                .subject_name));
                    });
                });
            }
        });

        function dropDurations(course_id) {
            $(".nav-dd_durations").css("display", "block");
            removeAllDurations();
            removeAllSubjects();
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
        $(document).ajaxError(function (event, jqxhr, settings, thrownError) {
            console.log(jqxhr.responseText + "\n" + thrownError);
        });
        $(document).on("submit", "#signupForm", function (event) {
            var $form = $(this);
            if ($("#gender").val() == null) {
                $("#snackbar").html("Select a gender");
                showToast();
                return false;
            }
            showLoading();
            $.post($form.attr("action"), $form.serialize(), function (response) {
                hideLoading();
                $("#snackbar").html(response);
                showToast();
                console.log(response);
                $form.trigger("reset");
            });
            event.preventDefault();
        });
        $(document).on("submit", "#signinForm", function (event) {
            var $form = $(this);
            showLoading();
            $.post($form.attr("action"), $form.serialize(), function (response) {
                hideLoading();
                $("#snackbar").html(response);
                showToast();
                console.log(response);
                fetchBankAccData();
                $form.trigger("reset");
            });
            event.preventDefault();
        });
    </script>