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
        [StringLength(30, MinimumLength=5, ErrorMessage="Username must be from 5 to 30 characters")]
        public string Username { get; set; }

        [Required(ErrorMessage = "Please enter password")]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        [StringLength(30, MinimumLength = 5, ErrorMessage = "Password must be from 5 to 30 characters")]
        public string Password { get; set; }

        public string ReturnUrl { get; set; }

    }

    public class ChangePassModel
    {
        public User InUser { get; set; }

        [Required(ErrorMessage = "Please enter old password")]
        [DataType(DataType.Password)]
        [StringLength(30, MinimumLength = 5, ErrorMessage = "Password must be from 5 to 30 characters")]
        public string OldPassword { get; set; }

        [Required(ErrorMessage = "Please enter new password")]
        [DataType(DataType.Password)]
        [StringLength(30, MinimumLength = 5, ErrorMessage = "New password must be from 5 to 30 characters")]
        public string NewPassword { get; set; }

        [Compare("NewPassword", ErrorMessage = "Repeat password must be the same as password")]
        public string RepeatPassword { get; set; }
    }
}