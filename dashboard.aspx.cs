using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goWheel
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                BindLabels();
                LoadProfile();
            }
        }
        private void LoadProfile()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserID"]); // (You can replace this with Session["UserID"])


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

        private void BindLabels()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Fetch total Fare Points
                    using (SqlCommand cmd1 = new SqlCommand("SELECT SUM(PointsEarned) AS ttlFare FROM Farepoints WHERE UserID =  '"+Session["UserID"].ToString()+"'", conn))
                    {
                        object result1 = cmd1.ExecuteScalar();
                        fp.Text = result1 != DBNull.Value ? result1.ToString() : "0";
                    }

                    // Fetch total Wallet Amount
                    using (SqlCommand cmd2 = new SqlCommand("SELECT SUM(Amt) AS ttlAmt FROM Wallet WHERE UserID = '"+Session["UserID"].ToString()+"'", conn))
                    {
                        object result2 = cmd2.ExecuteScalar();
                        mw.Text = result2 != DBNull.Value ? result2.ToString() : "0";
                    }

                    // Fetch total Rides/Bookings
                    using (SqlCommand cmd3 = new SqlCommand("SELECT COUNT(UserID) AS ttlRaid FROM Bookings WHERE UserID = '"+Session["UserID"].ToString()+"'", conn))
                    {
                        object result3 = cmd3.ExecuteScalar();
                        mr.Text = result3 != DBNull.Value ? result3.ToString() : "0";
                    }
                }
                catch (Exception ex)
                {
                    // Handle error (optional: show message or log it)
                    Response.Write("Error: " + ex.Message);
                }
            }
        }
    }
}