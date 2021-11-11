<%
	if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }
	if(request.getParameter("course_id")==null){response.sendRedirect("./SeeCourses"); }
%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
    <form action="../CourseController" method="POST" class="main__form main__form_wide" id="editCourseForm">
        <h1 class="main__heading">Update Course Details</h1>
        <div class="form_group">
            <label for="course_name">Course Name</label>
            <input type="text" name="course_name" id="course_name" required placeholder="Enter course name ">
        </div>
        <div class="form_group">
            <label for="name_abbr">Course Name Abbrivation</label>
            <input type="text" name="name_abbr" id="name_abbr" required placeholder="Enter abbrivation e.g. BCA">
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
            <input type="number" name="duration" id="duration" required placeholder="Enter course duration e.g. 6">
        </div>
        <input type="hidden" name="course_id" id="course_id">
        <input type="hidden" name="cmd" id="cmd" value="editCourse">
        <div class="form_group form_group_submit">
            <input type="submit" class="button flat-wide-button" value="Update Details">
        </div>
    </form>
</main>
<div id="snackbar"></div>
<script src="../app/js/jquery-3.6.0.min.js"></script>
<script src="../app/js/admin-script.js"></script>
<script type="text/javascript">
    showLoading();
    $(document).ready(fetchData());
    hideLoading();

    function fetchData() {
        $.ajax({
            url: "../CourseController",
            data: "cmd=editCourse&course_id=<%=request.getParameter("
            course_id ")%>",
            dataType: "json",
            success: function (res) {
                $("#course_id").val(res.course_id);
                $("#course_name").val(res.course_name);
                $("#name_abbr").val(res.name_abbr);
                $("#duration_type").val(res.duration_type);
                $("#duration").val(res.duration);
            }
        });
    }
    $(document).on("submit", "#editCourseForm", function (event) {
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
    $(document).ajaxError(function (event, jqxhr, settings, thrownError) {
        $("#snackbar").html("Some error occured see the log");
        console.log(jqxhr.responseText + "\n" + thrownError);
        showToast();
    });
</script>
<%@include file="footer.jsp" %>