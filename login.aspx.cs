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
	public partial class login : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}
        protected void Unnamed_ServerClick(object sender, EventArgs e)
        {
            string email = txtEmail.Value.Trim();
            string password = txtPassword.Value.Trim();

            if (email == "admin@gmail.com" && password == "admin")
            {
                Response.Redirect("vendor/home.aspx");
            }

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT UserID, FullName, Utype, IsFirstLogin FROM Users WHERE Email = @Email AND PasswordHash = @PasswordHash AND Status='Approved'";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@PasswordHash", password);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string userId = reader["UserID"].ToString();
                    string fullName = reader["FullName"].ToString();
                    string utype = reader["Utype"].ToString();
                    bool isFirstLogin = Convert.ToBoolean(reader["IsFirstLogin"]);

                    // Store session variables
                    Session["UserID"] = userId;
                    Session["UserName"] = fullName;

                    reader.Close(); // Close reader before executing any other SQL command

                    if (utype == "User")
                    {
                        if (isFirstLogin)
                        {
                            // Update IsFirstLogin to false (0)
                            SqlCommand updateCmd = new SqlCommand("UPDATE Users SET IsFirstLogin = 0 WHERE UserID = @UserID", con);
                            updateCmd.Parameters.AddWithValue("@UserID", userId);
                            updateCmd.ExecuteNonQuery();

                            Response.Redirect("qus.aspx");
                        }
                        else
                        {
                            Response.Redirect("dashboard.aspx");
                        }
                    }
                    else if (utype == "Vendor")
                    {
                        Response.Redirect("vendor/index.aspx");
                    }
                }
                else
                {
                    reader.Close();
                    Response.Write("<script>alert('Wait for Admin Approve');</script>");
                }
            }
        }
    }
}