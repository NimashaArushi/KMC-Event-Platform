using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using Kmc_Login.Models; 

namespace Kmc_Login.Data
{
    public class EventRepository
    {
        private string connString = ConfigurationManager.ConnectionStrings["KMCConnection"].ConnectionString;

        public bool AddEvent(Event evt)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"INSERT INTO Events(Title, EventDate, Location, Description, CreatedBy)
                                VALUES(@Title, @EventDate, @Location, @Description, @CreatedBy)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Title", evt.Title);
                cmd.Parameters.AddWithValue("@EventDate", evt.EventDate);
                cmd.Parameters.AddWithValue("@Location", evt.Location);
                cmd.Parameters.AddWithValue("@Description", evt.Description ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@CreatedBy", evt.CreatedBy);

                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

        public List<Event> GetEventsByOrganizer(string email)
        {
            List<Event> eventList = new List<Event>();

            string query = "SELECT Id, Title, EventDate, Location, Description, CreatedBy FROM Events WHERE CreatedBy = @Email";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Event evt = new Event
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Title = reader["Title"].ToString(),
                        EventDate = Convert.ToDateTime(reader["EventDate"]),
                        Location = reader["Location"].ToString(),
                        Description = reader["Description"] != DBNull.Value ? reader["Description"].ToString() : "",
                        CreatedBy = reader["CreatedBy"].ToString()
                    };

                    eventList.Add(evt);
                }
            }

            return eventList;
        }
    }
}