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
        private RequestBusiness ReBO;
        private SelectListFactory SlFactory;
        private StaffBusiness StaffBO;
        private StudentImageBusiness StuImBO;
        private AccountBusiness AccBO;

        public AdminController()
        {
            RSMEntities db = new RSMEntities();
            StuBO = new StudentBusiness(db);
            ClaBO = new ClassBusiness(db);
            ReBO = new RequestBusiness(db);
            SlFactory = new SelectListFactory(db);
            StaffBO = new StaffBusiness(db);
            AccBO = new AccountBusiness(db);
            StuImBO = new StudentImageBusiness(db);
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
                Students = StuBO.GetActiveStudents().OrderByDescending(s => s.StudentID).ToList();
            }
            else
            {
                Students = StuBO.GetStudentInClass(ClassID.Value).OrderByDescending(s => s.StudentID).ToList();
            }

            var Classes = ClaBO.GetActiveClasses();
            ViewBag.ClassID = SlFactory.MakeSelectList<Class>("ClassID", "ClassName");
            ViewBag.SelectedID = ClassID;
              //new SelectList(Classes.OrderBy(c => c.ClassName), "ClassID", "ClassName", ClassID);
            return View(Students);
        }

        public ActionResult StudentRequest()
        {
            List<Request> Requests = ReBO.GetResponse();
            return View(Requests);
        }

        [ChildActionOnly]
        public ActionResult RequestCount()
        {
            ViewBag.RequestCount = ReBO.GetResponse().Count;
            return PartialView("_RequestCount");
        }
        public ActionResult CreateRequest() 
        {
            return View();
        }
        public ActionResult SendRequest(String stu, String context, String name)
        {
            var adminID = AccBO.GetUserByUsername(name).UserID;
            List<Student> students = StuBO.GetActiveStudents();
            if (stu == "All")
            {
                
                foreach (var student in students)
                {
                    var req = new Request();
                    req.StudentID = student.StudentID;
                    req.Context = context;
                    req.CreatedAdminID = adminID;
                    ReBO.Insert(req);
                }
            }
            else
            {
                String[] tmp = stu.Split(',');
                for (int i = 0; i < tmp.Length; i++)
                {
                    var req = new Request();
                    req.StudentID = int.Parse(tmp[i]);
                    req.Context = context;
                    req.CreatedAdminID = adminID;
                    ReBO.Insert(req);
                }
            }
            return RedirectToAction("StudentRequest");
        }
        public ActionResult AcceptRequest(int requestID,String name)
        {
            var adminID = AccBO.GetUserByUsername(name).UserID;
            var req = ReBO.GetRequestByID(requestID);
            req.CheckedAdminID = adminID;
            ReBO.UpdateExist(req);

            foreach (var rq in req.RequestImages)
            {
                var stImage = new StudentImage();
                stImage.StudentID = rq.Request.StudentID;
                stImage.ImageID = rq.ImageID;
                stImage.ImageLink = rq.ImageLink;
                StuImBO.Insert(stImage);
            }

            return RedirectToAction("StudentRequest");
        }

        public ActionResult DenyRequest(int requestID,String name)
        {
            var adminID = AccBO.GetUserByUsername(name).UserID;
            var req = ReBO.GetRequestByID(requestID);
            req.CheckedAdminID = adminID;

            ReBO.UpdateExist(req);

            return RedirectToAction("ReRequest", new {studentid= req.StudentID });
        }
        public ActionResult ReRequest(int studentid)
        {
            ViewBag.StudentID = studentid;
            return View() ;
        }
        public ActionResult DetailRequest(int id) {

            var request = ReBO.GetRequestByID(id);
            return View(request);
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
            return View("SingleStudentResult", Results);
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

            return View("AddImagesResult", Results);
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

            return View("RecognizeTestingResult", Result);
        }

        public ActionResult AddStaff()
        {
            AddStaffModel Model = new AddStaffModel() { CreateAccount = true };
            return View(Model);
        }

        [HttpPost]
        public ActionResult AddStaff(AddStaffModel Model)
        {
            if (ModelState.IsValid)
            {
                Staff staff = new Staff() { Fullname = Model.Name, Email = Model.Email, Phone = Model.Phone, IsActive = true };
                if (Model.CreateAccount)
                {
                  staff.User = AccBO.CreateUser(staff.Fullname);
                }
                StaffBO.Insert(staff);
                return RedirectToAction("StaffAccountList");
            }
            return View(Model);
        }

        public ActionResult StaffAccountList()
        {
            StaffBusiness StaffBO = new StaffBusiness();
            var Model = StaffBO.GetAllStaff().OrderByDescending(s => s.StaffID).ToList();
            return View(Model);
        }

        public ActionResult InstructorAccountList()
        {
            InstructorBusiness InsBO = new InstructorBusiness();
            var Model = InsBO.GetAllInstructor().OrderByDescending(ins => ins.InstructorID);
            return View(Model);
        }

        public ActionResult StudentAccountList()
        {
            var Model = StuBO.GetAllStudents().OrderByDescending(s => s.StudentID);
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

        public ActionResult LogImages()
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


            LogImageViewModel Model = new LogImageViewModel();
            ViewBag.ClassID = SlFactory.MakeSelectList<Class>("ClassID", "ClassName");
            return View(Model);
        }

        [HttpPost]
        public ActionResult LogImages(String InFromDate, String InToDate, int? ClassID)
        {
            LogBusiness LogBO = new LogBusiness();
            DateTime FromDate = InFromDate.ParseStringToDateTime();
            DateTime ToDate = InToDate.ParseStringToDateTime();

            LogImageViewModel Model = new LogImageViewModel();
            Model.FromDate = FromDate;
            Model.ToDate = ToDate;
            if (ClassID != null)
            {
                Model.ClassID = ClassID.Value;
            }
            Model.LogList = LogBO.FindLogWithImages(FromDate, ToDate, ClassID);


            ViewBag.ClassID = SlFactory.MakeSelectList<Class>("ClassID", "ClassName");
            return View(Model);
        }
        public JsonResult GetOption()
        {
            var option = StuBO.GetActiveStudents().
                Select(s => new { id = s.StudentID ,code = s.StudentCode, name = s.FullName });
            return Json(option, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult SelectLogImage(IEnumerable<int> ImageIDs)
        {
            LogBusiness LogBO = new LogBusiness();

            //Lay nhung image da chon tu db, sort theo rollcall ID
            List<LogImage> ImageList = ImageIDs.Select(id => LogBO.GetLogImageByID(id))
                                       .OrderBy(img => img.AttendanceLog.RollCallID).ToList();

            List<int> RollCallIDs = ImageList.Select(img => img.AttendanceLog.RollCallID).Distinct().ToList();

            List<RecognizerResult> Result = new List<RecognizerResult>();

            foreach (int RollCallID in RollCallIDs)
            {
                List<LogImage> RollCallImages = ImageList.Where(img => img.AttendanceLog.RollCallID == RollCallID).ToList();
                List<String> ImagePaths = RollCallImages.Select(img => Server.MapPath("~/Content/Log/" + img.ImageLink)).ToList();

                //Nhan dien khuon mat, dua vao list de show ra
                Result.AddRange(FaceBusiness.RecognizeStudentForAttendance(RollCallID, ImagePaths));
            }


            //Danh sash student de tao select list
            ViewBag.Students = StuBO.GetAllStudents();

            return View("LogImagesResult", Result);
        }
    }
}
