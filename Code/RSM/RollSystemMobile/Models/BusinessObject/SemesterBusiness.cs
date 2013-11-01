using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class SemesterBusiness: GenericBusiness<Semester>
    {
         public SemesterBusiness()
        {
            
        }
         public SemesterBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }
        
        public Semester GetSemesterByID(int id)
        {
            return base.GetList().SingleOrDefault(c => c.SemesterID == id);
        }
    }
}