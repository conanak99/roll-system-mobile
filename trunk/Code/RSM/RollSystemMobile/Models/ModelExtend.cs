using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using RollSystemMobile.Models.HelperClass;

namespace RollSystemMobile.Models
{
    [MetadataType(typeof(InstructorMetaData))]
    public partial class Instructor
    {
    }

    public class InstructorMetaData
    {
        [Required(ErrorMessage = "Please enter instructor name")]
        [MinLength(5, ErrorMessage = "Name must be longer than 5 characters")]
        [MaxLength(50, ErrorMessage = "Name must be shorter than 50 character")]
        public String Fullname { get; set; }

        [MinLength(5, ErrorMessage = "Email must be longer than 5 characters")]
        [MaxLength(50, ErrorMessage = "Email must be shorter than 50 character")]
        [DataType(DataType.EmailAddress, ErrorMessage = "Invalid email format")]
        [RegularExpression(@"^([\w\.])+@([\w])+\.(\w){2,6}(\.([\w]){2,4})*$", ErrorMessage = "Invalid email format")]
        public String Email { get; set; }

        [MinLength(10, ErrorMessage = "Phone number must in range [10-12]")]
        [MaxLength(12, ErrorMessage = "Phone number must in range [10-12]")]
        [RegularExpression("[0-9]{10,12}", ErrorMessage = "Invalid phone number format")]
        public String Phone { get; set; }
    }

    public partial class RollCall
    {
        public StudySession SessionToCheckAttendance { get; set; }

        public RollCall Clone()
        {
            var NewRoll = new RollCall();
            NewRoll.RollCallID = this.RollCallID;
            NewRoll.BeginDate = this.BeginDate;
            NewRoll.EndDate = this.EndDate;
            NewRoll.Class = this.Class;
            NewRoll.Subject = this.Subject;

            return NewRoll;
        }

        public DateTime AttendanceDate()
        {
            if (SessionToCheckAttendance == null)
            {
                return DateTime.Today;
            }
            return SessionToCheckAttendance.GetOriginalDate();
        }
    }

    public partial class StudySession
    {
        public void SetNote(String Note)
        {
            this.Note = GetOriginalDate().ToString("dd-MM-yyyy") + " : " + Note;
        }

        //Chi lay doan sau thoi gian
        public String GetNote()
        {
            if (Note.Split(':').Count() > 1)
            {
                return Note.Split(':')[1].Trim();
            }
            return "";
        }

        public DateTime GetOriginalDate()
        {
            String OriginDateStr = Note.Split(':')[0].Trim();
            return OriginDateStr.ParseStringToDateTime();
        }
    }

}