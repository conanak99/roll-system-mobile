using System;
using System.Collections.Generic;
using System.Linq;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Mvc;
using System.Web.Security;

namespace RollSystemMobile.Models.ViewModels
{

    [Serializable]
    public class ConfigModel
    {
        public String HaarXMLFile { get; set; }

        [Required(ErrorMessage = "Please enter height")]
        [Range(500, 2000, ErrorMessage="Height must be from 500 to 2000")]
        public int ResizedHeight { get; set; }

        [Required(ErrorMessage = "Please enter width")]
        [Range(500, 2000, ErrorMessage = "Width must be from 500 to 2000")]
        public int ResizeWidth { get; set; }

        [Required(ErrorMessage = "Please enter threehold")]
        [Range(500, 2500, ErrorMessage = "Threehold must be from 500 to 2500")]
        public int Threehold { get; set; }

        public ConfigModel()
        {
            HaarXMLFile = "haarcascade_frontalface_alt.xml";
            ResizedHeight = 1100;
            ResizeWidth = 800;
            Threehold = 1000;
        }
    }

    public class LogImageViewModel
    {
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public int ClassID { get; set; }
        public List<AttendanceLog> LogList { get; set; }

        public LogImageViewModel()
        {
            FromDate = DateTime.Now;
            ToDate = DateTime.Now.AddDays(1);
            ClassID = 0;
        }
    }
}