using System;
using System.Collections.Generic;
using System.Linq;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Mvc;
using System.Web.Security;

namespace RollSystemMobile.Models.ViewModels
{
    public class StudentViewModel
    {
        public Student AuthorizedStudent { get; set; }
        public List<RollCall> LearnedRollCalls { get; set; }
        public List<RollCall> LearningRollCalls { get; set; }
    }

    public class StudentAttendanceViewModel
    {
        public Student InStudent { get; set; }
        public RollCall InRollCall { get; set; }
        public List<StudentAttendance> StudentAttendances { get; set; }
    }
    public class AttendanceReportViewModel
    {
        public Student Student { get; set; }
        public List<RollCall> RollCallList { get; set; }
    }
}