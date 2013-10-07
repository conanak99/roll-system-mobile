using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;

namespace RollSystemMobile.Controllers
{
    public class ImageController : Controller
    {

        private RSMEntities _db = new RSMEntities();

        // GET: /Image/ 
        [HttpPost]
        public ActionResult SaveImageSingle(FormCollection Form) 
        {
            int StudentID = int.Parse(Form["StudentID"]);
            List<String> ErrorList = new List<String>();
            //Moi anh se co 1 id, luu face region co id nay vao database
            String[] FilesPath = Form["ImageLink"].Split(',');
            String[] FaceIDs = Form["FaceID"].Split(',');

            for (int i = 0; i < FilesPath.Length; i++)
            {
                String ImagePath = Server.MapPath("~/Content/Temp/Resized/" + FilesPath[i]);
                int FaceID = int.Parse(FaceIDs[i]);
                try
                {
                    FaceBO.SaveTrainingData(ImagePath, FaceID, StudentID);
                }
                catch (Exception e)
                {
                    ErrorList.Add(e.Message);
                }
            }
            TempData["Errors"] = ErrorList;
            //Cat image ra, cat face index ra, lam tro tiep
            return RedirectToAction("SingleStudent","Admin", new { StudentID = StudentID });
        }

        public ActionResult DeleteTrainingImage(int ImageID)
        {
            var TrainingImage = _db.StudentImages.FirstOrDefault(i => i.ImageID == ImageID);
            String message = "";
            if (TrainingImage != null)
            {
                _db.StudentImages.DeleteObject(TrainingImage);
                _db.SaveChanges();
                message = TrainingImage.ImageLink + " deleted.";
            }
            else
            {
                message = "Error. Image not exist in DB";
            }
            return Json(new { message = message}, JsonRequestBehavior.AllowGet);
        }
    }
}
