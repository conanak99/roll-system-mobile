using System;
using System.Collections.Generic;
using System.Linq;

namespace RollSystemMobile.Models.ViewModels
{
    public class AdminViewModel
    {
       
    }

    public class AccountsViewModel
    {
        public List<Staff> Staffs { get; set; }
        public List<Instructor> Instructors { get; set; }
        public List<Student> Students { get; set; }
    }
}