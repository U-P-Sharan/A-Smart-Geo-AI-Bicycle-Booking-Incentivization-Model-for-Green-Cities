<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="goWheel.register" %>

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
                     <li>
                           <a href="#" target="_blank">About Us</a>
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
                        <p class="contact-info-header">+91 9611652108</p>
                    </div>
                </li>
            </ul>
        </nav>
    </header>
    <!-- /Header -->
    
    <!-- Page Content -->
    <div class="content">
        <div class="container-fluid">
            <form id="form1" runat="server">
                <div class="row">
                    <div class="col-md-8 offset-md-2">
                        <!-- Register Content -->
                        <div class="account-content">
                            <div class="row align-items-center justify-content-center">
                                <div class="col-md-7 col-lg-6 login-left">
                                    <img src="assets/img/login-banner.png" class="img-fluid" alt="Go Wheel Register">
                                </div>
                                <div class="col-md-12 col-lg-6 login-right">
                                    <div class="login-header">
                                        <h3>User Register <a href="vendor-register.aspx"></a></h3>
                                    </div>
                                    <!-- Register Form -->
                                    <div class="form-group form-focus">
                                       <input type="text" id="txtFullName" name="txtFullName" runat="server"
pattern="^[a-zA-Z]+([ ]?[a-zA-Z]+)*$" title="Enter a valid name using only letters, spaces, hyphens, or apostrophes." class="form-control" required />

                                        <label class="focus-label">Full Name</label>
                                    </div>

                                    <div class="form-group form-focus">
                                        <input type="email" class="form-control floating" id="txtEmail" runat="server"
                                               pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Email address must be in a valid format (example: user@example.com)" required />
                                        <label class="focus-label">Email</label>
                                    </div>

                                    <div class="form-group form-focus">
                                        <input type="tel" class="form-control floating" id="txtPhone" runat="server"
                                               pattern="^\d{10}$" title="Phone number must be 10 digits" required />
                                        <label class="focus-label">Mobile Number</label>
                                    </div>

                                    <div class="form-group form-focus">
                                        <select id="utype" class="form-control floating" runat="server" required>
                                            <option selected="selected">User Type</option>
                                            <option>User</option>
                                            <option>Vendor</option>
                                        </select>
                                        <label class="focus-label">User Type</label>
                                    </div>

                                    <div class="form-group form-focus">
                                        <textarea class="form-control floating" id="txtAddress" runat="server" rows="2"></textarea>
                                        <label class="focus-label">Address</label>
                                    </div>

                                    <div class="form-group form-focus">
                                       <input type="password" id="txtPassword" name="txtPassword" runat="server"
pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d])[A-Za-z\d@$!%*?&]{8,}$"
title="Password must be at least 8 characters long, and include at least one uppercase letter, one lowercase letter, one number, and one special character."
class="form-control" required />


                                        <label class="focus-label">Create Password</label>
                                    </div>

                                    <div class="text-right">
                                        <a class="forgot-link" href="login.aspx">Already have an account?</a>
                                    </div>
                                    <div class="form-group form-check mb-3">
    <input type="checkbox" class="form-check-input" id="chkTerms" required />
    <label class="form-check-label" for="chkTerms"> I agree to the terms and Condition</label>      
</div>
                                    <div>
                                 <input type="submit" id="btnRegister" class="btn btn-primary btn-block btn-lg login-btn" value="Register" runat="server" onserverclick="btnRegister_Click" />

                                </div>
                            </div>
                        </div>
                        <!-- /Register Content -->
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- /Page Content -->
    
    <!-- Footer -->
    <footer class="footer">
        <!-- Footer Top -->
        <!-- Footer Bottom -->
        <div class="footer-bottom">
            <div class="container-fluid">
                <!-- Copyright -->
                <div class="copyright">
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="copyright-text">
                                <p class="mb-0"><a href="templateshub.net">CODEREDSOLUTIONS</a></p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <!-- Copyright Menu -->
                            <div class="copyright-menu">
                                <ul class="policy-menu">
                                    
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
    
    <!-- /Main Wrapper -->
    
    <!-- jQuery -->
    <script src="assets/js/jquery.min.js"></script>
    
    <!-- Bootstrap Core JS -->
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    
    <!-- Custom JS -->
    <script src="assets/js/script.js"></script>
       

</body>
<!-- doccure/register.html  30 Nov 2019 04:12:20 GMT -->
</html>
