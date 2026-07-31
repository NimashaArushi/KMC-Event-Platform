using System;
using System.Configuration;
using System.Data.SqlClient;
using Kmc_Login.Models;

namespace Kmc_Login.Data
{
    public class UserRepository
    {
        private string connStr = ConfigurationManager.ConnectionStrings["KMCConnString"].ConnectionString;

        public bool RegisterUser(User user)
        {
            using (SqlConnection conn = new SqlConnection(connStr)) {
                string query = "INSERT INTO Users(Email,Password) VALUES (@Email,@Password)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", user.Email);
                cmd.Parameters.AddWithValue("@Password", user.Password);


                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                return rowsAffected > 0;
            }
        }

        public bool IsEmailExists(string email) {
            using (SqlConnection conn = new SqlConnection(connStr)) {
                string query = "SELECT COUNT(1) FROM Users WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                return count > 0;
            
            }
        }




    }
}