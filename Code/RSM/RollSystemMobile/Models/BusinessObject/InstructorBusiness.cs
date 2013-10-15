using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class InstructorBusiness: GenericBusiness<Instructor>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public InstructorBusiness()
        {
            
        }
        public InstructorBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }

        public List<Instructor> GetAllInstructor()
        {
            return base.GetList().ToList();
        }


        public List<Instructor> GetActiveInstructor()
        {
            return base.GetList().Where(i => i.IsActive).ToList();
        }

        public List<Instructor> GetInstructorOfRollCall(int RollCallID)
        {
            RollCallBusiness RollBO = new RollCallBusiness();
            var rollCall = RollBO.GetRollCallByID(RollCallID);
            return rollCall.Subject.SubjectType.Instructors.ToList();
        }

        public Instructor GetInstructorByID(int ID)
        {
            return base.GetList().FirstOrDefault(i => i.InstructorID == ID);
        }

        public Instructor GetInstructorByUserID(int ID)
        {
            return base.GetList().FirstOrDefault(i => i.UserID == ID);
        }

    }
}