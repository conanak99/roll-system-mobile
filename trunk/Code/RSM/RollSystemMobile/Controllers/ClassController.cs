using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;

namespace RollSystemMobile.Controllers
{ 
    public class ClassController : Controller
    {
         private ClassBusiness ClassBO;
         SelectListFactory slFactory ;
         StudentBusiness StuBO;
        //
        // GET: /Subject/

         public ClassController()
        {
            slFactory = new SelectListFactory();
            ClassBO = new ClassBusiness();
            StuBO = new StudentBusiness();
        }

        public ViewResult Index()
        {
            return View(ClassBO.GetAllClasses().ToList());
        }

        //
        // GET: /Class/Details/5

        public ViewResult Details(int id)
        {
            Class cls = ClassBO.GetClassByID(id);
            return View(cls);
        }

        //
        // GET: /Class/Create

        public ActionResult Create()
        {
            SelectListFactory slFactory = new SelectListFactory();
            ViewBag.MajorID = slFactory.MakeSelectList<Major>("MajorID", "ShortName");
            return View();
        } 

        //
        // POST: /Class/Create

        [HttpPost]
        public ActionResult Create(Class cls)
        {
            if (ModelState.IsValid)
            {
                cls.IsActive = true;
                ClassBO.Insert(cls);
                return RedirectToAction("Index");  
            }
            return View(cls);
        }
        
        //
        // GET: /Class/Edit/5
 
        public ActionResult Edit(int id)
        {
            Class cls = ClassBO.GetClassByID(id);

            int MajorID = cls.MajorID;
            ViewBag.MajorID = slFactory.MakeSelectList<Major>("MajorID", "FullName", MajorID);
            return View(cls);
        }

        public ActionResult InactiveClass(int id)
        {
            var clss = ClassBO.GetClassByID(id);
            clss.IsActive = false;
            ClassBO.UpdateExist(clss);
            return RedirectToAction("Index");
        }
        public ActionResult ActiveClass(int id)
        {
            var clss = ClassBO.GetClassByID(id);
            clss.IsActive = true;
            ClassBO.UpdateExist(clss);
            return RedirectToAction("Index");
        }
        //
        // POST: /Class/Edit/5

        [HttpPost]
        public ActionResult Edit(Class cls)
        {
            if (ModelState.IsValid)
            {
                ClassBO.Update(cls);
                return RedirectToAction("Index");
            }
            int MajorID = cls.MajorID;
            ViewBag.MajorID = slFactory.MakeSelectList<Major>("MajorID", "FullName", MajorID);
            return View(cls);
        }

        // student list
        public ActionResult StudentList(int ClassID) {
            List<Student> Students = null;
                Students = StuBO.GetStudentInClass(ClassID);
                ViewBag.ClassID = ClassID;
            return View(Students);
        }
        public ActionResult AddStudent(int ClassID,String StudentID) {
            String[] tmp = StudentID.Split(',');
            for (int i = 0; i < tmp.Length; i++)
            {
                int test = int.Parse(tmp[i]);
                var Student = StuBO.GetStudentByID(test);
                Student.ClassID = ClassID;
                StuBO.UpdateExist(Student);
            }
            return RedirectToAction("StudentList", new { ClassID = ClassID });
        }
        public ActionResult DeleteStudent(int ClassID, int StudentID)
        {
            Class cls = ClassBO.GetClassByID(ClassID);
            var stu = cls.Students.Single(c=>c.StudentID == StudentID);
            cls.Students.Remove(stu);
            ClassBO.Update(cls);
            return RedirectToAction("StudentList", new { ClassID = ClassID });
        }
        //

        // GET: /Class/Delete/5
 
        public ActionResult Delete(int id)
        {
            Class cls = ClassBO.GetClassByID(id);
            return View(cls);
        }

        //
        public JsonResult GetStudents()
        {
            var option = StuBO.GetActiveStudents().Where(c=>c.ClassID== null).
               Select(d => new { id = d.StudentID, name = d.FullName, code = d.StudentCode });
            return Json(option, JsonRequestBehavior.AllowGet);
        }
        // POST: /Class/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {            
            Class cls = ClassBO.GetClassByID(id);
            ClassBO.Delete(cls);
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }
    }
}