<%if(session.getAttribute("ADMIN")==null){ response.sendRedirect("./Login"); }%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<main class="main">
    <h1 class="main__heading">Add Admin Bank Account</h1>
    <form action="../BankAccountController" method="POST" class="main__form" id="addAdminBankAccForm">
        <span class="caption">Enter Bank Details</span>
        <div class="form_group">
            <label for="admin_id">Select Admin</label>
            <select name="admin_id" id="admin_id">
                <option value="default" selected disabled>Select an Admin </option>
            </select>
        </div>
        <div class="form_group">
            <label for="bank_name">Bank Name</label>
            <input type="text" name="bank_name" id="bank_name" required placeholder="Enter bank name ">
        </div>
        <div class="form_group">
            <label for="acc_no">Account Number</label>
            <input type="text" name="acc_no" id="acc_no" required placeholder="Enter account number">
        </div>
        <div class="form_group">
            <label for="holder_name">Account Holder</label>
            <input type="text" name="holder_name" id="holder_name" required placeholder="Enter holder's name">
        </div>
        <div class="form_group">
            <label for="ifsc_code">IFSC Code</label>
            <input type="text" name="ifsc_code" id="ifsc_code" required placeholder="Enter IFSC code">
        </div>
        <div class="form_group">
            <label for="balance">Initial Balance</label>
            <input type="number" name="balance" id="balance" required placeholder="Enter initial balance">
        </div>
        <input type="hidden" name="cmd" id="cmd" value="addAdminBankAcc">
        <div class="form_group form_group_submit">
            <input type="submit" class="button flat-wide-button" value="Add Bank Account">
        </div>
    </form>
    <div class="main__preview">
        <a href="./SeeAdminBankAcc" class="button float-right-btn">See Bank Acc(s) >></a>
        <table aria-label="Course Preview">
            <caption> Recent Entries </caption>
            <thead>
                <tr>
                    <th scope="...">S.No.</th>
                    <th scope="...">Admin Name</th>
                    <th scope="...">Bank Name</th>
                    <th scope="...">Account No.</th>
                    <th scope="...">IFSC Code</th>
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
    showLoading();
    fetchAdminData();
    fetchBankAccData();
    hideLoading();

    function fetchBankAccData() {
        $.ajax({
            url: "../BankAccountController",
            data: "cmd=seeAdminBankAccounts",
            dataType: "json",
            processData: true,
            success: function (res) {
                if (res.length < 1) {
                    $("thead").hide();
                    $(".float-right-btn").hide();
                    $(".main__preview").append(
                        "<p style=\"text-align:center\" id=\"NoData\">No Bank Account Found</p>");
                } else {
                    $("thead").show();
                    $(".float-right-btn").show();
                    $("#NoData").remove();
                }
                $("tbody").empty();
                $.each(res, function (index, list) {
                    $("<tr>").appendTo($("tbody"))
                        .append($("<td>").text(index + 1))
                        .append($("<td>").text(list.name))
                        .append($("<td>").text(list.bank_name))
                        .append($("<td>").text(list.acc_no))
                        .append($("<td>").text(list.ifsc_code))
                        .append($("<td>").addClass("main__preview_action")
                            .append($("<a>").attr({
                                href: "./EditAdminBankAcc?admin_bank_acc_id=" + list
                                    .admin_bank_acc_id,
                                class: "button small-round-button edit-button",
                            }).text("Edit"))
                            .append($("<a>").attr({
                                href: "#",
                                class: "button small-round-button delete-button",
                                onclick: "deleteAcc(" + list.admin_bank_acc_id + ")"
                            }).text("Delete"))
                        );
                });
            }
        });
    }

    function fetchAdminData() {
        $.ajax({
            url: "../AdminController",
            data: "cmd=seeAdmins",
            dataType: "json",
            success: function (res) {
                $("#admin_id").empty();
                $("#admin_id").append($("<option>").attr({
                    selected: true,
                    disabled: true
                }).text("Select an Admin"));
                $.each(res, function (index, list) {
                    $("#admin_id").append($("<option>").val(list.admin_id).text(list.name));
                });
            }
        });
    }

    function deleteAcc(admin_bank_acc_id) {
        if (confirm("Are you sure you want to delete this bank account? ")) {
            showLoading();
            $.ajax({
                url: "../BankAccountController",
                data: "cmd=deleteAdminBankAccount&admin_bank_acc_id=" + admin_bank_acc_id,
                success: function (response) {
                    hideLoading();
                    $("#snackbar").html(response);
                    console.log(response);
                    showToast();
                    fetchBankAccData();
                }
            });
        }
    }
    $(document).on("submit", "#addAdminBankAccForm", function (event) {
        var $form = $(this);
        if ($("#admin_id").val() == null) {
            $("#snackbar").html("Select an Admin");
            showToast();
            return false;
        }
        showLoading();
        $.post($form.attr("action"), $form.serialize(), function (response) {
            hideLoading();
            $("#snackbar").html(response);
            showToast();
            console.log(response);
            fetchBankAccData();
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