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
    public class SemesterController : Controller
    {
        private RSMEntities db = new RSMEntities();

        //
        // GET: /Semester/

        public ViewResult Index()
        {
            return View(db.Semesters.ToList());
        }

        //
        // GET: /Semester/Details/5

        public ViewResult Details(int id)
        {
            Semester semester = db.Semesters.Single(s => s.SemesterID == id);
            return View(semester);
        }

        //
        // GET: /Semester/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Semester/Create

        [HttpPost]
        public ActionResult Create(Semester semester)
        {
            if (ModelState.IsValid)
            {
                db.Semesters.AddObject(semester);
                db.SaveChanges();
                return RedirectToAction("Index");  
            }

            return View(semester);
        }
        
        //
        // GET: /Semester/Edit/5
 
        public ActionResult Edit(int id)
        {
            Semester semester = db.Semesters.Single(s => s.SemesterID == id);
            return View(semester);
        }

        //
        // POST: /Semester/Edit/5

        [HttpPost]
        public ActionResult Edit(Semester semester)
        {
            if (ModelState.IsValid)
            {
                db.Semesters.Attach(semester);
                db.ObjectStateManager.ChangeObjectState(semester, EntityState.Modified);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(semester);
        }

        //
        // GET: /Semester/Delete/5
 
        public ActionResult Delete(int id)
        {
            Semester semester = db.Semesters.Single(s => s.SemesterID == id);
            return View(semester);
        }

        //
        // POST: /Semester/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {            
            Semester semester = db.Semesters.Single(s => s.SemesterID == id);
            db.Semesters.DeleteObject(semester);
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