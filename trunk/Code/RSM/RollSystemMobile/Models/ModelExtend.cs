using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

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
    }
}