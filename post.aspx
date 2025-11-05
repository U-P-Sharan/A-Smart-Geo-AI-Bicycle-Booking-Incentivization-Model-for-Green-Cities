<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="post.aspx.cs" Inherits="goWheel.post" %>

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
										
											<li class="active">
												<a href="post.aspx">
													<i class="fas fa-star"></i>
													<span>Post</span>
												</a>
											</li>

                                            <li class="active">
				<a href="Managepost.aspx">
								<i class="fas fa-star"></i>
								<span>Manage Post</span>
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

                        <form id="postForm" runat="server" enctype="multipart/form-data">
                            <div class="card">
                                <div class="card-body">

                                    <h4 class="card-title">Create Post</h4>
                                  

                                    <div class="form-group">
                                        <asp:TextBox ID="txtPostText" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="4" placeholder="What's on your mind?"></asp:TextBox>
                                    </div>

                                    <div class="form-group">
                                        <asp:FileUpload ID="fileUploadPostImage" runat="server" CssClass="form-control" />
                                    </div>

                                    <div class="form-group">
                                        <asp:Button ID="btnSubmitPost" runat="server" Text="Post" CssClass="btn btn-primary" OnClick="btnSubmitPost_Click" />
                                    </div>

                                </div>
                            </div>
                        </form>


                        <div class="row row-grid">


                            <asp:Repeater ID="rptPosts" runat="server">
                                <ItemTemplate>
                                    <div class="col-md-6 col-lg-4 col-xl-3 post-block" data-postid='<%# Eval("PostID") %>'>
                                        <div class="profile-widget">
                                            <div class="doc-img">
                                                <img class="img-fluid" alt="User Image"
                                                    src='../<%# Eval("PostImagePath") %>'
                                                    style="width: 100%; height: 200px; object-fit: cover; border-radius: 6px;" />
                                            </div>
                                            <div class="pro-content">
                                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                                    <h3 class="title mb-0" style="font-size: 18px;"><%# Eval("FullName") %></h3>
                                                    <a href="javascript:void(0);" class="toggle-comments text-primary" style="font-size: 14px;">Comments</a>
                                                </div>
                                                <small class="post-date" style="display: none;"><%# Eval("PostDate", "{0:dd MMM yyyy HH:mm}") %></small>
                                                <p><%# Eval("PostText") %></p>

                                                <div class="comments" style="max-height: 100px; overflow-y: auto; margin-top: 10px; padding-right: 5px; display: none;">
                                                    <asp:Repeater ID="rptComments" runat="server" DataSource='<%# Eval("Comments") %>'>
                                                        <ItemTemplate>
                                                            <div class="comment" style="margin-bottom: 6px;">
                                                                <div style="font-size: 12px; color: #666;">
                                                                    <strong><%# Eval("CommentedBy") %></strong> - 
                                        <small><%# Eval("CommentDate", "{0:dd MMM yyyy HH:mm}") %></small>
                                                                </div>
                                                                <p style="font-size: 13px; margin: 2px 0 0 0;">
                                                                    <%# Eval("CommentText").ToString().Length > 16 ? Eval("CommentText").ToString().Substring(0, 16) + "..." : Eval("CommentText") %>
                                                                    <%# Eval("CommentText").ToString().Length > 16 ? "<a href='javascript:void(0);' class='read-more' data-full='" + Eval("CommentText") + "' style='font-size:12px; color:#007bff;'> Read more</a>" : "" %>
                                                                </p>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>

                                                <div class="add-comment mt-2">
                                                    <textarea class="form-control comment-text" rows="2" placeholder="Add a comment..."></textarea>
                                                    <button class="btn btn-primary btn-sm mt-2 submit-comment">Comment</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                            <script>
                                $(document).ready(function () {
                                    // Toggle comments section and post date
                                    $(document).on("click", ".toggle-comments", function () {

                                        var card = $(this).closest(".pro-content");
                                        card.find(".comments").slideToggle();
                                        card.find(".post-date").toggle();
                                    });

                                    // Show full comment on "Read more"
                                    $(document).on("click", ".read-more", function () {
                                        var fullText = $(this).data("full");
                                        $(this).parent().html(fullText);
                                    });
                                });
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
        <script src="assets/js/encry.js"></script>
    <script>
        $(document).on("click", ".submit-comment", function () {
            var container = $(this).closest(".post-block");
            var postID = container.data("postid");
            var commentText = container.find(".comment-text").val();

            if (commentText.trim() === "") {
                Swal.fire("Oops!", "Please enter a comment.", "warning");
                return;
            }

            $.ajax({
                type: "POST",
                url: "post.aspx/SubmitComment",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ postID: postID, commentText: commentText }),
                success: function (response) {
                    let res = response.d ? JSON.parse(response.d) : response;
                    if (res.success) {
                        Swal.fire("Success", "Comment added!", "success");
                        let html = `
                        <div class="comment">
                            <strong>${res.userName}</strong> - <small>${res.commentDate}</small>
                            <p>${res.commentText}</p>
                        </div>`;
                        container.find(".comments").append(html);
                        container.find(".comment-text").val('');
                    } else {
                        Swal.fire("Error", res.message, "error");
                    }
                },
                error: function () {
                    Swal.fire("Error", "Something went wrong!", "error");
                }
            });
        });
    </script>




</body>

<!-- doccure/favourites.html  30 Nov 2019 04:12:17 GMT -->
</html>
