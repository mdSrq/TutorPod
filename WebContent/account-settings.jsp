
<%
if (session.getAttribute("USER") == null) {
	response.sendRedirect("./");
	return;
}
%>
<%@include file="header.jsp"%>
<%
	User currentUser = (User)session.getAttribute("USER");
	String dashboardType = session.getAttribute("DASHBOARD_TYPE").toString();
%>
<div class="flex-container">
	<%@include file="sidebar.jsp"%>
	<main class="main">
		<h1 class="main__heading">Account Settings</h1>
		<%if(dashboardType.equals("USER")){
		  if(session.getAttribute("TUTOR")!=null){ %>
			<a href="./UserController?cmd=switchToTutor&page=AccountSettings" class="button float-right-btn float-equally">Switch to Tutor &gt;&gt;</a>
		<%} %>
		<div class="main__acc-forms-container">
			<div class="tab-selector">
				<span class="tab-selector_tab tab_1 <%if(user.getPhoto()==null){%>tab-selector_exclamation<%}%>" id="tab-selector_tab1" onclick="changeTab(1)">Personal Info</span>
				<span class="tab-selector_tab tab_2" id="tab-selector_tab2"  onclick="changeTab(2)">Username & Email</span> 
				<span class="tab-selector_tab tab_3" id="tab-selector_tab3"  onclick="changeTab(3)">Password</span> 
				<span class="tab-selector_tab tab_4 <%if(user.getBank_acc_id()<1){%>tab-selector_error<%}%>" id="tab-selector_tab4" onclick="changeTab(4)">Bank Account</span> 
			</div>
			<div class="main__container_inner" id="tab_1">
				<div class="main__container_inner_photo">
						<%if(currentUser.getPhoto()==null ){ %>
						<span class="form-info form-info_yellow">Add Photo to be more recognizable</span>
						<div class="main__container_inner_photo_img">
						<img src="./images/user.png" alt="Photo of user" />
						</div>
						<%}else{ %>
						<%if(request.getParameter("msg")!=null){%>
							<span class="form-info form-info_green"> <%=request.getParameter("msg")%> </span>
						<%}%>
						<div class="main__container_inner_photo_img">
						<img src="<%= pageContext.getServletContext().getInitParameter("usersphoto.location")
									+ currentUser.getPhoto()%>" 
							 alt="Photo of user">
						</div>
						<%}%>
					<form action="./UserController" method="post" enctype="multipart/form-data" id="photoForm" class="main__container_inner_photo_buttons">
						<input type="file" name="photo" id="photo" accept=".jpg" style="display: none" required/>
						<input type="hidden" name="cmd" value="changePhoto" /> 
						<button type="submit" name="submit"class="button flat-wide-button" id="changePhotoBtn">Change Photo</button>
						<button class="button flat-wide-button delete-button" id="removePhotoBtn">Remove Photo</button>
					</form>
				</div>
				<div class="main__form-container">
					<h2 class="main__sub-heading">Personal Info</h2>
					<form action="./UserController" method="post" class="main__form" id="personalInfoForm">
						<div class="form-unit-half-container">
							<div class="form-unit form-unit-half">
								<label for="fname">First Name</label> 
								<input type="text" class="input-with-icon user_name user_fname" name="fname" id="fname" placeholder="Enter First Name" required value="<%=currentUser.getFname()%>" />
							</div>
							<div class="form-unit form-unit-half">
								<label for="lname">Last Name</label> 
								<input type="text" class="input-with-icon user_name user_lname" name="lname" id="lname" placeholder="Enter Last Name" required value="<%=currentUser.getLname()%>" />
							</div>
						</div>
						<div class="form-unit form-unit-full">
							<label for="gender">Gender</label> 
							<select name="gender" id="gender" class="input-with-icon user_gender">
								<option value="default" selected disabled>Select Gender</option>
								<option value="Male"<%if(currentUser.getGender().equals("Male")){%>selected<%}%> >Male</option>
								<option value="Female"<%if(currentUser.getGender().equals("Female")){%>selected<%}%>>Female</option>
								<option value="Other"<%if(currentUser.getGender().equals("Other")){%>selected<%}%>>Other</option>
							</select>
						</div>
						<div class="form-unit form-unit-full">
							<label for="mobile_no">Mobile Number</label> 
							<input type="tel" class="input-with-icon user_tel" name="mobile_no" id="mobile_no" placeholder="Enter Mobile Number" required value="<%=currentUser.getMobile_no()%>"/>
						</div>
						<input type="hidden" name="cmd" value="changePersonalInfo" /> 
						<input type="submit" class="button flat-wide-button" value="Save Changes" />
					</form>
				</div>
			</div>
			<div class="main__container_inner" id="tab_2">
				<div class="main__form-container">
					<h2 class="main__sub-heading">Username and Email</h2>
					<form action="./UserController" method="post" class="main__form" id="usernameAndEmailForm">
						<div class="form-unit form-unit-full">
                                <label for="username">Username</label>
                                <input type="text" class="input-with-icon user_id" name="username" id="username"
                                    placeholder="Enter Username" required value="<%=currentUser.getUsername()%>"/>
                        </div>
						<div class="form-unit form-unit-full">
                                <label for="email_id">Email ID</label>
                                <input type="text" class="input-with-icon user_email" name="email_id" id="email_id"
                                    placeholder="Enter Email Adderss" required value="<%=currentUser.getEmail_id()%>" />
                         </div>
                         <div class="form-unit form-unit-full">
                                <label for="passwordSignIn">Password</label>
                                <input type="password" class="input-with-icon user_pass" name="password"
                                placeholder="Password required to save changes" required/>
                         </div>
						<input type="hidden" name="cmd" value="changeUsernameOrEmail" /> 
						<input type="submit" class="button flat-wide-button" value="Save Changes" />
					</form>
				</div>
			</div>
			<div class="main__container_inner" id="tab_3">
				<div class="main__form-container">
					<h2 class="main__sub-heading">Password</h2>
					<form action="./UserController" method="post" class="main__form" id="passwordForm">
                         <div class="form-unit form-unit-full">
                                <label for="passwordSignIn">Current Password</label>
                                <input type="password" class="input-with-icon user_pass" id="currentPassword" name="password"
                                placeholder="Enter Current Password" required/>
                          </div>
                          <div class="form-unit form-unit-full">
                                <label for="passwordSignIn">New Password</label>
                                <input type="password" class="input-with-icon user_pass" id="newPassword" name="newPassword"
                                placeholder="Enter New Password" required/>
                          </div>
                          <div class="form-unit form-unit-full">
                                <label for="passwordSignIn">Repeat Password</label>
                                <input type="password" class="input-with-icon user_pass" id="repPassword" name="repPassword"
                                placeholder="Repeat New Password" required/>
                          </div>
						<input type="hidden" name="cmd" value="changePassword" /> 
						<input type="submit" class="button flat-wide-button" value="Save Changes" />
					</form>
				</div>
			</div>
			<div class="main__container_inner" id="tab_4">
				<div class="main__form-container">
					<h2 class="main__sub-heading">Bank Account</h2>
					<%if(user.getBank_acc_id()<1){ %>
					<span class="form-info form-info_red">Bank Account is required to get refund in case of payment failure</span>
					<%}if(request.getParameter("msg")!=null){%>
					<span class="form-info form-info_green"> <%=request.getParameter("msg")%> </span>
					<%} %>
					<form action="./BankAccountController" method="post" class="main__form" id="bankAccForm">
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
					            <input type="text" name="holder_name" class="input-with-icon acc_holder" id="holder_name" required placeholder="Enter holder's name" >
					        </div>
					        <div class="form-unit form-unit-half">
					            <label for="ifsc_code">IFSC Code</label>
					            <input type="text" name="ifsc_code" class="input-with-icon bank" id="ifsc_code" required placeholder="Enter IFSC code">
					        </div>
					    </div>
					        <div class="form-unit form-unit-full">
                                <label for="passwordSignIn">Password</label>
                                <input type="password" class="input-with-icon user_pass" name="password"
                                placeholder="Password required to save changes" required/>
                         	</div>
						<input type="hidden" name="cmd" value="saveBankAcc" /> 
						<input type="submit" class="button flat-wide-button" value="Save Changes" />
					</form>
				</div>
			</div>
		</div>
		<%}else{ Tutor tutor = (Tutor)session.getAttribute("TUTOR"); %>
			<a href="./UserController?cmd=switchToUser&page=AccountSettings" class="button float-right-btn float-equally">Switch to User &gt;&gt;</a>
			<div class="main__acc-forms-container">
				<div class="tab-selector">
					<span class="tab-selector_tab tab_1 <%if(tutor.getBio().length()> 0){%>tab-selector_completed<%}%>" onclick="changeTab(1)" id="tab-selector_tab1">1. Bio</span>
					<span class="tab-selector_tab tab_2" onclick="changeTab(2)" id="tab-selector_tab2">2. Address</span>
					<span class="tab-selector_tab tab_3" onclick="changeTab(3)" id="tab-selector_tab3">3. Languages</span>
					<span class="tab-selector_tab tab_4" onclick="changeTab(4)" id="tab-selector_tab4">4. Experience</span>
					<span class="tab-selector_tab tab_5" onclick="changeTab(5)" id="tab-selector_tab5">5. Price</span>
				</div>
				<div class="main__container_inner" id="tab_1">
					<div class="main__form-container">
						<h2 class="main__sub-heading">Bio</h2>
						<form action="./TutorController" method="post" class="main__form" id="bioForm">
							<div class="form-unit form-unit-full">
								<label for="bio">Bio</label>
								<textarea class="input-with-icon user_bio" required name="bio" id="bio"
									placeholder="Tell us about yourself in a brief paragraph. In Less than 300 character."><%=tutor.getBio()%></textarea>
							</div>
							<input type="hidden" name="cmd" value="updateBio" />
							<input type="submit" class="button flat-wide-button" value="Save Changes" />
						</form>
					</div>
				</div>
				<div class="main__container_inner" id="tab_2">
					<div class="main__form-container">
						<h2 class="main__sub-heading">Address</h2>
						<form action="./TutorController" method="post" class="main__form" id="addressForm">
							<div class="form-unit-half-container">
								<div class="form-unit form-unit-half">
									<label for="street_address">Address</label> <input type="text" class="input-with-icon user_house"
										name="street_address" id="street_address" placeholder="House/Flat No., Block No, Street No."
										required />
								</div>
								<div class="form-unit form-unit-half">
									<label for="locality">Locality</label> <input type="text" class="input-with-icon user_location"
										id="locality" name="locality" placeholder="Enter Your Locality" required />
								</div>
							</div>
							<div class="form-unit-half-container">
								<div class="form-unit form-unit-half">
									<label for="district">District</label> <input type="text" class="input-with-icon user_location"
										id="district" name="district" placeholder="Enter Your District" required />
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
									<label for="pincode">Pincode</label> <input type="text" class="input-with-icon user_location"
										id="pincode" name="pincode" placeholder="Enter Your Pincode" required />
								</div>
							</div>
							<input type="hidden" name="cmd" value="saveAddress">
							<input type="submit" class="button flat-wide-button" value="Save Changes"/>
						</form>
					</div>
				</div>
				<div class="main__container_inner" id="tab_3">
					<div class="main__form-container">
						<h2 class="main__sub-heading">Languages</h2>
						<form action="./TutorController" method="post" class="main__form" id="languagesForm">
							<div class="checkboxs-container">
							</div>
							<input type="hidden" name="cmd" value="saveLanguages">
							<input type="submit" class="button flat-wide-button" value="Save Changes" />
						</form>
					</div>
				</div>
				<div class="main__container_inner" id="tab_4">
					<div class="main__form-container main__form-container_wider">
						<h2 class="main__sub-heading">Experiences</h2>
						<form action="./TutorController" method="post" class="main__form" >
							<button class=" button round-single-button addBtn">+</button>
							<div class="table-container scrollable">
								<table aria-label="Experience Table" id="experienceTable" class="white-table">
									<thead>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
							<input type="hidden" name="cmd" value="saveExperience">
						</form>
						<div class="main__form_overlayform" tabindex="-1">
						 	<a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
						 	<h2 class="main__sub-heading" id="experience_heading">Add Experience</h2>
						 	<form action="./TutorController" method="post" class="scrollable" id="addExperience">
						 		<div class="form-unit-half-container">
						 			<div class="form-unit form-unit-half">
						 				<label for="experience_type">Experience Type</label>
						 				<select name="experience_type" id="experience_type"
						 					class="input-with-icon input-with-icon_no-icon">
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
						 			<textarea class="input-with-icon input-with-icon_no-icon" required name="description"
						 				id="description"
						 				placeholder="Describe your experience in a brief paragraph. In Less than 300 character."></textarea>
						 		</div>
						 		<input type="hidden" name="cmd" value="addExperience">
						 		<input type="submit" class="button flat-wide-button" value="Add Experience" id="experience_submitBtn">
						 	</form>
						</div>
					</div>
				</div>
				<div class="main__container_inner " id="tab_5">
					<div class="main__form-container main__form-container_wider">
						<h2 class="main__sub-heading">Price</h2>
						<form action="./TutorController" method="post" class="main__form" >
							<button class=" button round-single-button addBtn">+</button>
							<div class="table-container scrollable">
								<table aria-label="Price Table" id="priceTable" class="white-table">
									<thead>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
							<input type="hidden" name="cmd" value="savePrice">
						</form>
						 <div class="main__form_overlayform" tabindex="-1">
						 	<a href="#" class="main__form_overlayform_cross" onclick="hideOverlayForm()">X</a>
						 	<h2 class="main__sub-heading">Add Price </h2>
						 	<form action="./TutorController" method="post" class="scrollable" id="addPrice">
						 		<div class="form-unit-half-container">
						 			<div class="form-unit form-unit-half">
						 				<label for="course_id">Course</label>
						 				<select name="course_id" id="course_id" class="input-with-icon input-with-icon_no-icon">
						 					<option value="default" selected disabled>Select Course</option>
						 				</select>
						 			</div>
						 			<div class="form-unit form-unit-half">
						 				<label for="duration_no">Year/Sem</label>
						 				<select name="duration_no" id="duration_no" class="input-with-icon input-with-icon_no-icon">
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
						 		<input type="hidden" name="subject_name" id="subject_name">
						 		<input type="hidden" name="cmd" value="addPrice">
						 		<input type="submit" class="button flat-wide-button" value="Add Price">
						 	</form>
						 </div>
					</div>
				</div>
			</div>
		<%}%>
	</main>
</div>
<script type="text/javascript">
	<%if(dashboardType.equals("TUTOR")){ %>
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
	<%}else{%>
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
        }
    });
}
<%}%>
function changeTab(tabNo) {
		$(".main__container_inner").css("display", "none");
		$("#tab_" + tabNo).css("display", "flex");
		$(".tab-selector_tab").removeClass("tab-selector_selected");
		$(".tab_" + tabNo).addClass("tab-selector_selected");
		var href = location.href;
		let nextURL;
		const nextTitle = 'TutorPod';
		const nextState = { additionalInformation: 'Updated the URL with JS' };
		if(href.includes("?")){
			href = href.substring(0,href.indexOf("tab="));
			if(href.substring(href.indexOf("?")).length>1)
				nextURL=href+"&tab="+tabNo;
			else
				nextURL=href+"tab="+tabNo;
		}
		else
			nextURL = href.substring(0,href.indexOf("tab="))+"?tab="+tabNo;
		window.history.pushState(nextState, nextTitle, nextURL);
		window.history.replaceState(nextState, nextTitle, nextURL);
		$('.tab-selector').animate({
			scrollLeft: $('#tab-selector_tab' + tabNo).offset().left
		}, 500);
	}
	$(document).ready(()=>{
		<%if(dashboardType.equals("TUTOR")){ %>
		loadLanguages();
		loadSubjects();
		loadAddress();
		loadSelectedLanguages();
		loadExperiences();
		loadPrices();
		<%}else{%>
		loadBankAcc();
		setTimeout(()=>{
			$(".form-info_green").remove();
		},4000);
		<%}%>
	let searchParams = new URLSearchParams(window.location.search);
	if(searchParams.has('tab'))
		changeTab(searchParams.get('tab'));
	else
		changeTab(1);
	<%if(dashboardType.equals("USER")){ %>
	$("#changePhotoBtn").click((e) => {
		$("#photo").click();
		e.preventDefault();
	});
	$("#photo").change(() => {
		var $form =  $("#photoForm");
		var dform = $("#photoForm")[0];
		var data = new FormData(dform);
		showLoading();
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: "./UserController",
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
				$form.trigger("reset");

				if (response.includes("Changed")) {
					const nextURL = location.href+"&msg="+response;
					const nextTitle = 'TutorPod';
					const nextState = { additionalInformation: 'Updated the URL with JS' };
					window.history.pushState(nextState, nextTitle, nextURL);
					window.history.replaceState(nextState, nextTitle, nextURL);
					location.reload();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
			}
		});
	});
	$("#removePhotoBtn").click((e)=>{
		e.preventDefault();
		if(!confirm("Are you sure you want to remove your profile photo?")){
			return;
		}else{
		showLoading();
		$.ajax({
			type: "POST",
			url: "./UserController",
			data: "cmd=removePhoto",
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
				if (response.includes("Removed")) {
					location.reload();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
			}
		});
		}
	});
	$(document).on("submit", "#personalInfoForm", function (event) {
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
					$("#snackbar").html(response);
					showToast();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
            });
    });
	$(document).on("submit", "#usernameAndEmailForm", function (event) {
		event.preventDefault();
        var $form = $(this);
        showLoading();
		if(isValidUsername($("#usernameAndEmailForm .user_id").val())){
        $.post($form.attr("action"), $form.serialize(), function (response) {
            hideLoading();
            $("#snackbar").html(response);
            showToast();
            console.log(response);
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
				$("#snackbar").html(response);
				showToast();
				$("#usernameAndEmailForm .user_pass").val("");
			}else{
				$("#snackbar").html(response);
				showToast();
				console.log(response);
			}
        });
	}else{
        $("#snackbar").html("Username Already Exists");
        showToast();
	}
	});
	$(document).on("submit", "#passwordForm", function (event) {
		event.preventDefault();
            var $form = $(this);
			if($("#newPassword").val() === $("#repPassword").val()){
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
					$("#snackbar").html(response);
					showToast();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
            });
			}else{
           		$("#snackbar").html("Passwords don't match");
                showToast();
				return;
		}
    });

	$(document).on("submit", "#bankAccForm", function (event) {
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
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
				}
            });
    });
	<%}else{%>
	$(document).on("submit", "#bioForm", function (event) {
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
					$("#snackbar").html(response);
					showToast();
				}else{
					$("#snackbar").html(response);
					showToast();
					console.log(response);
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
		<%}%>
	});
</script>
<%@include file="footer.jsp"%>