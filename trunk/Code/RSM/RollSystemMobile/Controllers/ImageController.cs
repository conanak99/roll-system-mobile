using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;

namespace RollSystemMobile.Controllers
{
    public class ImageController : Controller
    {
        //
        // GET: /Image/
        [HttpPost]
        public ActionResult SaveImageSingle(FormCollection Form)
        {
            int StudentID = int.Parse(Form["StudentID"].ToString());

            //Moi anh se co 1 id, luu face region co id nay vao database
            String[] FilesPath = Form["ImageLink"].ToString().Split(',');
            String[] FaceIDs = Form["FaceID"].ToString().Split(',');

            for (int i = 0; i < FilesPath.Length; i++)
            {
                String ImagePath = Server.MapPath("~/Content/Temp/Resized/" + FilesPath[i]);
                int FaceID = int.Parse(FaceIDs[i]);
                FaceBO.SaveTrainingData(ImagePath, FaceID, StudentID);
            }

            //Cat image ra, cat face index ra, lam tro tiep
            return RedirectToAction("SingleStudent","Admin", new { StudentID = StudentID });
        }

        public ActionResult DeleteTrainingImage(int ImageID)
        {
            var TrainingImage = DataContext.db.StudentImages.First(i => i.ImageID == ImageID);
            DataContext.db.StudentImages.DeleteObject(TrainingImage);
            DataContext.db.SaveChanges();

            return Json(new { message = TrainingImage.ImageLink + " deleted."}, JsonRequestBehavior.AllowGet );
        }
    }
}
