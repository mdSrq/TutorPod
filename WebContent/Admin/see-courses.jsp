<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%> 
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
	<div class="main__preview main__table">
            <table aria-label="Course Data">
                <h1 class="main__heading">Courses Details</h1>
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
                    <tr>
                        <td>1</td>
                        <td>Bachelor Of Computer Application</td>
                        <td>BCA</td>
                        <td>Semester</td>
                        <td>6</td>
                        <td class="main__preview_action">
                            <a href="#" class="button small-round-button edit-button">Edit</a>
                            <a href="#" class="button small-round-button delete-button">Delete</a>
                        </td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>Bachelor Of Computer Application</td>
                        <td>BCA</td>
                        <td>Semester</td>
                        <td>6</td>
                        <td class="main__preview_action">
                            <a href="#" class="button small-round-button edit-button">Edit</a>
                            <a href="#" class="button small-round-button delete-button">Delete</a>
                        </td>
                    </tr>
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
    	$.post("../CourseController","cmd=deleteCourse&course_id="+course_id, function(response) {
            	$("#snackbar").html(response); 
                showToast();
        });
    }
}
$( document ).ajaxError(function(event, jqxhr, settings, thrownError ) {
	  $("#snackbar").html("ShitWentDown Ya'll "+jqxhr.responseText); 
	    showToast(); 
}); 
</script>
<%@include file="footer.jsp" %>