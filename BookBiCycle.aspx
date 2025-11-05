<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookBiCycle.aspx.cs" Inherits="goWheel.BookBiCycle" %>

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
		
		<!-- Datetimepicker CSS -->
		<link rel="stylesheet" href="assets/css/bootstrap-datetimepicker.min.css">
		
		<!-- Select2 CSS -->
		<link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">
		
		<!-- Fancybox CSS -->
		<link rel="stylesheet" href="assets/plugins/fancybox/jquery.fancybox.min.css">
		
		<!-- Main CSS -->
		<link rel="stylesheet" href="assets/css/style.css">
		
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
			<script src="assets/js/html5shiv.min.js"></script>
			<script src="assets/js/respond.min.js"></script>
		<![endif]-->
	 <style>
        ul {
            padding: 0;
            list-style-type: none;
        }

        li {
            display: inline-block;  /* Images in a row */
            margin-right: 10px;     /* Space between images */
        }

        .small-img {
            width: 50px;  /* Fixed size */
            height: 50px; /* Fixed size */
            object-fit: cover; /* Ensure the image is cropped to fit */
        }
    </style>
	</head>
	<body>

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
						<div class="col-md-8 col-12">
							<nav aria-label="breadcrumb" class="page-breadcrumb">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="dashboard.aspx">Home</a></li>
									<li class="breadcrumb-item active" aria-current="page">Search</li>
								</ol>
							</nav>
							<h2 class="breadcrumb-title">List of BiCycle</h2>
						</div>
					
					</div>
				</div>
			</div>
			<!-- /Breadcrumb -->
			
			<!-- Page Content -->
			<div class="content">
				<div class="container-fluid">

					<div class="row">
						<div class="col-md-12 col-lg-2 col-xl-2">
							</div>
						
						<div class="col-md-12 col-lg-8 col-xl-9">
							<form runat="server">
							<!-- Doctor Widget -->
						<asp:Repeater ID="rptBicycles" runat="server">
    <ItemTemplate>
        <div class="card mb-3">
            <div class="card-body">
                <div class="doctor-widget">
                    <div class="doc-info-left">
                        <div class="doctor-img">
                            <img src='Uploads/<%# Eval("BicycleImage1") %>' class="img-fluid" alt="Bicycle Image">
                        </div>
                        <div class="doc-info-cont">
                            <h4 class="doc-name"><%# Eval("BicycleName") %></h4>
                            <p class="doc-speciality"><%# Eval("BicycleBrand") %> - <%# Eval("BicycleModel") %></p>
                            <h5 class="doc-department"><i class="fas fa-mountain text-success"></i>0 <%# Eval("BicycleType") %></h5>
                            <div class="clinic-details">
               <h5>
       <i class="fas fa-map-marker-alt text-danger"></i>
       <a href="#"
          style="color: #007bff; font-weight: bold; text-decoration: underline;"
          onclick='openLocationInMap(<%# Eval("Latitude") %>, <%# Eval("Longitude") %>)'>
           <%# Eval("City") %>, <%# Eval("StopName") %>
       </a>
   </h5>
                                <ul class="clinic-gallery">
                             <ul>
    <li><img src='Uploads/<%# Eval("BicycleImage1") %>' alt="Image 1" class="small-img" /></li>
    <li><img src='Uploads/<%# Eval("BicycleImage2") %>' alt="Image 2" class="small-img" /></li>
    <li><img src='Uploads/<%# Eval("BicycleImage3") %>' alt="Image 3" class="small-img" /></li>
</ul>
                                </ul>
                            </div>
                            <div class="clinic-services">
                                <span><%# Eval("BicycleFeatures") %></span>
                                <span><%# Eval("BicycleCondition") %></span>
                            </div>
                        </div>
                    </div>
                    <div class="doc-info-right">
                        <div class="clini-infos">
                            <ul>
                                <li><i class="far fa-thumbs-up"></i> <%# Eval("BicycleYear") %></li>
                                <li><i class="far fa-comment"></i> <%# Eval("BicycleQuantity") %> in Stock</li>
                                <li><i class="far fa-money-bill-alt"></i> Rs.<%# Eval("PerHourCharge") %> /hr</li>
                            </ul>
                        </div>
                        <div class="clinic-booking">
                            
                            <a class="apt-btn" href="#" onclick='book(<%# Eval("BicycleID") %>)'>Book</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
								    <script>
                                        function openLocationInMap(lat, lng) {
                                            const url = `https://www.google.com/maps?q=${lat},${lng}`;
                                            window.open(url, '_blank');
                                        }
                                    </script>
<div class="load-more text-center">
<asp:Button ID="btnLoadMore" runat="server" CssClass="btn btn-primary" Text="Load More" OnClick="btnLoadMore_Click" />
	</div>	
							<!-- /Doctor Widget -->

		</form>


				

						
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
		
		<!-- Select2 JS -->
		<script src="assets/plugins/select2/js/select2.min.js"></script>
		
		<!-- Datetimepicker JS -->
		<script src="assets/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-datetimepicker.min.js"></script>
		
		<!-- Fancybox JS -->
		<script src="assets/plugins/fancybox/jquery.fancybox.min.js"></script>
		
		<!-- Custom JS -->
		<script src="assets/js/script.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
        <script src="assets/js/encry.js"></script>

	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function book(bicycleId) {
        $.ajax({
            type: "POST",
            url: "BookBiCycle.aspx/GetBicycleDetails",
            data: JSON.stringify({ bicycleId: bicycleId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                const data = response.d;
                Swal.fire({
                    title: `<strong>🚴 Your Booking Details</strong>`,
                    html: `
        <div style="text-align: center; font-size: 16px; line-height: 1.8;">
            <p><strong>📌 Bicycle Name:</strong> ${data.BicycleName}</p>
            <p><strong>💵 Rate per Hour:</strong> ₹${data.PerHourCharge}</p>
        </div>
    `,
                    icon: "info",
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: "✅ Confirm Booking",
                    cancelButtonText: "❌ Cancel"
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "POST",
                            url: "BookBiCycle.aspx/BookBicycle",
                            data: JSON.stringify({ bicycleId: bicycleId }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function () {
                                Swal.fire("Booked!", "Your booking has been confirmed.", "success");
                            },
                            error: function () {
                                Swal.fire("Error", "Something went wrong.", "error");
                            }
                        });
                    }
                });
            },
            error: function () {
                Swal.fire("Error", "Could not fetch bicycle details.", "error");
            }
        });
    }
</script>
	</body>

<!-- doccure/search.html  30 Nov 2019 04:12:16 GMT -->
</html>