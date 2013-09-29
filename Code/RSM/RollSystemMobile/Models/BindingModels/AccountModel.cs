using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Mvc;
using System.Web.Security;

namespace RollSystemMobile.Models.BindingModels
{
    public class LoginModelView
    {
        [Required(ErrorMessage = "Please enter username")]
        [Display(Name = "Username")]
        [MinLength(5, ErrorMessage = "Username/Password must be from 5 to 30 characters")]
        [MaxLength(30, ErrorMessage = "Username/Password must be from 5 to 30 characters")]
        public string Username { get; set; }

        [Required(ErrorMessage = "Please enter password")]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        [MinLength(5, ErrorMessage = "Username/Password must be from 5 to 30 characters")]
        [MaxLength(30, ErrorMessage = "Username/Password must be from 5 to 30 characters")]
        public string Password { get; set; }

        public string ReturnUrl { get; set; }

    }
}