using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Web.Services;

namespace goWheel
{
    public partial class BookBiCycle : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        static int pageIndex = 0;
        static int pageSize = 5;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pageIndex = 0;
                LoadBicycles();
             
            }
        }


   


private void LoadBicycles()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"
            SELECT * FROM (
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY B.BicycleID DESC) AS RowNum,
                    B.*, 
                    S.StopName,
                    S.City,
                    S.Latitude,
                    S.Longitude
                FROM Bicycles B
                LEFT JOIN Shops S ON B.Location = S.ShopID
            ) AS RowConstrainedResult
            WHERE RowNum > @Offset AND RowNum <= @NextLimit
            ORDER BY RowNum";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Offset", pageIndex * pageSize);
                cmd.Parameters.AddWithValue("@NextLimit", (pageIndex + 1) * pageSize);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (rptBicycles.DataSource != null)
                {
                    var currentList = (DataTable)rptBicycles.DataSource;
                    currentList.Merge(dt);
                    rptBicycles.DataSource = currentList;
                }
                else
                {
                    rptBicycles.DataSource = dt;
                }

                rptBicycles.DataBind();
            }
        }


        protected void btnLoadMore_Click(object sender, EventArgs e)
        {
            pageIndex++;
            LoadBicycles();
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object GetBicycleDetails(int bicycleId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT BicycleName, PerHourCharge FROM Bicycles WHERE BicycleID = @ID", con);
                cmd.Parameters.AddWithValue("@ID", bicycleId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    return new
                    {
                        BicycleName = reader["BicycleName"].ToString(),
                        PerHourCharge = Convert.ToDecimal(reader["PerHourCharge"])
                    };
                }
                return null;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static void BookBicycle(int bicycleId)
        {
            //int userId = Convert.ToInt32(Session["UserID"]);
            //int? userId = HttpContext.Current.Session["UserID"] as int?;

            string userId = HttpContext.Current.Session["UserID"].ToString();
            //string userId = "1";
            if (userId == null)
                throw new Exception("User not logged in.");

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"INSERT INTO Bookings 
            (UserID, BicycleID, BookingType, StartDate, TotalAmount, IsApproved, PaymentStatus) 
            VALUES (@UserID, @BicycleID, 'Hourly', GETDATE(), 
            (SELECT PerHourCharge FROM Bicycles WHERE BicycleID = @BicycleID), 1, 'Pending')", con);

                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@BicycleID", bicycleId);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }



    }
}