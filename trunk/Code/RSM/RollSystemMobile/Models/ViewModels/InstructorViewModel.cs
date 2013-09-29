using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace RollSystemMobile.Models.ViewModels
{
    public class InstructorViewModel
    {
        public Instructor AuthorizedInstructor { get; set; }
        public RollCall CurrentRollCall { get; set; }
        public IEnumerable<RollCall> TeachingRollCall { get; set; }
        public AttendanceLog CurrentAttendanceLog { get; set; }
    }

    public class AttendanceViewModel
    {
        public List<RecognizerResult> RecognizeResult { get; set; }
        public List<Student> PresentStudents { get; set; }
        public RollCall CurrentRollCall { get; set; }

    }

    public class RollCallDetailViewModel
    {
        public RollCall RollCall { get; set; }
        public IEnumerable<AttendanceLog> RollCallLogs { get; set; }
    }

    public class LogDetailViewModel
    {
        public RollCall RollCall { get; set; }
        public AttendanceLog AutoLog { get; set; }
        public AttendanceLog ManualLog { get; set; }
    }
}
