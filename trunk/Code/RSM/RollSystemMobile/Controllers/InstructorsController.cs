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
    public class InstructorsController : Controller
    {
        private RSMEntities db = new RSMEntities();

        //
        // GET: /Default1/

        public ViewResult Index()
        {
            var instructors = db.Instructors.Include("User");
            return View(instructors.ToList());
        }

        //
        // GET: /Default1/Details/5

        public ViewResult Details(int id)
        {
            Instructor instructor = db.Instructors.Single(i => i.InstructorID == id);
            return View(instructor);
        }

        //
        // GET: /Default1/Create

        public ActionResult Create()
        {
            ViewBag.UserID = new SelectList(db.Users, "UserID", "Username");
            return View();
        } 

        //
        // POST: /Default1/Create

        [HttpPost]
        public ActionResult Create(Instructor instructor)
        {
            if (ModelState.IsValid)
            {
                db.Instructors.AddObject(instructor);
                db.SaveChanges();
                return RedirectToAction("Index");  
            }

            ViewBag.UserID = new SelectList(db.Users, "UserID", "Username", instructor.UserID);
            return View(instructor);
        }
        
        //
        // GET: /Default1/Edit/5
 
        public ActionResult Edit(int id)
        {
            Instructor instructor = db.Instructors.Single(i => i.InstructorID == id);
            ViewBag.UserID = new SelectList(db.Users, "UserID", "Username", instructor.UserID);
            return View(instructor);
        }

        //
        // POST: /Default1/Edit/5

        [HttpPost]
        public ActionResult Edit(Instructor instructor)
        {
            if (ModelState.IsValid)
            {
                db.Instructors.Attach(instructor);
                db.ObjectStateManager.ChangeObjectState(instructor, EntityState.Modified);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.UserID = new SelectList(db.Users, "UserID", "Username", instructor.UserID);
            return View(instructor);
        }

        //
        // GET: /Default1/Delete/5
 
        public ActionResult Delete(int id)
        {
            Instructor instructor = db.Instructors.Single(i => i.InstructorID == id);
            return View(instructor);
        }

        //
        // POST: /Default1/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {            
            Instructor instructor = db.Instructors.Single(i => i.InstructorID == id);
            db.Instructors.DeleteObject(instructor);
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