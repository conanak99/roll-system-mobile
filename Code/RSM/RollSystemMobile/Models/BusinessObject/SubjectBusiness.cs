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
        public void Insert(Subject sub, List<int> SubjectTypeIDs)
        {
            foreach (var SubjectTypeID in SubjectTypeIDs)
            {
             //   sub.SubjectTypes.Add(GetSubjectTypeByID(SubjectTypeID));
            }
            base.Insert(sub);
        }

        public void Update(Subject sub, List<int> SubjectTypeIDs)
        {
            var subject = GetSubjectByID(sub.SubjectID);

            subject.ShortName = sub.ShortName;
            subject.NumberOfSession = sub.NumberOfSession;
            subject.NumberOfSlot = sub.NumberOfSlot;
            subject.FullName = sub.FullName;

            foreach (var SubjectTypeID in SubjectTypeIDs)
            {
                //subject.SubjectTypes.Add(GetSubjectTypeByID(SubjectTypeID));
            }
            base.Detach(subject);
            base.Update(subject);
        }
    }
}