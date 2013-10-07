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
        private RSMEntities _db = new RSMEntities();


        public ActionResult Index()
        {
            return View();
        }

        public ActionResult StudentList(int? ClassID)
        {
            List<Student> Students = null;

            if (ClassID == null)
            {
                Students = _db.Students.Include("Class").Where(st => st.IsActive == true).ToList();
            }
            else
            {
                Students = _db.Students.Include("Class").Where(st => st.IsActive == true && st.ClassID == ClassID).ToList();
            }


            var Classes = _db.Classes.Where(c => c.IsActive == true);
            ViewBag.ClassID = new SelectList(Classes.OrderBy(c => c.ClassName), "ClassID", "ClassName", ClassID);
            return View(Students);
        }

        public ActionResult SingleStudent(int StudentID)
        {
            var Student = _db.Students.SingleOrDefault(s => s.StudentID == StudentID);
            ViewBag.Errors = TempData["Errors"];
            return View(Student);
        }

        [HttpPost]
        public ActionResult SingleStudent(int StudentID, IEnumerable<HttpPostedFileBase> ImageFiles)
        {
            ViewBag.StudentID = StudentID;
            ViewBag.StudentName = _db.Students.First(s => s.StudentID == StudentID).FullName;

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

       
    }
}
