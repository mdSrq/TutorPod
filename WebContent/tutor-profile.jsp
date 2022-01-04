<%@include file="header.jsp" %>
<main>
    <main>
        <div class="profile__container flex flex-jc-sb">
            <div class="profile">
                <div class="profile__header">
                    <div class="search__result_profile">
                        <div class="search__result_profile_img">
                            <img src="./images/user.png" alt="Tutor Photo">
                        </div>
                    </div>
                    <div class="search__result_about">
                        <p class="search__result_about_name" id="tutor_name"></p>
                        <p class="search__result_about_info" id="tutor_location"></p>
                        <p class="search__result_about_sub-heading">Speaks</p>
                        <p class="search__result_about_details" id="tutor_langs"></p>
                        <p class="search__result_about_sub-heading">Hourly Rate</p>
                        <p class="search__result_about_details" id="tutor_price_range"></p>
                    </div>
                </div>
                <div class="profile__body">
                    <section class="profile__body_about">
                        <h2 class="profile__body_about_heading" id="aboutHeading"></h2>
                        <p class="profile__body_about_text" id="aboutText">
                        </p>
                    </section>
                    <section class="profile__body_fees">
                        <h2>Lesson Prices</h2>
                        <table class="white-table" id="feeTable">
                            <thead>
                                <th>Subject Name</th>
                                <th>Price (1 Hr)</th>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </section>
                    <section class="profile__body_avail">
                        <h2>Weekly Availability</h2>
                        <table class="white-table">
                            <thead>
                                <th>Day</th>
                                <th>From</th>
                                <th>To</th>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Monday</td>
                                    <td class="dynamic" id="time_from_day_1">NA</td>
                                    <td class="dynamic" id="time_to_day_1">NA</td>
                                </tr>
                                <tr>
                                    <td>Tuesday</td>
                                    <td class="dynamic" id="time_from_day_2">NA</td>
                                    <td class="dynamic" id="time_to_day_2">NA</td>
                                </tr>
                                <tr>
                                    <td>Wednesday</td>
                                    <td class="dynamic" id="time_from_day_3">NA</td>
                                    <td class="dynamic" id="time_to_day_3">NA</td>
                                </tr>
                                <tr>
                                    <td>Thursday</td>
                                    <td class="dynamic" id="time_from_day_4">NA</td>
                                    <td class="dynamic" id="time_to_day_4">NA</td>
                                </tr>
                                <tr>
                                    <td>Friday</td>
                                    <td class="dynamic" id="time_from_day_5">NA</td>
                                    <td class="dynamic" id="time_to_day_5">NA</td>
                                </tr>
                                <tr>
                                    <td>Saturday</td>
                                    <td class="dynamic" id="time_from_day_6">NA</td>
                                    <td class="dynamic" id="time_to_day_6">NA</td>
                                </tr>
                                <tr>
                                    <td>Sunday</td>
                                    <td class="dynamic" id="time_from_day_7">NA</td>
                                    <td class="dynamic" id="time_to_day_7">NA</td>
                                </tr>
                            </tbody>
                        </table>
                    </section>
                    <section class="profile__body_exps">
                        <h2>Education & Experiences</h2>
                        <div class="profile__body_exps_edu">
                            <h3>Education</h3>
                        </div>
                        <div class="profile__body_exps_work">
                            <h3>Experiences</h3>
                        </div>
                        <div class="profile__body_exps_cert">
                            <h3>Certifications</h3>
                        </div>
                    </section>
                </div>
            </div>
            <div class="profile__buttons">
                <button class="flat-button-filled" id="bookBtn">Book Now</button>
                <button class="flat-button-hallow" id="checkAvailBtn">Check Availability </button>
            </div>
        </div>
    </main>
    <div class="main__form_overlayform search__booking" tabindex="-1" id="bookingOverlay">
            <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
        <h2 class="main__sub-heading">Book Lessons</h2>

            <div class="search__booking_tutor">
                <label class="search__booking_tutor_label">Selected Tutor</label>
                <div class="search__booking_tutor_img">
                    <img src="" alt="user_pic">
                </div>
                <div class="search__booking_tutor_info">
                    <p class="search__booking_tutor_info_name"></p>
                </div>
            </div>
            <form action="./BookingController" method="post" class="search__booking_form" id="bookingForm">
                <div class="form-unit-half-container">
                    <div class="form-unit form-unit-half">
                        <label for="subject_id">Subject</label>
                        <select name="subject_id" id="booking_subject_id" class="input-with-icon input-with-icon_no-icon">
                            <option value="default" selected disabled>Select Subject</option>
                        </select>
                    </div>
                    <div class="form-unit form-unit-half">
                        <label for="price">Price (1 Hr)</label>
                        <input type="text" readonly class="input-with-icon rupee" name="price"
                            placeholder="Price per hour" id="price" required />
                    </div>
                </div>
                <div class="form-unit-half-container">
                    <div class="form-unit form-unit-half">
                        <label>Lesson Length (Hr)</label>
                        <input type="number" class="input-with-icon input-with-icon_no-icon" name="duration"
                            placeholder="Enter Length (in Hours)" id="duration" required />
                    </div>
                    <div class="form-unit form-unit-half">
                        <label>No. Of Lessons</label>
                        <input type="number" class="input-with-icon input-with-icon_no-icon" name="no_of_lesson"
                            placeholder="Enter Number of Lessons" id="no_of_lesson" required />
                    </div>
                    <input type="hidden" name="tutor_id" id="tutor_id">
                    <input type="submit" class="button flat-wide-button" id="bookBtn" value="Book Lesson">
                </div>
            </form>
        </div>
        <div class="main__form_overlayform search__booking" tabindex="-1" id="paymentOverlay">
        <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
        <h2 class="main__sub-heading">Payment</h2>
            <div class="search__booking_walletDiv">
                <span class="search__booking_walletDiv_heading">Wallet Status</span>
                <a class="search__booking_walletDiv_heading_link" href="#">+ Add</a>
                <span class="search__booking_walletDiv_info">
                    <span class="search__booking_walletDiv_text">Amount present in wallet</span>
                    <span class="search__booking_walletDiv_value" id="walletBalance">&#8377; 0</span>
                </span>
                <span class="search__booking_walletDiv_info">
                    <span class="search__booking_walletDiv_text">Payment to be made</span>
                    <span class="search__booking_walletDiv_value" id="showPrice">&#8377; 0</span>
                </span>
                <span class="search__booking_walletDiv_info">
                    <span class="search__booking_walletDiv_text">Balance after payment</span>
                    <span class="search__booking_walletDiv_value" id="afterMath">&#8377; 0</span>
                </span>
            </div>
            <div class="search__booking_summary">
                <span class="search__booking_summary_heading">Booking Summary</span>
                <span class="search__booking_summary_mainItem">
                    <span class="search__booking_summary_mainItem_text" id="mainLessons">2 Lessons</span>
                    <span class="search__booking_summary_mainItem_value" id="mainLessonsPrice">&#8377; 500</span>
                </span>
                <span class="search__booking_summary_details">
                    <span class="search__booking_summary_detail">
                        <span class="search__booking_summary_text">Subject :</span>
                        <span class="search__booking_summary_value" id="subject_name"> BCS-011 - Computer Basics and PC Software</span>
                    </span>
                    <span class="search__booking_summary_detail">
                        <span class="search__booking_summary_text">Price :</span>
                        <span class="search__booking_summary_value" id="detailsPrice"> &#8377; 500</span>
                    </span>
                    <span class="search__booking_summary_detail">
                        <span class="search__booking_summary_text">Duration :</span>
                        <span class="search__booking_summary_value" id="detailsDuration"> 2 Hr</span>
                    </span>
                    <span class="search__booking_summary_detail">
                        <span class="search__booking_summary_text">Lessons Count :</span>
                        <span class="search__booking_summary_value" id="detailsNOL"> 2</span>
                    </span>
                </span>
                <span class="search__booking_summary_mainItem">
                    <span class="search__booking_summary_mainItem_text">TutorPod Fee (2.5%)</span>
                    <span class="search__booking_summary_mainItem_value" id="podFees">&#8377; 25</span>
                </span>
                <span class="search__booking_summary_mainItem total">
                    <span class="search__booking_summary_mainItem_text">Total </span>
                    <span class="search__booking_summary_mainItem_value" id="detailsTotal">&#8377; 525</span>
                </span>
                <form action="./BookingController" method="post" style="width:100%;" id="paymentForm">
                    <input type="hidden" name="cmd" value="addBooking">
                    <input type="hidden" name="tutor_id" id="pay_tutor_id">
                    <input type="hidden" name="subject_id" id="pay_subject_id">
                    <input type="hidden" name="price" id="pay_price">
                    <input type="hidden" name="duration" id="pay_duration">
                    <input type="hidden" name="no_of_lesson" id="pay_no_of_lesson">
                    <input type="submit" class="button flat-wide-button" id="payBtn" value="Book Lesson">
                    <button class="flat-button-hallow" id="backBtn">&lt; Back</button>
                </form>
            </div>
        </div>
        <div class="main__form_overlayform" tabindex="-1" id="addOverlay">
            <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
            <h2 class="main__sub-heading">Add Money </h2>
            <form action="./WalletController" method="post" style="width: 100%;" class="scrollable" id="addMoneyForm">
                <div class="form-unit form-unit-full">
                    <label for="amount">Amount</label>
                    <input type="number" class="input-with-icon input-with-icon rupee" name="amount"
                        placeholder="Enter amount to add" required />
                </div>
                <input type="hidden" name="cmd" value="addMoney">
                <input type="submit" class="button flat-wide-button" value="Add Money to Wallet">
            </form>
        </div>
        <div class="main__form_overlayform search__booking" tabindex="-1" id="successOverlay">
            <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
            <span class="big-green-tick"></span>
            <h1 class="thin-H1 ">Booking Completed!</h1>
        </div>
        <div class="main__form_overlayform main__lesson__overlay scheduleOverlay" tabindex="-1" id="scheduleOverlay">
            <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
            <h2 class="main__sub-heading">Availability</h2>
                <div class="form-unit  form-unit-half">
                    <label for="date">Select Date:</label>
                    <input type="date" name="date" id="date" class="input-with-icon input-with-icon_no-icon" required>
                </div>
                <div class="form-unit form-unit-full" id="scheduleDiv">
                    <div class="main__lesson__overlay_label">
                        <label for=""></label>
                        <div>
                            <span><span class="dot green_unit"></span> Available</span>
                            <span><span class="dot red_unit"></span> Booked</span>
                            <span><span class="dot"></span> Not Available</span>
                        </div>
                    </div>
                    <div class="main__lesson__overlay_avail scrollable">

                    </div>
                </div>
        </div>
</main>
<script type="text/javascript">
    let lessonsMap = new Map();
    let days_of_week = new Array();
    let availMap = new Map();
    let scheduleMap = new Map();
    let feesMap = new Map();
    daysObj = {
        1:"Monday",
        2:"Tuesday",
        3:"Wednesday",
        4:"Thursday",
        5:"Friday",
        6:"Saturday",
        7:"Sunday"
    }
    function loadTutorInfo() {
        showLoading();
        $.ajax({
            url: "./TutorController",
            data: "cmd=loadTutor&tutor_id=<%=request.getParameter("tutor_id")%>",
            timeout: 800000,
            success: function (tutor) {
                hideLoading();
                $("#checkAvailBtn").click(function(e){showScheduleLessonForm(tutor.tutor_id)});
                $("#bookBtn").click(function(e){bookTutor()});
                if (tutor.photo !== undefined) {
                    $(".search__result_profile_img > img").prop("src", "/TutorPod_Photos/Users/" + tutor.photo + ".jpg");
                    $(".search__booking_tutor_img > img").prop("src", "/TutorPod_Photos/Users/" + tutor.photo + ".jpg");
                } else
                    $(".search__booking_tutor_img > img").prop("src", "./images/user.png");
                $("#tutor_name").text(tutor.fname + " " + tutor.lname);
                $("#location").text(tutor.address.city);
                $("#aboutHeading").text("About " + tutor.fname + " " + tutor.lname);
                $("#aboutText").text(tutor.bio);
                <%if (session.getAttribute("USER") != null) {%>
                if (tutor.tutor_id ===<%= ((User)session.getAttribute("USER")).getTutor_id() %>)
        $("#bookBtn").prop("disabled", true).css("cursor", "not-allowed");
                <%}%>
        $("#tutor_id").val(tutor.tutor_id);
    $(".search__booking_tutor_info_name").text(tutor.fname + " " + tutor.lname);
    $("#booking_subject_id").empty().append('<option value="default" selected disabled>Select Subject</option>');
    if (tutor.fees === undefined)
        $("#feeTable").remove();
    else {
        var min_fees = tutor.fees[0].fee;
        var max_fees = 0;
        $.each(tutor.fees, function (i, fee) {
            feesMap.set(fee.subject_id, fee);
            $("<tr>").appendTo($("#feeTable > tbody"))
                .append($("<td>").text(fee.subject_name))
                .append($("<td>").html("&#8377; " + fee.fee));
            if (fee.fee < min_fees)
                min_fees = fee.fee;
            if (fee.fee > max_fees)
                max_fees = fee.fee;
            $("#booking_subject_id").append($("<option>").prop("value", fee.subject_id).text(fee.subject_name));
        });
        $("#tutor_price_range").html("&#8377; " + min_fees + " - &#8377; " + max_fees);
    }
    $.each(tutor.availability, function (i, avail) {
        $("#time_from_day_" + avail.day_of_week).text(avail.time_from);
        $("#time_to_day_" + avail.day_of_week).text(avail.time_to);
    });
    $.each(tutor.languages, function (i, lang) {
        $("#tutor_langs").append(lang[1] + " ");
    });

    $.each(tutor.experiences, function (i, exps) {
        const title = $("<h4>").addClass("profile__body_exps_title").text(exps.title);
        const body = $("<p>").append($("<span>").addClass("profile__body_exps_inst").text(exps.institution))
            .append($("<span>").addClass("profile__body_exps_location").text(exps.location))
            .append($("<span>").addClass("profile__body_exps_period").text(exps.start_year + " - " + exps.end_year))
            .append($("<span>").addClass("profile__body_exps_desc").text(exps.description));
        switch (exps.experience_type) {
            case "Education":
                $(".profile__body_exps_edu").append(title).append(body);
                break;
            case "Certification":
                $(".profile__body_exps_cert").append(title).append(body);
                break;
            case "Work Experience":
                $(".profile__body_exps_work").append(title).append(body);
                break;
        }
    });
    if ($(".profile__body_exps_edu").find(".profile__body_exps_title").length < 1)
        $(".profile__body_exps_edu").remove();
    if ($(".profile__body_exps_cert").find(".profile__body_exps_title").length < 1)
        $(".profile__body_exps_cert").remove();
    if ($(".profile__body_exps_work").find(".profile__body_exps_title").length < 1)
        $(".profile__body_exps_work").remove();
            }
        });
    }
    function bookTutor() {
    	<%if (session.getAttribute("USER") != null) {%>
            showOverlayForm("bookingOverlay");
        <%} else {%>
            showSignInDiv();
        <%}%>
    }
    function preparePayment() {
        showLoading();
        $.ajax({
            url: "./WalletController",
            data: "cmd=loadBalance",
            timeout: 800000,
            success: function (response) {
                hideLoading();
                try {
                    const type = parseFloat(response);
                } catch (e) {
                    $("#snakbar").html("Session Expired Please Login");
                    showToast();
                    return;
                }
                const balance = response.balance;
                const price = parseFloat($("#pay_price").val());
                const duration = parseFloat($("#pay_duration").val());
                const no_of_lesson = parseInt($("#pay_no_of_lesson").val());
                const sub_total = price * duration * no_of_lesson;
                const total = sub_total + (sub_total / 100) * 2.5;
                const subject_id = parseInt($("#pay_subject_id").val());
                const tutor_id = parseInt($("#pay_tutor_id").val());
                if (balance < total) {
                    $(".search__booking_walletDiv_heading").removeClass("green_circle").addClass("red_circle").text("Insufficient Balance in Wallet");
                    $(".search__booking_walletDiv_heading_link").show();
                    $("#payBtn").prop("disabled", true);
                } else {
                    $(".search__booking_walletDiv_heading").removeClass("red_circle").addClass("green_circle").text("Sufficient Balance in Wallet");
                    $(".search__booking_walletDiv_heading_link").hide();
                    $("#payBtn").prop("disabled", false);
                }
                $("#walletBalance").html("&#8377; " + balance);
                $("#showPrice").html("&#8377; " + total);
                $("#afterMath").html("&#8377; " + (balance - total));
                $("#mainLessons").text(no_of_lesson + " Lessons");
                $("#mainLessonsPrice").html("&#8377; " + sub_total);
                $("#subject_name").text(tutorsMap.get(tutor_id).feesMap.get(subject_id).subject_name);
                $("#detailsPrice").html("&#8377; " + price);
                $("#detailsDuration").text(duration + " Hr");
                $("#detailsNOL").text(no_of_lesson);
                $("#podFees").html("&#8377; " + ((sub_total / 100) * 2.5));
                $("#detailsTotal").html("&#8377; " + total);
            }
        });
    }
    function showOverlayForm(overlayID) {
        if ($(".overlay-background").length < 1)
            $("<div>").addClass("overlay-background").css("display", "block").appendTo($("body"));
        if(overlayID==="scheduleOverlay")
            $("#" + overlayID).css("display","block");
        else
            $("#" + overlayID).css("display", "flex");
        $("#" + overlayID).focus();
    }

    function hideOverlayForm() {
        $(".main__form_overlayform").removeAttr("style");
        $(".overlay-background").remove();
    }
    function hideForm(overlayID) {
        $("#" + overlayID).removeAttr("style");
    }
    function showScheduleLessonForm(tutor_id){
        showLoading();
        $("#scheduleDiv").hide();
        $(".main__lesson__overlay_avail").empty();
        $("#scheduleForm").trigger("reset");
        $.ajax({
            url:"./AvailabilityController",
            data:"cmd=loadTutorAvailability&tutor_id="+tutor_id,
            success: function(response){    
                hideLoading();
                $.each(response,function(i,av){
                    days_of_week.push(daysObj[av.day_of_week]);
                    availMap.set(daysObj[av.day_of_week],av);
                });
            }
        });
        showLoading();
        $.ajax({
            url:"./LessonController",
            data:"cmd=loadScheduledLessons&tutor_id="+tutor_id,
            success: function(response){    
                hideLoading();
                $.each(response,function(i,schedule){
                    if(scheduleMap.has(schedule.date)){
                        const scheduleArray = scheduleMap.get(schedule.date);
                        scheduleArray.push(schedule);
                        scheduleMap.set(schedule.date,scheduleArray);
                    }else{
                        let scheduleArray = new Array();
                        scheduleArray.push(schedule);
                        scheduleMap.set(schedule.date,scheduleArray);
                    }
                });
            }
        });
        showOverlayForm("scheduleOverlay");
    }
    function validateDate(date){
        const parts = date.split('-');
        const day = (new Date(parts[0], parts[1]-1, parts[2])).toLocaleDateString('en-US', { weekday: 'long' });
        if(days_of_week.indexOf(day)===-1)
            return false;
        else
            return true;
    }
    function tConvert (start_time,format) {
        const start_mins = Math.floor((start_time/1000)/60);
        const start_min = Math.floor(start_mins%60);
        const start_hr = Math.floor((start_mins - start_min)/60);
        let time="";
        start_hr<10? time="0":time+="";
        time+=start_hr+":";
        start_min<10? time += "0":time+="";
        time+=start_min;
    if(format===24){
        return time;
    }else{
        // Check correct time format and split into components
            time = time.match(/^([01]\d|2[0-3])(:)([0-5]\d)(:[0-5]\d)?$/) || [time];

            if (time.length > 1) { // If time format correct
                time = time.slice (1);  // Remove full string match value
                time[5] = +time[0] < 12 ? 'AM' : 'PM'; // Set AM/PM
                time[0] = +time[0] % 12 || 12; // Adjust hours
            }
            return time.join (''); // return adjusted time or original string
    }
    }
    $(document).ready(function (event) {
        var d = new Date();
        var date = d.getFullYear() + "-";
        var tMonth = d.getMonth()+1;
        var tDate = d.getDate();
        if(tMonth < 10)
            date += "0"+ tMonth + "-";
        else
            date += tMonth + "-";
        if(tDate<10)
            date += "0"+tDate;
        else
            date += tDate;
        $("#date").prop("min",date);
        $("#scheduleDiv").hide();
        loadTutorInfo();
        $("#booking_subject_id").change(function (event) {
            const subject_id = parseInt($(this).val());
            const fees = feesMap.get(subject_id);
            $("#price").val(fees.fee);
        });
        $(document).on("submit", "#bookingForm", function (event) {
            event.preventDefault();
            $("#pay_tutor_id").val($("#tutor_id").val());
            $("#pay_subject_id").val($("#booking_subject_id").val());
            $("#pay_price").val($("#price").val());
            $("#pay_duration").val($("#duration").val());
            $("#pay_no_of_lesson").val($("#no_of_lesson").val());
            if ($("#booking_subject_id").val() === null || $("#pay_subject_id").val() === null) {
                $("#snackbar").html("Select a subject");
                showToast();
                return;
            }
            preparePayment();
            hideForm("bookingOverlay");
            showOverlayForm("paymentOverlay");
        });
        $("#backBtn").click(function (event) {
            event.preventDefault();
            hideForm("paymentOverlay");
            showOverlayForm("bookingOverlay");
        });
        $(document).on("submit", "#paymentForm", function (event) {

            event.preventDefault();
            var $form = $(this);
            showLoading();
            $.post($form.attr("action"), $form.serialize(), function (response) {
                hideLoading();
                if (response.includes("Exception")) {
                    $("<pre>").addClass("overlay-background").css({
                        "display": "block",
                        "background-color": "rgba(0, 0, 0, 0.85)"
                    }).html(response).appendTo("body");
                    $(".overlay-background").click(() => {
                        $(".overlay-background").remove();
                    });
                }
                if (response.includes("Booked")) {
                    hideForm("paymentOverlay");
                    showOverlayForm("successOverlay");
                    loadNotifications();
                } else {
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
                }
            });
        });
        $(".search__booking_walletDiv_heading_link").click(function (event) {
            hideForm("paymentOverlay");
            showOverlayForm("addOverlay");
        });
        $(document).on("submit", "#addMoneyForm", function (event) {
            event.preventDefault();
            var $form = $(this);
            showLoading();
            $.post($form.attr("action"), $form.serialize(), function (response) {
                hideLoading();
                $form.trigger("reset");
                if (response.includes("Exception")) {
                    $("<pre>").addClass("overlay-background").css({
                        "display": "block",
                        "background-color": "rgba(0, 0, 0, 0.85)"
                    }).html(response).appendTo("body");
                    $(".overlay-background").click(() => {
                        $(".overlay-background").remove();
                    });
                }
                if (response.includes("Added")) {
                    preparePayment();
                    hideForm("addOverlay");
                    showOverlayForm("paymentOverlay");
                } else {
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
                }
            });
        });
        $("#date").change(function(event){
            if(!validateDate($(this).val())){
                $(this).val('');
                let daysAvail = "";
                $.each(days_of_week,function(i,day){
                    daysAvail += day+" ";
                });
                const alertMsg = "Tutor is not available on this day. Choose a date on following days: "+daysAvail;
                daysAvail = "";
                $("#scheduleDiv").hide();
                alert(alertMsg);
            }else{
                const parts = $(this).val().split('-');
                const day = (new Date(parts[0], parts[1]-1, parts[2])).toLocaleDateString('en-US', { weekday: 'long' });
                const avail = availMap.get(day);
                let dateParts = $(this).val().split('-');
                let timeParts1 = avail.time_from.split(':');
                let timeParts2 = avail.time_to.split(':');
                const datetime1 = new Date(dateParts[0], dateParts[1]-1,
                dateParts[2],timeParts1[0],timeParts1[1],timeParts1[2]);
                const datetime2 = new Date(dateParts[0], dateParts[1]-1,
                dateParts[2],timeParts2[0],timeParts2[1]);
                const diff = Math.abs(datetime1 - datetime2);
                const mins = Math.floor((diff/1000)/60);
                const no_of_units = Math.floor(mins/30);
                const avail_div = $(".main__lesson__overlay_avail");
                let start_time = (parseInt(timeParts1[0])*1000*60*60)+(parseInt(timeParts1[1])*1000*60);
                let end_time = (parseInt(timeParts2[0])*1000*60*60)+(parseInt(timeParts2[1])*1000*60);
                avail_div.empty();
                $("#scheduleDiv").show();
                for(let i=0;i<=no_of_units;i++){
                    let avail_unit = $("<div>").addClass("avail_unit green_unit")
                                               .append($("<span>").text(tConvert(start_time,12)))
                                               .append($("<i>").addClass("unit_value").text(start_time).css("display","none"));
                    $.each(scheduleMap.get($(this).val()),function(i,schedule){
                        const time_parts = schedule.time_from.split(":");
                         const time_parts1 = schedule.time_to.split(":");
                        let scheduleStartTime = (parseInt(time_parts[0])*1000*60*60)+(parseInt(time_parts[1])*1000*60);
                        let scheduleEndTime = (parseInt(time_parts1[0])*1000*60*60)+(parseInt(time_parts1[1])*1000*60);
                        if(start_time>=scheduleStartTime && start_time<scheduleEndTime)
                            avail_unit.addClass("red_unit");
                    });
                    avail_div.append(avail_unit);
                    start_time += 30*1000*60;
                }
            }
        });
    });
</script>
<%@include file="footer.jsp" %>