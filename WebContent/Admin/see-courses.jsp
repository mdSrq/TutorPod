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
                        <th scope="...">Subjects</th>
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
fetchData();
function fetchData() {
    $.ajax({
           url:"../CourseController",
           data:"cmd=seeCourses",
           dataType:"json",
           success:function(res){
        	   if(res.length<1){
                   $("thead").hide();
                   $(".main__preview").append("<p style=\"text-align:center\" id=\"NoData\">No Courses Found</p>"); 
               }else{
                   $("thead").show();
                   $("#NoData").remove();
               }
        	   $("tbody").empty();
        	   var data=""
        	   $.each(res, function(index, list) {   
        		   		$("<tr>").appendTo($("tbody"))                   
        	               .append($("<td>").text(index+1))        
        	               .append($("<td>").text(list.course_name))  
        	               .append($("<td>").text(list.name_abbr)) 
        	               .append($("<td>").text(list.duration_type)) 
        	               .append($("<td>").text(list.duration))
        	               .append($("<td>").append($("<a>").attr({href:"#",onclick:"showSubjects()"})))
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
$( document ).ajaxError(function(event, jqxhr, settings, thrownError ) {
	  $("#snackbar").html("Some error occured see the log"); 
	  console.log(jqxhr.responseText+"\n"+thrownError);
	    showToast(); 
});  
</script>
<%@include file="footer.jsp" %>