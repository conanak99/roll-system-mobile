using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;

namespace RollSystemMobile.Controllers
{
    public class ServiceController : Controller
    {

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
        public ActionResult CheckAttendanceAuto(int RollCallID, List<HttpPostedFileBase> ImageFiles)
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
                FaceBusiness.ResizeImage(OldPath, NewPath);
                ImagePaths.Add(NewPath);

                //Nhan dien tung khuon mat trong anh
            }

            List<RecognizerResult> Results = FaceBusiness.RecognizeStudentForAttendance(RollCallID, ImagePaths);
            //Dua result nay cho AttendanceBO xu ly
            AttendanceBusiness AttenBO = new AttendanceBusiness();
            AttendanceLog Log = AttenBO.WriteAttendanceAutoLog(RollCallID, Results);
            //Danh sach sinh vien trong log

            List<int> StudentIDs = AttenBO.GetStudentIDList(Results);

            //Lay danh sach sinh vien da nhan
            StudentBusiness StuBO = new StudentBusiness();
            List<Student> Students = StuBO.Find(stu => StudentIDs.Contains(stu.StudentID)).ToList();

            var StudentsJson = Students.ToList().Select(s => new { studentID = s.StudentID,
            studentCode = s.StudentCode, studentName = s.FullName});

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
                time = r.StartTime.ToString(@"hh\:mm") + " - " + r.EndTime.ToString(@"hh\:mm"),
                date = r.BeginDate.ToString("dd-MM-yyyy") + " to " + r.EndDate.ToString("dd-MM-yyyy"),
                isCurrent = CurrentRollCall != null && CurrentRollCall.RollCallID == r.RollCallID  ? true : false   
            });



            var a = new { id = CurrentRollCall.BeginDate, studentlist = CurrentRollCall.Students.Select(s => new { }) };

            return Json(RollCallJson, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetRollCallInfo(int RollCallID)
        {
            RollCallBusiness RollBO = new RollCallBusiness();
            RollCall rollcall = RollBO.GetRollCallByID(RollCallID);


            var RollJson = new
            {
                rollID = rollcall.RollCallID,
                subject = rollcall.Subject.FullName,
                classes = rollcall.Class.ClassName,
                time = rollcall.StartTime.ToString(@"hh\:mm") + " - " + rollcall.EndTime.ToString(@"hh\:mm"),
                date = rollcall.BeginDate.ToString("dd-MM-yyyy") + " to " + rollcall.EndDate.ToString("dd-MM-yyyy"),
                studentList = rollcall.Students.Select(st => new { studentID = st.StudentID, studentCode = st.StudentCode, studentName = st.FullName })
            };

            return Json(RollJson, JsonRequestBehavior.AllowGet);
        }
    }
}
