<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="changepswd.aspx.cs" Inherits="goWheel.changepswd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta charset="utf-8">
		<title>Go Wheel</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
		
		<!-- Favicons -->
		<link href="assets/img/favicon.png" rel="icon">
		
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="assets/css/bootstrap.min.css">
		
		<!-- Fontawesome CSS -->
		<link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
		<link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">
		
		<!-- Main CSS -->
		<link rel="stylesheet" href="assets/css/style.css">
		
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
			<script src="assets/js/html5shiv.min.js"></script>
			<script src="assets/js/respond.min.js"></script>
		<![endif]-->
	
	</head>
	<body>

		<!-- Main Wrapper -->
		<div class="main-wrapper">
		
			<!-- Header -->
		<header class="header">
	<nav class="navbar navbar-expand-lg header-nav">
		<div class="navbar-header">
			<a id="mobile_btn" href="javascript:void(0);">
				<span class="bar-icon">
					<span></span>
					<span></span>
					<span></span>
				</span>
			</a>
			<a href="#" class="navbar-brand logo">
				<img src="assets/img/logo.png" class="img-fluid" alt="Logo">
			</a>
		</div>
		<div class="main-menu-wrapper">
			<div class="menu-header">
				<a href="#" class="menu-logo">
					<img src="assets/img/logo.png" class="img-fluid" alt="Logo">
				</a>
				<a id="menu_close" class="menu-close" href="javascript:void(0);">
					<i class="fas fa-times"></i>
				</a>
			</div>
		
		</div>		 
		<ul class="nav header-navbar-rht">
			<li class="nav-item contact-item">
				<div class="header-contact-img">
					<i class="far fa-hospital"></i>							
				</div>
				<div class="header-contact-detail">
					<p class="contact-header">Contact</p>
					<p class="contact-info-header"> +92 6363364672</p>
				</div>
			</li>
			
	
			
		</ul>
	</nav>
</header>
			<!-- /Header -->
			
			<!-- Breadcrumb -->
			<div class="breadcrumb-bar">
				<div class="container-fluid">
					<div class="row align-items-center">
						<div class="col-md-12 col-12">
							<nav aria-label="breadcrumb" class="page-breadcrumb">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="#">Home</a></li>
									<li class="breadcrumb-item active" aria-current="page">Change Password</li>
								</ol>
							</nav>
							<h2 class="breadcrumb-title">Change Password</h2>
						</div>
					</div>
				</div>
			</div>
			<!-- /Breadcrumb -->
			
			<!-- Page Content -->
			<div class="content">
				<div class="container-fluid">
					<div class="row">
										<div class="col-md-5 col-lg-4 col-xl-3 theiaStickySidebar">
							
							<!-- Profile Sidebar -->
							<div class="profile-sidebar">
							<div class="widget-profile pro-widget-content">
    <div class="profile-info-widget">
        <a href="#" class="booking-doc-img">
            <asp:Image ID="imgProfile" runat="server" Width="100px" Height="100px" />
        </a>
        <div class="profile-det-info">
            <h3><asp:Label ID="lblFullName" runat="server" Text="Dr. Darren Elder"></asp:Label></h3>
        </div>
    </div>
</div>
								<div class="dashboard-widget">
									<nav class="dashboard-menu">
										<ul>
											<li>
												<a href="dashboard.aspx">
													<i class="fas fa-columns"></i>
													<span>Dashboard</span>
												</a>
											</li>
											<li>
												<a href="BookBiCycle.aspx">
													<i class="fas fa-calendar-check"></i>
													<span>Book BiCycle</span>
												</a>
											</li>
											<li>
												<a href="Profile.aspx">
													<i class="fas fa-user-injured"></i>
													<span>Profile Settings</span>
												</a>
											</li>
											<li>
												<a href="mybooking.aspx">
													<i class="fas fa-hourglass-start"></i>
													<span>My Ride</span>
												</a>
											</li>
										
											<li>
												<a href="post.aspx">
													<i class="fas fa-star"></i>
													<span>Post</span>
												</a>
											</li>
											<li>
												<a href="Recharge.aspx">
													<i class="fas fa-star"></i>
													<span>Recharge</span>
												</a>
											</li>
										
												<li class="active"> 
												<a href="changepswd.aspx">
													<i class="fas fa-lock"></i>
													<span>Change Password</span>
												</a>
											</li>
											<li>
											<a href="logout.aspx">
													<i class="fas fa-sign-out-alt"></i>
													<span>Logout</span>
												</a>
											</li>
										</ul>
									</nav>
								</div>
							</div>
							<!-- /Profile Sidebar -->
							
						</div>
						<div class="col-md-7 col-lg-8 col-xl-9">
    <div class="card">
        <div class="card-body">
            <div class="row">
                <div class="col-md-12 col-lg-6">

                    <!-- Change Password Form -->
                    <form id="changePasswordForm" onsubmit="return false;">
                        <div class="form-group">
                            <label>Old Password</label>
                            <input type="password" class="form-control" id="oldPassword">
                        </div>
                        <div class="form-group">
                            <label>New Password</label>
                            <input type="password" class="form-control" id="newPassword">
                        </div>
                        <div class="form-group">
                            <label>Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword">
                        </div>
                        <div class="submit-section">
                            <button type="button" class="btn btn-primary submit-btn" onclick="validateOldPassword()">Save Changes</button>
                        </div>
                    </form>
                    <!-- /Change Password Form -->

                </div>
            </div>
        </div>
    </div>
</div>
					</div>
				</div>

			</div>		
			<!-- /Page Content -->
   
			<!-- Footer -->
			<footer class="footer">
		
		<!-- Footer Top -->
	
		<!-- /Footer Top -->
		
		<!-- Footer Bottom -->
        <div class="footer-bottom">
			<div class="container-fluid">
			
				<!-- Copyright -->
				<div class="copyright">
					<div class="row">
						<div class="col-md-6 col-lg-6">
							<div class="copyright-text">
								<p class="mb-0"><a href="#"><span id="developer-info"></span></a></p>
							</div>
						</div>
						<div class="col-md-6 col-lg-6">
						
							<!-- Copyright Menu -->
							<div class="copyright-menu">
								<ul class="policy-menu">
									<li><a href="#"><span id="phone-info"></span> </a></li>
									<li><a href="#">Policy</a></li>
								</ul>
							</div>
							<!-- /Copyright Menu -->
							
						</div>
					</div>
				</div>
				<!-- /Copyright -->
				
			</div>
		</div>
		<!-- /Footer Bottom -->
		
	</footer>
			<!-- /Footer -->
		   
		</div>
		<!-- /Main Wrapper -->
	  
		<!-- jQuery -->
		<script src="assets/js/jquery.min.js"></script>
		
		<!-- Bootstrap Core JS -->
		<script src="assets/js/popper.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		
		<!-- Sticky Sidebar JS -->
        <script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
        <script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>
		
		<!-- Custom JS -->
		<script src="assets/js/script.js"></script>

		<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
        <script src="assets/js/encry.js"></script>
		<script>
    function validateOldPassword() {
        var oldPassword = $('#oldPassword').val();

        if (oldPassword.trim() === '') {
            alert('Old password cannot be empty');
            return;
        }

        $.ajax({
            type: "POST",
            url: "changepswd.aspx/CheckOldPassword",
            data: JSON.stringify({ oldPassword: oldPassword }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d) {
                    // If old password is correct, check new password and confirm password
                    var newPassword = $('#newPassword').val();
                    var confirmPassword = $('#confirmPassword').val();

                    if (newPassword !== confirmPassword) {
                        alert('New password and confirm password do not match.');
                    } else {
                        changePassword(newPassword);
                    }
                } else {
                    alert('Old password is incorrect.');
                }
            },
            error: function (error) {
                alert('Error: ' + error);
            }
        });
    }

    function changePassword(newPassword) {
        $.ajax({
            type: "POST",
            url: "changepswd.aspx/ChangePassword",
            data: JSON.stringify({ newPassword: newPassword }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d) {
					alert('Password updated successfully!');
					window.location.href = "login.aspx";
                    // Optionally, redirect or clear form inputs.
                } else {
                    alert('Error updating password.');
                }
            },
            error: function (error) {
                alert('Error: ' + error);
            }
        });
    }
        </script>
	</body>

<!-- doccure/doctor-change-password.html  30 Nov 2019 04:12:36 GMT -->
</html>
