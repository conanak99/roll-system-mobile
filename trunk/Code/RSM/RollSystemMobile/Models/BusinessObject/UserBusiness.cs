using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class UserBusiness : GenericBusiness<User>
    {
        //
        // GET: /UserBusiness/

         public UserBusiness()
        {
            
        }
         public UserBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }
        public List<User> GetAllUsers()
        {
            return base.GetList();
        }

        public List<User> GetActiveUsers()
        {
            return base.GetList().Where(c => c.IsActive).ToList();
        }

    }
}
