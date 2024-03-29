<%if(session.getAttribute("ADMIN")!=null){ response.sendRedirect("./Dashboard"); }%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../app/css/admin-styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">
    <title>TutorPod Admin</title>
</head>

<body>
    <section class="adminLogin flex flex-jc-c flex-ai-c">
        <form class="adminLogin__form" action="../AdminController" method="POST" id="login-form">
            <div class="header__logo adminLogin__form_header">
                <img src="../images/TutorPod1.svg" alt="TutorPod">
                <span class="header__logo_title">Tutor<span class="header__logo_title_part">Pod</span> </span>
            </div>
            <input type="text" class="input-with-icon adminLogin__form_id" name="name" id="name"
                placeholder="Admin Name" required>
            <input type="password" class="input-with-icon adminLogin__form_pass" name="password" id="password"
                placeholder="Password" required>
            <input type="hidden" name="cmd" id="cmd" value="login">
            <input type="submit" class="button flat-wide-button" value="Login">
        </form>
    </section>
    <div id="snackbar"></div>
</body>
<script src="../app/js/jquery-3.6.0.min.js"></script>
<script src="../app/js/admin-script.js"></script>
<script>
    $(document).on("submit", "#login-form", function (event) {
        var $form = $(this);
        $.post($form.attr("action"), $form.serialize(), function (response) {
            if (response.includes("Success")) {
                $(location).prop('href', './Dashboard');
            } else {
                $("#snackbar").html(response);
                showToast();
            }
        });
        event.preventDefault();
    });
    $(document).ajaxError(function (event, jqxhr, settings, thrownError) {
        $("#snackbar").html(jqxhr.responseText);
        showToast();
    });
</script>

</html>