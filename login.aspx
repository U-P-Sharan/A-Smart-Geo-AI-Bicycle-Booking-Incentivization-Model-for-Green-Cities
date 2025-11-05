<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="goWheel.login" %>

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
	<body class="account-page">

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
				<ul class="main-nav">
					<li class="active">
						<a href="index.aspx">Home</a>
					</li>
					<li class="has-submenu">
						<a href="#">Register <i class="fas fa-chevron-down"></i></a>
						<ul class="submenu">
							<li><a href="register.aspx">User Register</a></li>
						
							
						</ul>
					</li>	
				
					<li>
						<a href="login.aspx" target="_blank">Login</a>
					</li>
					<li class="login-link">
						<a href="register.aspx">Login / Signup</a>
					</li>
				</ul>		 
			</div>		 
			<ul class="nav header-navbar-rht">
				<li class="nav-item contact-item">
					<div class="header-contact-img">
						<i class="fas fa-phone"></i>							
					</div>
					<div class="header-contact-detail">
						<p class="contact-header">Contact</p>
						<p class="contact-info-header"> +91 9611652108</p>
					</div>
				</li>
			
			</ul>
		</nav>
	</header>
			<!-- /Header -->
			
			<!-- Page Content -->
			<div class="content">
				<div class="container-fluid">
					
					<div class="row">
						<div class="col-md-8 offset-md-2">
							
							<!-- Login Tab Content -->
							<div class="account-content">
								<div class="row align-items-center justify-content-center">
									<div class="col-md-7 col-lg-6 login-left">
										<img src="assets/img/login-banner.png" class="img-fluid" alt="Doccure Login">	
									</div>
									<div class="col-md-12 col-lg-6 login-right">
										<div class="login-header">
											<h3>Login </h3>
										</div>
										<form runat="server">
											<div class="form-group form-focus">
												<input type="email" runat="server" id="txtEmail" class="form-control floating" required>
												<label class="focus-label">Email</label>
											</div>
											<div class="form-group form-focus">
												<input type="password" runat="server" id="txtPassword" class="form-control floating"  pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" required>
												<label class="focus-label">Password</label>
											</div>
											<%--<div class="text-right">
												<a class="forgot-link" href="forgot-password.html">Forgot Password ?</a>
											</div>--%>
											<input  class="btn btn-primary btn-block btn-lg login-btn" type="submit" value="Sign in" runat="server" onserverclick="Unnamed_ServerClick"/>
											<div class="login-or">
												<span class="or-line"></span>
												<span class="span-or">or</span>
											</div>
										
											<div class="text-center dont-have">Don’t have an account? <a href="register.aspx">Register</a></div>
										</form>
									</div>
								</div>
							</div>
							<!-- /Login Tab Content -->
								
						</div>
					</div>

				</div>

			</div>		
			<!-- /Page Content -->
   
			<!-- Footer -->
			<footer class="footer">
				
		
				
				<!-- Footer Bottom -->
                <div class="footer-bottom">
					<div class="container-fluid">
					
						<!-- Copyright -->
						<div class="copyright">
							<div class="row">
								<div class="col-md-6 col-lg-6">
									<div class="copyright-text">
										<p class="mb-0"><a href="templateshub.net">CodeRedsolutions</a></p>
									</div>
								</div>
								<div class="col-md-6 col-lg-6">
								
									<!-- Copyright Menu -->
									<div class="copyright-menu">
										<ul class="policy-menu">
											<li><a href="#">Terms and Conditions</a></li>
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
		
		<!-- Custom JS -->
		<script src="assets/js/script.js"></script>
		
	</body>

<!-- doccure/login.html  30 Nov 2019 04:12:20 GMT -->
</html>