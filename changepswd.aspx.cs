using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Org.BouncyCastle.Crypto.Generators;

namespace goWheel
{
	public partial class changepswd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
               
                LoadProfile();
            }
        }
        private void LoadProfile()
        {
            string userId = HttpContext.Current.Session["UserID"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
           // int userId = 3; // (You can replace this with Session["UserID"])

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
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool CheckOldPassword(string oldPassword)
        {
            string userId = HttpContext.Current.Session["UserID"].ToString();
            //string userId = HttpContext.Current.Session["UserID"].ToString();
            //string userId = "3";
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT PasswordHash FROM Users WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                var result = cmd.ExecuteScalar();
                conn.Close();

                if (result != null)
                    if (result != null && Equals(oldPassword, result.ToString()))

                    {
                    return true;
                }
                return false;
            }
        }

        // WebMethod to change the password
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool ChangePassword(string newPassword)
        {
            string userId = HttpContext.Current.Session["UserID"].ToString();
            // string userId ="3";
            string hashedPassword = newPassword;
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Users SET PasswordHash = @PasswordHash WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                conn.Close();

                return rowsAffected > 0;
            }
        }
    }
}