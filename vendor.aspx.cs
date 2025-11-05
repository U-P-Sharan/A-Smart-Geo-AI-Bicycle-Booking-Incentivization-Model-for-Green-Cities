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
    public partial class vendor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim(); // Hash this in production!
            string phone = txtPhone.Text.Trim();
            string address = txtAddress.Text.Trim();
            string utypea = utype.Value.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Vendore (FullName, Email, PasswordHash, Phone,Utype, Address) " +
                               "VALUES (@FullName, @Email, @PasswordHash, @Phone,@Utype, @Address)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PasswordHash", password); // Use hashed password in real app!
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.Parameters.AddWithValue("@Utype", utypea);
                    cmd.Parameters.AddWithValue("@Address", address);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }


            Response.Redirect("login.aspx");
        }
    }
}
