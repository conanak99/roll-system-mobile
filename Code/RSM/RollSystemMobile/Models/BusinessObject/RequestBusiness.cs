using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.HelperClass;

namespace RollSystemMobile.Models.BusinessObject
{
    public class RequestBusiness: GenericBusiness<Request>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public RequestBusiness()
        {
            
        }
        public RequestBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }

        public void InsertImage(RequestImage ReqImg)
        {
            RollSystemDB.RequestImages.AddObject(ReqImg);
        }
    }
}