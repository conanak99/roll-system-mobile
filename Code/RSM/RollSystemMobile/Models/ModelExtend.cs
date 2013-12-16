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
        [RegularExpression(@"^[\w\.=-]+@[\w\.-]+\.[\w]{2,3}$", ErrorMessage = "Invalid email format")]
        public String Email { get; set; }

        [RegularExpression(@"^[\d]*{8,10}$", ErrorMessage = "Invalid email format")]
        public String Phone { get; set; }
    }

    [MetadataType(typeof(StudentMetaData))]
    public partial class Student
    {
    }
    public class StudentMetaData
    {
        [Required(ErrorMessage = "Please choose a class.")]
        public int ClassID { get; set; }

        [Required(ErrorMessage = "Please enter student name")]
        [MinLength(1, ErrorMessage = "Name must be longer than 1 characters")]
        [MaxLength(50, ErrorMessage = "Name must be shorter than 50 character")]
        public String FullName { get; set; }

        [Required(ErrorMessage = "Please enter student code")]
        [MinLength(5, ErrorMessage = "Student code must be longer than 5 characters")]
        [MaxLength(7, ErrorMessage = "Student code must be shorter than 7 character")]
        [RegularExpression(@"^([A-Za-z]{2})?[\d]{5}$", ErrorMessage = "Invalid student code format")]
        public String StudentCode { get; set; }

        [Required(ErrorMessage = "Please enter student citizenID")]
        [RegularExpression("[0-9]{9}", ErrorMessage = "Invalid citizenid format")]
        public int CitizenID { get; set; }

        [Required(ErrorMessage = "Please enter the student birthdate")]
        public DateTime Birthdate { get; set; }

        [DataType(DataType.EmailAddress,ErrorMessage = "Invalid email format")]
        [RegularExpression(@"^[\w\.=-]+@[\w\.-]+\.[\w]{2,3}$", ErrorMessage = "Invalid email format")]
        public String Email { get; set; }
    }

    [MetadataType(typeof(SubjectMetaData))]
    public partial class Subject
    {
    }
    public class SubjectMetaData
    {
        [Required(ErrorMessage = "Please enter subject short name")]
        [MinLength(1, ErrorMessage = "Short name must be longer than 1 characters")]
        [MaxLength(10, ErrorMessage = "Short name must be shorter than 10 character")]
        public String ShortName { get; set; }

        [Required(ErrorMessage = "Please enter subject full name")]
        [MinLength(1, ErrorMessage = "Full name must be longer than 1 characters")]
        [MaxLength(50, ErrorMessage = "Full name must be shorter than 50 character")]
        public String FullName { get; set; }

        [Required(ErrorMessage = "Please enter number of session")]
        [Range(1,40,ErrorMessage ="The number of sesion is a digit from 1 to 40")]
        public int NumberOfSession { get; set; }

        [Required(ErrorMessage = "Please enter number of slot")]
        public int NumberOfSlot { get; set; }
    }
    [MetadataType(typeof(ClassMetaData))]
    public partial class Class
    {
    }
    public class ClassMetaData
    {
        [Required(ErrorMessage = "Please enter Class name")]
        [MinLength(5, ErrorMessage = "Name must be longer than 5 characters")]
        [MaxLength(50, ErrorMessage = "Name must be shorter than 50 character")]
        public String ClassName { get; set; }
    }
    [MetadataType(typeof(SemesterMetadata))]
    public partial class Semester
    {
    }
    public class SemesterMetadata
    {
        [Required(ErrorMessage = "Please enter semester name")]
        public String SemesterName { get; set; }
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
            foreach (var Student in this.Students)
            {
                NewRoll.Students.Add(Student);
            }
            //NewRoll.Students = this.Students.ToList();
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