using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goWheel
{
    public partial class post : System.Web.UI.Page
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPosts();
                LoadProfile();
            }
        }
        private void LoadProfile()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            //int userId = 3; // (You can replace this with Session["UserID"])
            int userId = Convert.ToInt32(Session["UserID"]);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT FullName, ImagePath FROM Users WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblFullName.Text = reader["FullName"].ToString();

                    string imagePath = reader["ImagePath"]?.ToString();
                    if (string.IsNullOrEmpty(imagePath))
                    {
                        imgProfile.ImageUrl = "http://localhost:55034/assets/img/dummy.jpeg";
                    }
                    else
                    {
                        imgProfile.ImageUrl = imagePath;
                    }
                }
                else
                {
                    // If no user found, set default values
                    lblFullName.Text = "Unknown User";
                    imgProfile.ImageUrl = "http://localhost:55034/assets/img/dummy.jpeg";
                }
                con.Close();
            }
        }
        private void LoadPosts()
        {
            DataTable posts = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT P.PostID, P.PostText, P.PostImagePath, P.PostDate, U.FullName
                             FROM Posts P
                             INNER JOIN Users U ON P.UserID = U.UserID
                             ORDER BY P.PostDate DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.Fill(posts);
            }

            List<PostWithComments> postList = new List<PostWithComments>();
            foreach (DataRow row in posts.Rows)
            {
                var post = new PostWithComments
                {
                    PostID = Convert.ToInt32(row["PostID"]),
                    FullName = row["FullName"].ToString(),
                    PostText = row["PostText"].ToString(),
                    PostImagePath = row["PostImagePath"].ToString(),
                    PostDate = Convert.ToDateTime(row["PostDate"]),
                    Comments = LoadComments(Convert.ToInt32(row["PostID"]))
                };
                postList.Add(post);
            }

            rptPosts.DataSource = postList;
            rptPosts.DataBind();
        }

        private List<CommentModel> LoadComments(int postId)
        {
            var comments = new List<CommentModel>();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT C.CommentText, C.CommentDate, U.FullName AS CommentedBy
                             FROM Comments C
                             INNER JOIN Users U ON C.UserID = U.UserID
                             WHERE C.PostID = @PostID
                             ORDER BY C.CommentDate ASC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@PostID", postId);
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            comments.Add(new CommentModel
                            {
                                CommentText = reader["CommentText"].ToString(),
                                CommentDate = Convert.ToDateTime(reader["CommentDate"]),
                                CommentedBy = reader["CommentedBy"].ToString()
                            });
                        }
                    }
                }
            }
            return comments;
        }

        // Models
        public class PostWithComments
        {
            public int PostID { get; set; }
            public string FullName { get; set; }
            public string PostText { get; set; }
            public string PostImagePath { get; set; }
            public DateTime PostDate { get; set; }
            public List<CommentModel> Comments { get; set; }
        }

        public class CommentModel
        {
            public string CommentText { get; set; }
            public string CommentedBy { get; set; }
            public DateTime CommentDate { get; set; }
        }

        [System.Web.Services.WebMethod]
        public static string SubmitComment(int postID, string commentText)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            // Simulate logged-in user
            //int userId = HttpContext.Current.Session["UserID"] != null ? Convert.ToInt32(HttpContext.Current.Session["UserID"]) : 0;
            // int userId = 3;
            string userId = HttpContext.Current.Session["UserID"].ToString();

            if (userId == null)
            {
                return new JavaScriptSerializer().Serialize(new { success = false, message = "User not logged in" });
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Comments (PostID, UserID, CommentText) VALUES (@PostID, @UserID, @CommentText)";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@PostID", postID);
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@CommentText", commentText);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }

                    // Get user name for response
                    string userName = "";
                    using (SqlCommand cmd = new SqlCommand("SELECT FullName FROM Users WHERE UserID = @UserID", con))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        var reader = cmd.ExecuteReader();
                        if (reader.Read())
                            userName = reader["FullName"].ToString();
                    }

                    return new JavaScriptSerializer().Serialize(new
                    {
                        success = true,
                        userName = userName,
                        commentDate = DateTime.Now.ToString("dd MMM yyyy HH:mm"),
                        commentText = commentText
                    });
                }
            }
            catch (Exception ex)
            {
                return new JavaScriptSerializer().Serialize(new { success = false, message = ex.Message });
            }
        }
        protected void btnSubmitPost_Click(object sender, EventArgs e)
        {
            int userID = Convert.ToInt32(Session["UserID"]);
            //int userID = 3; // Example - You can replace with Session["UserID"]
            string postText = txtPostText.Text.Trim();
            string postImagePath = null;

            if (fileUploadPostImage.HasFile)
            {
                string folderPath = Server.MapPath("~/uploads/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(fileUploadPostImage.PostedFile.FileName);
                string filePath = folderPath + fileName;
                fileUploadPostImage.SaveAs(filePath);

                postImagePath = "uploads/" + fileName;
            }
            else
            {
                postImagePath = "~/assets/img/dummy.jpeg"; // default dummy image
            }

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Posts (UserID, PostText, PostImagePath) VALUES (@UserID, @PostText, @PostImagePath)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userID);
                cmd.Parameters.AddWithValue("@PostText", postText);
                cmd.Parameters.AddWithValue("@PostImagePath", postImagePath);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            // Clear the form
            txtPostText.Text = "";

            // Show success alert
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Post added successfully!');", true);
            Response.Write("<script>window.location.href='post.aspx'</script>");
        }

    }
}