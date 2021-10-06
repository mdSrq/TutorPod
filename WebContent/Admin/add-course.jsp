<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%> 
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
        <h1 class="main__heading">Add Course</h1>
        <form action="../CourseController" method="POST" class="main__form" id="addCourseForm">
            <span class="caption">Enter Course Details</span>
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
                    <option value="year">Year</option>
                    <option value="sem">Semester</option>
                </select>
            </div>
            <div class="form_group">
                <label for="duration">Duration</label>
                <input type="number" name="duration" id="duration" required placeholder="Enter course duration e.g. 6">
            </div>
            <input type="hidden" name="cmd" id="cmd" value="addCourse">
            <div class="form_group form_group_submit">
                <input type="submit" class="button flat-wide-button" value="Add Course">
            </div>
        </form>
        <div class="main__preview">
            <table aria-label="Course Preview">
                <caption> Recent Entries </caption>
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
                <tbody>
                   
                </tbody>
            </table>
        </div>
</main>
<div id="snackbar"></div>
<script src="../app/js/jquery-3.6.0.min.js"></script>
<script src="../app/js/admin-script.js"></script>
<script type="text/javascript">
$(document).ready(fetchData);
function fetchData() {
    $.ajax({
           url:"../CourseController",
           data:"cmd=seeCourses",
           dataType:"json",
           processData: true,
           success:function(res){
        	   $("tbody").empty();
        	   var data=""
        	   $.each(res, function(index, list) {   
        		//    data += "<tr><td>"+(index+1)+"</td>"+
        		//    		   "<td>"+list.course_name+"</td>"+
        		//    		   "<td>"+list.name_abbr+"</td>"+
        		//    		   "<td>"+list.duration_type+"</td>"+
        		//    		   "<td>"+list.duration+"</td>"+
        		//    		   "<td class=\"main__preview_action\">"+
        		//    		   "<a href=\"./EditCourse?course_id="+list.course_id+"\" class=\"button small-round-button edit-button\">Edit</a>"+
        		//    		   "<a href=\"../CourseController?cmd=deleteCourse&course_id="+list.course_id+"\" class=\"button small-round-button delete-button\">Delete</a>"+
        		//    		   "</td></tr>";
        		   		$("<tr>").appendTo($("tbody"))                   
        	               .append($("<td>").text(index+1))        
        	               .append($("<td>").text(list.course_name))  
        	               .append($("<td>").text(list.name_abbr)) 
        	               .append($("<td>").text(list.duration_type)) 
        	               .append($("<td>").text(list.duration)) 
        	               .append($("<td>").addClass("main__preview_action")
        	            		   .append($("<a>").attr({
					        	            			   href:"./EditCourse?course_id="+list.course_id,
					        	            			   class:"button small-round-button edit-button",
					        	            			 }).text("Edit")
					        	          )
        	            		   .append($("<a>").attr({
        	            			   					href:"#",
        	            					   			class:"button small-round-button delete-button",
        	            					   			onclick:"deleteCourse("+list.course_id+")"
        	            					   			}).text("Delete")
        	            				   )
        	            			); 
        	   });
             // $("tbody").html(data);  
           }
       });
}
function deleteCourse(course_id){
    if(confirm("Are you sure you want to delete this course? ")){ 
    	$.ajax({
    	    url: "../CourseController",
    	    data:"cmd=deleteCourse&course_id="+course_id,
            processData: true,
    	    success: function(response) {
    	    	$("#snackbar").html(response); 
                showToast();
                fetchData();
    	    }
    	});
    }
}
$(document).on("submit", "#addCourseForm", function(event) {
    var $form = $(this);
    $.post($form.attr("action"), $form.serialize(), function(response) {
        	$("#snackbar").html(response); 
            showToast();
            fetchData();
    });  
    event.preventDefault();
});
$( document ).ajaxError(function(event, jqxhr, settings, thrownError ) {
	  $("#snackbar").html(+jqxhr.responseText); 
	    showToast(); 
}); 
</script>
<%@include file="footer.jsp" %>