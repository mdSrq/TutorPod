
<%
if (session.getAttribute("TUTOR") == null) {
	response.sendRedirect("./");
	return;
}
%>
<%@include file="header.jsp"%>
<%
	Tutor tutor = (Tutor)session.getAttribute("TUTOR");
%>
<div class="flex-container">
<%@include file="sidebar.jsp"%>
<main class="main">
            <h1 class="main__heading">Availability</h1>
            <div class="main__availability_container">
                <div class="main__availability_form">
                    <h2 class="main__sub-heading">Set Availability</h2>
                    <form action="./AvailabilityController" method="post" id="availabilityForm">
                        <div class="form-unit form-unit-full">
                            <label for="day_of_week">Day</label>
                            <select name="day_of_week" id="day_of_week"
                                class="input-with-icon input-with-icon_no-icon">
                                <option value="default" selected disabled>Select a day</option>
                                <option value="1">Monday</option>
                                <option value="2">Tuesday</option>
                                <option value="3">Wednesday</option>
                                <option value="4">Thursday</option>
                                <option value="5">Friday</option>
                                <option value="6">Saturday</option>
                                <option value="7">Sunday</option>
                            </select>
                        </div>
                        <div class="form-unit-half-container">
                            <div class="form-unit form-unit-half">
                                <label for="time_from">From</label>
                                <input type="time" class="input-with-icon input-with-icon_no-icon" name="time_from"
                                    placeholder="Enter Start Time" id="time_from" value="00:00" required />
                            </div>
                            <div class="form-unit form-unit-half">
                                <label for="time_to">To</label>
                                <input type="time" class="input-with-icon input-with-icon_no-icon" name="time_to"
                                    placeholder="Enter End Time" id="time_to" value="00:00" required />
                            </div>
                            <input type="hidden" name="tutor_id" value="<%=tutor.getTutor_id()%>">
                            <input type="hidden" name="cmd" value="addWeeklyAvailability">
                            <input type="submit" class="button flat-wide-button" value="Set Availability">
                        </div>
                    </form>
                </div>
                <div class="main__availability_calendar">
                    <h2 class="main__sub-heading">Weekly Availability</h2>
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
                                    <td id="time_to_day_5">NA</td>
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
                </div>
            </div>
        </main>
</div>
<script>
    function loadWeeklyAvailability(){
        showLoading();
        $.ajax({
            url: "./AvailabilityController",
            data: "cmd=loadWeeklyAvailability",
            success: function (response) {
                hideLoading();
                $(".dynamic").text("NA");
                $.each(response,function(i,avail){
                    $("#time_from_day_"+avail.day_of_week).text(avail.time_from);
                    $("#time_to_day_"+avail.day_of_week).text(avail.time_to);
                });
            }
        });
    }
    $(document).ready(()=>{
        loadWeeklyAvailability();
        $(document).on("submit", "#availabilityForm", function (event) {
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
                if (response.includes("Saved")) {
                    $("#snackbar").html("Details Saved");
                    showToast();
                } else {
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
                }
            });
        });
    });
</script>
<%@include file="footer.jsp"%>