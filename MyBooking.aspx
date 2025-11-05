<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyBooking.aspx.cs" Inherits="goWheel.MyBooking" %>

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
                                <li class="breadcrumb-item active" aria-current="page">Appointments</li>
                            </ol>
                        </nav>
                        <h2 class="breadcrumb-title">My Ride</h2>
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
											<li class="active">
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
                        <div class="appointments">

                            <asp:Repeater ID="rptBookings" runat="server">
                                <ItemTemplate>
                                    <div class="appointment-list">
                                        <div class="profile-info-widget">
                                            <a href="#" class="booking-doc-img">
                                                <img src="Uploads/<%# Eval("BicycleImage1") %>" alt="User Image" />
                                            </a>
                                            <div class="profile-det-info">
                                                <h3><a href="#"><%# Eval("BicycleName") %></a></h3>
                                                <div class="patient-details">
                                                    <h5><i class="far fa-clock"></i><%# Eval("StartDate", "{0:dd MMM yyyy, hh:mm tt}") %></h5>
                                                    <h5>
                                                        <i class="fas fa-map-marker-alt text-danger"></i>
                                                        <a href="javascript:void(0);"
                                                            onclick='openLocationInMap(<%# Eval("Latitude") %>, <%# Eval("Longitude") %>)'
                                                            style="color: #007bff; font-weight: bold; text-decoration: underline;">
                                                            <%# Eval("City") %>, <%# Eval("Country") %>
                                                        </a>
                                                    </h5>
                                                    <h5><i class="fas fa-rupee-sign"></i><%# Eval("PerHourCharge", "{0:C}") %> per hour</h5>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="appointment-action">
                                            <a href="javascript:void(0);" onclick='showDetails(<%# Eval("BicycleID") %>)'
                                                class="btn btn-sm bg-info-light" data-toggle="modal" data-target="#appt_details">
                                                <i class="far fa-eye"></i>View
                                            </a>

                                            <%# Eval("PaymentStatus").ToString() == "clear"
                    ? $"<a href='Invoice.aspx?bookingId={Eval("BookingID")}' class='btn btn-sm bg-primary-light'><i class='fas fa-print'></i> Invoice</a>"
                    : $"<a href='javascript:void(0);' class='btn btn-sm bg-success-light openFareModal' data-toggle='modal' data-target='#fareModal' data-bicycleid='{Eval("BicycleID")}' data-bookingid='{Eval("BookingID")}' data-startdate='{Eval("StartDate", "{0:yyyy-MM-ddTHH:mm:ss}")}' data-charge='{Eval("PerHourCharge")}'><i class='fas fa-rupee-sign'></i> Drop & Pay</a>"
                                            %>

                                            <%# Convert.ToBoolean(Eval("CanCancel")) && Eval("PaymentStatus").ToString() != "clear"
                    ? $"<a href='javascript:void(0);' onclick='cancelBooking({Eval("BookingID")})' class='btn btn-sm bg-danger-light'><i class='fas fa-times'></i> Cancel</a>"
                    : "" %>
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

    <!-- Appointment Details Modal -->
    <!-- Bicycle Details Modal -->
    <div class="modal fade custom-modal" id="appt_details" tabindex="-1" role="dialog" aria-labelledby="bicycleDetailsModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h5 class="modal-title" id="bicycleDetailsModal">Bicycle Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <!-- Modal Body (Content gets injected here by JS) -->
                <div class="modal-body">
                    <p>Loading...</p>
                    <!-- Placeholder content -->
                </div>

            </div>
        </div>
    </div>


    <div class="modal fade" id="fareModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content p-3">
                <div class="modal-header">
                    <h5 class="modal-title">Drop & Pay</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <label>Select Drop Shop:</label>
                    <select id="shopDropdown" class="form-control mb-2"></select>
                    <div id="fareDetails" class="mt-3"></div>
                    <button id="confirmDrop" class="btn btn-primary w-100 mt-2">Confirm Drop & Pay</button>
                </div>
            </div>
        </div>
    </div>

    <!-- /Appointment Details Modal -->

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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
        <script src="assets/js/encry.js"></script>
</body>


<script>
    function showDetails(id) {
        $.ajax({
            type: "POST",
            url: "MyBooking.aspx/GetBicycleDetails",
            data: JSON.stringify({ BicycleID: id }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                let data = JSON.parse(response.d);

                if (data.error) {
                    $('#appt_details .modal-body').html('<p class="text-danger">No data found.</p>');
                } else {
                    let html = `
                        <div class="row">
                            <!-- Left side image -->
                            <div class="col-md-5 text-center">
                                <img src="uploads/${data.BicycleImage1}" class="img-fluid rounded mb-3" style="max-height: 250px;" />
                            </div>

                            <!-- Right side details -->
                            <div class="col-md-7">
                       
                                <h4 class="text-primary">${data.BicycleName}</h4>
                                <p><strong>Brand:</strong> ${data.BicycleBrand}</p>
                                <p><strong>Type:</strong> ${data.BicycleType}</p>
                                <p><strong>Features:</strong> ${data.BicycleFeatures}</p>
                                <p><strong>Description:</strong> ${data.BicycleDescription}</p>
                                <p><strong class="text-success">Rate per Hour:</strong> ₹${data.PerHourCharge}</p>
                                <hr />
                                <h5 class="mt-3">Shop Location</h5>
                                <p><strong>${data.StopName}</strong>, ${data.City}, ${data.Country}</p>
                                <p><i class="fas fa-phone"></i> ${data.ContactNumber}</p>
                            </div>
                        </div>
                    `;

                    // Inject content and show modal
                    $('#appt_details .modal-body').html(html);
                    $('#appt_details').modal('show');
                }
            },
            error: function () {
                $('#appt_details .modal-body').html('<p class="text-danger">Error fetching data.</p>');
                $('#appt_details').modal('show');
            }
        });
    }

</script>


<script>
    let selectedBicycleID = 0;
    let startDateTime = "";
    let perHourCharge = 0;
    let bookingId = 0;

    $(document).on('click', '.openFareModal', function () {
        selectedBicycleID = $(this).data('bicycleid');
        bookingId = $(this).data('bookingid');
        startDateTime = $(this).data('startdate');
        perHourCharge = parseFloat($(this).data('charge'));

        // Load shops
        $.ajax({
            type: "POST",
            url: "MyBooking.aspx/GetShops",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (res) {
                let shops = res.d;
                let options = shops.map(s => `<option value="${s.ShopID}">${s.StopName}</option>`);
                $('#shopDropdown').html(options);
            }
        });

        // Calculate fare dynamically
        $.ajax({
            type: "POST",
            url: "MyBooking.aspx/CalculateFare",
            data: JSON.stringify({ startDate: startDateTime, perHourCharge: perHourCharge }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (res) {
                let fare = res.d;
                $('#fareDetails').html(`
                    <h5>Total Hours: ${fare.Hours}</h5>
                    <h5>Total Fare: ₹ ${fare.TotalFare}</h5>
                    <h5>Discount: ${fare.DiscountPercent}%</h5>
                    <h5>Discounted Fare: ₹ ${fare.DiscountedFare}</h5>
                    <h5>Points Earned: ${fare.FarePoints}</h5>
                `);
            }
        });
    });

    // Confirm Drop
    $('#confirmDrop').click(function () {
        let shopId = $('#shopDropdown').val();

        $.ajax({
            type: "POST",
            url: "MyBooking.aspx/ConfirmDropAndPay",
            data: JSON.stringify({
                bicycleId: selectedBicycleID,
                startDate: startDateTime,
                perHourCharge: perHourCharge,
                shopId: shopId,
                bookingId: bookingId
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (res) {
                let result = res.d;

                if (result.Success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Drop Completed!',
                        html: `Points Earned: <b>${result.FarePoints}</b><br>Total Paid: ₹<b>${result.DiscountedFare}</b>`,
                        confirmButtonColor: '#28a745'
                    }).then(() => {
                        $('#fareModal').modal('hide');
                        location.reload(); // Optional: refresh page after payment
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Insufficient Balance',
                        text: result.Message,
                        confirmButtonColor: '#dc3545'
                    });
                }
            },
            error: function () {
                Swal.fire({
                    icon: 'error',
                    title: 'Error!',
                    text: 'Something went wrong. Please try again later.',
                    confirmButtonColor: '#dc3545'
                });
            }
        });
    });

</script>



<script>
    function cancelBooking(bookingId) {
        Swal.fire({
            title: "Are you sure?",
            text: "Do you want to cancel this booking?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Yes, cancel it!"
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: "POST",
                    url: "MyBooking.aspx/CancelBooking",
                    data: JSON.stringify({ bookingId: bookingId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function () {
                        Swal.fire("Cancelled!", "Your booking has been cancelled.", "success").then(() => {
                            location.reload(); // Refresh page
                        });
                    },
                    error: function () {
                        Swal.fire("Error", "Could not cancel booking.", "error");
                    }
                });
            }
        });
    }
</script>

</html>
