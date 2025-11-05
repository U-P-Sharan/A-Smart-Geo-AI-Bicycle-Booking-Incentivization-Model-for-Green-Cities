using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goWheel
{
	public partial class logout : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            Session.Abandon();
            string script = @"<script>
                        localStorage.removeItem('introShown');
                        window.location.href = 'Login.aspx';
                      </script>";
            Response.Write(script);
            //Response.Redirect("Login.aspx"); 
        }
	}
}