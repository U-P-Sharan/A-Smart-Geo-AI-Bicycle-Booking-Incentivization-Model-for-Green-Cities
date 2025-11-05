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
	public partial class register : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Value.Trim();
            string email = txtEmail.Value.Trim();
            string password = txtPassword.Value.Trim(); // Hash this in production!
            string phone = txtPhone.Value.Trim();
            string address = txtAddress.Value.Trim();
            string utypea = utype.Value.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string queryUsers = "INSERT INTO Users (FullName, Email, PasswordHash, Phone, Utype, Address) " +
                                    "VALUES (@FullName, @Email, @PasswordHash, @Phone, @Utype, @Address)";

                string queryVendors = "INSERT INTO Vendors (FullName, Email, PasswordHash, Phone, Utype, Address) " +
                                      "VALUES (@FullName, @Email, @PasswordHash, @Phone, @Utype, @Address)";

                using (SqlCommand cmdUsers = new SqlCommand(queryUsers, con))
                using (SqlCommand cmdVendors = new SqlCommand(queryVendors, con))
                {
                    cmdUsers.Parameters.AddWithValue("@FullName", fullName);
                    cmdUsers.Parameters.AddWithValue("@Email", email);
                    cmdUsers.Parameters.AddWithValue("@PasswordHash", password); // Use hashed password in production
                    cmdUsers.Parameters.AddWithValue("@Phone", phone);
                    cmdUsers.Parameters.AddWithValue("@Utype", utypea);
                    cmdUsers.Parameters.AddWithValue("@Address", address);

                    cmdVendors.Parameters.AddWithValue("@FullName", fullName);
                    cmdVendors.Parameters.AddWithValue("@Email", email);
                    cmdVendors.Parameters.AddWithValue("@PasswordHash", password);
                    cmdVendors.Parameters.AddWithValue("@Phone", phone);
                    cmdVendors.Parameters.AddWithValue("@Utype", utypea);
                    cmdVendors.Parameters.AddWithValue("@Address", address);

                    con.Open();
                    cmdUsers.ExecuteNonQuery();
                    cmdVendors.ExecuteNonQuery();
                    con.Close();
                }
            }

            Response.Write("<script>alert('You earned a plant for your Registration');</script>");
            Response.Write("<script>window.location.href='login.aspx'</script>");
        }
        }
}
