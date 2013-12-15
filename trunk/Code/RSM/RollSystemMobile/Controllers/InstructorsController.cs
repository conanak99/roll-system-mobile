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


        public ActionResult InactiveInstructor(int id) {
            var ins = InsBO.GetInstructorByID(id);
            ins.IsActive = false;
            InsBO.UpdateExist(ins);
            return RedirectToAction("Index");
        }
        public ActionResult ActiveInstructor(int id)
        {
            var ins = InsBO.GetInstructorByID(id);
            ins.IsActive = true;
            InsBO.UpdateExist(ins);
            return RedirectToAction("Index");
        }
        //
        // POST: /Default1/Create

        public ActionResult Create()
        {
            ViewBag.TypeID = slFactory.MakeSelectList<SubjectType>("TypeID", "TypeName");
            return View();
        }

        [HttpPost]
        public ActionResult Create(Instructor instructor, List<int> SubjectTypeID)
        {
            if (ModelState.IsValid && SubjectTypeID != null)
            {
                InsBO.Insert(instructor, SubjectTypeID);
                return RedirectToAction("Index");
            }
            if (SubjectTypeID == null)
            {
                ModelState.AddModelError("", "One or more subject type must be selected.");
            }
            ViewBag.SelectedIDs = SubjectTypeID;
            ViewBag.TypeID = slFactory.MakeSelectList<SubjectType>("TypeID", "TypeName");
            return View(instructor);
        }

        public ActionResult Edit(int id)
        {
            Instructor instructor = InsBO.GetInstructorByID(id);
            ViewBag.TypeID = slFactory.MakeSelectList<SubjectType>("TypeID", "TypeName");
            return View(instructor);
        }

        [HttpPost]
        public ActionResult Edit(Instructor instructor, List<int> SubjectTypeID)
        {
            if (ModelState.IsValid && SubjectTypeID != null)
            {
                InsBO.Update(instructor, SubjectTypeID);
            }
            if (SubjectTypeID == null)
            {
                ModelState.AddModelError("", "One or more subject type must be selected.");
            }
            ViewBag.TypeID = slFactory.MakeSelectList<SubjectType>("TypeID", "TypeName");
            return RedirectToAction("Index");
        }

        public ActionResult Delete(int id)
        {
            Instructor instructor = InsBO.GetInstructorByID(id);
            InsBO.Delete(instructor);
            return RedirectToAction("Index");
        }

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

        public ActionResult GetCalendarEvent(int InstructorID)
        {
            StudySessionBusiness StuSesBO = new StudySessionBusiness();
            List<Event> TeachingSession = StuSesBO.GetCalendarEvent(InstructorID);
            return Json(TeachingSession, JsonRequestBehavior.AllowGet);
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }
    }
}