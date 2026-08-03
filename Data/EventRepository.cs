using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using Kmc_Login.Models;

namespace Kmc_Login.Data
{
    public class EventRepository
    {
        private string _connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        private string connString;
        private List<Event> eventList;

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

        public List<Event> SearchEvents(string keyword)
        {
            List<Event> eventList = new List<Event>();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            { 
            string query="SELECT Id,Title,EventDate,Location,Description FROM Events" +
                  "WHERE Title LIKE @Keyword OR Location LIKE @Keyword ORDER BY EventDate ASC";


                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@keyword", "%" + keyword + "%");
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read()) {
                    eventList.Add(new Event
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Title = reader["Title"].ToString(),
                        EventDate = Convert.ToDateTime(reader["EventDate"]),
                        Location = reader["Location"].ToString(),
                        Description = reader["Description"].ToString()
                    }) ;}
  }
            return eventList;
        }

        public List<Event> GetAllEvents()
        {
            List<Event> eventList = new List<Event>();

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT Id, Title, EventDate, Location, Description FROM Events ORDER BY EventDate ASC";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    eventList.Add(new Event
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Title = reader["Title"].ToString(),
                        EventDate = Convert.ToDateTime(reader["EventDate"]),
                        Location = reader["Location"].ToString(),
                        Description = reader["Description"].ToString()
                    });
                }
            }
            return eventList;
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

        public bool RegisterUserForEvent(int eventId, string userEmail)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
              
                string checkQuery = "SELECT COUNT(1) FROM EventRegistrations WHERE EventId = @EventId AND UserEmail = @UserEmail";
                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@EventId", eventId);
                checkCmd.Parameters.AddWithValue("@UserEmail", userEmail);

                conn.Open();
                int count = Convert.ToInt32(checkCmd.ExecuteScalar());

                if (count > 0)
                {
                    return false; 
                }

               
                string insertQuery = "INSERT INTO EventRegistrations (EventId, UserEmail, RegisteredDate) VALUES (@EventId, @UserEmail, GETDATE())";
                SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                insertCmd.Parameters.AddWithValue("@EventId", eventId);
                insertCmd.Parameters.AddWithValue("@UserEmail", userEmail);

                int rows = insertCmd.ExecuteNonQuery();
                return rows > 0;
            }
        }
    }
}