using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;
using RollSystemMobile.Models.ViewModels;

namespace RollSystemMobile.Controllers
{
    public class StudentController : Controller
    {
        private StudentBusiness StuBO;
        private AccountBusiness AccBO;
        private RollCallBusiness RollBO;
        //
        // GET: /Student/

        public StudentController()
        {
            RSMEntities db = new RSMEntities();
            StuBO = new StudentBusiness(db);
            AccBO = new AccountBusiness(db);
            RollBO = new RollCallBusiness(db);
        }

        //Hien thi cac mon ma student do da hoc
        public ActionResult CourseList()
        {
            string Username = this.HttpContext.User.Identity.Name;
            User User = AccBO.GetUserByUsername(Username);
            Student AuthorizedStudent = StuBO.GetStudentByUserID(User.UserID);


            StudentViewModel Model = new StudentViewModel();

            //Lay toan bo danh sach rollCall in ra
            Model.AuthorizedStudent = AuthorizedStudent;
            Model.LearnedRollCalls = RollBO.GetStudentLearnedCourses(AuthorizedStudent.StudentID);
            Model.LearningRollCalls = RollBO.GetStudentLearningCourse(AuthorizedStudent.StudentID);

            return View(Model);
        }

        public ActionResult RollAttendance(int RollCallID, int StudentID)
        {
            Student Stu = StuBO.GetStudentByID(StudentID);
            RollCall Roll = RollBO.GetRollCallByID(RollCallID);

            AttendanceBusiness AttenBO = new AttendanceBusiness();
            List<AttendanceLog> RollCallLogs = AttenBO.GetRollCallAttendanceLog(RollCallID);

            //Tim nhung attendance cua student, nam trong log, co rollcallID bang RollcallID dua vao
            var StudentAttendances = Stu.StudentAttendances.Where(sa => sa.AttendanceLog.RollCallID == RollCallID 
                && RollCallLogs.Select(r => r.LogID).Contains(sa.LogID))
                .OrderBy(sa => sa.AttendanceLog.LogDate).ToList();


            StudentAttendanceViewModel Model = new StudentAttendanceViewModel();
            Model.InStudent = Stu;
            Model.InRollCall = Roll;
            Model.StudentAttendances = StudentAttendances;

            return PartialView("_RollAttendance", Model);
        }


    }
}
