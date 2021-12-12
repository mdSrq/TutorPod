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
                <%
                	String subject_id="";
                	String keyword="";
                	if(request.getParameter("searchBy")!=null) {
                		String searchBy = request.getParameter("searchBy");
                		if(searchBy.equals("subject"))
                			subject_id = request.getParameter("subject_id");
                		else if(searchBy.equals("keyword"))
                			keyword = request.getParameter("keyword");
                	}
                %>
                <div class="search__bar">
                    <input type="search" name="keyword" id="keyword" placeholder="Search by Tutor Name, Subject Code or Name" value="<%=keyword%>">
                    <a href="#" id="searchBtn"><img src="./images/search.png" alt=""></a>
                </div>
               	<input type="hidden" name="subject_id" id="subject_id" value="<%=subject_id%>">
               	<input type="hidden" name="cmd" value="searchTutor">
            </form>
        </section>
        <section class="search__results_container">
        </section>
        <div class="main__form_overlayform search__booking" tabindex="-1">
            <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
        <h2 class="main__sub-heading">Book Lessons</h2>

            <div class="search__booking_tutor">
                <label class="search__booking_tutor_label">Selected Tutor</label>
                <div class="search__booking_tutor_img">
                    <img src="" alt="user_pic">
                </div>
                <div class="search__booking_tutor_info">
                    <p class="search__booking_tutor_info_name"></p>
                </div>
            </div>
            <form action="./TutorController" method="post" class="search__booking_form">
                <div class="form-unit-half-container">
                    <div class="form-unit form-unit-half">
                        <label for="subject_id">Subject</label>
                        <select name="subject_id" id="booking_subject_id" class="input-with-icon input-with-icon_no-icon">
                            <option value="default" selected disabled>Select Subject</option>
                        </select>
                    </div>
                    <div class="form-unit form-unit-half">
                        <label for="price">Price (1 Hr)</label>
                        <input type="text" readonly class="input-with-icon input-with-icon_no-icon" name="price"
                            placeholder="Price per hour" id="pricePerHour" required />
                    </div>
                </div>
                <div class="form-unit-half-container">
                    <div class="form-unit form-unit-half">
                        <label>Lesson Length (Hr)</label>
                        <input type="number" class="input-with-icon input-with-icon_no-icon" name="duration"
                            placeholder="Enter Length (in Hours)" required />
                    </div>
                    <div class="form-unit form-unit-half">
                        <label>No. Of Lessons</label>
                        <input type="number" class="input-with-icon input-with-icon_no-icon" name="no_of_lesson"
                            placeholder="Enter Number of Lessons" required />
                    </div>
                    <input type="hidden" name="tutor_id" id="tutor_id">
                    <input type="hidden" name="cmd" value="addBooking">
                    <input type="submit" class="button flat-wide-button" value="Book Lesson">
                </div>
            </form>
        </div>
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
                    $("<li>").addClass("search__selector_course").prop("id", courses.courseSubjects[
                            0].name_abbr).appendTo($(".search__selector_courses"))
                        .append($("<span>").addClass("course_text").text(courses.courseSubjects[0]
                            .name_abbr))
                        .append($("<ul>").addClass("search__selector_durations"));
                    var durationCount = courses.courseSubjects[0].duration_no;
                    var duration = $("<li>").addClass("search__selector_duration")
                        .append($("<span>").addClass("duration_text").text(courses.courseSubjects[0]
                            .duration_type + " " + courses.courseSubjects[0].duration_no))
                        .append($("<ul>").addClass("search__selector_subjects"));
                    $.each(courses.courseSubjects, function (j, subjects) {
                        if (subjects.duration_no != durationCount) {
                            duration.appendTo($("#" + subjects.name_abbr +
                                " .search__selector_durations"));
                            durationCount = subjects.duration_no;
                            duration = $("<li>").addClass("search__selector_duration")
                                .append($("<span>").addClass("duration_text").text(subjects
                                    .duration_type + " " + subjects.duration_no))
                                .append($("<ul>").addClass("search__selector_subjects"));
                        }
                        duration.children("ul").append($("<li>").addClass(
                                "search__selector_subject")
                            .append($("<span>")
                                .addClass("subject_text")
                                .attr("onclick", "filterBySubject(" + subjects
                                    .subject_id + ")")
                                .text(subjects.subject_code + " - " + subjects
                                    .subject_name)))
                    });
                    duration.appendTo($("#" + courses.courseSubjects[(courses.courseSubjects
                        .length - 1)].name_abbr + " .search__selector_durations"));
                });
            }
        });
    }

    function filterBySubject(subject_id) {
        $("#subject_id").val(subject_id);
        $("#searchForm").submit();
    }
    var tutors;
    var tutorsMap = new Map();
    function loadAllTutors() {
        showLoading();
        $.ajax({
            url: "./TutorController",
            data: "cmd=loadAllTutors",
            timeout: 800000,
            success: function (response) {
                hideLoading();
                console.log(response);
                tutors = response;
                showResults();
            }
        });
    }

    function showResults() {
        $(".search__results_container").empty().append($("<h1>").addClass("main__heading").text(tutors.length +
            " Tutors Found"));
        $.each(tutors, function (i, tutor) {
            $("<div>").addClass("search__result").appendTo($(".search__results_container"))
                .append($("<div>").addClass("search__result_profile")
                    .append($("<div>").addClass("search__result_profile_img")
                        .append($("<img>").prop({
                            "src": "/TutorPod_Photos/Users/" + tutor.photo,
                            "alt": tutor.fname + " " + tutor.lname + "'s Photo"
                        })))
                    .append($("<p>").addClass("search__result_profile_price").prop("id", "price_tutor_" + tutor
                        .tutor_id))
                    .append($("<div>").addClass("search__result_profile_buttons")
                        .append($("<button>").addClass("flat-button-filled").text("Book Now").attr("onclick",
                            "bookTutor(" + tutor.tutor_id + ")")))
                    .append($("<button>").addClass("flat-button-hallow").text("View Profile").attr("onclick",
                        "viewTutor(" + tutor.tutor_id + ")")))
                .append($("<div>").addClass("search__result_about")
                    .append($("<p>").addClass("search__result_about_name").text(tutor.fname + " " + tutor
                        .lname))
                    .append($("<p>").addClass("search__result_about_info").text(tutor.address.city))
                    .append($("<p>").addClass("search__result_about_sub-heading").text("Teaches"))
                    .append($("<p>").addClass("search__result_about_details").prop("id", "subjects_tutor_" +
                        tutor.tutor_id))
                    .append($("<p>").addClass("search__result_about_sub-heading").text("Speaks"))
                    .append($("<p>").addClass("search__result_about_details").prop("id", "langs_tutor_" + tutor
                        .tutor_id))
                    .append($("<p>").addClass("search__result_about_sub-heading").text("About"))
                    .append($("<p>").addClass("search__result_about_details").text(tutor.bio)))
                .append($("<div>").addClass("search__result_availability")
                    .append($("<h2>").addClass("main__sub-heading").text("Availability"))
                    .append($("<table>").addClass("white-table")
                        .append($("<thead>")
                            .append($("<th>").text("Day"))
                            .append($("<th>").text("From"))
                            .append($("<th>").text("To")))
                        .append($("<tbody>")
                            .append($("<tr>")
                                .append($("<td>").text("Monday"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_from_day_1_tutor_" +
                                    tutor.tutor_id).text("NA"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_to_day_1_tutor_" + tutor
                                    .tutor_id).text("NA")))
                            .append($("<tr>")
                                .append($("<td>").text("Tuesday"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_from_day_2_tutor_" +
                                    tutor.tutor_id).text("NA"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_to_day_2_tutor_" + tutor
                                    .tutor_id).text("NA")))
                            .append($("<tr>")
                                .append($("<td>").text("Wednesday"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_from_day_3_tutor_" +
                                    tutor.tutor_id).text("NA"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_to_day_3_tutor_" + tutor
                                    .tutor_id).text("NA")))
                            .append($("<tr>")
                                .append($("<td>").text("Thursday"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_from_day_4_tutor_" +
                                    tutor.tutor_id).text("NA"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_to_day_4_tutor_" + tutor
                                    .tutor_id).text("NA")))
                            .append($("<tr>")
                                .append($("<td>").text("Friday"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_from_day_5_tutor_" +
                                    tutor.tutor_id).text("NA"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_to_day_5_tutor_" + tutor
                                    .tutor_id).text("NA")))
                            .append($("<tr>")
                                .append($("<td>").text("Saturday"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_from_day_6_tutor_" +
                                    tutor.tutor_id).text("NA"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_to_day_6_tutor_" + tutor
                                    .tutor_id).text("NA")))
                            .append($("<tr>")
                                .append($("<td>").text("Sunday"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_from_day_7_tutor_" +
                                    tutor.tutor_id).text("NA"))
                                .append($("<td>").addClass("dynamic").prop("id", "time_to_day_7_tutor_" + tutor
                                    .tutor_id).text("NA")))
                        )));
            if(tutor.photo==null)
                $(".search__result_profile_img > img").prop("src","./images/user.png");
            var min_fees = tutor.fees[0].fee;
            var max_fees = 0;
            var feesMap = new Map();
            if(tutor.fees.length>3)
               var moreSubjects = $('<a href="#" onclick="viewTutor(' + tutor.tutor_id + ')"> ' + (tutor.fees.length - 3) +' More Subjects</a>');
            $.each(tutor.fees, function (i, fee) {
                feesMap.set(fee.subject_id,fee);
                if (i > 3) {
                    let title = moreSubjects.prop("title");
                    title+=fee.subject_code+"-"+fee.subject_name+" ";
                    moreSubjects.prop("title",title);
                    if(i===tutor.fees.length-3)
                        $("#subjects_tutor_" + tutor.tutor_id).append('and ').append(moreSubjects);
                    return;
                }
                if (fee.fee < min_fees)
                    min_fees = fee.fee;
                if (fee.fee > max_fees)
                    max_fees = fee.fee;
                $("#subjects_tutor_" + tutor.tutor_id).append(fee.subject_name + "<br>");
            });
            tutor.feesMap = feesMap;
            $("#price_tutor_" + tutor.tutor_id).html("&#8377; " + min_fees + " - &#8377; " + max_fees);
            $.each(tutor.availability, function (i, avail) {
                $("#time_from_day_" + avail.day_of_week + "_tutor_" + tutor.tutor_id).text(avail
                    .time_from);
                $("#time_to_day_" + avail.day_of_week + "_tutor_" + tutor.tutor_id).text(avail.time_to);
            });
            $.each(tutor.languages, function (i, lang) {
                $("#langs_tutor_" + tutor.tutor_id).append(lang[1]);
                if (i == lang.length - 1) {
                    $("#langs_tutor_" + tutor.tutor_id).append(" and ");
                    return;
                }
                if (i == lang.length)
                    return;
                $("#langs_tutor_" + tutor.tutor_id).append(", ");
            });
            tutorsMap.set(tutor.tutor_id,tutor);
        });
        console.log(tutorsMap);
    }

    function showOverlayForm() {
        $("<div>").addClass("overlay-background").css("display", "block").appendTo($("body"));
        $(".main__form_overlayform").css("display", "flex");
        $(".main__form_overlayform").focus();
    }

    function hideOverlayForm() {
        $(".main__form_overlayform").removeAttr("style");
        $(".overlay-background").remove();
    }

    function bookTutor(tutor_id) {
        var tutor = tutorsMap.get(tutor_id);
        if(tutor.photo==null)
            $(".search__booking_tutor_img > img").prop("src","./images/user.png");
        else
            $(".search__booking_tutor_img > img").prop("src","/TutorPod_Photos/Users/"+tutor.photo);
        $("#tutor_id").val(tutor_id);
        $(".search__booking_tutor_info_name").text(tutor.fname+" "+tutor.lname);
        $("#booking_subject_id").empty().append('<option value="default" selected disabled>Select Subject</option>');
        $.each(tutor.fees,function(i,fee){
            $("#booking_subject_id").append($("<option>").prop("value",fee.subject_id).text(fee.subject_name));
        });
        showOverlayForm();
    }
    $(document).ready(() => {
        loadSubjects();
        $(document).on("submit", "#searchForm", function (event) {
            event.preventDefault();
            var form = $(this);
            showLoading();
            $.post("./TutorController", form.serialize(), function (response) {
                hideLoading();
                tutors = response;
                showResults();
            });
        });
        <%if(request.getParameter("searchBy")!=null) {%>
			$("#searchForm").submit();
		<%}else{%>
		loadAllTutors();
		<%}%>
        $(".search__selector").click(function (event) {
            if ($(".search__selector :hover").length > 0)
                return;
            $(this).toggleClass("flip");
            $(".search__selector_courses").toggleClass("grow");
        });
        $(".search__selector").on("click", ".course_text", function (event) {
            $(this).toggleClass("flip");
            $(this).next(".search__selector_durations").toggleClass("grow-limitless");
        });
        $(".search__selector").on("click", ".duration_text", function (event) {
            $(this).toggleClass("flip");
            $(this).next(".search__selector_subjects").toggleClass("grow-limitless");
        });
        $(".search__check").click(function (event) {
            if ($(".search__check :hover").length > 0)
                return;
            $(this).toggleClass("flip");
            $(".checkboxs-container").toggleClass("grow");
        });
        $("input[name=avail_days]").click(() => {
            $("#searchForm").submit();
        });
        $("#searchBtn").click(() => {
            $("#searchForm").submit();
        });
        $(".main__form_overlayform").focusout(function () {
            if ($(".main__form_overlayform :hover").length > 0)
                return;
            hideOverlayForm();
        });
        $("#booking_subject_id").change(function(event){
            var subject_id = parseInt($(this).val());
            var tutor_id = parseInt($("#tutor_id").val());
            var fees = tutorsMap.get(tutor_id).feesMap.get(subject_id);
            $("#pricePerHour").val(fees.fee);
        });
    });
</script>
<%@include file="footer.jsp" %>