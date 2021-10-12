<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%> 
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
	<div class="main__preview main__table">
            <table aria-label="Course Data" id="default_table">
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
		<div class="overlaydiv">
            <div id="btnCross" class="header__menu cross">
                <span></span>
                <span></span>
                <span></span>
            </div>
            <h2 class="caption">Subjects</h2>
            <div class="main__table scrollable">
                <table aria-label="Course Preview" id="popup_table">
                    <thead>
                        <tr>
                            <th scope="...">S.No.</th>
                            <th scope="..." id="durationTh">Year/Sem</th>
                            <th scope="...">Subject Name</th>
                            <th scope="...">Subject Code</th>
                            <th scope="...">Action</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
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
        		   		$("<tr>").appendTo($("#default_table tbody"))                   
        	               .append($("<td>").text(index+1))        
        	               .append($("<td>").text(list.course_name))  
        	               .append($("<td>").text(list.name_abbr)) 
        	               .append($("<td>").text(list.duration_type)) 
        	               .append($("<td>").text(list.duration))
        	               .append($("<td>").append($("<a>").attr({href:"#",onclick:"showSubjects("+list.course_id+")"}).text("See Subjects")))
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
function showSubjects(course_id) {
    $.ajax({
           url:"../SubjectController",
           data:"cmd=seeCourseSubjects&course_id="+course_id,
           dataType:"json",
           processData: true,
           success:function(res){
               if(res.length<1){
                   $("#popup_table thead").hide();
                   $(".scrollable").append("<p style=\"text-align:center\" id=\"NoData\">No Subjects Found in this course</p>"); 
                   $(".caption").text("Subjects Not Found");
               }else{
                   $("#popup_table thead").show();
                   $("#NoData").remove();
                   $(".caption").text(res[0].course_name);
               }
        	   $("#popup_table tbody").empty();
        	   var data=""
        	   $.each(res, function(index, list) {  
        		   		$("<tr>").appendTo($("#popup_table tbody"))                   
        	               .append($("<td>").text(index+1))        
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
        	            					   			onclick:"deleteSubject("+list.course_sub_id+","+list.subject_id+","+list.course_id+")"
        	            					   			}).text("Delete")
        	            				   )
        	            			); 
        	   });
           }
       });
       $(".overlaydiv").css("animation","fade-in ease-in 0.3s forwards");
       $(".overlaydiv").css("visibility","visible");
}
function deleteSubject(course_sub_id,subject_id,course_id){
    if(confirm("Are you sure you want to delete this course? ")){ 
    	$.ajax({
    	    url: "../SubjectController",
    	    data:"cmd=deleteSubject&course_sub_id="+course_sub_id+"&subject_id="+subject_id,
    	    success: function(response) {
    	    	$("#snackbar").html(response); 
                showToast();
                showSubjects(course_id);
    	    }
    	});
    }
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
$("#btnCross").click(function (){
	 $(".overlaydiv").css("animation","fade-out ease-in 0.3s forwards");
     $(".overlaydiv").css("visibility","hidden");
});
$( document ).ajaxError(function(event, jqxhr, settings, thrownError ) {
	  $("#snackbar").html("Some error occured see the log"); 
	  console.log(jqxhr.responseText+"\n"+thrownError);
	    showToast(); 
});  
</script>
<%@include file="footer.jsp" %>