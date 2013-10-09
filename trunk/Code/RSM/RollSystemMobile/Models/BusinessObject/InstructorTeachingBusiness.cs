using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class InstructorTeachingBusiness: GenericBusiness<InstructorTeaching>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public InstructorTeachingBusiness()
        {
            
        }
        public InstructorTeachingBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }

        public List<InstructorTeaching> GetByRollCallID(int RollCallID)
        {
            return base.GetList().Where(it => it.RollCallID == RollCallID).ToList();
        }



    }
}