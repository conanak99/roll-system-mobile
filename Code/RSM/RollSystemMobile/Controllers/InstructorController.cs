using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BindingModels;
using RollSystemMobile.Models.ViewModels;

namespace RollSystemMobile.Controllers
{
    [Authorize(Roles = "Instructor")] 
    public class InstructorController : Controller
    {
        //
        // GET: /Instructor/

        private RSMEntities _db = new RSMEntities();

        public ActionResult Index()
        {
            //Tim instructor da dang nhạp vao
            string Username = this.HttpContext.User.Identity.Name;
            User User = _db.Users.First(u => u.Username.Equals(Username));
            Instructor AuthorizedInstructor = _db.Instructors.First(i => i.UserID == User.UserID);

            //Nhung mon ma instructor nay dang day
            DateTime Today = DateTime.Now;
            var RollCalls = _db.RollCalls.Where(r => r.InstructorTeachings.
                                       Any(inte => inte.InstructorID == AuthorizedInstructor.InstructorID)
                                       && r.BeginDate < Today && r.EndDate > Today);
            
            //Mon dang day vao thoi diem dang nhap
            RollCall CurrentRollCall = null;
            TimeSpan CurrentTime = DateTime.Now.TimeOfDay;
            if (RollCalls.Count() > 0)
            {
                
                CurrentRollCall = RollCalls.FirstOrDefault(r => r.StartTime < CurrentTime && r.EndTime > CurrentTime);
            }

            //Neu co mon dang day, lay luon log cua mon do
            AttendanceLog CurrentAttendanceLog = null;
            if (CurrentRollCall != null)
            {
                AttendanceBO AttendanceBO = new AttendanceBO();
                CurrentAttendanceLog = AttendanceBO.GetCurrentAttendanceLog(CurrentRollCall.RollCallID);
            }

            InstructorViewModel model = new InstructorViewModel();
            model.AuthorizedInstructor = AuthorizedInstructor;
            model.CurrentRollCall = CurrentRollCall;
            model.TeachingRollCall = RollCalls;
            model.CurrentAttendanceLog = CurrentAttendanceLog;
            return View(model);
        }

        [HttpPost]
        public ActionResult CheckAttendanceAuto(int RollCallID, IEnumerable<HttpPostedFileBase> ImageFiles)
        {
            List<String> ImagePaths = new List<string>();
            foreach (HttpPostedFileBase file in ImageFiles)
            {
                //Save file anh xuong
                String OldPath = Server.MapPath("~/Content/Temp/" + file.FileName);
                file.SaveAs(OldPath);

                //Resize file anh, luu vao thu muc log, nho them ngay thang truoc
                String NewPath = Server.MapPath("~/Content/Log/" + 
                    DateTime.Today.ToString("dd-MM-yyyy") + "_" + file.FileName);
                FaceBO.ResizeImage(OldPath, NewPath);
                ImagePaths.Add(NewPath);

                //Nhan dien tung khuon mat trong anh
            }

            List<RecognizerResult> Result = FaceBO.RecognizeStudentForAttendance(RollCallID, ImagePaths);
            //Dua reseult nay cho AttendanceBO xu ly
            AttendanceBO attendanceBO = new AttendanceBO();            
            AttendanceLog Log = attendanceBO.WriteAttendanceAutoLog(RollCallID, Result);
            //Danh sach sinh vien trong log
            List<Student> Students = _db.Students.Where(stu => stu.StudentAttendances.
                Any(attend => attend.LogID == Log.LogID)).ToList();
            RollCall CurrentRollCall = _db.RollCalls.First(roll => roll.RollCallID == RollCallID);

            //Tao model de show trong view
            AttendanceViewModel model = new AttendanceViewModel();
            model.CurrentRollCall = CurrentRollCall;
            model.PresentStudents = Students;
            model.RecognizeResult = Result;

            return View(model);
        }

        public ActionResult RollCallDetail(int id)
        {
            RollCall RollCall = _db.RollCalls.FirstOrDefault(roll => roll.RollCallID == id);
            return View(RollCall);
        }

        [HttpPost]
        public ActionResult CheckAttendanceManual(CheckAttendanceManualBindModel Model)
        {
            AttendanceBO AttendanceBO = new AttendanceBO();
            AttendanceBO.WriteAttendanceManualLog(Model.RollCallID, Model.AttendanceChecks);
            return RedirectToAction("Index");
        }
    }
}
