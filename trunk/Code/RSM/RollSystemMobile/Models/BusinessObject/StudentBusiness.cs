using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class StudentBusiness: GenericBusiness<Student>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public StudentBusiness()
        {
            
        }
        public StudentBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }
        public List<Student> GetAllStudents()
        {
            return base.GetList();
        }

        public List<Student> GetActiveStudents()
        {
            return base.GetList().Where(c => c.IsActive).ToList();
        }

        public List<Student> GetStudentInClass(int ClassID)
        {
            return base.GetList().Where(s => s.ClassID == ClassID && s.IsActive).ToList();
        }

        public Student GetStudentByID(int StudentID)
        {
            return base.GetList().SingleOrDefault(s => s.StudentID == StudentID);
        }

        public List<Student> GetStudentsNotInRollCall(int RollCallID)
        {
            return base.GetList().Where(s => !s.RollCalls.Any(d => d.RollCallID == RollCallID)).
                OrderBy(s => s.StudentID).ToList();
        }

        public Student GetStudentByUserID(int UserID)
        {
            return base.FindSingle(st => st.UserID == UserID);
        }
    }
}