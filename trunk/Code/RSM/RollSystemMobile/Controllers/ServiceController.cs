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
        private RSMEntities db;
        //
        // GET: /Service/
        public ServiceController()
        {
            db = new RSMEntities();
        }

        [HttpPost]
        public ActionResult Login(string Username, string Password)
        {
            User user = db.Users.FirstOrDefault(u => u.Username.Equals(Username)
                                                       && u.Password.Equals(Password)
                                                       && u.IsActive == true);
            if (user == null)
            {
                return Json(new { message = "Invalid" });
            }
            else
            {
                Instructor AuthorizedInstructor = db.Instructors.First(i => i.User.Username.Equals(Username));
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
                FaceBO.ResizeImage(OldPath, NewPath);
                ImagePaths.Add(NewPath);

                //Nhan dien tung khuon mat trong anh
            }

            List<RecognizerResult> Results = FaceBO.RecognizeStudentForAttendance(RollCallID, ImagePaths);
            //Dua result nay cho AttendanceBO xu ly
            AttendanceBO attendanceBO = new AttendanceBO();
            AttendanceLog Log = attendanceBO.WriteAttendanceAutoLog(RollCallID, Results);
            //Danh sach sinh vien trong log

            List<int> StudentIDs = attendanceBO.GetStudentIDList(Results);

            //Lay danh sach sinh vien da nhan
            List<Student> Students = db.Students.Where(stu => StudentIDs.Contains(stu.StudentID)).ToList();

            var StudentsJson = Students.ToList().Select(s => new { studentID = s.StudentID,
            studentCode = s.StudentCode, studentName = s.FullName});

            return Json(StudentsJson, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetCurrentRollCalls(int InstructorID)
        {
            //Nhung mon ma instructor nay dang day, sau nay phai check status, instructor teaching phai them ngay thang
            DateTime Today = DateTime.Now;
            var RollCalls = db.RollCalls.Where(r => r.InstructorTeachings.
                                       Any(inte => inte.InstructorID == InstructorID && inte.BeginDate <= Today && r.EndDate >= Today)
                                       && r.BeginDate <= Today && r.EndDate >= Today).OrderBy(roll => roll.StartTime);
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

            return Json(RollCallJson, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SendStudentTest()
        {
            List<Student> Students = db.Students.Where(stu => stu.IsActive).ToList();

            var StudentsJson = Students.Select(s => new
            {
                studentID = s.StudentID,
                studentCode = s.StudentCode,
                studentName = s.FullName
            });

            return Json(StudentsJson, JsonRequestBehavior.AllowGet);
        }


    }
}
