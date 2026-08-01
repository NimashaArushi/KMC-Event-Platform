using System;
using Kmc_Login.Data;
using Kmc_Login.Models;

namespace Kmc_Login.Services
{
    public class AuthService
    {
        private UserRepository _userRepo = new UserRepository();

      
        public User ValidateUser(string email, string password)
        {
           
            bool isValid = _userRepo.ValidateUser(email, password);

            if (isValid)
            {
               
                return _userRepo.GetUserByEmail(email);
            }

            
            return null;
        }


        public string Register(string email, string password, string confirmPassword, string role)
        {
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
                return "All fields are required!";

            if (password != confirmPassword)
                return "Passwords do not match!";

            if (_userRepo.IsEmailExists(email))
                return "Email already registered!";

            User newUser = new User
            {
                Email = email,
                Password = password,
                Role = role
            };

            bool isSuccess = _userRepo.RegisterUser(newUser);
            return isSuccess ? "SUCCESS" : "Registration failed!";
        }
    }
}