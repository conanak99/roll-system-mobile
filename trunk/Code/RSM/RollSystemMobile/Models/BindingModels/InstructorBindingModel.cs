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
    public class CheckAttendanceManualBindModel
    {
        public int RollCallID { get; set; }
        public String Username { get; set; }
        public DateTime Date { get; set; }
        public List<SingleAttendanceCheck> AttendanceChecks { get; set; }
        public String ReturnUrl { get; set; }
    }

    public class SingleAttendanceCheck
    {
        public int StudentID { get; set; }
        public bool IsPresent { get; set; }
        public String Note { get; set; }
    }
}