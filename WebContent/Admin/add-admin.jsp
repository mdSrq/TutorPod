<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%> 
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
        <h1 class="main__heading">Add Admin</h1>
        <form action="../AdminController" method="POST" class="main__form" id="addAdminForm">
            <span class="caption">Enter Admin Details</span>
            <div class="form_group">
                <label for="name">Admin Name</label>
                <input type="text" name="name" id="name" required placeholder="Enter Admin Name ">
            </div>
            <div class="form_group">
                <label for="password">Password</label>
                <input type="password" name="password" id="password" required placeholder="Enter Password ">
            </div>
            <div class="form_group">
                <label for="re-password">Re-enter Password</label>
                <input type="password" name="re-password" id="re-password" required placeholder="Re Enter Password ">
            </div>
            <input type="hidden" name="cmd" id="cmd" value="addAdmin">
            <div class="form_group form_group_submit">
                <input type="submit" class="button flat-wide-button" value="Add Admin">
            </div>
        </form>
        <div class="main__preview">
        <a href="./SeeAdmins" class="button float-right-btn">See All Admins >></a>
            <table aria-label="Course Preview">
                <caption> Recent Entries </caption>
                <thead>
                    <tr>
                        <th scope="...">S.No.</th>
                        <th scope="...">Admin Name</th>
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
	fetchAdminData();
	hideLoading();
});
function fetchAdminData() {
    $.ajax({
           url:"../AdminController",
           data:"cmd=seeRecentAdmins",
           dataType:"json",
           processData: true,
           success:function(res){
        	   $("tbody").empty();
        	   $.each(res, function(index, list) {  
        		   		$("<tr>").appendTo($("tbody"))                   
        	               .append($("<td>").text(index+1))        
        	               .append($("<td>").text(list.name))
        	               .append($("<td>").addClass("main__preview_action")
        	            		   .append($("<a>").attr({
					        	            			   href:"./EditAdmin?admin_id="+list.admin_id,
					        	            			   class:"button small-round-button edit-button",
					        	            			 }).text("Edit")
					        	          )
        	            		   .append($("<a>").attr({
        	            			   					href:"#",
        	            					   			class:"button small-round-button delete-button",
        	            					   			onclick:"deleteAdmin("+list.admin_id+")"
        	            					   			}).text("Delete")
        	            				   )
        	            			); 
        	   });
        	   if(res.length<2)
        		   $(".delete-button").remove();
           }
       });
}
function deleteAdmin(admin_id){
	showLoading();
    if(confirm("Are you sure you want to delete this course? ")){ 
    	$.ajax({
    	    url: "../AdminController",
    	    data:"cmd=deleteAdmin&admin_id="+admin_id,
    	    success: function(response) {
    	    	hideLoading();
    	    	$("#snackbar").html(response); 
                showToast();
                fetchAdminData();
    	    }
    	});
    }
}
$(document).on("submit", "#addAdminForm", function(event) {
    var $form = $(this);
    if($("#password").val()!=$("#re-password").val()){
        $("#snackbar").html("Passwords do not match");
        showToast();
        return false; 
    }
    showLoading();
    $.post($form.attr("action"), $form.serialize(), function(response) {
    		hideLoading();
        	$("#snackbar").html(response); 
            showToast();
            $form.trigger("reset");
            fetchAdminData();
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