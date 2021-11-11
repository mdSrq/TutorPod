
<%
if (session.getAttribute("USER") == null) {
	response.sendRedirect("./");
	return;
}
%>
<%@page import="com.TutorPod.model.User"%>
<%@page import="com.TutorPod.model.BankAcc"%>
<%
	User currentUser = (User)session.getAttribute("USER");
%>
<%@include file="header.jsp"%>
<div class="flex-container">
	<%@include file="sidebar.jsp"%>
	<main class="main">
		<h1 class="main__heading">Account Settings</h1>
		<div class="main__acc-forms-container">
			<div class="tab-selector">
				<span href="#" class="tab-selector_tab tab_1 <%if(user.getPhoto()==null){%>tab-selector_exclamation<%}%>" onclick="changeTab(1)">Personal Info</span>
				<span href="#" class="tab-selector_tab tab_2" onclick="changeTab(2)">Username & Email</span> 
				<span href="#" class="tab-selector_tab tab_3" onclick="changeTab(3)">Password</span> 
				<span href="#" class="tab-selector_tab tab_4 <%if(user.getBank_acc_id()<1){%>tab-selector_error<%}%>" onclick="changeTab(4)">Bank Account</span> 
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
						<input type="file" name="photo" id="photo" accept=".jpg" style="display: none" />
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
					<%
						String bank_name = "";
						String acc_no = "";
						String holder_name = "";
						String ifsc_code = "";
						if(session.getAttribute("BANK_ACC")!=null){
							BankAcc bankAcc = (BankAcc)session.getAttribute("BANK_ACC"); 
							bank_name = bankAcc.getBank_name();
							acc_no = bankAcc.getAcc_no();
							holder_name = bankAcc.getHolder_name();
							ifsc_code = bankAcc.getIfsc_code();
						}
					%>
					<form action="./BankAccountController" method="post" class="main__form" id="bankAccForm">
						<div class="form-unit-half-container">
                          <div class="form-unit form-unit-half">
					            <label for="bank_name">Bank Name</label>
					            <input type="text" name="bank_name" class="input-with-icon bank" id="bank_name" required placeholder="Enter bank name " value="<%=bank_name%>">
					        </div>
					        <div class="form-unit form-unit-half">
					            <label for="acc_no">Account Number</label>
					            <input type="text" name="acc_no" class="input-with-icon acc_no" id="acc_no" required placeholder="Enter account number" value="<%=acc_no%>">
					        </div>
					    </div>
					    <div class="form-unit-half-container">
					        <div class="form-unit form-unit-half">
					            <label for="holder_name">Account Holder</label>
					            <input type="text" name="holder_name" class="input-with-icon acc_holder" id="holder_name" required placeholder="Enter holder's name" value="<%=holder_name%>">
					        </div>
					        <div class="form-unit form-unit-half">
					            <label for="ifsc_code">IFSC Code</label>
					            <input type="text" name="ifsc_code" class="input-with-icon bank" id="ifsc_code" required placeholder="Enter IFSC code" value="<%=ifsc_code%>">
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
	</main>
</div>
<script type="text/javascript">
	$(document).ready(()=>{
		setTimeout(()=>{
			$(".form-info_green").remove();
		},4000);
	});
	let searchParams = new URLSearchParams(window.location.search);
	if(searchParams.has('tab'))
		changeTab(searchParams.get('tab'));
	else
		changeTab(1);
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
	}
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
            });
    });
</script>
<%@include file="footer.jsp"%>