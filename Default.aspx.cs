using System;
using Kmc_Login.Services;
using Kmc_Login.Models;
namespace Kmc_Login
{
    public partial class Web_Form_with_Master_Page : System.Web.UI.Page
    {
        private AuthService _authService = new AuthService();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            
            User user = _authService.ValidateUser(email, password);

          
            if (user != null)
            {
               
                Session["UserEmail"] = user.Email;
                Session["UserRole"] = user.Role;

               
                if (user.Role == "Organizer")
                {
                    Response.Redirect("OrganizerDashboard.aspx");
                }
                else
                {
                    Response.Redirect("ResidentHome.aspx");
                }
            }
            else
            {
               
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Invalid Email or Password!";
            }
        }
    }
}