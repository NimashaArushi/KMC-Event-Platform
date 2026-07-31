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

            string result = _authService.Register(email, password, confirmPassword);

            if (result == "SUCCESS")
            {
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Registration Successful! You can login now.";
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = result;
            }
        }
    }
}