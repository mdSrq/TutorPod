<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%>
<%@include file="header.jsp" %> <%@include file="sidebar.jsp" %>
<main class="main">
    <h1 class="main__heading">Add Course</h1>
    <form action="../CourseController" method="POST" class="main__form" id="addCourseForm">
        <span class="caption">Enter Course Details</span>
        <div class="form_group">
            <label for="course_name">Course Name</label>
            <input type="text" name="course_name" id="course_name" required placeholder="Enter course name " />
        </div>
        <div class="form_group">
            <label for="name_abbr">Course Name Abbrivation</label>
            <input type="text" name="name_abbr" id="name_abbr" required placeholder="Enter abbrivation e.g. BCA" />
        </div>
        <div class="form_group">
            <label for="duration_type">Duration Type</label>
            <select name="duration_type" id="duration_type">
                <option value="default" selected disabled>Select duration type</option>
                <option value="Year">Year</option>
                <option value="Semester">Semester</option>
            </select>
        </div>
        <div class="form_group">
            <label for="duration">Duration</label>
            <input type="number" name="duration" id="duration" required placeholder="Enter course duration e.g. 6" />
        </div>
        <input type="hidden" name="cmd" id="cmd" value="addCourse" />
        <div class="form_group form_group_submit">
            <input type="submit" class="button flat-wide-button" value="Add Course" />
        </div>
    </form>
    <div class="main__preview">
        <a href="./SeeCourses" class="button float-right-btn">See All Courses >></a>
        <table aria-label="Course Preview">
            <caption>
                Recent Entries
            </caption>
            <thead>
                <tr>
                    <th scope="...">S.No.</th>
                    <th scope="...">Course Name</th>
                    <th scope="...">Name Abbr</th>
                    <th scope="...">Duration Type</th>
                    <th scope="...">Duration</th>
                    <th scope="...">Action</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</main>
<script type="text/javascript">
    showLoading();
    fetchData();
    hideLoading();

    function fetchData() {
        $.ajax({
            url: "../CourseController",
            data: "cmd=seeRecentCourses",
            dataType: "json",
            processData: true,
            success: function (res) {
                if (res.length < 1) {
                    $("thead").hide();
                    $(".float-right-btn").hide();
                    $(".main__preview").append(
                        '<p style="text-align:center" id="NoData">No Courses Found</p>'
                    );
                } else {
                    $("thead").show();
                    $(".float-right-btn").show();
                    $("#NoData").remove();
                }
                $("tbody").empty();
                var data = "";
                $.each(res, function (index, list) {
                    $("<tr>")
                        .appendTo($("tbody"))
                        .append($("<td>").text(index + 1))
                        .append($("<td>").text(list.course_name))
                        .append($("<td>").text(list.name_abbr))
                        .append($("<td>").text(list.duration_type))
                        .append($("<td>").text(list.duration))
                        .append(
                            $("<td>")
                            .addClass("main__preview_action")
                            .append(
                                $("<a>")
                                .attr({
                                    href: "./EditCourse?course_id=" + list.course_id,
                                    class: "button small-round-button edit-button",
                                })
                                .text("Edit")
                            )
                            .append(
                                $("<a>")
                                .attr({
                                    href: "#",
                                    class: "button small-round-button delete-button",
                                    onclick: "deleteCourse(" + list.course_id + ")",
                                })
                                .text("Delete")
                            )
                        );
                });
            },
        });
    }

    function deleteCourse(course_id) {
        if (confirm("Are you sure you want to delete this course? ")) {
            showLoading();
            $.ajax({
                url: "../CourseController",
                data: "cmd=deleteCourse&course_id=" + course_id,
                success: function (response) {
                    hideLoading();
                    $("#snackbar").html(response);
                    showToast();
                    fetchData();
                },
            });
        }
    }
    $(document).on("submit", "#addCourseForm", function (event) {
        var $form = $(this);
        if ($("#duration_type").val() == null) {
            $("#snackbar").html("Select Duration Type");
            showToast();
            return false;
        }
        showLoading();
        $.post($form.attr("action"), $form.serialize(), function (response) {
            hideLoading();
            $("#snackbar").html(response);
            showToast();
            fetchData();
            $form.trigger("reset");
        });
        event.preventDefault();
    });
</script>
<%@include file="footer.jsp" %>