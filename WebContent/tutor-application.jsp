<%try{ %>
<%@include file="header.jsp"%>
<main class="grey-container">
<%
	String profile_status="";
	if(session.getAttribute("TUTOR")!=null){
		Tutor tutor = (Tutor)session.getAttribute("TUTOR");
		profile_status = tutor.getProfile_status();
	}
	if(profile_status.equals("Applied")){
%>
	<div class="main__form-container main__form-container_shadowed">
            <div class="main__form-section">
                <span class="big-green-tick"></span>
                <h1 class="thin-H1 ">Already Applied </h1>
                <div class="main__form" style="diplay:block">
                    <p>You are have already a applied to be a tutor on TutorPod.</p><p>To fill another tutor application form please log out from
                        this
                        profile and then revisit this page.</p>
                </div>
            </div>
        </div>
<%}else{%>
    <div class="main__form-container main__form-container_shadowed" id="applicationForm">
        <h1 class="thin-H1">Tutor Application</h1>
        <div class="tab-selector" id="tab-selector_form">
            <span class="tab-selector_tab tab_1" id="tab-selector_tab1">1. Basic Info</span>
			<span class="tab-selector_tab tab_2" id="tab-selector_tab2">2. Address</span> 
			<span class="tab-selector_tab tab_3" id="tab-selector_tab3">3. Languages</span> 
			<span class="tab-selector_tab tab_4" id="tab-selector_tab4">4. Experience</span> 
			<span class="tab-selector_tab tab_5" id="tab-selector_tab5">5. Price</span>
			<span class="tab-selector_tab tab_6" id="tab-selector_tab6">6. Bank Details</span>
		</div>


		<div class="main__form" id="tab_1">
			<form action="#" method="post" enctype="multipart/form-data" class="main__form-section"
				id="basicInfoForm">
				<h2 class="main__sub-heading"> Enter Your Basic Info</h2>
				<div class=" form-unit form-unit-full">
                <label for="username">Username</label> <input type="text" class="input-with-icon user_id" id="username"
                    name="username" placeholder="Enter Username" required />
        </div>
        <div class="form-unit-half-container">
            <div class="form-unit form-unit-half">
                <label for="fname">First Name</label> <input type="text" class="input-with-icon user_name user_fname" id="fname"
                    name="fname" placeholder="Enter First Name" required />
            </div>
            <div class="form-unit form-unit-half">
                <label for="lname">Last Name</label> <input type="text" class="input-with-icon user_name user_lname" id="lname"
                    name="lname" placeholder="Enter Last Name" required />
            </div>
        </div>
        <div class="form-unit form-unit-full">
            <label for="password">Password</label> <input type="password" class="input-with-icon user_pass" id="password"
                name="password" placeholder="Enter Password" required />
        </div>
        <div class="form-unit form-unit-full">
            <label for="gender">Gender</label>
            <select name="gender" class="input-with-icon user_gender" required id="gender">
                <option value="default" selected disabled>Select Gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
        </div>
        <div class="form-unit form-unit-full">
            <label for="email_id">Email ID</label> <input type="text" class="input-with-icon user_email" name="email_id" id="email_id"
                placeholder="Enter Email Adderss" required />
        </div>
        <div class="form-unit form-unit-full">
            <label for="mobile_no">Mobile Number</label> <input type="tel" class="input-with-icon user_tel" id="mobile_no"
                name="mobile_no" placeholder="Enter Mobile Number" required />
        </div>
        <div class="form-unit form-unit-full">
            <label for="photo">Photo</label> <input type="file" class="input-with-icon acc_holder" accept=".jpg"
                name="photo" id="photo" required>
        </div>
        <div class="form-unit form-unit-full">
            <label for="bio">Bio</label>
            <textarea class="input-with-icon user_bio" required name="bio" id="bio"
                placeholder="Tell us about yourself in a brief paragraph. In Less than 300 character."></textarea>
        </div>
        <input type="hidden" name="cmd" value="saveBasicInfo">
        <div class="main__form_footer">
            <button class="button flat-wide-button flat-hallow-button backBtn" id="backBtn_tab1" disabled>&lt;
                Back</button>
            <button type="submit" class="button flat-wide-button flat-wide-button_narrow saveBtn" id="saveBtn_tab1">Save Details</button>
					<button class="button flat-wide-button flat-hallow-button nextBtn"
						id="nextBtn_tab1" disabled>Next &gt;</button>
				</div>
			</form>
		</div>


		<div class="main__form" id="tab_2">
			<form action="./TutorController" method="post" class="main__form-section"
				id="addressForm">
				<h2 class="main__sub-heading">Enter Your Address</h2>
                <div class="form-unit-half-container">
                    <div class="form-unit form-unit-half">
                        <label for="street_address">Address</label> <input type="text"
                            class="input-with-icon user_house" name="street_address" id="street_address"
                            placeholder="House/Flat No., Block No, Street No." required />
                    </div>

                    <div class="form-unit form-unit-half">
                        <label for="locality">Locality</label> <input type="text" class="input-with-icon user_location" id="locality"
                            name="locality" placeholder="Enter Your Locality" required />
                    </div>
                </div>
                <div class="form-unit-half-container">
                    <div class="form-unit form-unit-half">
                        <label for="district">District</label> <input type="text" class="input-with-icon user_location" id="district"
                            name="district" placeholder="Enter Your District" required />
                    </div>
                    <div class="form-unit form-unit-half">
                        <label for="city">City</label> <input type="text" class="input-with-icon user_location" id="city"
                            name="city" placeholder="Enter Your City" required />
                    </div>
                </div>
                <div class="form-unit-half-container">
                    <div class="form-unit form-unit-half">
                        <label for="state">State</label> <input type="text" class="input-with-icon user_location" id="state"
                            name="state" placeholder="Enter Your State" required />
                    </div>
                    <div class="form-unit form-unit-half">
                        <label for="pincode">Pincode</label> <input type="text" class="input-with-icon user_location" id="pincode"
                            name="pincode" placeholder="Enter Your Pincode" required />
                    </div>
                </div>
                <input type="hidden" name="cmd" value="saveAddress">
                <div class="main__form_footer">
                    <button class="button flat-wide-button flat-hallow-button backBtn" id="backBtn_tab2">&lt; Back</button>
                    <button type="submit" class="button flat-wide-button flat-wide-button_narrow saveBtn" id="saveBtn_tab2">Save Details</button>
                    <button class="button flat-wide-button flat-hallow-button nextBtn" id="nextBtn_tab2" disabled>Next &gt;</button>
                </div>
			</form>
		</div>


		<div class="main__form" id="tab_3">
			<form action="./TutorController" method="post" class="main__form-section"
				id="languagesForm">
				<h2 class="main__sub-heading"> Select Languages You Speak</h2>
                <div class="checkboxs-container">
                </div>
                <input type="hidden" name="cmd" value="saveLanguages">
                <div class="main__form_footer">
                    <button class="button flat-wide-button flat-hallow-button backBtn" id="backBtn_tab3">&lt; Back</button>
                    <button type="submit" class="button flat-wide-button flat-wide-button_narrow saveBtn" id="saveBtn_tab3">Save Details</button>
                    <button class="button flat-wide-button flat-hallow-button nextBtn" id="nextBtn_tab3" disabled>Next &gt;</button>
                </div>
			</form>
		</div>


		<div class="main__form" id="tab_4">
			<form action="./TutorController" method="post" class="main__form-section"
				id="experienceForm">
				<h2 class="main__sub-heading">Add Your Experience</h2>
				<div class="table-container scrollable">
					<table aria-label="Experience Table" id="experienceTable" class="white-table">
					<thead>
					</thead>
					<tbody>
					</tbody>
					</table>
				</div>
                <input type="hidden" name="cmd" value="saveExperience">
				<button class=" button round-single-button addBtn">+</button>
                <div class="main__form_footer">
                    <button class="button flat-wide-button flat-hallow-button backBtn" id="backBtn_tab4">&lt; Back</button>
                    <button type="submit" class="button flat-wide-button flat-wide-button_narrow saveBtn" id="saveBtn_tab4" disabled>Save Details</button>
                    <button class="button flat-wide-button flat-hallow-button nextBtn" id="nextBtn_tab4" disabled>Next &gt;</button>
                </div>
			</form>
            <div class="main__form_overlayform" tabindex="-1">
                <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
                <h2 class="main__sub-heading" id="experience_heading">Add Experience</h2>
                <form action="./TutorController" method="post" class="scrollable" id="addExperience">
                    <div class="form-unit-half-container">
                        <div class="form-unit form-unit-half">
                            <label for="experience_type">Experience Type</label>
                            <select name="experience_type" id="experience_type" class="input-with-icon input-with-icon_no-icon">
                                <option value="default" selected disabled>Select Experience Type</option>
                                <option value="Education">Education</option>
                                <option value="Certification">Certification</option>
                                <option value="Work Experience">Work Experience</option>
                            </select>
                        </div>
                        <div class="form-unit form-unit-half">
                            <label for="title">Title</label>
                            <input type="text" class="input-with-icon input-with-icon_no-icon" name="title"
                                placeholder="Enter Title of Experience" id="title" required />
                        </div>
                    </div>
                    <div class="form-unit-half-container">
                        <div class="form-unit form-unit-half">
                            <label for="institution">Institution</label>
                            <input type="text" class="input-with-icon input-with-icon_no-icon" name="institution"
                                placeholder="Enter Institution Name" id="institution" required />
                        </div>
                        <div class="form-unit form-unit-half">
                            <label for="location">Location</label>
                            <input type="text" class="input-with-icon input-with-icon_no-icon" name="location"
                                placeholder="Enter Location" id="location" required />
                        </div>
                    </div>
                    <div class="form-unit-half-container">
                        <div class="form-unit form-unit-half">
                            <label for="start_year">Start Year</label>
                            <input type="number" class="input-with-icon input-with-icon_no-icon" name="start_year"
                                placeholder="Enter Start Year" id="start_year" required />
                        </div>
                        <div class="form-unit form-unit-half">
                            <label for="end_year">End Year</label>
                            <input type="number" class="input-with-icon input-with-icon_no-icon" name="end_year"
                                placeholder="Enter End Year" id="end_year" required />
                        </div>
                    </div>
                    <div class="form-unit form-unit-full">
                        <label for="description">Description</label>
                        <textarea class="input-with-icon input-with-icon_no-icon" required name="description" id="description"
                            placeholder="Describe your experience in a brief paragraph. In Less than 300 character."></textarea>
                    </div>
                    <input type="hidden" name="cmd" value="addExperience">
                    <input type="submit" class="button flat-wide-button" value="Add Experience" id="experience_submitBtn">
                </form>
            </div>
		</div>


        <div class="main__form" id="tab_5">
            <form action="./TutorController" method="post" class="main__form-section" id="priceForm">
                <h2 class="main__sub-heading"> Your Fees Price</h2>
                <div class="table-container scrollable">
                    <table aria-label="Price Table" id="priceTable" class="white-table">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
					</table>
				</div>
                <input type="hidden" name="cmd" value="savePrice">
                <button class=" button round-single-button addBtn">+</button>
                <div class="main__form_footer">
                    <button class="button flat-wide-button flat-hallow-button backBtn" id="backBtn_tab5">&lt; Back</button>
                    <button type="submit" class="button flat-wide-button flat-wide-button_narrow saveBtn"
                        id="saveBtn_tab5" disabled >Save Details</button>
                    <button class="button flat-wide-button flat-hallow-button nextBtn" 
                        id="nextBtn_tab5" disabled >Next &gt;</button>
                </div>
            </form>
            <div class="main__form_overlayform" tabindex="-1">
                <a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
                <h2 class="main__sub-heading">Add Price </h2>
                <form action="./TutorController" method="post" class="scrollable" id="addPrice">
                    <div class="form-unit-half-container">
                        <div class="form-unit form-unit-half">
                            <label for="course_id">Course</label>
                            <select name="course_id" id="course_id"
                                class="input-with-icon input-with-icon_no-icon">
                                <option value="default" selected disabled>Select Course</option>
                            </select>
                        </div>
                        <div class="form-unit form-unit-half">
                            <label for="duration_no">Year/Sem</label>
                            <select name="duration_no" id="duration_no"
                                class="input-with-icon input-with-icon_no-icon">
                                <option value="default" selected disabled>Select Year/Sem</option>
                            </select>
                        </div>
                    </div>
                        <div class="form-unit form-unit-full">
                            <label for="subject_id">Subject</label>
                            <select name="subject_id" id="subject_id" class="input-with-icon input-with-icon_no-icon">
                                <option value="default" selected disabled>Select Subject</option>
                            </select>
                        </div>
                        <div class="form-unit form-unit-full">
                            <label for="amount">Fee Per Hour</label>
                            <input type="number" class="input-with-icon input-with-icon rupee" name="fee" id="fee"
                                placeholder="Enter Price" required />
                        </div>
                    <input type="hidden" name="subject_name" id="subject_name" >
                    <input type="hidden" name="cmd" value="addPrice">
                    <input type="submit" class="button flat-wide-button" value="Add Price">
                </form>
            </div>
        </div>


        <div class="main__form" id="tab_6">
			<form action="./BankAccountController" method="post" class="main__form-section" id="bankAccForm">
					<h2 class="main__sub-heading">Enter Bank Account</h2>
						<div class="form-unit-half-container">
                          <div class="form-unit form-unit-half">
					            <label for="bank_name">Bank Name</label>
					            <input type="text" name="bank_name" class="input-with-icon bank" id="bank_name" required placeholder="Enter bank name ">
					        </div>
					        <div class="form-unit form-unit-half">
					            <label for="acc_no">Account Number</label>
					            <input type="text" name="acc_no" class="input-with-icon acc_no" id="acc_no" required placeholder="Enter account number">
					        </div>
					    </div>
					    <div class="form-unit-half-container">
					        <div class="form-unit form-unit-half">
					            <label for="holder_name">Account Holder</label>
					            <input type="text" name="holder_name" class="input-with-icon acc_holder" id="holder_name" required placeholder="Enter holder's name">
					        </div>
					        <div class="form-unit form-unit-half">
					            <label for="ifsc_code">IFSC Code</label>
					            <input type="text" name="ifsc_code" class="input-with-icon bank" id="ifsc_code" required placeholder="Enter IFSC code">
					        </div>
					    </div>
                        <input type="hidden" name="pass_required" value="Not">
						<input type="hidden" name="cmd" value="saveBankAcc" /> 
						<div class="main__form_footer">
		                    <button class="button flat-wide-button flat-hallow-button backBtn" id="backBtn_tab6">&lt; Back</button>
		                    <button type="submit" class="button flat-wide-button flat-wide-button_narrow saveBtn" id="saveBtn_tab6">Save Details</button>
		                    <button class="button flat-wide-button flat-hallow-button" id="nextBtn_tab6" disabled>Next &gt;</button>
               			</div>
					</form>
		</div>
	</div>
    <div class="main__form-container main__form-container_shadowed" id="finalMsg">
            <span class="big-green-tick"></span>
            <h1 class="thin-H1 ">Application Submitted</h1>
            <div class="main__form">
                <p>Your application is submitted. You will be able to provide lessons to learners once your application
                    is approved. </p>
                <p>Until then you can use TutodPod as a learner and you can also edit your details.</p>
                <ul>
                    <li>
                        Click on your profile in navigation bar then click <strong>Account Settings</strong> to see and change your profile details.
                    </li>
                    <li>
                        Click on your profile in navigation bar then click <strong>Switch to Tutor</strong> or <strong>Switch to Learner</strong> to switch between two profiles and see dashboard options for respective profile.
                    </li>
                </ul>
                <p> <strong>We wish you a great learning and teacher experience.</strong> </p>
            </div>
    </div>
</main>

<script type="text/javascript">
    function loadLanguages() {
        $.ajax({
            url: "./TutorController",
            data: "cmd=loadLanguages",
            success: function (response) {
                $.each(response, function (i, lang) {
                    $(".checkboxs-container").append('<label class="check-container">' + lang[1] +
                        '<input type = "checkbox" name="languages" value="' + lang[0] +
                        '" id="' + lang[1] + '" ><span class="check"></span></label >');
                });
            }
        });
    }
    $.fn.serializeObject = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

    function changeTab(tabNo) {
        $(".main__form").css("display", "none");
        $("#tab_" + tabNo).css("display", "block");
        $(".tab-selector_tab").removeClass("tab-selector_selected");
        $(".tab_" + tabNo).addClass("tab-selector_selected");
        var href = location.href;
        let nextURL;
        const nextTitle = 'TutorPod';
        const nextState = {
            additionalInformation: 'Updated the URL with JS'
        };
        if (href.includes("?")) {
            href = href.substring(0, href.indexOf("tab="));
            if (href.substring(href.indexOf("?")).length > 1)
                nextURL = href + "&tab=" + tabNo;
            else
                nextURL = href + "tab=" + tabNo;
        } else
            nextURL = href.substring(0, href.indexOf("tab=")) + "?tab=" + tabNo;
        window.history.pushState(nextState, nextTitle, nextURL);
        window.history.replaceState(nextState, nextTitle, nextURL);
        $('#tab-selector_form').animate({
            scrollLeft: $('#tab-selector_tab' + tabNo).offset().left - 10
        }, 500);
        getNextButton(tabNo);
    }
    function getNextButton(tabNo){
        if($("#tab-selector_tab"+tabNo).hasClass("tab-selector_completed")){
            $("#nextBtn_tab"+tabNo).prop("disabled",false);
        }
    }
    function loadBasicInfo() {
        showLoading();
        $.ajax({
            url: "./TutorController",
            data: "cmd=loadBasicInfo",
            success: function (response) {
                hideLoading();
                if (response.username!=null) {
                    $("#username").val(response.username).text(response.username);
                    $("#fname").val(response.fname).text(response.fname);
                    $("#lname").val(response.lname);
                    $("#password").remove();
                    $("#gender").val(response.gender);
                    $("#email_id").val(response.email_id);
                    $("#mobile_no").val(response.mobile_no);
                    if (response.photo != null)
                        $("#photo").remove();
                    $("#bio").val(response.bio);
                    if(response.photo!=null && response.bio!=null)
                    $("#tab-selector_tab1").addClass("tab-selector_completed");
                }
                getNextButton(1);
            }
        });
    }

    function loadAddress() {
        showLoading();
        $.ajax({
            url: "./TutorController",
            data: "cmd=loadAddress",
            success: function (response) {
                hideLoading();
                $("#street_address").val(response.street_address);
                $("#locality").val(response.locality);
                $("#district").val(response.district);
                $("#city").val(response.city);
                $("#state").val(response.state);
                $("#pincode").val(response.pincode);
                if(response.address_id != null)
                    $("#tab-selector_tab2").addClass("tab-selector_completed");
                getNextButton(2);
            }
        });
    }

    function loadSelectedLanguages() {
        showLoading();
        $.ajax({
            url: "./TutorController",
            data: "cmd=loadSelectedLanguages",
            success: function (response) {
                hideLoading();
                $.each(response, function (i, lang) {
                    $("#" + lang[1]).prop("checked", true);
                });
                if(response.length>0){
                    $("#tab-selector_tab3").addClass("tab-selector_completed");
                }
                getNextButton(3);
            }
        });
    }
    function loadExperiences() {
        showLoading();
        $.ajax({
            url: "./TutorController",
            data: "cmd=loadExperiences",
            success: function (response) {
                hideLoading();
                if(response.length>0){
                    if($("#experienceTable thead th").length<1){
                        var tableHead ='<th>Experience Type</th><th>Experience</th><th>Duration</th><th>Description</th><th>Actions</th>';
                        $("#experienceTable thead").append(tableHead);
                    }
                    $.each(response, function (i, expr) {
                        var tableRow = '<tr id="experience_'+expr.experience_id+'">' +
                            '<td>' + expr.experience_type + '</td>' +
                            '<td><strong>' + expr.title + '</strong><br>' + expr.institution + '<br>' + expr.location + '</td>' +
                            '<td>' + expr.start_year + ' - ' + expr.end_year + '</td>' +
                            '<td>' + expr.description + '</td>' +
                            '<td class="table_action">' +
                            '<a href="#" class="button small-round-button edit-button" onclick="editExperience('+expr.experience_id+')">Edit</a>' +
                            '<a href="#" class="button small-round-button delete-button" onclick="deleteExperience('+expr.experience_id+')">Delete</a>' +
                            '</td>' +
                            '</tr>';
                        $("#experienceTable tbody").append(tableRow);
                    });
                     if(response.length>0){
                     $("#tab-selector_tab4").addClass("tab-selector_completed");
                     }
                }
                getNextButton(4);
            }
        });
    }
    function loadPrices() {
        showLoading();
        $.ajax({
            url: "./TutorController",
            data: "cmd=loadPrices",
            success: function (response) {
                hideLoading();
                if(response.length>0){
                    if($("#priceTable thead th").length<1){
                        var tableHead ='<th>Subject</th><th>Fees (Hr)</th><th>Actions</th>';
                        $("#priceTable thead").append(tableHead);
                    }
                    $.each(response, function (i, price) {
                        var tableRow = '<tr id="price_'+price.fees_id+'">' +
                            '<td>' + price.subject_name + '</td>' +
                            '<td>&#8377;' + price.fee + '</td>' +
                            '<td>' +
                                '<a href="#" class="button small-round-button delete-button" onclick="deleteFees('+price.fees_id+')">Delete</a>' +
                            '</td>' +
                            '</tr>';
                        $("#priceTable tbody").append(tableRow);
                    });
                     if(response.length>0){
                     $("#tab-selector_tab5").addClass("tab-selector_completed");
                     }
                }
                getNextButton(5);
            }
        });
    }
    function loadBankAcc() {
        showLoading();
        $.ajax({
            url: "./BankAccountController",
            data: "cmd=loadBankAcc",
            success: function (response) {
                hideLoading();
                $("#bank_name").val(response.bank_name);
                $("#acc_no").val(response.acc_no);
                $("#holder_name").val(response.holder_name);
                $("#ifsc_code").val(response.ifsc_code);  
                if(response.bank_acc_id != null)
                    $("#tab-selector_tab6").addClass("tab-selector_completed");
                getNextButton(6);
            }
        });
    }
    function editExperience(id){
        var hiddenElement = '<input type="hidden" name="experience_id" id="experience_id" value="'+id+'">';
        $("#addExperience").append(hiddenElement);
        showOverlayForm();
        showLoading();
        $.ajax({
            url: "./TutorController",
            data: "cmd=loadExperience&experience_id="+id,
            success: function (response) {
                hideLoading();
                $("#experience_submitBtn").val("Update Experience");
                $("#experience_heading").html("Update Experience");
                $("#experience_type").val(response.experience_type);
                $("#title").val(response.title);
                $("#institution").val(response.institution);
                $("#location").val(response.location);
                $("#start_year").val(response.start_year);
                $("#end_year").val(response.end_year);
                $("#description").val(response.description);
            }
        });

    }
    function deleteExperience(id){
        if(!confirm("Are you sure you want to delete this experience ?"))
            return;
        showLoading();
        $.post("./TutorController","cmd=deleteExperience&experience_id="+id,function(response){
            if(response.includes("Deleted")){
                $("#experience_"+id).remove();
            }
            $("#snackbar").html(response);
            showToast();
            if($("#experienceTable tbody tr").length<1)
                $("#tab-selector_tab4").removeClass("tab-selector_completed");

            if(response.includes("Failed"))
                console.log(response);
            
        });
    }
    function deleteFees(id){
        if(!confirm("Are you sure you want to delete this fees ?"))
            return;
        showLoading();
        $.post("./TutorController","cmd=deletePrice&fees_id="+id,function(response){
            if(response.includes("Deleted")){
                $("#price_"+id).remove();
            }
            $("#snackbar").html(response);
            showToast();
            if($("#priceTable tbody tr").length<1)
                $("#tab-selector_tab5").removeClass("tab-selector_completed");
            if(response.includes("Failed"))
                console.log(response);
        });
    }
    function showOverlayForm(){
        $("<div>").addClass("overlay-background").css("display", "block").appendTo($("body"));
        $(".main__form_overlayform").css("display", "block");
        $(".main__form_overlayform").focus();
    }
    function hideOverlayForm() {
        if($("#experience_id").length>0){
            $("#experience_id").remove();
            $("#experience_submitBtn").val("Add Experience");
            $("#experience_heading").html("Add Experience");
            $("#addExperience").trigger("reset");
        }
        $(".main__form_overlayform").removeAttr("style");
        $(".overlay-background").remove();
    }

    const courseMap = new Map();

    function loadSubjects() {
        $.ajax({
            url: "./SubjectController",
            data: "cmd=seeCourseAndSubjects",
            success: function (response) {
                $.each(response, function (i, courses) {
                    if (courses.courseSubjects[0] == null)
                        return;
                    $("#course_id").append('<option value="' + courses.course_id + '">' + courses
                        .courseSubjects[0].name_abbr + '</option>');
                    var durationInfoArray = [courses.courseSubjects[0].duration_type];
                    var durationArray = [];
                    var duration_no = courses.courseSubjects[0].duration_no;
                    var subjectsArray = [];
                    $.each(courses.courseSubjects, function (i, subjects) {
                        if (duration_no != subjects.duration_no) {
                            durationArray.push(subjectsArray);
                            duration_no = subjects.duration_no;
                            subjectsArray = [];
                        }
                        subjectsArray.push([subjects.subject_id, subjects.subject_code +
                            " - " + subjects.subject_name
                        ]);
                    });
                    durationArray.push(subjectsArray);
                    durationInfoArray.push(durationArray);
                    courseMap.set(courses.course_id, durationInfoArray);
                });
            }
        });
    }
    $(document).ready(() => {
        loadLanguages();
        loadSubjects();
        loadBasicInfo();
        loadAddress();
        loadSelectedLanguages();
        loadExperiences();
        loadPrices();
        loadBankAcc();
        let searchParams = new URLSearchParams(window.location.search);
        if (searchParams.has('tab'))
            changeTab(searchParams.get('tab'));
        else
            changeTab(1);
        $(document).on("submit", "#basicInfoForm", function (event) {
            event.preventDefault();
            var $form = $("#basicInfoForm");
            var dform = $("#basicInfoForm")[0];
            var data = new FormData(dform);
            showLoading();
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "./TutorController",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 800000,
                success: function (response) {
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
                    if (response.includes("Changed") || response.includes("Created")) {
                        $("#snackbar").html("Details Saved");
                        showToast();
                        $("#tab-selector_tab1").addClass("tab-selector_completed");
                    } else {
                        $("#snackbar").html(response);
                        showToast();
                        console.log(response);
                    }
                    getNextButton(1);
                }
            });
        });
        $(document).on("submit", "#addressForm", function (event) {
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
                if (response.includes("Saved")) {
                    $("#snackbar").html("Details Saved");
                    showToast();
                    $("#tab-selector_tab2").addClass("tab-selector_completed");

                } else {
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
                }
                getNextButton(2);
            });
        });
        $(document).on("submit", "#languagesForm", function (event) {
            event.preventDefault();
            var $form = $(this);
            if ($(".checkboxs-container :checkbox:checked").length < 1) {
                $("#snackbar").html("Tick Atleast One Checkbox");
                showToast();
                return;
            }
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
                if (response.includes("Saved")) {
                    loadSelectedLanguages();
                    $("#snackbar").html("Details Saved");
                    showToast();
                } else {
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
                }
            });
        });
        $(document).on("submit", "#addExperience", function (event) {
            event.preventDefault();
            var $form = $(this);
            if ($("#experience_type").val() == null) {
                $("#snackbar").html("Select Experience Type");
                showToast();
                return;
            }
            showLoading();
            $.post($form.attr("action"), $form.serialize(), function (response) {
                var formData = $form.serializeObject();
                hideLoading();
                $form.trigger("reset");
                if (response.msg.includes("Exception")) {
                    $("<pre>").addClass("overlay-background").css({
                        "display": "block",
                        "background-color": "rgba(0, 0, 0, 0.85)"
                    }).html(response).appendTo("body");
                    $(".overlay-background").click(() => {
                        $(".overlay-background").remove();
                    });
                }
                if (response.msg.includes("Added")) {
                    if ($("#experienceTable thead th").length == 0) {
                        var tableHead =
                            '<th>Experience Type</th><th>Experience</th><th>Duration</th><th>Description</th><th>Actions</th>';
                        $("#experienceTable thead").append(tableHead);
                        $("#tab-selector_tab4").addClass("tab-selector_completed");
                    }
                    if($("#experience_id").length>0){
                        var tableRow = '<td>' + formData.experience_type + '</td>' +
                        '<td><strong>' + formData.title + '</strong><br>' + formData.institution + '<br>' + formData.location + '</td>' +
                        '<td>' + formData.start_year + ' - ' + formData.end_year + '</td>' +
                        '<td>' + formData.description + '</td>' +
                        '<td class="table_action">' +
                        '<a href="#" class="button small-round-button edit-button" onclick="editExperience('+response.experience_id+')">Edit</a>' +
                        '<a href="#" class="button small-round-button delete-button" onclick="deleteExperience('+response.experience_id+')">Delete</a>' +
                        '</td>';
                        $("#experience_"+response.experience_id).empty().append(tableRow);
                        hideOverlayForm();
                        $("#snackbar").html("Experience Updated");
                    }else{
                        var tableRow = '<tr id="experience_'+response.experience_id+'">' +
                            '<td>' + formData.experience_type + '</td>' +
                            '<td><strong>' + formData.title + '</strong><br>' + formData.institution + '<br>' + formData.location + '</td>' +
                            '<td>' + formData.start_year + ' - ' + formData.end_year + '</td>' +
                            '<td>' + formData.description + '</td>' +
                            '<td class="table_action">' +
                            '<a href="#" class="button small-round-button edit-button" onclick="editExperience('+response.experience_id+')">Edit</a>' +
                            '<a href="#" class="button small-round-button delete-button" onclick="deleteExperience('+response.experience_id+')">Delete</a>' +
                            '</td>' +
                            '</tr>';
                        $("#experienceTable tbody").append(tableRow);
                        $("#snackbar").html("Experience Added");
                    }
                    showToast();
                } else {
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
                }
                getNextButton(4);
            });
        });
        $(document).on("submit", "#addPrice", function (event) {
            event.preventDefault();
            var $form = $(this);
            if ($("#course_id").val() == null) {
                $("#snackbar").html("Select Course");
                showToast();
                return;
            }
            if ($("#duration_no").val() == null) {
                $("#snackbar").html("Select Year/Sem");
                showToast();
                return;
            }
            if ($("#subject_id").val() == null) {
                $("#snackbar").html("Select Subject");
                showToast();
                return;
            }
            showLoading();
            $.post($form.attr("action"), $form.serialize(), function (response) {
                var formData = $form.serializeObject();
                hideLoading();
                $("#fee").val("");
                if (response.msg.includes("Exception")) {
                    $("<pre>").addClass("overlay-background").css({
                        "display": "block",
                        "background-color": "rgba(0, 0, 0, 0.85)"
                    }).html(response).appendTo("body");
                    $(".overlay-background").click(() => {
                        $(".overlay-background").remove();
                    });
                }
                if (response.msg.includes("Added")) {
                    if ($("#priceTable thead th").length == 0) {
                        var tableHead = '<th>Subject</th><th>Fees (1 Hr)</th><th>Actions</th>';
                        $("#priceTable thead").append(tableHead);
                    }
                    var tableRow = '<tr id="price_'+response.fees_id+'">' +
                        '<td>' + formData.subject_name + '</td>' +
                        '<td> &#8377;' + formData.fee + '</td>' +
                        '<td>' +
                            '<a href="#" class="button small-round-button delete-button" onclick="deleteFees('+response.fees_id+')">Delete</a>' +
                        '</td>' +
                        '</tr>';
                    $("#priceTable tbody").append(tableRow);
                    $("#snackbar").html("Price Added");
                    $("#tab-selector_tab5").addClass("tab-selector_completed");
                    showToast();
                } else {
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
                }
                getNextButton(5);
            });
        });
        $(document).on("submit", "#bankAccForm", function (event) {
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
                if (response.includes("Saved")) {
                    $("#snackbar").html("Details Saved");
                    showToast();
                    $("#tab-selector_tab6").addClass("tab-selector_completed");
                } else {
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
                }
                getNextButton(6);
            });
        });
        $(document).on("submit", "#finalForm", function (event) {
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
                if (response.includes("Submitted")) {
                    $("#applicationForm").css("display", "none");
                    $("#finalMsg").css("display", "block");
                    $("#finalMsg .main__form").css("display", "block");
                } else {
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
                }
            });
        });
        $(".backBtn").click(function (event) {
            event.preventDefault();
            var id = $(this).attr("id");
            var tab = parseInt(id.substring(id.length - 1));
            changeTab(tab - 1);
        });
        $(".nextBtn").click(function (event) {
            event.preventDefault();
            var id = $(this).attr("id");
            var tab = parseInt(id.substring(id.length - 1));
            changeTab(tab + 1);
        });
        $(".addBtn").click(function (event) {
            event.preventDefault();
            showOverlayForm();
        });
        $("#nextBtn_tab6").click(function(event){
            event.preventDefault();
            var formCompleted = true;
            for(var i=1;i<=6;i++){
                if(! $("#tab-selector_tab"+i).hasClass("tab-selector_completed")){
                    formCompleted=false;
                    break;
                }
            }
            if(formCompleted){
                $.post("./TutorController","cmd=submitApplication",function(response){
                    if(response=="Submitted"){
                        $(".main__form-container_shadowed").css("display","none");
                        $("#finalMsg").css("display","block");
                        $("#finalMsg .main__form").css("display","block");
                    }else{
                        $("#snackbar").html(response);
                        showToast();
                        console.log(response);
                    }
                });
            }
            else{
                $("#snackbar").html("Incomplete Form!");
                showToast();
            }
        });
        $(".main__form_overlayform").focusout(function () {
            if ($(".main__form_overlayform :hover").length > 0)
                return;
            hideOverlayForm();
        });
        $("#course_id").change(function (event) {
            var course_id = parseInt($(this).val());
            var durationInfo = courseMap.get(course_id);
            $("#duration_no").empty();
            for (var i = 0; i < durationInfo[1].length; i++) {
                if (i == 0)
                    $("#duration_no").append('<option value="default" selected disabled>Select ' +
                        durationInfo[0] + '</option>');
                $("#duration_no").append('<option value="' + (i + 1) + '">' + durationInfo[0] + " " + (
                    i + 1) + '</option>');
            }
        });
        $("#duration_no").change(function (event) {
            var course_id = parseInt($("#course_id").val());
            var duration_no = parseInt($(this).val());
            var subjects = courseMap.get(course_id)[1][duration_no - 1];
            $("#subject_id").empty();
            $.each(subjects, function (i, subject) {
                if (i == 0)
                    $("#subject_id").append(
                        '<option value="default" selected disabled>Select Subject</option>');
                $("#subject_id").append('<option value="' + subject[0] + '">' + subject[1] +
                    '</option>');
            });
        });
        $("#subject_id").change(function (event) {
            $("#subject_name").val($("#subject_id option:selected").text());
        });
    });
</script>
<%}%>
<%@include file="footer.jsp"%>
<%}catch(Exception e){
	out.print(e.getMessage());
}
%>