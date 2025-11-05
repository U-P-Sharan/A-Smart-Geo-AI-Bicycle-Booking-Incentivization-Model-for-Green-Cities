<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Recharge.aspx.cs" Inherits="goWheel.Recharge" %>

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
                                <li class="breadcrumb-item active" aria-current="page">Favourites</li>
                            </ol>
                        </nav>
                        <h2 class="breadcrumb-title">Favourites</h2>
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
											<li class="active">
												<a href="Recharge.aspx">
													<i class="fas fa-star"></i>
													<span>Recharge</span>
												</a>
											</li>
										
												<li>
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


                        							<div class="row">
								<div class="col-md-12">
									<div class="card dash-card">
										<div class="card-body">
											<div class="row">
												<div class="col-md-12 col-lg-4">
													<div class="dash-widget dct-border-rht">
														<div class="circle-bar circle-bar1">
															<div class="circle-graph1" data-percent="75">
																<i class="fas fa-hand-o-right" aria-hidden="true"></i>
															</div>
														</div>
														<div class="dash-widget-info">
															<h6>Sweat Coins</h6>
															<h3>
															<asp:Label ID="fp" runat="server"></asp:Label></h3>
															<p class="text-muted">Till Today</p>
														</div>
													</div>
												</div>
												
												<div class="col-md-12 col-lg-4">
													<div class="dash-widget dct-border-rht">
														<div class="circle-bar circle-bar2">
															<div class="circle-graph2" data-percent="65">
																<img src="assets/img/icon-02.png" class="img-fluid" alt="Patient">
															</div>
														</div>
														<div class="dash-widget-info">
															<h6>My Wallet</h6>
															<h3>
<asp:Label ID="mw" runat="server"></asp:Label></h3>
														<p class="text-muted">Till Today</p>
														</div>
													</div>
												</div>
												
												<div class="col-md-12 col-lg-4">
													<div class="dash-widget">
														<div class="circle-bar circle-bar3">
															<div class="circle-graph3" data-percent="50">
																<img src="assets/img/icon-03.png" class="img-fluid" alt="Patient">
															</div>
														</div>
														<div class="dash-widget-info">
															<h6>My Ride</h6>
															<h3>
<asp:Label ID="mr" runat="server"></asp:Label></h3>
														<p class="text-muted">Till Today</p>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>





                        <form id="postForm" runat="server" enctype="multipart/form-data">


                            <div class="card">
                                <div class="card-body">




                                    <hr />
                                    <h5 class="mb-3">Payment Information</h5>

                                    <div class="form-group">
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Full Name"></asp:TextBox>
                                    </div>

                                    <div class="form-group">
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email Address"></asp:TextBox>
                                    </div>

                                    <div class="form-group">
                                        <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" placeholder="Card Number"></asp:TextBox>
                                    </div>

                                    <div class="form-group">
                                        <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" placeholder="CVV"></asp:TextBox>
                                    </div>

                                    <div class="form-group">
                                        <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Amount"></asp:TextBox>
                                    </div>

                                    <div class="form-group">
                                        <asp:Button ID="btnSubmitPost" runat="server" Text="Redeem Sweatcoins" CssClass="btn btn-primary" OnClick="btnSubmitPost_Click" />
                                    </div>

                                </div>
                            </div>
                        </form>


                        <div class="row">
                            <div class="col-md-12">
                                <h4 class="mb-4">Fare Point Information</h4>
                                <div class="appointment-tab">



                                    <div class="tab-content">

                                        <!-- Upcoming Appointment Tab -->
                                        <div class="tab-pane show active" id="upcoming-appointments">
                                            <div class="card card-table mb-0">
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                    <asp:Repeater ID="rptFarePoints" runat="server">
    <HeaderTemplate>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Ride Info</th>
                    <th>Points Earned</th>
                    <th>Points Used</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td>
                RideID: <%# Eval("RideID") %><br />
                BicycleID: <%# Eval("BicycleID") %><br />
                StartDate: <%# Eval("StartDate") %><br />
                EndDate: <%# Eval("EndDate") %><br />
                TotalAmount: <%# Eval("TotalAmount") %>
            </td>
            <td><%# Eval("PointsEarned") %></td>
            <td><%# Eval("PointsUsed") %></td>
            <td>
                <button class="btn btn-success btn-sm" onclick="addToWallet(<%# Eval("PointID") %>, <%# Eval("PointsEarned") %>)">Add to Wallet</button>
            </td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /Upcoming Appointment Tab -->



                  

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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
        <script src="assets/js/encry.js"></script>
</body>
    <script>
        function addToWallet(pointID, pointsEarned) {
            swal({
                title: "Are you sure?",
                text: "You are about to add " + pointsEarned + " points to your wallet.",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
                .then((willAdd) => {
                    if (willAdd) {
                        $.ajax({
                            type: "POST",
                            url: "Recharge.aspx/AddPointsToWallet",
                            data: JSON.stringify({ pointID: pointID, points: pointsEarned }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                if (response.d === "Success") {
                                    swal("Success!", "Points added to your wallet.", "success");
                                    location.reload();
                                    // Optionally, update the UI or reload the page
                                } else {
                                    swal("Error!", "Failed to add points. Please try again.", "error");
                                }
                            },
                            error: function () {
                                swal("Error!", "An unexpected error occurred.", "error");
                            }
                        });
                    }
                });
        }

    </script>
<!-- doccure/favourites.html  30 Nov 2019 04:12:17 GMT -->
</html>
