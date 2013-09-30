using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;

namespace RollSystemMobile.Controllers
{ 
    public class RollCallController : Controller
    {
        private RSMEntities db = new RSMEntities();

        //
        // GET: /RollCall/

        public ViewResult Index()
        {
            var rollcalls = db.RollCalls.Include("Class").Include("Semester").Include("Subject");
            return View(rollcalls.ToList());
        }

        //
        // GET: /RollCall/Details/5

        public ViewResult Details(int id)
        {
            RollCall rollcall = db.RollCalls.Single(r => r.RollCallID == id);
            return View(rollcall);
        }

        //
        // GET: /RollCall/Create

        public ActionResult Create()
        {
            ViewBag.ClassID = new SelectList(db.Classes, "ClassID", "ClassName");
            ViewBag.SemesterID = new SelectList(db.Semesters, "SemesterID", "SemesterName");
            ViewBag.SubjectID = new SelectList(db.Subjects, "SubjectID", "ShortName");
            return View();
        } 

        //
        // POST: /RollCall/Create

        [HttpPost]
        public ActionResult Create(RollCall rollcall)
        {
            if (ModelState.IsValid)
            {
                db.RollCalls.AddObject(rollcall);
                db.SaveChanges();
                return RedirectToAction("Index");  
            }

            ViewBag.ClassID = new SelectList(db.Classes, "ClassID", "ClassName", rollcall.ClassID);
            ViewBag.SemesterID = new SelectList(db.Semesters, "SemesterID", "SemesterName", rollcall.SemesterID);
            ViewBag.SubjectID = new SelectList(db.Subjects, "SubjectID", "ShortName", rollcall.SubjectID);
            return View(rollcall);
        }
        
        //
        // GET: /RollCall/Edit/5
 
        public ActionResult Edit(int id)
        {
            RollCall rollcall = db.RollCalls.Single(r => r.RollCallID == id);
            ViewBag.ClassID = new SelectList(db.Classes, "ClassID", "ClassName", rollcall.ClassID);
            ViewBag.SemesterID = new SelectList(db.Semesters, "SemesterID", "SemesterName", rollcall.SemesterID);
            ViewBag.SubjectID = new SelectList(db.Subjects, "SubjectID", "ShortName", rollcall.SubjectID);
            return View(rollcall);
        }

        //
        // POST: /RollCall/Edit/5

        [HttpPost]
        public ActionResult Edit(RollCall rollcall)
        {
            if (ModelState.IsValid)
            {
                db.RollCalls.Attach(rollcall);
                db.ObjectStateManager.ChangeObjectState(rollcall, EntityState.Modified);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ClassID = new SelectList(db.Classes, "ClassID", "ClassName", rollcall.ClassID);
            ViewBag.SemesterID = new SelectList(db.Semesters, "SemesterID", "SemesterName", rollcall.SemesterID);
            ViewBag.SubjectID = new SelectList(db.Subjects, "SubjectID", "ShortName", rollcall.SubjectID);
            return View(rollcall);
        }

        //
        // GET: /RollCall/Delete/5
 
        public ActionResult Delete(int id)
        {
            RollCall rollcall = db.RollCalls.Single(r => r.RollCallID == id);
            return View(rollcall);
        }

        //
        // POST: /RollCall/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {            
            RollCall rollcall = db.RollCalls.Single(r => r.RollCallID == id);
            db.RollCalls.DeleteObject(rollcall);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}