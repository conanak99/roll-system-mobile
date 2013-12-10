using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;

namespace RollSystemMobile.Controllers
{ 
    [Authorize]
    public class SubjectController : Controller
    {
        private SubjectBusiness SubBO;
        SelectListFactory slFactory; 
        //
        // GET: /Subject/

        public SubjectController()
        {
            SubBO = new SubjectBusiness();
            slFactory = new SelectListFactory();
        }

        public ViewResult Index()
        {
            return View(SubBO.GetList());
        }

        //
        // GET: /Subject/Details/5

        public ViewResult Details(int id)
        {
            Subject subject = SubBO.GetSubjectByID(id);
            return View(subject);
        }

        //
        // GET: /Subject/Create

        public ActionResult Create()
        {
            ViewBag.TypeID = slFactory.MakeSelectList<SubjectType>("TypeID", "TypeName");
            return View();
        } 

        //
        // POST: /Subject/Create

        [HttpPost]
        public ActionResult Create(Subject subject , List<int> SubjectTypeID)
        {
            if (ModelState.IsValid && SubjectTypeID != null)
            {
                subject.IsActive= true;
                SubBO.Insert(subject, SubjectTypeID);
                return RedirectToAction("Index");
            }
            if (SubjectTypeID == null)
            {
                ModelState.AddModelError("", "One or more subject type must be selected.");
            }
            ViewBag.SelectedIDs = SubjectTypeID;
            ViewBag.TypeID = slFactory.MakeSelectList<SubjectType>("TypeID", "TypeName");
            return View(subject);
        }
        
        //
        // GET: /Subject/Edit/5
 
        public ActionResult Edit(int id)
        {
            Subject subject = SubBO.GetSubjectByID(id);
            int NumberOfSlot = subject.NumberOfSlot;
            ViewBag.NumberOfSlot = slFactory.MakeSelectList<Subject>("SubjectID", "NumberOfSlot", NumberOfSlot);
            ViewBag.TypeID = slFactory.MakeSelectList<SubjectType>("TypeID", "TypeName");
            return View(subject);
        }

        //
        // POST: /Subject/Edit/5

        [HttpPost]
        public ActionResult Edit(Subject subject, List<int> SubjectTypeID)
        {
            if (ModelState.IsValid && SubjectTypeID != null)
            {
                SubBO.Update(subject, SubjectTypeID);
            }
            if (SubjectTypeID == null)
            {
                ModelState.AddModelError("", "One or more subject type must be selected.");
            }
            ViewBag.TypeID = slFactory.MakeSelectList<SubjectType>("TypeID", "TypeName");
            int NumberOfSlot = subject.NumberOfSlot;
            ViewBag.NumberOfSlot = slFactory.MakeSelectList<Subject>("SubjectID", "NumberOfSlot", NumberOfSlot);
            return View(subject);
        }

        //
        public ActionResult InactiveSubject(int id)
        {
            var sub = SubBO.GetSubjectByID(id);
            sub.IsActive = false;
            SubBO.UpdateExist(sub);
            return RedirectToAction("Index");
        }
        public ActionResult ActiveSubject(int id)
        {
            var sub = SubBO.GetSubjectByID(id);
            sub.IsActive = true;
            SubBO.UpdateExist(sub);
            return RedirectToAction("Index");
        }
        // GET: /Subject/Delete/5
 
        public ActionResult Delete(int id)
        {
            Subject subject = SubBO.GetSubjectByID(id);
            SubBO.Delete(subject);
            return RedirectToAction("Index");
        }

        //
        // POST: /Subject/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            Subject subject = SubBO.GetSubjectByID(id);
            SubBO.Delete(subject);
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
           
            base.Dispose(disposing);
        }
    }
}