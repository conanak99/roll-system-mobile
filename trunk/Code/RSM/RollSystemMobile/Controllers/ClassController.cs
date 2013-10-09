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
    public class ClassController : Controller
    {
         private ClassBusiness ClassBO;
        //
        // GET: /Subject/

         public ClassController()
        {
            ClassBO = new ClassBusiness();
        }

        public ViewResult Index()
        {
            return View(ClassBO.GetAllClasses().ToList());
        }

        //
        // GET: /Class/Details/5

        public ViewResult Details(int id)
        {
            Class cls = ClassBO.GetClassByID(id);
            return View(cls);
        }

        //
        // GET: /Class/Create

        public ActionResult Create()
        {
            SelectListFactory slFactory = new SelectListFactory();
            //ViewBag.MajorID = new SelectList(, "MajorID", "Shortname");
            ViewBag.MajorID = slFactory.MakeSelectList<Major>("MajorID", "ShortName");
            return View();
        } 

        //
        // POST: /Class/Create

        [HttpPost]
        public ActionResult Create(Class cls)
        {
            if (ModelState.IsValid)
            {
                ClassBO.Insert(cls);
                return RedirectToAction("Index");  
            }
            return View(cls);
        }
        
        //
        // GET: /Class/Edit/5
 
        public ActionResult Edit(int id)
        {
            Class cls = ClassBO.GetClassByID(id);
            return View(cls);
        }

        //
        // POST: /Class/Edit/5

        [HttpPost]
        public ActionResult Edit(Class cls)
        {
            if (ModelState.IsValid)
            {
                ClassBO.Update(cls);
                return RedirectToAction("Index");
            }
            return View(cls);
        }

        //
        // GET: /Class/Delete/5
 
        public ActionResult Delete(int id)
        {
            Class cls = ClassBO.GetClassByID(id);
            return View(cls);
        }

        //
        // POST: /Class/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {            
            Class cls = ClassBO.GetClassByID(id);
            ClassBO.Delete(cls);
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }
    }
}