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

    [Serializable]
    public class ConfigModel
    {
        public String HaarXMLFile { get; set; }
        public int ResizedHeight { get; set; }
        public int ResizeWidth { get; set; }

        public ConfigModel()
        {
            HaarXMLFile = "";
            ResizedHeight = 0;
            ResizeWidth = 0;
        }
    }
}