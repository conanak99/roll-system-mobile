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
using RollSystemMobile.Models.ViewModels;
using RollSystemMobile.Models.BindingModels;
using RollSystemMobile.Models.GoogleApi;

namespace RollSystemMobile.Controllers
{
    public class RollCallController : Controller
    {
        private RollCallBusiness RollBO;
        private SelectListFactory SlFactory;
        ClassBusiness ClaBO;
        SubjectBusiness SubBO;
        StudentBusiness StuBO;
        InstructorBusiness InsBO;
        SemesterBusiness SeBO;

        public RollCallController()
        {
            RSMEntities DB = new RSMEntities();
            RollBO = new RollCallBusiness(DB);
            SlFactory = new SelectListFactory(DB);
            ClaBO = new ClassBusiness(DB);
            SubBO = new SubjectBusiness(DB);
            StuBO = new StudentBusiness(DB);
            InsBO = new InstructorBusiness(DB);
            SeBO = new SemesterBusiness(DB);
        }

        //
        // GET: /RollCall/
        public ViewResult Index(int? status)
        {
            List<RollCall> rollcalls = null;
            if (status == null)
            {
                 rollcalls = RollBO.GetList().Where(r => r.Status == 2).OrderBy(i => i.BeginDate).ToList();
                
            }
            else {
                 rollcalls = RollBO.GetList().Where(r => r.Status == status).OrderBy(i => i.BeginDate).ToList();
            }
            return View(rollcalls);
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


        public ActionResult RollCallDetail(int id)
        {
            RollCall RollCall = RollBO.GetRollCallByID(id);

            AttendanceBusiness AttendanceBO = new AttendanceBusiness();
            //Lay danh sach nhung log cua roll call nay, tu luc bat dau
            List<AttendanceLog> AttendanceLogs = AttendanceBO.GetRollCallAttendanceLog(id);


            RollCallDetailViewModel Model = new RollCallDetailViewModel();
            Model.RollCall = RollCall;
            Model.RollCallLogs = AttendanceLogs;

            return View(Model);
        }
        [HttpPost]
        public ActionResult CheckAttendanceManual(CheckAttendanceManualBindModel Model)
        {
            AttendanceBusiness AttendanceBO = new AttendanceBusiness();
            AttendanceBO.WriteAttendanceManualLog(Model.Username, Model.RollCallID, Model.Date, Model.AttendanceChecks);

            String returnUrl = Model.ReturnUrl;

            if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1
                            && returnUrl.StartsWith("/") && !returnUrl.StartsWith("//")
                            && !returnUrl.StartsWith("/\\"))
            {
                return Redirect(Model.ReturnUrl);
            }
            return RedirectToAction("Index");
        }

        public ActionResult LogDetail(int RollCallID, DateTime Date)
        {
            AttendanceBusiness AttenBO = new AttendanceBusiness();

            //1 ngay, 1 roll call co the co 2 loai log, log manual va auto, do do phai lay ca 2
            AttendanceLog AutoLog = AttenBO.GetAttendanceLogAtDate(RollCallID, Date, 1);

            AttendanceLog ManualLog = AttenBO.GetAttendanceLogAtDate(RollCallID, Date, 2);
            RollCall RollCall = RollBO.GetRollCallByID(RollCallID);

            LogDetailViewModel Model = new LogDetailViewModel();
            Model.RollCall = RollCall;
            Model.AutoLog = AutoLog;
            Model.ManualLog = ManualLog;
            return PartialView("_LogDetail", Model);
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
            List<Semester> semester = SeBO.GetList().Where(s => s.EndDate > DateTime.Now).ToList();
            ViewBag.SemesterID = semester;
            ViewBag.SubjectID = new SelectList(SubBO.GetSubjectByMajor(MajorID), "SubjectID", "FullName");
            return View();
        }

        //
        // POST: /RollCall/Create

        [HttpPost]
        public ActionResult Create(RollCall rollcall, int MajorID, int ClassID, TimeSpan? otherTime)
        {

            List<string> ErrorList = RollBO.ValidRollCall(rollcall, otherTime);
            if (ErrorList.Count == 0)
            {
                if (otherTime.ToString() != "")
                {
                    rollcall.StartTime = TimeSpan.Parse(otherTime.ToString());
                }
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


            ViewBag.InstructorID = SlFactory.MakeSelectList<Instructor>("InstructorID", "FullName", rollcall.InstructorID);
            ViewBag.MajorID = SlFactory.MakeSelectList<Major>("MajorID", "FullName", MajorID);
            ViewBag.ClassID = new SelectList(ClaBO.GetClassByMajor(MajorID),
                "ClassID", "ClassName", rollcall.ClassID);
            //Mac dinh, lay semester moi nhat
            ViewBag.SemesterID = SlFactory.MakeSelectList<Semester>("SemesterID", "SemesterName", rollcall.SemesterID);
            ViewBag.SubjectID = new SelectList(SubBO.GetSubjectByMajor(MajorID), "SubjectID", "FullName", rollcall.SubjectID);
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
            ViewBag.SubjectID = new SelectList(SubBO.GetSubjectByMajor(MajorID), "SubjectID", "FullName", rollcall.SubjectID);
            ViewBag.BeginDate = rollcall.BeginDate.ToString("dd-MM-yyyy") ;
            return View(rollcall);
        }

        //
        // POST: /RollCall/Edit/5

        [HttpPost]
        public ActionResult Edit(RollCall rollcall, TimeSpan? otherTime)
        {
            if (ModelState.IsValid)
            {
                List<string> ErrorList = RollBO.ValidRollCall(rollcall, otherTime);
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
            var rollCall = RollBO.GetRollCallByID(rollcall.RollCallID);
            int MajorID = rollCall.Class.MajorID;
            ViewBag.InstructorID = SlFactory.MakeSelectList<Instructor>("InstructorID", "FullName", rollcall.InstructorID);
            ViewBag.MajorID = SlFactory.MakeSelectList<Major>("MajorID", "FullName", MajorID);
            ViewBag.ClassID = new SelectList(ClaBO.GetClassByMajor(MajorID),
                "ClassID", "ClassName", rollcall.ClassID);
            //Mac dinh, lay semester moi nhat
            ViewBag.SemesterID = SlFactory.MakeSelectList<Semester>("SemesterID", "SemesterName", rollcall.SemesterID);
            ViewBag.SubjectID = new SelectList(SubBO.GetSubjectByMajor(MajorID), "SubjectID", "FullName", rollcall.SubjectID);

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
        //lay danh sach cac time ma lop chua hoc
        public JsonResult GetStartTime(int id)
        {
            var rc = RollBO.GetList().Where(a => a.ClassID == id)
             .Select(c => new
             {
                 enddate = c.EndDate.ToString("yyyy-MM-dd"),
                 starttime = c.StartTime.ToString(@"hh\:mm"),
                 endtime = c.EndTime.ToString(@"hh\:mm")
             });
            return Json(rc, JsonRequestBehavior.AllowGet);
        }
        //get so slot cua mon hoc
        public JsonResult GetNumberOfSlot(int id)
        {
            var slot = SubBO.GetSubjectByID(id).NumberOfSlot;
            return Json(slot, JsonRequestBehavior.AllowGet);
        }
        //Lay danh sach mon hoc cua 1 major, de dua vao dropbox
        public JsonResult GetSubjects(int id)
        {
            var Subject = SubBO.GetSubjectByMajor(id).
                Select(s => new { id = s.SubjectID, name = s.FullName });
            return Json(Subject, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetSelectOption(int RollCallID)
        {
            var option = StuBO.GetStudentsNotInRollCall(RollCallID).
               Select(d => new { id = d.StudentID, name = d.FullName, code = d.StudentCode });
            return Json(option, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetDateSemester(int id)
        {
            var begindate = SeBO.GetSemesterByID(id).BeginDate.ToString("yyyy-MM-dd");
            var enddate = SeBO.GetSemesterByID(id).EndDate.ToString("yyyy-MM-dd");
            var semester = new { begindate, enddate };
            return Json(semester, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetStatusRollCall(int id)
        {
            var status = RollBO.GetRollCallByID(id).Status;
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetClassFree(int id)
        {
            var cls = RollBO.GetList().Where(r => r.SubjectID == id).
                Select(a => new
                {
                    id = a.ClassID,
                    classname = a.Class.ClassName,
                    enddate = a.EndDate.ToString("yyyy-MM-dd"),
                    begindate = a.BeginDate.ToString("yyyy-MM-dd")
                });
            return Json(cls, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetSubjectFree(int id, int semesterid)
        {
            var sub = RollBO.GetList().Where(r => r.ClassID == id && r.SemesterID == semesterid).
                Select(a => new
                {
                    id = a.SubjectID,
                    subjectname = a.Subject.FullName,
                    enddate = a.EndDate.ToString("yyyy-MM-dd"),
                    begindate = a.BeginDate.ToString("yyyy-MM-dd")
                });
            return Json(sub, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetInstructors(int id)
        {
            int typeID = SubBO.GetSubjectByID(id).TypeID;
            var instructor = InsBO.GetAllInstructor().Where(d => d.SubjectTypeID == typeID).
                Select(i => new { id = i.InstructorID, name = i.Fullname });
            return Json(instructor, JsonRequestBehavior.AllowGet);
        }
        //get time instructor day trong ngay
        public JsonResult GetInstructorFree(int id)
        {
            var instructor = RollBO.GetList().Where(r => r.InstructorID == id)
                .Select(i => new
                {
                    starttime = i.StartTime.ToString(@"hh\:mm"),
                    endtime = i.EndTime.ToString(@"hh\:mm"),
                    enddate = i.EndDate.ToString("yyyy-MM-dd"),
                    begindate = i.BeginDate.ToString("yyyy-MM-dd")
                });
            return Json(instructor, JsonRequestBehavior.AllowGet);
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
            var TimeAndName = rollCall.StudySessions.Select(s => new
            {
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