<%
	if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }
	if(request.getParameter("admin_id")==null){response.sendRedirect("./Dashboard"); }
%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
    <form action="../AdminController" method="POST" class="main__form main__form_wide" id="editAdminForm">
        <h1 class="main__heading">Update Admin Details</h1>
        <div class="form_group">
            <label for="name">Admin Name</label>
            <input type="text" name="name" id="name" required placeholder="Enter Admin Name ">
        </div>
        <div class="form_group">
            <label for="password">Current Password</label>
            <input type="password" name="password" id="password" required placeholder="Enter Current Password ">
        </div>
        <div class="form_group">
            <label for="new-password">New Password</label>
            <input type="password" name="new-password" id="new-password" required placeholder="Enter New Password ">
        </div>
        <div class="form_group">
            <label for="re-password">Re-enter New Password</label>
            <input type="password" name="re-password" id="re-password" required placeholder="Re Enter New Password ">
        </div>
        <input type="hidden" name="admin_id" id="admin_id">
        <input type="hidden" name="cmd" id="cmd" value="editAdmin">
        <div class="form_group form_group_submit">
            <input type="submit" class="button flat-wide-button" value="Update Admin">
        </div>
    </form>
</main>
<div id="snackbar"></div>
<script src="../app/js/jquery-3.6.0.min.js"></script>
<script src="../app/js/admin-script.js"></script>
<script type="text/javascript">
    $("document").ready(() => {
        showLoading();
        fetchAdminData();
        hideLoading();
    });

    function fetchAdminData() {
        $.ajax({
            url: "../AdminController",
            data: "cmd=editAdmin&admin_id=<%=request.getParameter("admin_id")%>",
            dataType: "json",
            processData: true,
            success: function (res) {
                $("#name").val(res.name);
                $("#admin_id").val(res.admin_id);
            }
        });
    }
    $(document).on("submit", "#editAdminForm", function (event) {
        var $form = $(this);
        if ($("#new-password").val() != $("#re-password").val()) {
            $("#snackbar").html("New Passwords do not match");
            showToast();
            return false;
        }
        showLoading();
        $.post($form.attr("action"), $form.serialize(), function (response) {
            hideLoading();
            $("#snackbar").html(response);
            showToast();
            $form.trigger("reset");
            fetchAdminData();
        });
        event.preventDefault();
    });
    $(document).ajaxError(function (event, jqxhr, settings, thrownError) {
        $("#snackbar").html("Some error occured see the log");
        console.log(thrownError + "\n" + jqxhr.responseText);
        showToast();
    });
</script>
<%@include file="footer.jsp" %>