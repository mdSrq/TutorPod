<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%> 
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
        <h1 class="main__heading">Add Subject</h1>
        <form action="../SubjectController" method="POST" class="main__form" id="editSubjectForm">
            <span class="caption">Enter Subject Details</span>
            <div class="form_group">
                <label for="course_id">Course</label>
                <select name="course_id" id="course_id">
                    <option value="default" selected disabled>Select Course</option>
                </select>
            </div>
            <div class="form_group">
                <label for="duration_no" id="duration_no_label">Year / Semester</label>
                <select name="duration_no" id="duration_no">
                    <option value="default" selected disabled>Select Year/Semester </option>
                </select>
            </div>
            <div class="form_group">
                <label for="subject_name">Subject Name</label>
                <input type="text" name="subject_name" id="subject_name" required placeholder="Enter subject name">
            </div>
            <div class="form_group">
                <label for="subject_code">Subject Code</label>
                <input type="text" name="subject_code" id="subject_code" required placeholder="Enter subject code e.g. BCS012">
            </div>
            <input type="hidden" name="cmd" id="cmd" value="editSubject">
            <div class="form_group form_group_submit">
                <input type="submit" class="button flat-wide-button" value="Add Subject">
            </div>
        </form>
</main>
<div id="snackbar"></div>
<script src="../app/js/jquery-3.6.0.min.js"></script>
<script src="../app/js/admin-script.js"></script>
<script type="text/javascript">
fetchSubjectData();
fetchCourseData();
function fetchSubjectData() {
    $.ajax({
           url:"../SubjectController",
           data:"cmd=editSubject&course_sub_id=<%=request.getParameter("course_sub_id")%>",
           dataType:"json",
           processData: true,
           success:function(res){
        	  
        	  
           }
       });
}
const courseDurationMap = new Map();
const courseDurationTypeMap = new Map();
function fetchCourseData() {
    $.ajax({
           url:"../CourseController",
           data:"cmd=seeCourses",
           dataType:"json",
           success:function(res){
        	   $("#course_id").empty();
        	   $("#course_id").append($("<option>").attr({selected:true,disabled:true}).text("Select a course"));
        	   $("#duration_no").empty();
        	   $("#duration_no").append($("<option>").attr({selected:true,disabled:true}).text("Select Year/Sem"));
        	   var data=""
        	   $.each(res, function(index, list) {   
        		   $("#course_id").append($("<option>").val(list.course_id).text(list.name_abbr+" ("+list.course_name+")"));
        		   courseDurationMap.set(list.course_id,list.duration);
        		   courseDurationTypeMap.set(list.course_id,""+list.duration_type);
        	   });
           }
       });
}
$("#course_id").change(function(){
    var course_id = parseInt($("#course_id").val());
    $("#duration_no_label").text(courseDurationTypeMap.get(course_id));
    $("#duration_no").empty();
    $("#duration_no").append($("<option>").attr({selected:true,disabled:true}).text("Select "+courseDurationTypeMap.get(course_id)));
    for(i=1;i<=courseDurationMap.get(course_id);i++){
        $("#duration_no").append($("<option>").val(i).text(i));
    }
});
function deleteSubject(course_sub_id,subject_id){
    if(confirm("Are you sure you want to delete this course? ")){ 
    	$.ajax({
    	    url: "../SubjectController",
    	    data:"cmd=deleteSubject&course_sub_id="+course_sub_id+"&subject_id="+subject_id,
    	    success: function(response) {
    	    	$("#snackbar").html(response); 
                showToast();
                fetchSubjectData();
                fetchCourseData();
    	    }
    	});
    }
}
$(document).on("submit", "#addSubjectForm", function(event) {
    var $form = $(this);
    if($("#course_id").val()==null){
        $("#snackbar").html("Select Course");
        showToast();
        return false; 
    }
    if($("#duration_no").val()==null){
        $("#snackbar").html("Select "+ $("#duration_no_label").text());
        showToast();
        return false; 
    }
    var courseValue = $("#course_id").val();
    var courseText = $("#course_id").text();
    var durationValue = $("#duration_no").val();
    var durationLabel = $("#duration_no_label").text();
    $.post($form.attr("action"), $form.serialize(), function(response) {
        	$("#snackbar").html(response); 
            showToast();
            fetchSubjectData();
            fetchCourseData();
            $form.trigger("reset");
            $("#course_id").val(courseValue).text(courseText);
            $("#duration_no").val(durationValue).text(durationValue);
            $("#duration_no_label").text(durationLabel);
    });  
    event.preventDefault();
});
$( document ).ajaxError(function(event, jqxhr, settings, thrownError ) {
	$("#snackbar").html("Some error occured see the log"); 
	  console.log(jqxhr.responseText+"\n"+thrownError);
	    showToast(); 
}); 
</script>
<%@include file="footer.jsp" %>