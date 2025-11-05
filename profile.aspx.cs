using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goWheel
{
	public partial class profile : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!IsPostBack)
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                //int userId = 3;
                LoadUserProfile(userId);
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
        private void LoadUserProfile(int userId)
        {
           
            string query = "SELECT * FROM Users WHERE UserID = @UserID";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtUsername.Text = reader["FullName"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtPhone.Text = reader["Phone"].ToString();
                    txtAddress.Text = reader["Address"].ToString();
                    ddlGender.SelectedValue = reader["Utype"].ToString();
                    // Handle Date of Birth if available
                    // txtDOB.Text = reader["DOB"].ToString();
                }
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            //int userId = 3;
            string fullName = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string address = txtAddress.Text.Trim();
            string gender = ddlGender.SelectedValue;
            string imagePath = "";

            // Handle image upload
            if (FileUploadProfile.HasFile)
            {
                string extension = Path.GetExtension(FileUploadProfile.FileName).ToLower();
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };

                if (Array.Exists(allowedExtensions, ext => ext == extension))
                {
                    string fileName = "profile_" + userId + extension;
                    string folderPath = Server.MapPath("~/UserImages/");
                    if (!Directory.Exists(folderPath))
                        Directory.CreateDirectory(folderPath);

                    string fullPath = folderPath + fileName;
                    FileUploadProfile.SaveAs(fullPath);

                    imagePath = "UserImages/" + fileName;
                }
                else
                {
                    // Optional: Show error message for invalid file
                    return;
                }
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            string query = @"
    UPDATE Users SET
        FullName = @FullName,
        Email = @Email,
        Phone = @Phone,
        Address = @Address" +
             (string.IsNullOrEmpty(imagePath) ? "" : ", ImagePath = @ImagePath") + @"
    WHERE UserID = @UserID";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@UserID", userId);

                if (!string.IsNullOrEmpty(imagePath))
                {
                    cmd.Parameters.AddWithValue("@ImagePath", imagePath);
                }

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("Profile.aspx");
        }

    }
}