﻿using System;
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
        private RequestImageBusiness ReImBO;
        private StudentImageBusiness StuImBO;
        private UserBusiness UserBO;
        public AdminController()
        {
            RSMEntities db = new RSMEntities();
            StuBO = new StudentBusiness(db);
            ClaBO = new ClassBusiness(db);
            ReBO = new RequestBusiness(db);
            SlFactory = new SelectListFactory(db);
            ReImBO = new RequestImageBusiness(db);
            StuImBO = new StudentImageBusiness(db);
            UserBO = new UserBusiness(db);
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
        public ActionResult StudentRequest()
        {
            List<Request> Requests = null;
            Requests = ReBO.GetList().Where(r => r.CheckedAdminID == null).ToList();

            return View(Requests);
        }
        public ActionResult AcceptRequest(int requestID,String name)
        {
            var adminID = UserBO.GetList().SingleOrDefault(u => u.Username == name).UserID;
            var req = ReBO.GetRequestByID(requestID);
            req.IsAccepted = true;
            req.CheckedAdminID = adminID;
            ReBO.UpdateExist(req);

            List<RequestImage> requestImage = null;
            requestImage = ReImBO.GetList().Where(r => r.RequestID == requestID).ToList();
            foreach (var rq in requestImage)
            {
                var stImage = new StudentImage();
                stImage.StudentID = rq.RequestID;
                stImage.ImageID = rq.ImageID;
                stImage.ImageLink = rq.ImageLink;
                StuImBO.Insert(stImage);
            }

            return RedirectToAction("StudentRequest");
        }
        public ActionResult DenyRequest(int requestID,String name)
        {
            var adminID = UserBO.GetList().SingleOrDefault(u => u.Username == name).UserID;
            var req = ReBO.GetRequestByID(requestID);
            req.IsAccepted = false;
            req.CheckedAdminID = adminID;
            ReBO.UpdateExist(req);

            return RedirectToAction("StudentRequest");
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

        public ActionResult StaffAccountList()
        {
            StaffBusiness StaffBO = new StaffBusiness();
            var Model = StaffBO.GetAllStaff();
            return View(Model);
        }

        public ActionResult InstructorAccountList()
        {
            InstructorBusiness InsBO = new InstructorBusiness();
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
