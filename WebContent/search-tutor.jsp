<%@include file="header.jsp" %>
<main>
        <section class="search__container container">
            <form action="./TutorController" method="post" id="searchForm">
                <div class="search__selector" tabindex="5">
                    Select Subject
                    <ul class="search__selector_courses scrollable">
                    </ul>
                </div>
                <div class="search__check" tabindex="5">
                    Select Availability
                    <div class="checkboxs-container">
                        <label class="check-container">Monday
                            <input type="checkbox" name="avail_days" value="1" id="day_of_week_1">
                            <span class="check"></span>
                        </label>
                        <label class="check-container">Tuesday
                            <input type="checkbox" name="avail_days" value="2" id="day_of_week_2">
                            <span class="check"></span>
                        </label>
                        <label class="check-container">Wednesday
                            <input type="checkbox" name="avail_days" value="3" id="day_of_week_3">
                            <span class="check"></span>
                        </label>
                        <label class="check-container">Thursday
                            <input type="checkbox" name="avail_days" value="4" id="day_of_week_4">
                            <span class="check"></span>
                        </label>
                        <label class="check-container">Friday
                            <input type="checkbox" name="avail_days" value="5" id="day_of_week_5">
                            <span class="check"></span>
                        </label>
                        <label class="check-container">Saturday
                            <input type="checkbox" name="avail_days" value="6" id="day_of_week_6">
                            <span class="check"></span>
                        </label>
                        <label class="check-container">Sunday
                            <input type="checkbox" name="avail_days" value="7" id="day_of_week_7">
                            <span class="check"></span>
                        </label>
                    </div>
                </div>
                <div class="search__bar">
                    <input type="text" name="keyword" id="keyword" placeholder="Search by tutor name">
                    <a href="#" id="searchBtn"><img src="./images/search.png" alt=""></a>
                </div>
               	<input type="hidden" name="subject_id" id="subject_id">
               	<input type="hidden" name="cmd" value="searchTutor">
            </form>
        </section>
        <section class="search__results_container">
            <h1 class="main__heading">Found the best 15 tutors for you</h1>
            <div class="search__result">
                <div class="search__result_profile">
                    <div class="search__result_profile_img">
                        <img src="./images/user.png" alt="Tutor Photo">
                    </div>
                    <p class="search__result_profile_price"> 500/hr</p>
                    <div class="search__result_profile_buttons">
                        <button class="flat-button-filled">Book Now</button>
                        <button class="flat-button-hallow">View Profile</button>
                    </div>
                </div>
                <div class="search__result_about">
                    <p class="search__result_about_name">Mohd Shariq</p>
                    <p class="search__result_about_info">Delhi | 10 Students | 24 Lessons</p>
                    <p class="search__result_about_sub-heading">Teaches</p>
                    <p class="search__result_about_details">English, Discrete Mathematics, C++ and more</p>
                    <p class="search__result_about_sub-heading">Speaks</p>
                    <p class="search__result_about_details">Hindi English Urdu</p>
                    <p class="search__result_about_sub-heading">About</p>
                    <p class="search__result_about_details">A BCA student with diploma in computer engineering and love for teaching.</p>
                </div>
                <div class="search__result_availbality">
                    <h2 class="main__sub-heading">Availability</h2>
                    <table class="white-table">
                        <thead>
                            <th>Day</th>
                            <th>From</th>
                            <th>To</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Monday</td>
                                <td class="dynamic" id="time_from_day_1">06:00 PM</td>
                                <td class="dynamic" id="time_to_day_1">10:00 PM</td>
                            </tr>
                            <tr>
                                <td>Tuesday</td>
                                <td class="dynamic" id="time_from_day_2">06:00 PM</td>
                                <td class="dynamic" id="time_to_day_2">10:00 PM</td>
                            </tr>
                            <tr>
                                <td>Wednesday</td>
                                <td class="dynamic" id="time_from_day_3">06:00 PM</td>
                                <td class="dynamic" id="time_to_day_3">10:00 PM</td>
                            </tr>
                            <tr>
                                <td>Thursday</td>
                                <td class="dynamic" id="time_from_day_4">06:00 PM</td>
                                <td class="dynamic" id="time_to_day_4">10:00 PM</td>
                            </tr>
                            <tr>
                                <td>Friday</td>
                                <td class="dynamic" id="time_from_day_5">06:00 PM</td>
                                <td class="dynamic" id="time_to_day_5">10:00 PM</td>
                            </tr>
                            <tr>
                                <td>Saturday</td>
                                <td class="dynamic" id="time_from_day_6">09:00 AM</td>
                                <td class="dynamic" id="time_to_day_6">10:00 PM</td>
                            </tr>
                            <tr>
                                <td>Sunday</td>
                                <td class="dynamic" id="time_from_day_7">09:00 AM</td>
                                <td class="dynamic" id="time_to_day_7">10:00 PM</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
    </main>
<script type="text/javascript">
    function loadSubjects() {
        $.ajax({
            url: "./SubjectController",
            data: "cmd=seeCourseAndSubjects",
            success: function (response) {
                $.each(response, function (i, courses) {
                    if (courses.courseSubjects[0] == null)
                        return;
                    $("<li>").addClass("search__selector_course").prop("id",courses.courseSubjects[0].name_abbr).appendTo($(".search__selector_courses"))
                        .append($("<span>").addClass("course_text").text(courses.courseSubjects[0].name_abbr))
                        .append($("<ul>").addClass("search__selector_durations"));
                    var durationCount = courses.courseSubjects[0].duration_no;
                    var duration = $("<li>").addClass("search__selector_duration")
                                        .append($("<span>").addClass("duration_text").text(courses.courseSubjects[0].duration_type +" "+ courses.courseSubjects[0].duration_no))
                                        .append($("<ul>").addClass("search__selector_subjects"));
                    $.each(courses.courseSubjects, function (j, subjects) {
                        if(subjects.duration_no!=durationCount){
                            duration.appendTo($("#"+subjects.name_abbr+" .search__selector_durations"));
                            durationCount = subjects.duration_no;
                            duration = $("<li>").addClass("search__selector_duration")
                                        .append($("<span>").addClass("duration_text").text(subjects.duration_type + subjects.duration_no))
                                        .append($("<ul>").addClass("search__selector_subjects"));
                        }
                        duration.children("ul").append($("<li>").addClass("search__selector_subject")
                            .append($("<span>")
                                .addClass("subject_text")
                                .attr("onclick","filterBySubject("+subjects.subject_id+")")
                                .text(subjects.subject_code+" - "+subjects.subject_name)))
                    });
                });
            }
        });
    }
    function filterBySubject(subject_id){
        $("#subject_id").val(subject_id);
        var form = $("#searchForm");
        showLoading();
        $.post("./TutorController",form.serialize(),function(response){
            hideLoading();
            console.log(response);
        });
    }
$(document).ready(()=>{
    loadSubjects();
	$(".search__selector").click(function(event){
	    if($(".search__selector :hover").length>0)
	        return;
	    $(this).toggleClass("flip");
	    $(".search__selector_courses").toggleClass("grow");
	});
    $(".search__selector").on("click",".course_text",function(event){
	    $(this).toggleClass("flip");
	    $(this).next(".search__selector_durations") .toggleClass("grow");
	});
    $(".search__selector").on("click",".duration_text",function(event){  
	    $(this).toggleClass("flip");
	    $(this).next(".search__selector_subjects") .toggleClass("grow");
	});
    $(".search__check").click(function(event){
	    if($(".search__check :hover").length>0)
	        return;
	    $(this).toggleClass("flip");
	    $(".checkboxs-container").toggleClass("grow");
	});
});
</script>
<%@include file="footer.jsp" %>