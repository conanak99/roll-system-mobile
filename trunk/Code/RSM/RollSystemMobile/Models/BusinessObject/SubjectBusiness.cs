using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class SubjectBusiness: GenericBusiness<Subject>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public SubjectBusiness()
        {
            
        }
        public SubjectBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }


        public List<Subject> GetActiveSubject()
        {
            return base.GetList().Where(c => c.IsActive).ToList();
        }

        public List<Subject> GetSubjectByMajor(int MajorID)
        {
            return base.GetList().Where(c => 
                c.Majors.Select(m => m.MajorID).Contains(MajorID) && c.IsActive).
                OrderBy(s => s.ShortName).ToList();
        }

        public Subject GetSubjectByID(int SubjectID)
        {
            return base.GetList().FirstOrDefault(s => s.SubjectID == SubjectID);
        }

    }
}