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
        public void Insert(Subject sub, List<int> MajorIDs)
        {
            sub.IsActive = true;
            foreach (var MajorID in MajorIDs)
            {
                sub.Majors.Add(GetMajorByID(MajorID));
            }
            base.Insert(sub);
        }
        private Major GetMajorByID(int MajorID)
        {
            return base.RollSystemDB.Majors.FirstOrDefault(st => st.MajorID == MajorID);
        }
        public void Update(Subject sub, List<int> MajorIDs)
        {
            var subject = GetSubjectByID(sub.SubjectID);

            subject.ShortName = sub.ShortName;
            subject.NumberOfSession = sub.NumberOfSession;
            subject.NumberOfSlot = sub.NumberOfSlot;
            subject.FullName = sub.FullName;
            subject.SubjectType = subject.SubjectType;
            subject.Majors.Clear();
            foreach (var MajorID in MajorIDs)
            {
                subject.Majors.Add(GetMajorByID(MajorID));
            }
            base.RollSystemDB.SaveChanges();
        }
    }
}