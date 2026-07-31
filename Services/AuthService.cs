using Kmc_Login.Data;
using Kmc_Login.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Kmc_Login.Services
{
    public class AuthService
    {
        private UserRepository _userRepo = new UserRepository();

        public string Register(string email, string password, string confirmPassword) {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password)) {
                return "Plz fill in all fields ❌";
            }
            if (password != confirmPassword) {
                return "passwords do not match ‼️";
            }

            if (_userRepo.IsEmailExists(email)) {
                return "Email is already registered!";
            }

            User newUser = new User
            {
                Email = email,
                Password = password
            }; bool isSuccess = _userRepo.RegisterUser(newUser);

            if (isSuccess)
            {
                return "SUCCESS";
            }
            else
            {
                return "Failed to register. Please try again.";
            }
        }
    }
}