using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goWheel
{
	public partial class ManagePost : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

            if (!IsPostBack)
            {
                BindPosts();
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

private void BindPosts()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string userId = Session["UserID"].ToString();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT PostID, PostText, PostDate,PostImagePath, (SELECT FullName FROM Users WHERE Users.UserID = Posts.UserID) AS FullName FROM Posts where UserID='" + userId + "'";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();

                conn.Open();
                da.Fill(dt);
                conn.Close();

                rptPosts.DataSource = dt;
                rptPosts.DataBind();
            }
        }

        // WebMethod to delete post via AJAX
        [System.Web.Services.WebMethod]
        public static void DeletePost(int PostID)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Posts WHERE PostID = @PostID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@PostID", PostID);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
    }
}