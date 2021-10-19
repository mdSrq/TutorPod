<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%> 
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
        <h1 class="main__heading">Add Subject</h1>
        <form action="../SubjectController" method="POST" class="main__form" id="addSubjectForm">
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
            <input type="hidden" name="cmd" id="cmd" value="addSubject">
            <div class="form_group form_group_submit">
                <input type="submit" class="button flat-wide-button" value="Add Subject">
            </div>
        </form>
        <div class="main__preview">
        <a href="./SeeSubjects" class="button float-right-btn">See All Subjects >></a>
            <table aria-label="Course Preview">
                <caption> Recent Entries </caption>
                <thead>
                    <tr>
                        <th scope="...">S.No.</th>
                        <th scope="...">Course Name</th>
                        <th scope="...">Year/Sem</th>
                        <th scope="...">Subject Name</th>
                        <th scope="...">Subject Code</th>
                        <th scope="...">Action</th>
                    </tr>
                </thead>
                <tbody>
                   
                </tbody>
            </table>
        </div>
</main>
<div id="snackbar"></div>
<script src="../app/js/jquery-3.6.0.min.js"></script>
<script src="../app/js/admin-script.js"></script>
<script type="text/javascript">
$("document").ready(()=>{
	showLoading();
	fetchCourseData();
	fetchSubjectData();
	hideLoading();
});
function fetchSubjectData() {
    $.ajax({
           url:"../SubjectController",
           data:"cmd=seeRecentSubjects",
           dataType:"json",
           processData: true,
           success:function(res){
               if(res.length<1){
                   $("thead").hide();
                   $(".float-right-btn").hide();
                   $(".main__preview").append("<p style=\"text-align:center\" id=\"NoData\">No Subjects Found</p>"); 
               }else{
                   $("thead").show();
                   $(".float-right-btn").show();
                   $("#NoData").remove();
               }
        	   $("tbody").empty();
        	   var data=""
        	   $.each(res, function(index, list) {  
        		   		$("<tr>").appendTo($("tbody"))                   
        	               .append($("<td>").text(index+1))        
        	               .append($("<td>").text(list.course_name))  
        	               .append($("<td>").text(list.duration_no))  
        	               .append($("<td>").text(list.subject_name)) 
        	               .append($("<td>").text(list.subject_code)) 
        	               .append($("<td>").addClass("main__preview_action")
        	            		   .append($("<a>").attr({
					        	            			   href:"./EditSubject?course_sub_id="+list.course_sub_id,
					        	            			   class:"button small-round-button edit-button",
					        	            			 }).text("Edit")
					        	          )
        	            		   .append($("<a>").attr({
        	            			   					href:"#",
        	            					   			class:"button small-round-button delete-button",
        	            					   			onclick:"deleteSubject("+list.course_sub_id+","+list.subject_id+")"
        	            					   			}).text("Delete")
        	            				   )
        	            			); 
        	   });
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
function deleteSubject(course_sub_id,subject_id){
    if(confirm("Are you sure you want to delete this course? ")){ 
    	showLoading();
    	$.ajax({
    	    url: "../SubjectController",
    	    data:"cmd=deleteSubject&course_sub_id="+course_sub_id+"&subject_id="+subject_id,
    	    success: function(response) {
    	    	hideLoading();
    	    	$("#snackbar").html(response); 
                showToast();
                fetchSubjectData();
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
    showLoading();
    var courseValue = $("#course_id").val();
    var durationValue = $("#duration_no").val();
    $.post($form.attr("action"), $form.serialize(), function(response) {
    		hideLoading();
        	$("#snackbar").html(response); 
            showToast();
            fetchSubjectData();
            $("#subject_name").val("");
      	 	$("#subject_code").val(""); 
    });  
    event.preventDefault();
});
$( document ).ajaxError(function(event, jqxhr, settings, thrownError ) {
	$("#snackbar").html("Some error occured see the log"); 
	  console.log(thrownError+"\n"+jqxhr.responseText);
	  showToast(); 
}); 
</script>
<%@include file="footer.jsp" %>