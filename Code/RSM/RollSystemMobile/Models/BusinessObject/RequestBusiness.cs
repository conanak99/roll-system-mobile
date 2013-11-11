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

        public List<Request> GetPendingRequest()
        {
           return base.GetList().Where(r => r.CheckedAdminID == null).ToList();
        }

        public RequestImage FindReqImageByID(int ImageID)
        {
            return RollSystemDB.RequestImages.SingleOrDefault(img => img.ImageID == ImageID);
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

        public void DeleteImage(RequestImage ReqImg)
        {
            RollSystemDB.RequestImages.DeleteObject(ReqImg);
            RollSystemDB.SaveChanges();
        }
    }
}