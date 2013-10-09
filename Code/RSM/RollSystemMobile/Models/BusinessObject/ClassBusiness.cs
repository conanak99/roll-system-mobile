using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class ClassBusiness: GenericBusiness<Class>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public ClassBusiness()
        {
            
        }
        public ClassBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }
        public List<Class> GetAllClasses()
        {
            return base.GetList();
        }


        public List<Class> GetActiveClasses()
        {
            return base.GetList().Where(c => c.IsActive).ToList();
        }

    }
}