<%
	if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }
	if(request.getParameter("course_sub_id")==null){response.sendRedirect("./Dashboard"); } 
%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
        <h1 class="main__heading">Update Subject Details</h1>
        <form action="../SubjectController" method="POST" class="main__form main__form_wide" id="editSubjectForm">
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
            <input type="hidden" name="course_sub_id" id="course_sub_id">
            <input type="hidden" name="subject_id" id="subject_id">
            <input type="hidden" name="cmd" id="cmd" value="editSubject">
            <div class="form_group form_group_submit">
                <input type="submit" class="button flat-wide-button" value="Update Subject">
            </div>
        </form>
</main>
<div id="snackbar"></div>
<script src="../app/js/jquery-3.6.0.min.js"></script>
<script src="../app/js/admin-script.js"></script>
<script type="text/javascript">
$("document").ready(()=>{
	fetchCourseData();
	fetchSubjectData();
});
function fetchSubjectData() {
    $.ajax({
           url:"../SubjectController",
           data:"cmd=editSubject&course_sub_id=<%=request.getParameter("course_sub_id")%>",
           dataType:"json",
           processData: true,
           success:function(res){
        	  $("#course_id option[value=\""+res.course_id+"\"]").prop('selected', true);
        	  loadDurations();
        	  $("#duration_no option[value=\""+res.duration_no+"\"]").prop('selected', true);
        	  $("#duration_no_label").text(res.duration_type);
        	  $("#subject_name").val(res.subject_name);
        	  $("#subject_code").val(res.subject_code);
        	  $("#course_sub_id").val(res.course_sub_id);
        	  $("#subject_id").val(res.subject_id);
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
    loadDurations();
});
function loadDurations(){
	var course_id = parseInt($("#course_id").val());
    $("#duration_no_label").text(courseDurationTypeMap.get(course_id));
    $("#duration_no").empty();
    $("#duration_no").append($("<option>").attr({selected:true,disabled:true}).text("Select "+courseDurationTypeMap.get(course_id)));
    for(i=1;i<=courseDurationMap.get(course_id);i++){
        $("#duration_no").append($("<option>").val(i).text(i));
    }
}
$(document).on("submit", "#editSubjectForm", function(event) {
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
    $.post($form.attr("action"), $form.serialize(), function(response) {
        	$("#snackbar").html(response); 
            showToast();
            fetchCourseData();
            fetchSubjectData();
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