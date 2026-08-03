using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Kmc_Login.Data;

namespace Kmc_Login
{
    public partial class ResidentDashboard : System.Web.UI.Page
    {
        private EventRepository _eventRepo = new EventRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) {
                Response.Redirect("Default.aspx");
                return;
            }

            if (!IsPostBack) {
                lblUser.Text = Session["UserEmail"].ToString();
                LoadAllEvents();
            }

        }

        private void LoadAllEvents()
        {
            var events = _eventRepo.GetAllEvents();
            gvPublicEvents.DataSource = events;
            gvPublicEvents.DataBind();
        }


        protected void btnSearch_Click(object sender, EventArgs e) {
            string keyword = txtSearch.Text.Trim();

            if (!string.IsNullOrEmpty(keyword))
            {
                var filteredEvents = _eventRepo.SearchEvents(keyword);
                gvPublicEvents.DataSource = filteredEvents;
                gvPublicEvents.DataBind();
            }
            else {
                LoadAllEvents();
            }
        
        }
        protected void gvPublicEvents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           
            if (e.CommandName == "RegisterEvent")
            {
               
                int eventId = Convert.ToInt32(e.CommandArgument);

              
                string userEmail = Session["UserEmail"].ToString();

               
                bool success = _eventRepo.RegisterUserForEvent(eventId, userEmail);

             
                if (success)
                {
                    lblMsg.ForeColor = System.Drawing.Color.LightGreen;
                    lblMsg.Text = "Successfully registered for the event! 🎉";
                }
                else
                {
                    lblMsg.ForeColor = System.Drawing.Color.Tomato;
                    lblMsg.Text = "You are already registered or an error occurred.";
                }
            }
        }

      
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}