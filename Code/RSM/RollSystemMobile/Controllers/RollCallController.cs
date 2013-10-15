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
        private RollCallBusiness RollBO;
        private SelectListFactory SlFactory;
        ClassBusiness ClaBO;
        SubjectBusiness SubBO;
        StudentBusiness StuBO;

        public RollCallController()
        {
            RSMEntities DB = new RSMEntities();
            RollBO = new RollCallBusiness(DB);
            SlFactory = new SelectListFactory(DB);
            ClaBO = new ClassBusiness(DB);
            SubBO = new SubjectBusiness(DB);
            StuBO = new StudentBusiness(DB);
        }

        //
        // GET: /RollCall/
        public ViewResult Index()
        {
            var rollcalls = RollBO.GetList();
            return View(rollcalls.OrderBy(i => i.BeginDate).ToList());
        }

        //student list cho trang create new rollcall
        public ActionResult Studentlist(int? ClassID)
        {
            List<Student> Students = null;

            if (ClassID == null)
            {
                Students = StuBO.GetList();
            }
            else
            {
                Students = StuBO.GetStudentInClass(ClassID.Value);
            }

            var Classes = ClaBO.GetActiveClasses();
            ViewBag.ClassID = new SelectList(Classes.OrderBy(c => c.ClassName), "ClassID", "ClassName", ClassID);
            return View(Students);
        }

        //student list cho trang roll call list (co the xoa them)
        public ActionResult RollCallStudentList(int? RollCallID)
        {
            ViewBag.RollCallID = RollCallID;
            List<Student> Students = null;
            var rollcall = RollBO.GetRollCallByID(RollCallID.Value);
            Students = rollcall.Students.ToList();
            return View(Students);
        }

        //remove student from studenrlist of the rollcall
        public ActionResult DeleteStudent(int? RollCallID, int? StudentID)
        {
            RollCall rollcall = RollBO.GetRollCallByID(RollCallID.Value);
            var Student = rollcall.Students.Single(a => a.StudentID == StudentID);
            rollcall.Students.Remove(Student);
            RollBO.Update(rollcall);
            return RedirectToAction("RollCallStudentList", new { RollCallID = RollCallID });
        }
        //remove student from studenrlist of the rollcall
        public ActionResult AddStudent(int? RollCallID, String StudentID)
        {
            RollCall rollcall = RollBO.GetRollCallByID(RollCallID.Value);
            String[] tmp = StudentID.Split(',');
            for (int i = 0; i < tmp.Length; i++) 
            {
                int test = int.Parse(tmp[i]);
                var Student = StuBO.GetStudentByID(test);
                rollcall.Students.Add(Student);
                RollBO.Update(rollcall);
            }
            return RedirectToAction("RollCallStudentList", new { RollCallID = RollCallID });
        }
        // GET: /RollCall/Details/5

        public ViewResult Details(int id)
        {
            RollCall rollcall = RollBO.GetRollCallByID(id);
            return View(rollcall);
        }

        //
        // GET: /RollCall/Create

        public ActionResult Create()
        {

            //Mac dinh, majorID la 1
            int MajorID = 1;
            //Them 1 cai ID cua instructor
            ViewBag.InstructorID = SlFactory.MakeSelectList<Instructor>("InstructorID", "FullName");
            ViewBag.MajorID = SlFactory.MakeSelectList<Major>("MajorID", "FullName", MajorID);
            ViewBag.ClassID = new SelectList(ClaBO.GetClassByMajor(MajorID),
                "ClassID", "ClassName");
            //Mac dinh, lay semester moi nhat
            ViewBag.SemesterID = SlFactory.MakeSemesterSelectList();
               
            ViewBag.SubjectID = new SelectList(SubBO.GetSubjectByMajor(MajorID), "SubjectID", "ShortName");

            return View();
        }

        //
        // POST: /RollCall/Create

        [HttpPost]
        public ActionResult Create(RollCall rollcall, int MajorID, int ClassID)
        {
            if (ModelState.IsValid)
            {

                List<string> ErrorList = RollBO.ValidRollCall(rollcall);
                if (ErrorList.Count == 0)
                {
                    RollBO.Insert(rollcall);
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

            ViewBag.InstructorID = SlFactory.MakeSelectList<Instructor>("InstructorID", "FullName", rollcall.InstructorID);
            ViewBag.MajorID = SlFactory.MakeSelectList<Instructor>("MajorID", "FullName", MajorID);
            ViewBag.ClassID = new SelectList(ClaBO.GetClassByMajor(MajorID),
                "ClassID", "ClassName", rollcall.ClassID);
            //Mac dinh, lay semester moi nhat
            ViewBag.SemesterID = SlFactory.MakeSelectList<Semester>("SemesterID", "SemesterName", rollcall.SemesterID);
            ViewBag.SubjectID = new SelectList(SubBO.GetSubjectByMajor(MajorID), "SubjectID", "ShortName", rollcall.SubjectID);
            return View(rollcall);
        }

        //
        // GET: /RollCall/Edit/5

        public ActionResult Edit(int id)
        {
            RollCall rollcall = RollBO.GetRollCallByID(id);

            int MajorID = rollcall.Class.MajorID;
            int InstructorID = rollcall.InstructorID;
            ViewBag.InstructorID = SlFactory.MakeSelectList<Instructor>("InstructorID", "FullName", InstructorID);
            ViewBag.MajorID = SlFactory.MakeSelectList<Major>("MajorID", "FullName", MajorID);
            ViewBag.ClassID = new SelectList(ClaBO.GetClassByMajor(MajorID),
                "ClassID", "ClassName", rollcall.ClassID);
            //Mac dinh, lay semester moi nhat
            ViewBag.SemesterID = SlFactory.MakeSelectList<Semester>("SemesterID", "SemesterName", rollcall.SemesterID);
            ViewBag.SubjectID = new SelectList(SubBO.GetSubjectByMajor(MajorID), "SubjectID", "ShortName", rollcall.SubjectID);

            return View(rollcall);
        }

        //
        // POST: /RollCall/Edit/5

        [HttpPost]
        public ActionResult Edit(RollCall rollcall)
        {
            if (ModelState.IsValid)
            {
                List<string> ErrorList = RollBO.ValidRollCall(rollcall);
                if (ErrorList.Count == 0)
                {
                    // Kiem tra xem co doi giao vien hay ko
                    RollBO.Update(rollcall);
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
            ViewBag.InstructorID = SlFactory.MakeSelectList<Instructor>("InstructorID", "FullName", rollcall.InstructorID);
            ViewBag.MajorID = SlFactory.MakeSelectList<Major>("MajorID", "FullName", MajorID);
            ViewBag.ClassID = new SelectList(ClaBO.GetClassByMajor(MajorID),
                "ClassID", "ClassName", rollcall.ClassID);
            //Mac dinh, lay semester moi nhat
            ViewBag.SemesterID = SlFactory.MakeSelectList<Semester>("SemesterID", "SemesterName", rollcall.SemesterID);
            ViewBag.SubjectID = new SelectList(SubBO.GetSubjectByMajor(MajorID), "SubjectID", "ShortName", rollcall.SubjectID);

            return View(rollcall);
        }

        //
        // GET: /RollCall/Delete/5

        public ActionResult Delete(int id)
        {
            RollCall rollcall = RollBO.GetRollCallByID(id);
            return View(rollcall);
        }

        //
        // POST: /RollCall/Delete/5
        //Sau nay ko dung ham nay, chi dung trong giai doan test
        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            RollCall rollcall = RollBO.GetRollCallByID(id);
            RollBO.Delete(rollcall);
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }

        //Lay danh sach class cua 1 major, de dua vao dropbox
        public JsonResult GetClasses(int id)
        {
            var Classes = ClaBO.GetClassByMajor(id).
                Select(c => new { id = c.ClassID, name = c.ClassName });
            return Json(Classes, JsonRequestBehavior.AllowGet);
        }

        //Lay danh sach mon hoc cua 1 major, de dua vao dropbox
        public JsonResult GetSubjects(int id)
        {
            var Subject = SubBO.GetSubjectByMajor(id).
                Select(s => new { id = s.SubjectID, name = s.ShortName });
            return Json(Subject, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetSelectOption(int RollCallID)
        {
            var option = StuBO.GetStudentsNotInRollCall(RollCallID).
               Select(d => new { id = d.StudentID, name = d.FullName, code = d.StudentCode });
            return Json(option, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ChangeSchedule(int id)
        {
            RollCall rollCall = RollBO.GetRollCallByID(id);
            ViewBag.RollCallID = id;
            return View("RollCallSchedule", rollCall);
        }

        public ActionResult GetStudySession(int id)
        {
            RollCall rollCall = RollBO.GetRollCallByID(id);
            var TimeAndName = rollCall.StudySessions.Select(s => new { 
            id = s.SessionID,
            title = s.StartTime.ToString(@"hh\:mm") + " - " + s.EndTime.ToString(@"hh\:mm") + "\n" 
                    + "Ins:" + s.Instructor.Fullname,
            start = s.SessionDate.ToString("yyyy-MM-dd") + " " + s.StartTime.ToString(@"hh\:mm"),
            end = s.SessionDate.ToString("yyyy-MM-dd") + " " + s.EndTime.ToString(@"hh\:mm"),
            note = "abc"
            });
            return Json(TimeAndName.ToList(), JsonRequestBehavior.AllowGet);
        }
    }
}