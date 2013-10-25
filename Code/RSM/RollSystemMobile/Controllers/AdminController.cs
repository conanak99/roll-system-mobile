using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;
using System.IO;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;
using RollSystemMobile.Models.ViewModels;
using RollSystemMobile.Models.HelperClass;

namespace RollSystemMobile.Controllers
{
    public class AdminController : Controller
    {
        // GET: /Admin/
        private StudentBusiness StuBO;
        private ClassBusiness ClaBO;
        private AccountBusiness AccBO;
        private StaffBusiness StaffBO;
        private InstructorBusiness InsBO;

        public AdminController()
        {
            RSMEntities db = new RSMEntities();
            StuBO = new StudentBusiness(db);
            ClaBO = new ClassBusiness(db);
            AccBO = new AccountBusiness(db);
            StaffBO = new StaffBusiness(db);
            InsBO = new InstructorBusiness(db);
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult StudentList(int? ClassID)
        {
            List<Student> Students = null;

            if (ClassID == null)
            {
                Students = StuBO.GetActiveStudents();
            }
            else
            {
                Students = StuBO.GetStudentInClass(ClassID.Value);
            }

            var Classes = ClaBO.GetActiveClasses();
            ViewBag.ClassID = new SelectList(Classes.OrderBy(c => c.ClassName), "ClassID", "ClassName", ClassID);
            return View(Students);
        }

        public ActionResult SingleStudent(int StudentID)
        {
            var Student = StuBO.GetStudentByID(StudentID);
            ViewBag.Errors = TempData["Errors"];
            return View(Student);
        }

        [HttpPost]
        public ActionResult SingleStudent(int StudentID, IEnumerable<HttpPostedFileBase> ImageFiles)
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
            return View("UploadResult", Results);
        }

        public ActionResult AddImages()
        {
            if (TempData["FacesAdded"] != null)
            {
                //Lay cai gia tri da duoc add, show ra
                List<FaceAdded> FacesAdded = (List<FaceAdded>)TempData["FacesAdded"];
                FacesAdded = FacesAdded.OrderBy(fa => fa.StudentID).ToList();
                var StudentIDs = FacesAdded.Select(fa => fa.StudentID).Distinct().ToList();

                List<Student> Students = StuBO.Find(st => StudentIDs.Contains(st.StudentID));

                ViewBag.Students = Students;
                ViewBag.FacesAdded = FacesAdded;
            }

            ViewBag.Errors = TempData["Errors"];
            return View();
        }

        [HttpPost]
        public ActionResult AddImages(IEnumerable<HttpPostedFileBase> ImageFiles)
        {
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

            //Load may cai selectbox vao day
            var Students = StuBO.GetActiveStudents();
            ViewBag.Students = Students;

            return View("UploadMultiResult", Results);
        }

        public ActionResult RecognizeTesting()
        {
            SelectListFactory slFactory = new SelectListFactory();
            ViewBag.RollCallID = slFactory.MakeSelectList<RollCall>("RollCallID", "RollCallID");
            return View();
        }

        [HttpPost]
        public ActionResult RecognizeTesting(int RollCallID, IEnumerable<HttpPostedFileBase> ImageFiles)
        {
            RollCallBusiness RollBO = new RollCallBusiness();
            RollCall rollCall = RollBO.GetRollCallByID(RollCallID);

            List<String> ImagePaths = new List<string>();
            foreach (HttpPostedFileBase file in ImageFiles)
            {
                //Save file anh xuong
                String OldPath = Server.MapPath("~/Content/Temp/" + file.FileName);
                file.SaveAs(OldPath);

                //Resize file anh, luu vao thu muc log, ten mon hoc, ten lop
                String NewPath = Server.MapPath("~/Content/Temp/Resized/" + file.FileName);
                FaceBusiness.ResizeImage(OldPath, NewPath);
                ImagePaths.Add(NewPath);
            }
            //Nhan dien tung khuon mat trong anh
            List<RecognizerResult> Result = FaceBusiness.RecognizeStudentForAttendance(RollCallID, ImagePaths);

            return View("RecognizeResult", Result);
        }

        public ActionResult StaffAccountList()
        {
            var Model = StaffBO.GetAllStaff();
            return View(Model);
        }

        public ActionResult InstructorAccountList()
        {
            var Model = InsBO.GetAllInstructor();
            return View(Model);
        }

        public ActionResult StudentAccountList()
        {
            var Model = StuBO.GetAllStudents();
            return View(Model);
        }

        public ActionResult Config()
        {
            var Model = ConfigHelper.GetConfig();
            return View(Model);
        }

        [HttpPost]
        public ActionResult Config(ConfigModel Model)
        {
            if (ModelState.IsValid)
            {
                ViewBag.Message = "Setting saved.";
                ConfigHelper.SaveConfig(Model);
                FaceBusiness.Initialize();
            }
            return View(Model);
        }
    }
}
