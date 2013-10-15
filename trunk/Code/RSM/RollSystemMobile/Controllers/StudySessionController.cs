﻿using System;
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
        private RollCallBusiness RollBO;
        public StudySessionController()
        {
            StuSesBO = new StudySessionBusiness();
            RollBO = new RollCallBusiness();
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


        public ActionResult AddSession(int RollCallID)
        {
            var rollCall = RollBO.GetRollCallByID(RollCallID);
            SelectListFactory slFactory = new SelectListFactory();
            ViewBag.InstructorID = slFactory.MakeSelectList<Instructor>("InstructorID", "FullName", rollCall.InstructorID);

            return View("_NewSession", rollCall);
        }

        [HttpPost]
        public ActionResult AddSession(StudySession Model, TimeSpan _StartTime, String _SessionDate)
        { 
            Model.SessionDate = _SessionDate.ParseStringToDateTime();
            Model.StartTime = _StartTime;


            StuSesBO.Insert(Model);
            return Json(new { message = "Success" }, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetAvaibleSessionTime(int RollCallID, DateTime SelectedDate)
        {
            var TimeList = StuSesBO.FindAvaibleSessionTime(RollCallID, SelectedDate);
            //Dua ket qua ra
            var result = TimeList.Select(time => new { time = time.ToString(@"hh\:mm") });

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAvaibleInstructor(int RollCallID, TimeSpan SelectedTime, String InSelectedDate)
        {
            DateTime SelectedDate = InSelectedDate.ParseStringToDateTime();
            InstructorBusiness InsBO = new InstructorBusiness();
            //Lay nhung giao vien ko ban day vao ngay, gio
            var AllInstructors = InsBO.GetInstructorOfRollCall(RollCallID).ToList();
            var BusyInstructors = AllInstructors.Where(ins => ins.StudySessions.Any(ss =>
                ss.StartTime == SelectedTime && ss.SessionDate == SelectedDate)).ToList();

            foreach (var Ins in BusyInstructors)
            {
                AllInstructors.Remove(Ins);
            }

            var Result = AllInstructors.Select(ins => new { id = ins.InstructorID, name = ins.Fullname });
            return Json(Result, JsonRequestBehavior.AllowGet);
        }
    }
}