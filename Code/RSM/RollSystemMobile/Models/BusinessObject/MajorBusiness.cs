using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class MajorBusiness : GenericBusiness<Major>
    {
        public MajorBusiness()
        {

        }
        public MajorBusiness(RSMEntities DB)
            : base(DB)
        {

        }

        public Major GetMajorByID(int id)
        {
            return base.GetList().SingleOrDefault(c => c.MajorID == id);
        }
    }
}