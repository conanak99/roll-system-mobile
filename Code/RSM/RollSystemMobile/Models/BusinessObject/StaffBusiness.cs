using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class StaffBusiness : GenericBusiness<Staff>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public StaffBusiness()
        {
            
        }
        public StaffBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }

        public List<Staff> GetAllStaff()
        {
            return base.GetList().ToList();
        }

        public Staff GetStaffByID(int StaffID)
        {
            return base.GetList().SingleOrDefault(st => st.StaffID == StaffID);
        }
        

    }
}