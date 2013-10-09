using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;
using System.Drawing;

namespace RollSystemMobile.Controllers
{
    public class AdminController : Controller
    {
        // GET: /Admin/
        private StudentBusiness StuBO;
        private ClassBusiness ClaBO;

        public AdminController()
        {
            StuBO = new StudentBusiness();
            ClaBO = new ClassBusiness();
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
            ViewBag.StudentName = StuBO.GetStudentByID(StudentID).FullName;

            List<RecognizerResult> Results = new List<RecognizerResult>();

            foreach (HttpPostedFileBase file in ImageFiles)
            {
                //Save file anh xuong
                String OldPath = Server.MapPath("~/Content/Temp/" + file.FileName);
                file.SaveAs(OldPath);

                //Resize file anh
                String NewPath = Server.MapPath("~/Content/Temp/Resized/" + file.FileName);
                FaceBO.ResizeImage(OldPath, NewPath);

                //Nhan dien khuon mat, cho vao danh sach
                RecognizerResult SingleResult = FaceBO.DetectFromImage(NewPath);
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
                FaceBO.ResizeImage(OldPath, NewPath);

                //Nhan dien khuon mat, cho vao danh sach
                RecognizerResult SingleResult = FaceBO.DetectFromImage(NewPath);
                Results.Add(SingleResult);
            }

            //Load may cai selectbox vao day
            var Students = StuBO.GetActiveStudents();
            ViewBag.Students = Students;

            return View("UploadMultiResult", Results);
        }
    }
}
