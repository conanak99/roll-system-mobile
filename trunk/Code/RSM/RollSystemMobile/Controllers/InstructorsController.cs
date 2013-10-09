﻿using System;
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
        //
        // GET: /Subject/

       public InstructorsController()
        {
            InsBO = new InstructorBusiness();
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

            var ins = InsBO.GetAllInstructor();
            ViewBag.UserID = new SelectList(ins, "UserID", "Username");
            return View(instructor);
        }
        
        //
        // GET: /Default1/Edit/5
 
        public ActionResult Edit(int id)
        {
            Instructor instructor = InsBO.GetInstructorByID(id);
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

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }
    }
}