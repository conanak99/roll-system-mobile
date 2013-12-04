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
        MajorBusiness MjBO;
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
            MjBO = new MajorBusiness(DB);
        }

        //
        // GET: /RollCall/
        public ViewResult Index(String fromdate, String todate, String smtID)
        {
            List<Semester> semester = SeBO.GetList();
            ViewBag.SemesterID = semester;

            //set current semester. with format dd-mm-yyyy
            var now = new DateTime();
            now = DateTime.Now;
            var begindate = SeBO.GetList().SingleOrDefault(a => a.BeginDate < now && now < a.EndDate).BeginDate.ToString("dd-MM-yyyy");

            var enddate = SeBO.GetList().SingleOrDefault(a => a.BeginDate < now && now < a.EndDate).EndDate.ToString("dd-MM-yyyy");
            var id = SeBO.GetList().SingleOrDefault(a => a.BeginDate < now && now < a.EndDate).SemesterID;


            //get date with format mm-dd-yyyy
            var bgdate = SeBO.GetList().SingleOrDefault(a => a.BeginDate < now && now < a.EndDate).BeginDate.ToString("MM-dd-yyyy"); var endate = SeBO.GetList().SingleOrDefault(a => a.BeginDate < now && now < a.EndDate).EndDate.ToString("MM-dd-yyyy");
            DateTime fdate;
            DateTime tdate;
            if (fromdate == null && todate == null)
            {
                ViewBag.DefaultSemester = id;
                ViewBag.Todate = enddate;
                ViewBag.Fromdate = begindate;
                fdate = Convert.ToDateTime(bgdate);
                tdate = Convert.ToDateTime(endate);
            }
            else
            {
                ViewBag.DefaultSemester = smtID;
                ViewBag.Todate = todate;
                ViewBag.Fromdate = fromdate;
                String[] tmp = fromdate.Split('-');
                String fd = tmp[1] + "-" + tmp[0] + "-" + tmp[2];
                String[] tmp1 = todate.Split('-');
                String td = tmp1[1] + "-" + tmp1[0] + "-" + tmp1[2];
                fdate = Convert.ToDateTime(fd);
                tdate = Convert.ToDateTime(td);
            }

            RollBO.SetRollCallStatus();
            var rollcalls = RollBO.GetList().Where(r => r.BeginDate.CompareTo(fdate) >= 0 && r.EndDate.CompareTo(tdate) <= 0).OrderByDescending(r => r.BeginDate).OrderByDescending(r => r.Class.ClassName).ToList();

            return View(rollcalls);
        }

        //student list cho trang create new rollcall
        public ActionResult StudentList(int RollCallID)
        {
            List<Student> Students = null;
            var rollcall = RollBO.GetRollCallByID(RollCallID);
            ViewBag.Class = rollcall.Class.ClassName;
            Students = rollcall.Students.ToList();
            return PartialView("_StudentList", Students);
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
        public ActionResult DeleteStudent(int RollCallID, int StudentID)
        {
            RollCall rollcall = RollBO.GetRollCallByID(RollCallID);
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

        //view attendance roll call
        public ViewResult ViewAttendance(int RollCallID)
        {
            RollCall RollCall = RollBO.GetRollCallByID(RollCallID);

            AttendanceBusiness AttendanceBO = new AttendanceBusiness();
            //Lay danh sach nhung log cua roll call nay, tu luc bat dau
            List<AttendanceLog> AttendanceLogs = AttendanceBO.GetRollCallAttendanceLog(RollCallID);


            RollCallDetailViewModel Model = new RollCallDetailViewModel();
            Model.RollCall = RollCall;
            Model.RollCallLogs = AttendanceLogs;

            return View(Model);
        }

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
        public ActionResult Create(RollCall rollcall, int MajorID, int ClassID, TimeSpan? otherTime, String begindate)
        {

            List<string> ErrorList = RollBO.ValidRollCall(rollcall, otherTime);
            if (ErrorList.Count == 0)
            {
                if (otherTime.ToString() != "")
                {
                    rollcall.StartTime = TimeSpan.Parse(otherTime.ToString());
                }
                String[] tmp = begindate.Split('-');
                String bgd = tmp[1] + "-" + tmp[0] + "-" + tmp[2];
                rollcall.BeginDate = Convert.ToDateTime(bgd);
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
            ViewBag.BeginDate = rollcall.BeginDate.ToString("dd-MM-yyyy");
            ViewBag.StartTime = rollcall.StartTime.ToString(@"hh\:mm");
            ViewBag.SubjectID = rollcall.SubjectID.ToString();
            ViewBag.Semester = rollcall.SemesterID;
            ViewBag.Subject = rollcall.SubjectID;
            ViewBag.ID = InstructorID;
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
            ViewBag.Semester = rollcall.SemesterID;
            ViewBag.Subject = rollcall.SubjectID;
            return View(rollcall);
        }

        //
        // GET: /RollCall/Delete/5

        public ActionResult Delete(int id)
        {
            RollCall rollcall = RollBO.GetRollCallByID(id);
            RollBO.Delete(rollcall);
            return RedirectToAction("Index");
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
                 begindate = c.BeginDate.ToString("yyyy-MM-dd"),
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
            var session = SubBO.GetSubjectByID(id).NumberOfSession;
            var sub = new { slot, session };
            return Json(sub, JsonRequestBehavior.AllowGet);
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
            var bgdate = SeBO.GetSemesterByID(id).BeginDate.ToString("dd-MM-yyyy");
            var eddate = SeBO.GetSemesterByID(id).EndDate.ToString("dd-MM-yyyy");
            var semester = new { begindate, enddate, bgdate, eddate };
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
                    subjectname = a.Subject.FullName
                });
            return Json(sub, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetInstructors(int id)
        {
            var SubType = SubBO.GetSubjectByID(id).SubjectType;
            var instructor = SubType.Instructors.Where(ins => ins.IsActive == true).
                Select(i => new { id = i.InstructorID, name = i.Fullname });
            return Json(instructor, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetNumSub(int smtID, int mjID, int clsID)
        {
            var totalsub = SubBO.GetSubjectByMajor(mjID).Count();
            var numsub = RollBO.GetList().Where(r => r.ClassID == clsID && r.SemesterID == smtID).Count();
            var cls = new { totalsub, numsub };
            return Json(cls, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetMajors(int smtID)
        {
            List<Major> majors = MjBO.GetList();
            int numcls;
            int numsub;
            int totalrc;
            int numrc;
            var id = "";
            var name = "";
            foreach (var major in majors)
            {
                numcls = ClaBO.GetClassByMajor(major.MajorID).Count();
                numsub = SubBO.GetSubjectByMajor(major.MajorID).Count();
                totalrc = numsub * numcls;
                numrc = RollBO.GetList().Where(r => r.Class.MajorID == major.MajorID && r.SemesterID == smtID).Count();
                if (totalrc > numrc)
                {
                    id = id + major.MajorID.ToString() +",";
                    name = name + major.FullName + ",";
                }
            };

            var mj = new { id,name };
            return Json(mj, JsonRequestBehavior.AllowGet);
        }
        //get time instructor day trong ngay
        public JsonResult GetInstructorFree(int id)
        {
            var typeID = SubBO.GetSubjectByID(id).TypeID;
            var instructor = RollBO.GetList().Where(r => r.Instructor.SubjectTypes.Any(type => type.TypeID ==typeID))
                .Select(i => new
                {
                    id = i.InstructorID,
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
            ViewBag.HasAttendance = RollBO.RollCallHasAttendance(id);
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