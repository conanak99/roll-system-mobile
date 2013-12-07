using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;
using RollSystemMobile.Models.BindingModels;
using RollSystemMobile.Models.ViewModels;
using RollSystemMobile.Models.GoogleApi;

namespace RollSystemMobile.Controllers
{
    [Authorize]
    public class InstructorController : Controller
    {
        //
        // GET: /Instructor/


        private InstructorBusiness InsBO;
        private AccountBusiness AccBO;
        private RollCallBusiness RollBO;

        public InstructorController()
        {
            InsBO = new InstructorBusiness();
            AccBO = new AccountBusiness();
            RollBO = new RollCallBusiness();
        }

        public ActionResult Index_Home()
        {
             //Neu bam vao mon dang day, moi ra index
            //Tim instructor da dang nhạp vao

            string Username = this.HttpContext.User.Identity.Name;
            User User = AccBO.GetUserByUsername(Username);
            Instructor AuthorizedInstructor = InsBO.GetInstructorByUserID(User.UserID);

            //Nhung mon ma instructor nay dang day, sau nay phai check status
            var RollCalls = RollBO.GetInstructorCurrentRollCalls(AuthorizedInstructor.InstructorID);

            //Mon dang day vao thoi diem dang nhap
            RollCall CurrentRollCall = null;
            TimeSpan CurrentTime = DateTime.Now.TimeOfDay;
            if (RollCalls.Count() > 0)
            {
                CurrentRollCall = RollCalls.FirstOrDefault(r => r.StartTime <= CurrentTime && r.EndTime >= CurrentTime);
            }

            InstructorViewModel model = new InstructorViewModel();
            model.AuthorizedInstructor = AuthorizedInstructor;
            model.CurrentRollCall = CurrentRollCall;
            model.TeachingRollCall = RollCalls;
            return View(model);
        }

        public ActionResult TeachingCalendar()
        {
            //Neu bam vao mon dang day, moi ra index
            //Tim instructor da dang nhạp vao

            string Username = this.HttpContext.User.Identity.Name;
            User User = AccBO.GetUserByUsername(Username);
            Instructor AuthorizedInstructor = InsBO.GetInstructorByUserID(User.UserID);

            //Tao Url
            var APIWrapper = new GoogleCalendarAPIWrapper();
            APIWrapper.RedirectUri = @"http://localhost:35728/Instructor/Authorize";
            ViewBag.AuthUrl = APIWrapper.GetAuthUrl();
            ViewBag.Message = TempData["Message"];

            return View(AuthorizedInstructor);
        }


        public ActionResult Index()
        {
            //Tim instructor da dang nhạp vao
            string Username = this.HttpContext.User.Identity.Name;
            User User = AccBO.GetUserByUsername(Username);
            Instructor AuthorizedInstructor = InsBO.GetInstructorByUserID(User.UserID);

            //Nhung mon ma instructor nay dang day, sau nay phai check status
            DateTime Today = DateTime.Now;
            var RollCalls = RollBO.GetInstructorCurrentRollCalls(AuthorizedInstructor.InstructorID);

            //Mon dang day vao thoi diem dang nhap
            RollCall CurrentRollCall = null;
            TimeSpan CurrentTime = DateTime.Now.TimeOfDay;
            if (RollCalls.Count() > 0)
            {
                CurrentRollCall = RollCalls.FirstOrDefault(r => r.StartTime < CurrentTime && r.EndTime > CurrentTime);
            }

            //Neu co mon dang day, lay luon attendanlog log cua mon do
            AttendanceLog CurrentAttendanceLog = null;
            if (CurrentRollCall != null)
            {
                AttendanceBusiness AttendanceBO = new AttendanceBusiness();
                CurrentAttendanceLog = AttendanceBO.GetAttendanceLogAtDate(CurrentRollCall.RollCallID, DateTime.Today);
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
            RollCall rollCall = RollBO.GetRollCallByID(RollCallID);

            List<String> ImagePaths = new List<string>();
            foreach (HttpPostedFileBase file in ImageFiles)
            {
                //Save file anh xuong
                String OldPath = Server.MapPath("~/Content/Temp/" + file.FileName);
                file.SaveAs(OldPath);

                //Resize file anh, luu vao thu muc log, ten mon hoc, ten lop
                String NewPath = Server.MapPath("~/Content/Log/" 
                    + rollCall.Class.ClassName + "_"
                    + rollCall.Subject.ShortName + "_"
                    + file.FileName);
                FaceBusiness.ResizeImage(OldPath, NewPath);
                ImagePaths.Add(NewPath);
            }
            //Nhan dien tung khuon mat trong anh
            List<RecognizerResult> Result = FaceBusiness.RecognizeStudentForAttendance(RollCallID, ImagePaths);
            //Dua reseult nay cho AttendanceBO xu ly
            AttendanceBusiness AttenBO = new AttendanceBusiness();
            AttendanceLog Log = AttenBO.WriteAttendanceAutoLog(RollCallID, Result);
            
            
            //Danh sach sinh vien trong log
            StudentBusiness StuBO = new StudentBusiness();
            List<Student> Students = StuBO.Find(stu => stu.StudentAttendances.
                Any(attend => attend.LogID == Log.LogID && attend.IsPresent)).ToList();
            RollCall CurrentRollCall = RollBO.GetRollCallByID(RollCallID);

            //Tao model de show trong view
            AttendanceViewModel model = new AttendanceViewModel();
            model.CurrentRollCall = CurrentRollCall;
            model.PresentStudents = Students;
            model.RecognizeResult = Result;

            return View(model);
        }

        public ActionResult RollCallDetail(int id)
        {
            RollCall RollCall = RollBO.GetRollCallByID(id);

            //Lay danh sach nhung log cua roll call nay, tu luc bat dau
            AttendanceBusiness AttenBO = new AttendanceBusiness();
            List<AttendanceLog> AttendanceLogs = AttenBO.GetRollCallAttendanceLog(id);


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

        public ActionResult Authorize(String code)
        {
            var APIWrapper = new GoogleCalendarAPIWrapper();
            APIWrapper.RedirectUri = @"http://localhost:35728/Instructor/Authorize";
            String RefreshToken = APIWrapper.GetRefreshToken(code);

            //Tim instructor da dang nhạp vao
            string Username = this.HttpContext.User.Identity.Name;
            User User = AccBO.GetUserByUsername(Username);
            Instructor AuthorizedInstructor = InsBO.GetInstructorByUserID(User.UserID);
            
            //Tu code, lay refresh token
            AuthorizedInstructor.ApiToken = RefreshToken;
            InsBO.UpdateExist(AuthorizedInstructor);

            TempData["Message"] = "Token received. Your calendar will be sync to Google Calendar later.";
            return RedirectToAction("TeachingCalendar");
        }

        public ActionResult SyncManual()
        {
            //Tim instructor da dang nhạp vao
            string Username = this.HttpContext.User.Identity.Name;
            User User = AccBO.GetUserByUsername(Username);
            Instructor AuthorizedInstructor = InsBO.GetInstructorByUserID(User.UserID);

            CalendarBusiness CalBO = new CalendarBusiness();
            CalBO.SyncInstructorCalendar(AuthorizedInstructor.InstructorID);

            TempData["Message"] = "Your calendar was synced to Google Calendar at " 
                + DateTime.Now.ToString("dd-MM-yyyy  HH:mm:ss");
            return RedirectToAction("TeachingCalendar");
        }
    }
}
