using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class ClassBO
    {
        private RSMEntities db;

        public ClassBO()
        {
            db = new RSMEntities();
        }
        
    }
}