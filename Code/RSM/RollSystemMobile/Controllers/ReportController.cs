using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;
using RollSystemMobile.Models.HelperClass;

namespace RollSystemMobile.Controllers
{
    public class ReportController : Controller
    {
        //
        // GET: /Report/RollCall/1
        private RSMEntities db = new RSMEntities();

        public ActionResult RollCall(int id)
        {
            RollCall RollCall = db.RollCalls.First(r => r.RollCallID == id);
            String FileName = RollCall.Class.ClassName + "_" + RollCall.Subject.ShortName
                + "_" + DateTime.Today.ToString("dd-MM-yyyy") + ".xlsx";

            RollCallBusiness BO = new RollCallBusiness();
            String FilePath = Server.MapPath("~/Content/Temp/" + FileName);
            BO.CreateRollCallReport(id, FilePath);

            String ExcelMimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            return File(FilePath, ExcelMimeType, FileName);
        }

    }
}
