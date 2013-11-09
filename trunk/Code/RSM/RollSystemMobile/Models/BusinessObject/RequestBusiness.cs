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

        public Request GetRequestByID(int id)
        {
            return base.GetList().SingleOrDefault(c => c.RequestID == id);
        }

        public void InsertImage(RequestImage ReqImg)
        {
            try
            {
                RollSystemDB.RequestImages.AddObject(ReqImg);
                RollSystemDB.SaveChanges();
            }
            catch (Exception e)
            { 
            
            }
        }
    }
}