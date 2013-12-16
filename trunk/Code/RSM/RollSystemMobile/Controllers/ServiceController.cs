using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BindingModels;
using RollSystemMobile.Models.BusinessObject;


namespace RollSystemMobile.Controllers
{
    public class ServiceController : Controller
    {
        private RSMEntities RollSystemDB;

        [HttpPost]
        public ActionResult Login(string Username, string Password)
        {
            AccountBusiness AccBO = new AccountBusiness();
            InstructorBusiness InsBO = new InstructorBusiness();

            User user = AccBO.CheckLogin(Username, Password);
            if (user == null)
            {
                return Json(new { message = "Invalid" });
            }
            else
            {
                Instructor AuthorizedInstructor = InsBO.GetInstructorByUserID(user.UserID);
                return Json(new { message = "Success", instructorName = AuthorizedInstructor.Fullname, instructorID = AuthorizedInstructor.InstructorID });
            }
        }

        [HttpPost]
        public ActionResult CheckAttendanceAuto(int RollCallID, List<HttpPostedFileBase> ImageFiles, DateTime? AttendanceDate)
        {
            RollCallBusiness RollBO = new RollCallBusiness();
            var rollCall = RollBO.GetRollCallByID(RollCallID);
            List<String> ImagePaths = new List<string>();
            foreach (HttpPostedFileBase file in ImageFiles)
            {
                //Save file anh xuong
                String OldPath = Server.MapPath("~/Content/Temp/" + file.FileName);
                file.SaveAs(OldPath);

                //Resize file anh, luu vao thu muc log, nho them ngay thang truoc
                String NewPath = Server.MapPath("~/Content/Log/"
                    + rollCall.Class.ClassName + "_"
                     + rollCall.Subject.ShortName + "_"
                     + file.FileName);
                FaceBusiness.ResizeImage(OldPath, NewPath);
                ImagePaths.Add(NewPath);

                //Nhan dien tung khuon mat trong anh
            }

            List<RecognizerResult> Results = FaceBusiness.RecognizeStudentForAttendance(RollCallID, ImagePaths);
            //Dua result nay cho AttendanceBO xu ly
            AttendanceBusiness AttenBO = new AttendanceBusiness();
            AttendanceLog Log = null;
            if (AttendanceDate == null)
            {
              Log = AttenBO.WriteAttendanceAutoLog(RollCallID, Results);
            }
            else
            {
               Log = AttenBO.WriteAttendanceAutoLog(RollCallID, Results, AttendanceDate.Value);
            }
            
            //Danh sach sinh vien trong log

            List<int> StudentIDs = AttenBO.GetStudentIDList(Results);

            //Lay danh sach sinh vien ton tai trong log
            StudentBusiness StuBO = new StudentBusiness();
            //List<Student> Students = StuBO.Find(stu => StudentIDs.Contains(stu.StudentID)).ToList();
            
            /*
            var StudentsJson = Students.ToList().Select(s => new
            {
                studentID = s.StudentID,
                studentCode = s.StudentCode,
                studentName = s.FullName
            });
             */

            var StudentsJson = Log.StudentAttendances.Select(sa => new
            {
                studentID = sa.StudentID,
                studentCode = sa.Student.StudentCode,
                studentName = sa.Student.FullName,
                isPresent = sa.IsPresent
            });

            return Json(StudentsJson, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetCurrentRollCalls(int InstructorID)
        {
            //Nhung mon ma instructor nay dang day, sau nay phai check status, instructor teaching phai them ngay thang
            RollCallBusiness RollBO = new RollCallBusiness();

            var RollCalls = RollBO.GetInstructorCurrentRollCalls(InstructorID);
            //Mon dang day vao thoi diem dang nhap
            RollCall CurrentRollCall = null;
            TimeSpan CurrentTime = DateTime.Now.TimeOfDay;
            if (RollCalls.Count() > 0)
            {
                CurrentRollCall = RollCalls.FirstOrDefault(r => r.StartTime <= CurrentTime && r.EndTime >= CurrentTime);
            }

            var RollCallJson = RollCalls.ToList().Select(r => new
            {
                rollID = r.RollCallID,
                subject = r.Subject.FullName,
                classes = r.Class.ClassName,
                time = r.StartTime.Equals(new TimeSpan(0, 0, 0)) ?
                       "No Slot" : r.StartTime.ToString(@"hh\:mm") + " - " + r.EndTime.ToString(@"hh\:mm"),
                date = r.BeginDate.ToString("dd-MM-yyyy") + " to " + r.EndDate.ToString("dd-MM-yyyy"),
                isCurrent = CurrentRollCall != null && CurrentRollCall == r ? true : false,
                attendanceDate = r.AttendanceDate().ToString("MM-dd-yyyy")
            });

            return Json(RollCallJson, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetRollCallInfo(int RollCallID)
        {

            RollCallBusiness RollBO = new RollCallBusiness();
            RollCall rollcall = RollBO.GetRollCallByID(RollCallID);

            AttendanceBusiness AttenBO = new AttendanceBusiness();
            var AttendLog = AttenBO.GetRollCallAttendanceLog(RollCallID);

            var ReturnLog = AttendLog.Where(log => log.LogDate >= DateTime.Today.AddDays(-1)).ToList();//.OrderByDescending(log => log.LogDate);

            //Truong hop hom nay la thu 2
            if (DateTime.Today.DayOfWeek == DayOfWeek.Monday)
            {
                //Tim log thu 6 hoac thu 7
                DateTime LastSaturday = DateTime.Today.AddDays(-2);
                var LastSaturdayLog = AttendLog.FirstOrDefault(log => log.LogDate == LastSaturday);
                if (LastSaturdayLog != null)
                {
                    ReturnLog.Add(LastSaturdayLog);
                }
                else
                {
                    DateTime LastFriday = DateTime.Today.AddDays(-3);
                    var LastFridayLog = AttendLog.FirstOrDefault(log => log.LogDate == LastFriday);
                    if (LastFridayLog != null)
                    {
                        ReturnLog.Add(LastFridayLog);
                    }
                }
            }

            var RollJson = new
            {
                rollID = rollcall.RollCallID,
                subject = rollcall.Subject.FullName,
                classes = rollcall.Class.ClassName,
                time = rollcall.StartTime.ToString(@"hh\:mm") + " - " + rollcall.EndTime.ToString(@"hh\:mm"),
                date = rollcall.BeginDate.ToString("dd-MM-yyyy") + " to " + rollcall.EndDate.ToString("dd-MM-yyyy"),

                studentList = rollcall.Students.Select(st => new
                {
                    studentID = st.StudentID,
                    studentCode = st.StudentCode,
                    studentName = st.FullName,
                    percentRate = String.Format("{0:0.00}%", AttenBO.GetStudentAbsentRate(st.StudentID, RollCallID))

                }),
                logList = ReturnLog.OrderByDescending(log => log.LogDate).Select(log => new
                {
                    rollID = log.RollCallID,
                    logID = log.LogID,
                    logDate = log.LogDate.ToString("dd-MM-yyyy"),
                    logPresent = log.StudentAttendances.Count(attend => attend.IsPresent) + "/" + log.RollCall.Students.Count,
                }),

            };

            return Json(RollJson, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetLogDetail(int LogID)
        {
            AttendanceBusiness AttenBO = new AttendanceBusiness();
            AttendanceLog Log = AttenBO.GetLogByID(LogID);

            var LogJson = new
            {
                logID = Log.LogID,
                rollID = Log.RollCallID,
                logDate = Log.LogDate.ToString("dd-MM-yyyy"),
                logPresent = Log.StudentAttendances.Count(attend => attend.IsPresent) + "/" + Log.RollCall.Students.Count,
                submitDate = Log.LogDate.ToString("MM-dd-yyyy"),
                studentList = Log.StudentAttendances.Select(sa => new
                {
                    studentID = sa.StudentID,
                    studentCode = sa.Student.StudentCode,
                    studentName = sa.Student.FullName,
                    isPresent = sa.IsPresent
                })
            };

            return Json(LogJson, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult CheckAttendanceManual(CheckAttendanceManualBindModel Model)
        {
            AttendanceBusiness AttendanceBO = new AttendanceBusiness();
            AttendanceBO.WriteAttendanceManualLog(Model.Username, Model.RollCallID, Model.Date, Model.AttendanceChecks);

            return Json(new { message = "Success" });
        }


    }
}
