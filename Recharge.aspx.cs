using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goWheel
{
    public partial class Recharge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFarePoints();
                BindLabels();
                LoadProfile();
            }
        }
        private void LoadProfile()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            //int userId = 3; // (You can replace this with Session["UserID"])
            string userId = HttpContext.Current.Session["UserID"].ToString();
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
            string userId = HttpContext.Current.Session["UserID"].ToString();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Fetch total Fare Points
                    using (SqlCommand cmd1 = new SqlCommand("SELECT SUM(PointsEarned) AS ttlFare FROM Farepoints WHERE UserID = '"+ userId + "'", conn))
                    {
                        object result1 = cmd1.ExecuteScalar();
                        fp.Text = result1 != DBNull.Value ? result1.ToString() : "0";
                    }

                    // Fetch total Wallet Amount
                    using (SqlCommand cmd2 = new SqlCommand("SELECT SUM(Amt) AS ttlAmt FROM Wallet WHERE UserID = '"+ userId + "'", conn))
                    {
                        object result2 = cmd2.ExecuteScalar();
                        mw.Text = result2 != DBNull.Value ? result2.ToString() : "0";
                    }

                    // Fetch total Rides/Bookings
                    using (SqlCommand cmd3 = new SqlCommand("SELECT COUNT(UserID) AS ttlRaid FROM Bookings WHERE UserID = '"+ userId + "'", conn))
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
        private void BindFarePoints()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string query = @"
        SELECT f.PointID, f.UserID, f.PointsEarned, f.PointsUsed, f.RideDate, f.RideID, 
               b.BookingID, b.BicycleID, b.BookingType, b.StartDate, b.EndDate, b.TotalAmount
        FROM FarePoints f
        LEFT JOIN Bookings b ON f.RideID = b.BookingID
        WHERE b.PaymentStatus = 'clear' AND f.UserID = @UserID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@UserID", userId); // Replace with actual user ID
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptFarePoints.DataSource = dt;
                rptFarePoints.DataBind();
            }
        }
        protected void btnSubmitPost_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            //int userId = 3; // Example UserID. Replace with Session["UserID"] if available
            string fullName = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string cardNumber = txtCardNumber.Text.Trim();
            string cvv = txtCVV.Text.Trim();
            decimal amount = decimal.Parse(txtAmount.Text.Trim());

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();

                try
                {
                    // 1. Insert into Recharge
                    string insertRecharge = @"INSERT INTO Recharge (FullName, Email, CardNumber, CVV, Amount, PaymentDate)
                                      VALUES (@FullName, @Email, @CardNumber, @CVV, @Amount, GETDATE())";
                    SqlCommand cmdRecharge = new SqlCommand(insertRecharge, con, trans);
                    cmdRecharge.Parameters.AddWithValue("@FullName", fullName);
                    cmdRecharge.Parameters.AddWithValue("@Email", email);
                    cmdRecharge.Parameters.AddWithValue("@CardNumber", cardNumber);
                    cmdRecharge.Parameters.AddWithValue("@CVV", cvv);
                    cmdRecharge.Parameters.AddWithValue("@Amount", amount);
                    cmdRecharge.ExecuteNonQuery();

                    // 2. Update or Insert into Wallet
                    string checkWallet = "SELECT COUNT(*) FROM Wallet WHERE UserID = @UserID";
                    SqlCommand cmdCheck = new SqlCommand(checkWallet, con, trans);
                    cmdCheck.Parameters.AddWithValue("@UserID", userId);
                    int count = (int)cmdCheck.ExecuteScalar();

                    if (count > 0)  
                    {
                        string updateWallet = "UPDATE Wallet SET Amt = Amt + @Amount WHERE UserID = @UserID";
                        SqlCommand cmdUpdate = new SqlCommand(updateWallet, con, trans);
                        cmdUpdate.Parameters.AddWithValue("@Amount", amount);
                        cmdUpdate.Parameters.AddWithValue("@UserID", userId);
                        cmdUpdate.ExecuteNonQuery();
                        BindFarePoints();
                    }
                    else
                    {
                        string insertWallet = "INSERT INTO Wallet (UserID, Amt) VALUES (@UserID, @Amount)";
                        SqlCommand cmdInsert = new SqlCommand(insertWallet, con, trans);
                        cmdInsert.Parameters.AddWithValue("@UserID", userId);
                        cmdInsert.Parameters.AddWithValue("@Amount", amount);
                        cmdInsert.ExecuteNonQuery();
                        BindFarePoints();
                    }
            
                    trans.Commit();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Recharge successful and wallet updated!');", true);
                    Response.Write("<script>window.location.href='Recharge.aspx'</script>");

                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
                }
            }
        }

        [WebMethod]
        public static string AddPointsToWallet(int pointID, int points)
        {
            string userId = HttpContext.Current.Session["UserID"].ToString();
            //int userId = Convert.ToInt32(Session["UserID"]);
            try
            {
                // Update Wallet table
                string updateWalletQuery = @"
            IF EXISTS (SELECT 1 FROM Wallet WHERE UserID = @UserID)
            BEGIN
                UPDATE Wallet SET Amt = Amt + @Points WHERE UserID = @UserID
            END
            ELSE
            BEGIN
                INSERT INTO Wallet (UserID, Amt) VALUES (@UserID, @Points)
            END";

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand(updateWalletQuery, conn);
                    cmd.Parameters.AddWithValue("@UserID", userId); // Replace with actual user ID
                    cmd.Parameters.AddWithValue("@Points", points);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Update FarePoints table
                string updateFarePointsQuery = "UPDATE FarePoints SET PointsUsed = PointsUsed + @Points, PointsEarned='0' WHERE PointID = @PointID";

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand(updateFarePointsQuery, conn);
                    cmd.Parameters.AddWithValue("@PointID", pointID);
                    cmd.Parameters.AddWithValue("@Points", points);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                return "Success";
            }
            catch (Exception ex)
            {
                // Log exception
                return "Error: " + ex.Message;
            }
        }
    }
}