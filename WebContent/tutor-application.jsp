<%try{ %>
<%@page import="com.TutorPod.model.Address"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.util.ArrayList"%>
<%@include file="header.jsp"%>
<%
boolean isUser = false;
boolean isTutor = false;
boolean hasBankAcc = false;
boolean hasPhoto = false;
boolean basicInfoCompleted = false;
boolean hasAddress = false;
boolean hasLanguages = false;
int user_id = 0;
String fname = "";
String lname = "";
String username = "";
String password = "";
String email_id = "";
String mobile_no = "";
String gender = "";
String photo = "";
String bio = "";
String street_address = "";
String locality = "";
String district = "";
String city = "";
String state = "";
String pincode = "";
String languages = "";
if (session.getAttribute("USER") != null) {
	User currentUser = (User) session.getAttribute("USER");
	isUser = true;
	if (currentUser.getBank_acc_id() > 0)
		hasBankAcc = true;
	if (currentUser.getPhoto() != null)
		hasPhoto = true;
	user_id = currentUser.getUser_id();
	fname = currentUser.getFname();
	lname = currentUser.getLname();
	username = currentUser.getUsername();
	email_id = currentUser.getEmail_id();
	mobile_no = currentUser.getMobile_no();
	gender = currentUser.getGender();
	photo = currentUser.getPhoto();
}
if(session.getAttribute("TUTOR")!=null){
	isTutor = true;
	Tutor tutor = (Tutor)session.getAttribute("TUTOR");
	bio=tutor.getBio();
	if(tutor.getAddress_id()>0){
		hasAddress = true;
		Address address = (Address)session.getAttribute("ADDRESS");
		if(address!=null){
			street_address = address.getStreet_address();
			locality = address.getLocality();
			district = address.getDistrict();
			city = address.getCity();
			state = address.getState();
			pincode = address.getPincode();
		}
	}
	if(session.getAttribute("LANGUAGES")!=null){
		hasLanguages=true;
		List<String[]> lang = (ArrayList<String[]>)session.getAttribute("LANGUAGES");
		ListIterator<String[]> langItr = lang.listIterator();
		int counter=0;
		while(langItr.hasNext()){
			languages += langItr.next()[1];
			if(counter==lang.size()-1)
				continue;
			languages +=", ";
			counter++;
		}
	}
}
basicInfoCompleted = isUser && isTutor && hasPhoto;
%>
<main class="grey-container">
	<div class="main__form-container main__form-container_shadowed">
		<h1 class="thin-H1">Tutor Application</h1>
		<div class="tab-selector">
			<span class="tab-selector_tab tab_1 <%if(basicInfoCompleted){%>tab-selector_completed<%}%>" id="tab-selector_tab1">1. Basic Info</span>
			<span class="tab-selector_tab tab_2 <%if(hasAddress){%>tab-selector_completed<%}%>" id="tab-selector_tab2">2. Address</span> 
			<span class="tab-selector_tab tab_3 <%if(hasLanguages){%>tab-selector_completed<%}%>" id="tab-selector_tab3">3. Languages</span> 
			<span class="tab-selector_tab tab_4 " id="tab-selector_tab4">4. Achievements</span> 
			<span class="tab-selector_tab tab_5 " id="tab-selector_tab5">5. Price</span>
			<span class="tab-selector_tab tab_6 " id="tab-selector_tab6">6. Bank Details</span>
		</div>
		<div class="main__form" id="tab_1">
			<form action="#" method="post" enctype="multipart/form-data" class="main__form-section"
				id="basicInfoForm">
				<h2 class="main__sub-heading"><%if(!basicInfoCompleted){%>Enter<%}%> Your Basic Info</h2>
				<%
				if (isUser) {
				%>
				<span>Following details will be used to create your tutor profile:</span>
				<p>
					<strong>Username :</strong>
					<%=username%>
				</p>
				<p>
					<strong>Full Name :</strong>
					<%=fname + lname%>
				</p>
				<p>
					<strong>Gender :</strong>
					<%=gender%>
				</p>
				<p>
					<strong>Email ID :</strong>
					<%=email_id%>
				</p>
				<p>
					<strong>Mobile No. :</strong>
					<%=mobile_no%>
				</p>
				<%if(isTutor){%>
				<p>
					<strong>Bio :</strong>
					<%=bio%>
				</p>
				<%}if(!basicInfoCompleted){%>
				<p><em>Some <strong>Required Information</strong> is missing please complete the following : </em></p>
				<%}%>
				<%
				} else {
				%>
				<div class="form-unit form-unit-full">
					<label for="username">Username</label> <input type="text"
						class="input-with-icon user_id" name="username"
						placeholder="Enter Username" required />
				</div>
				<div class="form-unit-half-container">
					<div class="form-unit form-unit-half">
						<label for="fname">First Name</label> <input type="text"
							class="input-with-icon user_name user_fname" name="fname"
							placeholder="Enter First Name" required />
					</div>
					<div class="form-unit form-unit-half">
						<label for="lname">Last Name</label> <input type="text"
							class="input-with-icon user_name user_lname" name="lname"
							placeholder="Enter Last Name" required />
					</div>
				</div>
				<div class="form-unit form-unit-full">
					<label for="password">Password</label> <input type="password"
						class="input-with-icon user_pass" name="password"
						placeholder="Enter Password" required />
				</div>
				<div class="form-unit form-unit-full">
					<label for="gender">Gender</label> 
					<select name="gender" class="input-with-icon user_gender" required>
						<option value="default" selected disabled>Select Gender</option>
						<option value="Male">Male</option>
						<option value="Female">Female</option>
						<option value="Other">Other</option>
					</select>
				</div>
				<div class="form-unit form-unit-full">
					<label for="email_id">Email ID</label> <input type="text"
						class="input-with-icon user_email" name="email_id"
						placeholder="Enter Email Adderss" required />
				</div>
				<div class="form-unit form-unit-full">
					<label for="mobile_no">Mobile Number</label> <input type="tel"
						class="input-with-icon user_tel" name="mobile_no"
						placeholder="Enter Mobile Number" required />
				</div>
				<%
				}
				if (!hasPhoto) {
				%>
				<div class="form-unit form-unit-full">
					<label for="photo">Photo</label> <input type="file"
						class="input-with-icon acc_holder" accept=".jpg"  name="photo" id="photo" required>
				</div>
				<%
				}
				%>
				<%if(!isTutor){ %>
				<div class="form-unit form-unit-full">
					<label for="bio">Bio</label>
					<textarea class="input-with-icon user_bio" required name="bio" id="bio"
						placeholder="Tell us about yourself in a brief paragraph. In Less than 300 character."></textarea>
				</div>
				<%} %>
				<input type="hidden" name="cmd" value="saveBasicInfo">
				<div class="main__form_footer">
					<button class="button flat-wide-button flat-hallow-button backBtn"
						id="backBtn_tab1" disabled>&lt; Back</button>
					<button type="submit"
						class="button flat-wide-button flat-wide-button_narrow saveBtn"
						id="saveBtn_tab1" <%if(basicInfoCompleted){%>disabled<%}%> >Save Details</button>
					<button class="button flat-wide-button flat-hallow-button nextBtn"
						id="nextBtn_tab1" <%if(!basicInfoCompleted){%>disabled<%}%> >Next &gt;</button>
				</div>
			</form>
		</div>

		<div class="main__form" id="tab_2">
			<form action="./TutorController" method="post" class="main__form-section"
				id="addressForm">
				<h2 class="main__sub-heading"><%if(!hasAddress){%>Enter<%}%> Your Address</h2>
				<%if(hasAddress){ %>
				<span>Following address will be used to create your tutor profile: </span>
				<p>
					<strong>Address :</strong>
					<%=street_address%>
				</p>
				<p>
					<strong>Locality :</strong>
					<%=locality%>
				</p>
				<p>
					<strong>District :</strong>
					<%=district%>
				</p>
				<p>
					<strong>City :</strong>
					<%=city%>
				</p>
				<p>
					<strong>State :</strong>
					<%=state%>
				</p>
				<p>
					<strong>Pincode :</strong>
					<%=pincode%>
				</p>
				<%}else{%>
				<div class="form-unit-half-container">
					<div class="form-unit form-unit-half">
						<label for="street_address">Address</label> <input type="text"
							class="input-with-icon user_house" name="street_address"
							placeholder="House/Flat No., Block No, Street No." required />
					</div>

					<div class="form-unit form-unit-half">
						<label for="locality">Locality</label> <input type="text"
							class="input-with-icon user_location" name="locality"
							placeholder="Enter Your Locality" required />
					</div>
				</div>
				<div class="form-unit-half-container">
					<div class="form-unit form-unit-half">
						<label for="district">District</label> <input type="text"
							class="input-with-icon user_location" name="district"
							placeholder="Enter Your District" required />
					</div>
					<div class="form-unit form-unit-half">
						<label for="district">City</label> <input type="text"
							class="input-with-icon user_location" name="city"
							placeholder="Enter Your District" required />
					</div>
				</div>
				<div class="form-unit-half-container">
					<div class="form-unit form-unit-half">
						<label for="state">State</label> <input type="text"
							class="input-with-icon user_location" name="state"
							placeholder="Enter Your State" required />
					</div>
					<div class="form-unit form-unit-half">
						<label for="pincode">Pincode</label> <input type="text"
							class="input-with-icon user_location" name="pincode"
							placeholder="Enter Your Pincode" required />
					</div>
				</div>
				<%}%>
                <input type="hidden" name="cmd" value="saveAddress">
                <div class="main__form_footer">
                    <button class="button flat-wide-button flat-hallow-button backBtn" id="backBtn_tab2">&lt; Back</button>
                    <button type="submit" class="button flat-wide-button flat-wide-button_narrow saveBtn" id="saveBtn_tab2"
                        <%if(hasAddress){%>disabled<%}%> >Save Details</button>
                    <button class="button flat-wide-button flat-hallow-button nextBtn" id="nextBtn_tab2"
                        <%if(!hasAddress){%>disabled<%}%> >Next &gt;</button>
                </div>
			</form>
		</div>
		<div class="main__form" id="tab_3">
			<form action="./TutorController" method="post" class="main__form-section"
				id="languagesForm">
				<h2 class="main__sub-heading"><%if(!hasLanguages){%>Select<%}%> Languages You Speak</h2>
				<%if(hasLanguages){%>
					<span>Following languages will be added to your tutor profile: </span>
					<p>
						<strong>Languages Chosen :</strong>
						<%=languages%>
					</p>
				<%}else{%>
                <div class="checkboxs-container">

                </div>
                <%}%>
                <input type="hidden" name="cmd" value="saveLanguages">
                <div class="main__form_footer">
                    <button class="button flat-wide-button flat-hallow-button backBtn" id="backBtn_tab3">&lt; Back</button>
                    <button type="submit" class="button flat-wide-button flat-wide-button_narrow saveBtn" id="saveBtn_tab3"
                        <%if(hasLanguages){%>disabled<%}%> >Save Details</button>
                    <button class="button flat-wide-button flat-hallow-button nextBtn" id="nextBtn_tab3" <%if(!hasLanguages){%>disabled<%}%>
                            >Next &gt;</button>
                </div>
			</form>
		</div>
		<div class="main__form" id="tab_4">
			<form action="#" method="post" class="main__form-section"
				id="experienceForm">
				<h2 class="main__sub-heading">Add Your Experience</h2>
				<div class="table-container scrollable">
					<table aria-label="Experience Table" class="white-table">
						<thead>
							<th>Experience Type</th>
							<th>Experience</th>
							<th>Duration</th>
							<th>Description</th>
							<th>Actions</th>
						</thead>
						<tbody>
							<td>Education</td>
							<td>10th <br>Victor Public School <br> Delhi
							</td>
							<td>2010 - 2015</td>
							<td>Completed Secondary Education</td>
							<td><a href="#"
								class="button small-round-button delete-button">Delete</a></td>
						</tbody>
					</table>
				</div>
				<button class=" button round-single-button ">+</button>
                <div class="main__form_footer">
                    <button class="button flat-wide-button flat-hallow-button backBtn" id="backBtn_tab4">&lt; Back</button>
                    <button type="submit" class="button flat-wide-button flat-wide-button_narrow saveBtn" id="saveBtn_tab4"
                        <%if(false){%>disabled<%}%> >Save Details</button>
                    <button class="button flat-wide-button flat-hallow-button nextBtn" id="nextBtn_tab4" <%if(false){%>disabled<%}%>
                            >Next &gt;</button>
                </div>
			</form>
		</div>
	</div>
</main>

<script type="text/javascript">
    $(document).ready(()=>{
        loadLanguages();
        let searchParams = new URLSearchParams(window.location.search);
        if (searchParams.has('tab'))
            changeTab(searchParams.get('tab'));
        else
            changeTab(1);
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
            $('.tab-selector').animate({
                scrollLeft: $('#tab-selector_tab' + tabNo).offset().left - 10
            }, 500);
        }
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
                        location.reload();
                    } else {
                        $("#snackbar").html(response);
                        showToast();
                        console.log(response);
                    }
                }
            });
        });
        $(document).on("submit", "#addressForm", function (event) {
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
                        location.reload();
                    } else {
                        $("#snackbar").html(response);
                        showToast();
                        console.log(response);
                    }
                });
        });
        $(document).on("submit", "#languagesForm", function (event) {
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
                    location.reload();
                } else {
                    $("#snackbar").html(response);
                    showToast();
                    console.log(response);
                }
            });
        });
        $(".backBtn").click(function(event) {
            event.preventDefault();
            var id = $(this).attr("id");
            var tab = parseInt(id.substring(id.length - 1));
            changeTab(tab - 1);
        });
        $(".nextBtn").click(function (event) {
            event.preventDefault();
            var id = $(this).attr("id");
            var tab = parseInt(id.substring(id.length-1));
            changeTab(tab+1);
        });
    });
    function loadLanguages() {
        $.ajax({
            url: "./TutorController",
            data: "cmd=loadLanguages",
            success: function (response) {
                $.each(response, function (i, lang) {
                    if(i==1){
                        $(".checkboxs-container").append('<label class="check-container">' + lang[1] + '<input type = "checkbox" checked="checked" name="languages" value="' + lang[0] + '" ><span class="check"></span></label >');
                        return;
                    }
                    $(".checkboxs-container").append('<label class="check-container">' + lang[1] + '<input type = "checkbox" name="languages" value="' + lang[0] + '" ><span class="check"></span></label >');
                });
            }
        });
    }
</script>
<%@include file="footer.jsp"%>
<%}catch(Exception e){
	out.print(e.getMessage());
}
%>