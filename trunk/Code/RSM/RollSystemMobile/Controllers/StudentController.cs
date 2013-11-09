using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;
using RollSystemMobile.Models.ViewModels;
using System.Data;
using System.Data.Entity;

namespace RollSystemMobile.Controllers
{
    public class StudentController : Controller
    {
        private ClassBusiness ClassBO;
        private SelectListFactory slFactory;
        private StudentBusiness StuBO;
        private AccountBusiness AccBO;
        private RollCallBusiness RollBO;
        private RequestBusiness ReBO;

        public StudentController()
        {
            RSMEntities db = new RSMEntities();
            slFactory = new SelectListFactory(db);
            ClassBO = new ClassBusiness(db);
            StuBO = new StudentBusiness(db);
            AccBO = new AccountBusiness(db);
            RollBO = new RollCallBusiness(db);
            ReBO = new RequestBusiness(db);
        }
        //
        // GET: /Student/

        public ViewResult Index()
        {

            return View(StuBO.GetAllStudents().ToList());
        }

        //
        // GET: /Student/Details/5

        public ViewResult Details(int id)
        {
            Student student = StuBO.GetStudentByID(id);
            return View(student);
        }

        //
        // GET: /Student/Create

        public ActionResult Create()
        {
            ViewBag.ClassID = slFactory.MakeSelectList<Class>("ClassID", "ClassName");
            ViewBag.UserID = slFactory.MakeSelectList<User>("UserID", "Username");
            return View();
        }

        //
        // POST: /Student/Create

        [HttpPost]
        public ActionResult Create(Student student)
        {
            if (ModelState.IsValid)
            {
                StuBO.Insert(student);
                return RedirectToAction("Index");
            }
            ViewBag.ClassID = slFactory.MakeSelectList<Class>("ClassID", "ClassName");
            ViewBag.UserID = slFactory.MakeSelectList<User>("UserID", "Username");
            return View(student);
        }

        //
        // GET: /Student/Edit/5

        public ActionResult Edit(int id)
        {
            Student student = StuBO.GetStudentByID(id);
            ViewBag.ClassID = slFactory.MakeSelectList<Class>("ClassID", "ClassName");
            ViewBag.UserID = slFactory.MakeSelectList<User>("UserID", "Username");
            return View(student);
        }

        //
        // POST: /Student/Edit/5

        [HttpPost]
        public ActionResult Edit(Student student)
        {
            if (ModelState.IsValid)
            {
                StuBO.Update(student);
                return RedirectToAction("Index");
            }
            ViewBag.ClassID = slFactory.MakeSelectList<Class>("ClassID", "ClassName");
            ViewBag.UserID = slFactory.MakeSelectList<User>("UserID", "Username");
            return View(student);
        }

        public ActionResult ChangeClass(int id, int? classid)
        {
            Student student = StuBO.GetStudentByID(id);
            if (classid != null)
            {
                int clsid = classid.GetValueOrDefault();
                var type = ClassBO.GetClassByID(clsid).MajorID;
                List<Class> cls = ClassBO.GetAllClasses().Where(a => a.MajorID == type && a.Students.Count() < 30 && a.ClassID != clsid).ToList();
                ViewBag.ClassID = cls;
            }
            else { 
                ViewBag.ClassID = ClassBO.GetAllClasses();            
            }
            return View(student);
        }

        [HttpPost]
        public ActionResult ChangeClass(Student student, int id)
        {
            if (ModelState.IsValid)
            {
                Student std = StuBO.GetStudentByID(id);
                if (student.ClassID != -1)
                {
                    std.ClassID = student.ClassID;
                }
                else {
                    std.ClassID = null;
                }
                StuBO.UpdateExist(std);
                return Redirect("~/Student/Index");
            }
            return View();
        }
        //
        // GET: /Student/Delete/5

        public ActionResult Delete(int id)
        {
            Student student = StuBO.GetStudentByID(id);
            return View(student);
        }

        //
        // POST: /Student/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            Student student = StuBO.GetStudentByID(id);
            StuBO.Delete(student);
            return RedirectToAction("Index");
        }
        public ActionResult DeleteRequest(int id) {
            var request = ReBO.GetRequestByID(id);
            ReBO.Delete(request);
            return RedirectToAction("StudentImage", "Student", new { StudentID = request.StudentID });
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

        public ActionResult StudentImage(int StudentID)
        {
            var Student = StuBO.GetStudentByID(StudentID);
            ViewBag.Errors = TempData["Errors"];
            return View(Student);
        }

        [HttpPost]
        //student view image or upload image
        public ActionResult StudentImage(int StudentID, IEnumerable<HttpPostedFileBase> ImageFiles)
        { 
        
            ViewBag.StudentID = StudentID;
            var student = StuBO.GetStudentByID(StudentID);
            ViewBag.StudentCode = student.StudentCode;
            ViewBag.StudentName = student.FullName;

            List<RecognizerResult> Results = new List<RecognizerResult>();

            foreach (HttpPostedFileBase file in ImageFiles)
            {
                //Save file anh xuong
                String OldPath = Server.MapPath("~/Content/Temp/" + file.FileName);
                file.SaveAs(OldPath);

                //Resize file anh
                String NewPath = Server.MapPath("~/Content/Temp/Resized/" + file.FileName);
                FaceBusiness.ResizeImage(OldPath, NewPath);

                //Nhan dien khuon mat, cho vao danh sach
                RecognizerResult SingleResult = FaceBusiness.DetectFromImage(NewPath);
                Results.Add(SingleResult);
            }
            return View("StudentImageResult", Results);
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
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }
    }
}