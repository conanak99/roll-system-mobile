using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class LogBusiness: GenericBusiness<AttendanceLog>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public LogBusiness()
        {
            
        }
        public LogBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }

        public List<AttendanceLog> FindLogWithImages(DateTime FromDate, DateTime ToDate, int? ClassID)
        {
            var LogList = base.GetList().Where(log => log.LogDate >= FromDate
                && log.LogDate <= ToDate && log.LogImages.Count > 0).OrderByDescending(log => log.LogDate);
            if (ClassID == null)
            {
                return LogList.ToList();
            }
            else
            {
                return LogList.Where(log => log.RollCall.ClassID == ClassID.Value).ToList();
            }

        }
        
    }
}