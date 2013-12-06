using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;
using RollSystemMobile.Models.HelperClass;

namespace RollSystemMobile.Controllers
{
    public class ReportController : Controller
    {
        private static string ExcelMimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        //
        // GET: /Report/RollCall/1
        private RSMEntities db = new RSMEntities();

        public ActionResult RollCall(int id)
        {
            RollCall RollCall = db.RollCalls.First(r => r.RollCallID == id);
            String FileName = RollCall.Class.ClassName.Trim() + "_" + RollCall.Subject.ShortName
                + "_" + DateTime.Today.ToString("dd-MM-yyyy") + ".xlsx";

            RollCallBusiness BO = new RollCallBusiness();
            String FilePath = Server.MapPath("~/Content/Temp/" + FileName);
            BO.CreateRollCallReport(id, FilePath);

            return File(FilePath, ExcelMimeType, FileName);
        }

        public ActionResult RollCallBooks(List<int> RollCallIDs)
        {
            String FileName = "RollCallReport" + "_" + DateTime.Today.ToString("dd-MM-yyyy") + ".xlsx";

            RollCallBusiness BO = new RollCallBusiness();
            String FilePath = Server.MapPath("~/Content/Temp/" + FileName);
            BO.CreateRollCallBooks(RollCallIDs, FilePath);

            return File(FilePath, ExcelMimeType, FileName);
        }

        public ActionResult RollCallStudentLists(List<int> RollCallIDs)
        {
            String FileName = "RollCallStudentList" + "_" + DateTime.Today.ToString("dd-MM-yyyy") + ".xlsx";

            RollCallBusiness BO = new RollCallBusiness();
            String FilePath = Server.MapPath("~/Content/Temp/" + FileName);
            BO.CreateStudentLists(RollCallIDs, FilePath);

            return File(FilePath, ExcelMimeType, FileName);
        }

        public ActionResult StudentReport(int StudentID, int SemesterID)
        {
            StudentBusiness StuBO = new StudentBusiness();
            SemesterBusiness SemBO = new SemesterBusiness();

            var stu = StuBO.GetStudentByID(StudentID);
            var sem = SemBO.GetSemesterByID(SemesterID);

            String FileName = stu.StudentCode + "_" + sem.SemesterName + ".xlsx";
            String FilePath = Server.MapPath("~/Content/Temp/" + FileName);

            StuBO.CreateStudentReport(StudentID, SemesterID, FilePath);

            return File(FilePath, ExcelMimeType, FileName);
        }

        public ActionResult SessionReport(int InstructorID, int SelectedMonth, int SelectedYear)
        {
            InstructorBusiness InsBO = new InstructorBusiness();

            var Ins = InsBO.GetInstructorByID(InstructorID);
            DateTime SelectedTime = new DateTime(SelectedYear, SelectedMonth, 1);

            String FileName = InstructorID + "_" + Ins.Fullname.NonUnicode()
                               + "_" + SelectedTime.ToString("yyyy_MMMM") + ".xlsx";
            String FilePath = Server.MapPath("~/Content/Temp/" + FileName);

            InsBO.CreateSessionReport(InstructorID, SelectedTime, FilePath);

            return File(FilePath, ExcelMimeType, FileName);
        }
    }
}
