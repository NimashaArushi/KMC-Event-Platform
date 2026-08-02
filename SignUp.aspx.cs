using System;
using Kmc_Login.Services;

namespace Kmc_Login
{
    public partial class SignUp : System.Web.UI.Page
    {
        private AuthService _authService = new AuthService();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string selectedRole = ddlRole.SelectedValue;

            string result = _authService.Register(email, password, confirmPassword, selectedRole);

            if (result == "SUCCESS")
            {
               
                Session["UserEmail"] = email;
                Session["UserRole"] = selectedRole;

               
                if (selectedRole == "Organizer")
                {
                    Response.Redirect("OrganizerDashboard.aspx");
                }
                else
                {
                    
                    Response.Redirect("Default.aspx");
                }
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = result;
            }
        }
    }
}