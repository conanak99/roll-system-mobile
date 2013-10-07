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
    public class SubjectController : Controller
    {
        private RSMEntities db = new RSMEntities();

        //
        // GET: /Subject/

        public ViewResult Index()
        {
            return View(db.Subjects.ToList());
        }

        //
        // GET: /Subject/Details/5

        public ViewResult Details(int id)
        {
            Subject subject = db.Subjects.Single(s => s.SubjectID == id);
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
                db.Subjects.AddObject(subject);
                db.SaveChanges();
                return RedirectToAction("Index");  
            }

            return View(subject);
        }
        
        //
        // GET: /Subject/Edit/5
 
        public ActionResult Edit(int id)
        {
            Subject subject = db.Subjects.Single(s => s.SubjectID == id);
            return View(subject);
        }

        //
        // POST: /Subject/Edit/5

        [HttpPost]
        public ActionResult Edit(Subject subject)
        {
            if (ModelState.IsValid)
            {
                db.Subjects.Attach(subject);
                db.ObjectStateManager.ChangeObjectState(subject, EntityState.Modified);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(subject);
        }

        //
        // GET: /Subject/Delete/5
 
        public ActionResult Delete(int id)
        {
            Subject subject = db.Subjects.Single(s => s.SubjectID == id);
            return View(subject);
        }

        //
        // POST: /Subject/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {            
            Subject subject = db.Subjects.Single(s => s.SubjectID == id);
            db.Subjects.DeleteObject(subject);
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