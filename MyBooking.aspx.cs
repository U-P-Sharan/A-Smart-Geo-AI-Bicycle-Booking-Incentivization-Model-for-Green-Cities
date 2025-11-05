using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace goWheel
{
    public partial class MyBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBookings();
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
        private void LoadBookings()
        {
            string conStr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string userId = HttpContext.Current.Session["UserID"].ToString();
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"SELECT b.BookingID, b.PaymentStatus, bk.BicycleName, bk.PerHourCharge, bk.BicycleImage1, 
                                bk.BicycleID, s.City, s.Country, s.Latitude, s.Longitude, b.StartDate
                         FROM Bookings b
                         JOIN Bicycles bk ON b.BicycleID = bk.BicycleID
                         LEFT JOIN Shops s ON bk.Location = s.ShopId where b.userid='"+ userId + "' and PaymentStatus != 'Canceled'";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Add CanCancel column
                dt.Columns.Add("CanCancel", typeof(bool));

                foreach (DataRow row in dt.Rows)
                {
                    DateTime startDate = Convert.ToDateTime(row["StartDate"]);
                    row["CanCancel"] = (DateTime.Now <= startDate.AddMinutes(10));
                }

                rptBookings.DataSource = dt;
                rptBookings.DataBind();
            }
        }


        [WebMethod]
        public static string GetBicycleDetails(int BicycleID)
        {
            string conStr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            JavaScriptSerializer js = new JavaScriptSerializer();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"SELECT bk.BicycleName, bk.BicycleDescription, bk.PerHourCharge, bk.BicycleImage1,
                                    bk.BicycleBrand, bk.BicycleType, bk.BicycleFeatures,
                                    s.StopName, s.City, s.Country, s.ContactNumber
                             FROM Bicycles bk
                             LEFT JOIN Shops s ON bk.Location = s.ShopId
                             WHERE bk.BicycleID = @BicycleID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BicycleID", BicycleID);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    var data = new
                    {
                        BicycleName = dr["BicycleName"].ToString(),
                        BicycleDescription = dr["BicycleDescription"].ToString(),
                        PerHourCharge = Convert.ToDecimal(dr["PerHourCharge"]),
                        BicycleBrand = dr["BicycleBrand"].ToString(),
                        BicycleType = dr["BicycleType"].ToString(),
                        BicycleFeatures = dr["BicycleFeatures"].ToString(),
                        BicycleImage1 = dr["BicycleImage1"].ToString(),
                        StopName = dr["StopName"].ToString(),
                        City = dr["City"].ToString(),
                        Country = dr["Country"].ToString(),
                        ContactNumber = dr["ContactNumber"].ToString()
                    };

                    return js.Serialize(data);
                }
                else
                {
                    return js.Serialize(new { error = "No data found." });
                }
            }
        }


        [WebMethod]
        public static List<object> GetShops()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT DISTINCT ShopID, StopName FROM Shops", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                List<object> shops = new List<object>();
                while (rdr.Read())
                {
                    shops.Add(new
                    {
                        ShopID = rdr["ShopID"],
                        StopName = rdr["StopName"].ToString()
                    });
                }
                return shops;
            }
        }

        public class FareResponse
        {
            public int Hours;
            public decimal TotalFare;
            public decimal DiscountPercent;
            public decimal DiscountedFare;
            public int FarePoints;
        }

        [WebMethod]
        public static FareResponse CalculateFare(string startDate, decimal perHourCharge)
        {
            DateTime start = DateTime.Parse(startDate);
            DateTime end = DateTime.Now;
            int hours = (int)Math.Ceiling((end - start).TotalHours);

            decimal discount = 0;
            int points = 0;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT TOP 1 DiscountPercent, FarePoints FROM FareDiscounts WHERE MinHours <= @hours ORDER BY MinHours DESC", con);
                cmd.Parameters.AddWithValue("@hours", hours);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    discount = Convert.ToDecimal(rdr["DiscountPercent"]);
                    points = Convert.ToInt32(rdr["FarePoints"]);
                }
            }

            decimal totalFare = perHourCharge * hours;
            decimal discountedFare = totalFare * (1 - discount / 100);

            return new FareResponse
            {
                Hours = hours,
                TotalFare = totalFare,
                DiscountPercent = discount,
                DiscountedFare = discountedFare,
                FarePoints = points
            };
        }

        [WebMethod]
        public static object ConfirmDropAndPay(int bicycleId, string startDate, decimal perHourCharge, int shopId, int bookingId )
        {
            FareResponse fare = CalculateFare(startDate, perHourCharge);
            //int userId = 1; // Replace with session value if needed

            string userId = HttpContext.Current.Session["UserID"].ToString();
            DateTime end = DateTime.Now;
           
            string formattedDate = end.ToString("yyyy-MM-dd HH:mm:ss"); 
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                con.Open();

                // 1. Check wallet balance
                SqlCommand checkWalletCmd = new SqlCommand("SELECT amt FROM Wallet WHERE UserID = @uid", con);
                checkWalletCmd.Parameters.AddWithValue("@uid", userId);
                object balanceObj = checkWalletCmd.ExecuteScalar();

                if (balanceObj == null || Convert.ToDecimal(balanceObj) < fare.DiscountedFare)
                {
                    return new { Success = false, Message = "Not enough amount in wallet." };
                }

                // 2. Deduct fare from wallet
                SqlCommand deductCmd = new SqlCommand("UPDATE Wallet SET amt = amt - @amount WHERE UserID = @uid", con);
                deductCmd.Parameters.AddWithValue("@amount", fare.DiscountedFare);
                deductCmd.Parameters.AddWithValue("@uid", userId);
                deductCmd.ExecuteNonQuery();

                // 3. Insert fare points
                SqlCommand insertCmd = new SqlCommand("INSERT INTO FarePoints (UserID, PointsEarned, RideDate, RideID) VALUES (@uid, @points, @date, @rideid)", con);
                insertCmd.Parameters.AddWithValue("@points", fare.FarePoints);
                insertCmd.Parameters.AddWithValue("@date", DateTime.Now);
                insertCmd.Parameters.AddWithValue("@rideid", bookingId);
                insertCmd.Parameters.AddWithValue("@uid", userId);
                insertCmd.ExecuteNonQuery();

                // 4. Update booking status
                SqlCommand updateBookingCmd = new SqlCommand("UPDATE Bookings SET PaymentStatus = 'clear',DropedAt='"+ shopId + "',EndDate='"+ formattedDate + "',TotalAmount='"+ fare.TotalFare+ "' WHERE BookingID = @bookingId", con);
                updateBookingCmd.Parameters.AddWithValue("@bookingId", bookingId);
                updateBookingCmd.ExecuteNonQuery();
            }

            return new
            {
                Success = true,
                FarePoints = fare.FarePoints,
                DiscountedFare = fare.DiscountedFare
            };
        }


        [System.Web.Services.WebMethod]
        public static void CancelBooking(int bookingId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "UPDATE Bookings SET PaymentStatus = 'Canceled' WHERE BookingID = @BookingID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BookingID", bookingId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }


    }

}