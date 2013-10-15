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
    public class StudySessionController : Controller
    {
        //
        // GET: /StudySession/
        private StudySessionBusiness StuSesBO;

        public StudySessionController()
        {
            StuSesBO = new StudySessionBusiness();
        }

        public ActionResult SessionDetail(int ID)
        {
            StudySession Session = StuSesBO.GetSessionByID(ID);
            SelectListFactory slFactory = new SelectListFactory();
            ViewBag.InstructorID = slFactory.MakeSelectList<Instructor>("InstructorID", "FullName", Session.InstructorID);

            return PartialView("_SessionDetail", Session);
        }

        public ActionResult Edit(StudySession Model, TimeSpan _StartTime, String _SessionDate)
        {
            try
            {
                //Bug tao select list cua MVC
                Model.StartTime = _StartTime;
                //Parse datetime kieu manual
                Model.SessionDate = _SessionDate.ParseStringToDateTime();

                StuSesBO.Update(Model);
            }
            catch (Exception e)
            {
                return Json(new { message = "Error", error = e.Message }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { message = "Success" }, JsonRequestBehavior.AllowGet);
        }

    }
}
