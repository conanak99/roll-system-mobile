using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using System.Drawing;
using RollSystemMobile.Models.BusinessObject;

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
            //Mac dinh, majorID la 1
            int MajorID = 1;
            int ClassID = 1;
            //Them 1 cai ID cua instructor
            ViewBag.InstructorID = new SelectList(db.Instructors, "InstructorID", "FullName");
            ViewBag.MajorID = new SelectList(db.Majors, "MajorID", "FullName", MajorID);
            ViewBag.StudentID = new SelectList(db.Students.Where(a => a.ClassID == ClassID), "StudentID", "FullName");
            ViewBag.ClassID = new SelectList(db.Classes.Where(c => c.MajorID == MajorID),
                "ClassID", "ClassName");
            //Mac dinh, lay semester moi nhat
            ViewBag.SemesterID = new SelectList(db.Semesters, "SemesterID", "SemesterName", db.Semesters.ToList().Last().SemesterID);
            ViewBag.SubjectID = new SelectList(db.Majors.
                Single(m => m.MajorID == MajorID).Subjects,
                "SubjectID", "ShortName");

            return View();
        }

        //
        // POST: /RollCall/Create

        [HttpPost]
        public ActionResult Create(RollCall rollcall, int MajorID, int InstructorID,int ClassID)
        {
            if (ModelState.IsValid)
            {
                RollCallBO BO = new RollCallBO();
                List<string> ErrorList = BO.ValidRollCall(rollcall);
                if (ErrorList.Count == 0)
                {
                    rollcall = BO.FillRollCallInfo(rollcall, InstructorID);
                    BO.InsertRollCall(rollcall);
                    return RedirectToAction("Index");
                }
                else
                {
                    foreach (var Error in ErrorList)
                    {
                        ModelState.AddModelError(String.Empty, Error);
                    }
                }
            }

            ViewBag.InstructorID = new SelectList(db.Instructors, "InstructorID", "FullName", InstructorID);
            ViewBag.MajorID = new SelectList(db.Majors, "MajorID", "FullName", MajorID);
            ViewBag.StudentID = new SelectList(db.Students.Where(a => a.ClassID == ClassID), "StudentID", "FullName");
            ViewBag.ClassID = new SelectList(db.Classes.Where(c => c.MajorID == MajorID),
                "ClassID", "ClassName", rollcall.ClassID);
            ViewBag.SemesterID = new SelectList(db.Semesters, "SemesterID", "SemesterName", rollcall.SemesterID);
            ViewBag.SubjectID = new SelectList(db.Majors.
                Single(m => m.MajorID == MajorID).Subjects,
                "SubjectID", "ShortName", rollcall.SubjectID);
            return View(rollcall);
        }

        //
        // GET: /RollCall/Edit/5

        public ActionResult Edit(int id)
        {
            RollCall rollcall = db.RollCalls.Single(r => r.RollCallID == id);

            int MajorID = rollcall.Class.MajorID;
            int InstructorID = rollcall.InstructorTeachings.ToList().Last().InstructorID;
            ViewBag.MajorID = new SelectList(db.Majors, "MajorID", "FullName", MajorID);
            ViewBag.ClassID = new SelectList(db.Classes.Where(c => c.MajorID == MajorID),
                "ClassID", "ClassName", rollcall.ClassID);
            ViewBag.SemesterID = new SelectList(db.Semesters, "SemesterID", "SemesterName", rollcall.SemesterID);
            ViewBag.SubjectID = new SelectList(db.Majors.
                Single(m => m.MajorID == MajorID).Subjects,
                "SubjectID", "ShortName", rollcall.SubjectID);
            ViewBag.InstructorID = new SelectList(db.Instructors, "InstructorID", "FullName", InstructorID);

            return View(rollcall);
        }

        //
        // POST: /RollCall/Edit/5

        [HttpPost]
        public ActionResult Edit(RollCall rollcall, int InstructorID)
        {
            if (ModelState.IsValid)
            {
                RollCallBO BO = new RollCallBO();
                List<string> ErrorList = BO.ValidRollCall(rollcall);
                if (ErrorList.Count == 0)
                {
                    // Kiem tra xem co doi giao vien hay ko
                    rollcall = BO.ChangeRollCallInstructor(rollcall, InstructorID);
                    BO.UpdateRollCall(rollcall);
                    return RedirectToAction("Index");
                }
                else
                {
                    foreach (var Error in ErrorList)
                    {
                        ModelState.AddModelError(String.Empty, Error);
                    }
                }
            }

            int MajorID = rollcall.Class.MajorID;
            ViewBag.MajorID = new SelectList(db.Majors, "MajorID", "FullName", MajorID);
            ViewBag.ClassID = new SelectList(db.Classes.Where(c => c.MajorID == MajorID),
                "ClassID", "ClassName", rollcall.ClassID);
            ViewBag.SemesterID = new SelectList(db.Semesters, "SemesterID", "SemesterName", rollcall.SemesterID);
            ViewBag.SubjectID = new SelectList(db.Majors.
                Single(m => m.MajorID == MajorID).Subjects,
                "SubjectID", "ShortName", rollcall.SubjectID);

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
        //Sau nay ko dung ham nay, chi dung trong giai doan test
        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            RollCall rollcall = db.RollCalls.Single(r => r.RollCallID == id);
            foreach (var InstructorTeaching in rollcall.InstructorTeachings.ToList())
            {
                db.InstructorTeachings.DeleteObject(InstructorTeaching);
            }

            foreach (var Student in rollcall.Students.ToList())
            {
                rollcall.Students.Remove(Student);
            }

            db.RollCalls.DeleteObject(rollcall);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        //Lay danh sach class cua 1 major, de dua vao dropbox
        public JsonResult GetClasses(int id)
        {
            var Classes = db.Classes.Where(c => c.MajorID == id).
                Where(c => c.IsActive).OrderBy(c => c.ClassName).
                Select(c => new { id = c.ClassID, name = c.ClassName });
            return Json(Classes, JsonRequestBehavior.AllowGet);
        }

        //Lay danh sach mon hoc cua 1 major, de dua vao dropbox
        public JsonResult GetSubjects(int id)
        {
            var Subject = db.Majors.Single(m => m.MajorID == id).Subjects.
                Where(s=> s.IsActive).OrderBy(s => s.ShortName).
                Select(s => new { id = s.SubjectID, name = s.ShortName });
            return Json(Subject, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetStudents(int id)
        {
            var Students = db.Students.Where(a => a.ClassID == id).
                Where(a => a.IsActive).OrderBy(a => a.FullName).
                Select(a => new { id = a.StudentID, name = a.FullName });
            return Json(Students, JsonRequestBehavior.AllowGet);
        }
    }
}