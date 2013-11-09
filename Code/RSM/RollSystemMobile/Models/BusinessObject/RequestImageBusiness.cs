using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RollSystemMobile.Models.BusinessObject
{
    public class RequestImageBusiness : GenericBusiness<RequestImage>
    {
           public RequestImageBusiness()
        {
            
        }
           public RequestImageBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }
    }
}