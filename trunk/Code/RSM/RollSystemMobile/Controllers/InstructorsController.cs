using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BindingModels;
using RollSystemMobile.Models.BusinessObject;

namespace RollSystemMobile.Controllers
{
    public class InstructorsController : Controller
    {

        private InstructorBusiness InsBO;
        SelectListFactory slFactory; 
        //
        // GET: /Subject/

        public InstructorsController()
        {
            InsBO = new InstructorBusiness();
            slFactory = new SelectListFactory();
        }

        public ViewResult Index()
        {
            return View(InsBO.GetList().ToList());
        }

        //
        // GET: /Default1/Details/5

        public ViewResult Details(int id)
        {
            Instructor instructor = InsBO.GetInstructorByID(id);
            return View(instructor);
        }

        //
        // GET: /Default1/Create

        public ActionResult Create()
        {
            SelectListFactory slFactory = new SelectListFactory();
            ViewBag.UserID = slFactory.MakeSelectList<User>("UserID", "Username");
            return View();
        }

        //
        // POST: /Default1/Create

        [HttpPost]
        public ActionResult Create(Instructor instructor)
        {
            if (ModelState.IsValid)
            {
                InsBO.Insert(instructor);
                return RedirectToAction("Index");
            }

            
            ViewBag.UserID = slFactory.MakeSelectList<User>("UserID", "Username");
            return View(instructor);
        }

        //
        // GET: /Default1/Edit/5

        public ActionResult Edit(int id)
        {
            Instructor instructor = InsBO.GetInstructorByID(id);
            int UserID = instructor.User.UserID;
            ViewBag.UserID = slFactory.MakeSelectList<User>("UserID", "Username", UserID);
            return View(instructor);
        }

        //
        // POST: /Default1/Edit/5

        [HttpPost]
        public ActionResult Edit(Instructor instructor)
        {
            if (ModelState.IsValid)
            {
                InsBO.Update(instructor);
                return RedirectToAction("Index");
            }
            int UserID = instructor.User.UserID;
            ViewBag.UserID = slFactory.MakeSelectList<User>("UserID", "Username", UserID);
            return View(instructor);
        }

        //
        // GET: /Default1/Delete/5

        public ActionResult Delete(int id)
        {
            Instructor instructor = InsBO.GetInstructorByID(id);
            return View(instructor);
        }

        //
        // POST: /Default1/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            Instructor instructor = InsBO.GetInstructorByID(id);
            InsBO.Delete(instructor);
            return RedirectToAction("Index");
        }

        public ActionResult Schedule(int id)
        {
            var Instructor = InsBO.GetInstructorByID(id);
            return View(Instructor);
        }

        public ActionResult GetTeachingSession(int InstructorID)
        {
            RollCallBusiness RollBO = new RollCallBusiness();
            var CurrentRollCall = RollBO.GetInstructorFutureRollCalls(InstructorID);

            var TotalCompliation = new List<Event>();

            foreach (RollCall rollCall in CurrentRollCall)
            {
                var TimeAndClass = rollCall.StudySessions.Where(ss => ss.InstructorID == InstructorID).Select(s => new Event()
                {
                    id = s.SessionID +"",
                    title =  s.StartTime.ToString(@"hh\:mm") + " - " + s.EndTime.ToString(@"hh\:mm") + "\n" +
                    s.Class.ClassName + " - " + rollCall.Subject.ShortName,
                    start = s.SessionDate.ToString("yyyy-MM-dd") + " " + s.StartTime.ToString(@"hh\:mm"),
                    end = s.SessionDate.ToString("yyyy-MM-dd") + " " + s.EndTime.ToString(@"hh\:mm")
                });

                TotalCompliation.AddRange(TimeAndClass.ToList());
            }

            return Json(TotalCompliation, JsonRequestBehavior.AllowGet);
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }
    }
}