using Kmc_Login.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Kmc_Login
{
    public partial class OrganizerDashboard : System.Web.UI.Page
    {
        private EventRepository _eventRepo = new EventRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) {
                Response.Redirect("Default.aspx");
                return;
            }
            if (!IsPostBack) {
                string userEmail = Session["UserEmail"].ToString();
                lblUser.Text = userEmail;

                LoadOrganizerEvents(userEmail);
            }

        }

        private void LoadOrganizerEvents(string email)
        {
            var events = _eventRepo.GetEventsByOrganizer(email);
            gvEvents.DataSource = events;
            gvEvents.DataBind();
        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {
            try
            {
                Event newEvent = new Event
                {
                    Title = txtTitle.Text.Trim(),
                    EventDate = Convert.ToDateTime(txtDate.Text),
                    Location = txtLocation.Text.Trim(),
                    Description = txtDescription.Text.Trim(),
                    CreatedBy = Session["UserEmail"].ToString()

                };

                bool isSuccess = _eventRepo.AddEvent(newEvent);
                if (isSuccess)
                {
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblMsg.Text = "Event Created Successfully !!";
                    ClearForm();
                    LoadOrganizerEvents(Session["UserEmail"].ToString());
                }
                else
                {
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = "Failed to create event. Try again!";
                }


            }
            catch (Exception ex) {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Error :" + ex.Message;
            }

            }

        private void ClearForm() {
            txtTitle.Text = "";
            txtDate.Text = "";
            txtLocation.Text = "";
            txtDescription.Text = "";
        
        }

        protected void btnLogout_Click(object sender, EventArgs e) {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }

        }

    }
