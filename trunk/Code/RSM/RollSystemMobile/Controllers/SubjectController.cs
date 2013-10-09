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
            return View(SubBO.GetActiveSubject());
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
            return View();
        } 

        //
        // POST: /Subject/Create

        [HttpPost]
        public ActionResult Create(Subject subject)
        {
            if (ModelState.IsValid)
            {
                SubBO.Insert(subject);
                return RedirectToAction("Index");  
            }
            return View(subject);
        }
        
        //
        // GET: /Subject/Edit/5
 
        public ActionResult Edit(int id)
        {
            Subject subject = SubBO.GetSubjectByID(id);
            int NumberOfSlot = subject.NumberOfSlot;
            ViewBag.NumberOfSlot = slFactory.MakeSelectList<Subject>("SubjectID", "NumberOfSlot", NumberOfSlot);
            return View(subject);
        }

        //
        // POST: /Subject/Edit/5

        [HttpPost]
        public ActionResult Edit(Subject subject)
        {
            if (ModelState.IsValid)
            {
                SubBO.Update(subject);
                return RedirectToAction("Index");
            }
            int NumberOfSlot = subject.NumberOfSlot;
            ViewBag.NumberOfSlot = slFactory.MakeSelectList<Subject>("SubjectID", "NumberOfSlot", NumberOfSlot);
            return View(subject);
        }

        //
        // GET: /Subject/Delete/5
 
        public ActionResult Delete(int id)
        {
            Subject subject = SubBO.GetSubjectByID(id);
            return View(subject);
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