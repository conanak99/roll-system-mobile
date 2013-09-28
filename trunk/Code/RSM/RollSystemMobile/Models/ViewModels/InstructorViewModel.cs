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
    }

    public class AttendanceViewModel
    {
        public List<RecognizerResult> RecognizeResult { get; set; }
        public List<Student> PresentStudents { get; set; }
        public RollCall CurrentRollCall { get; set; }
    }
}
