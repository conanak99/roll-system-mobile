using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Controllers
{
    public class ImageController : Controller
    {
        private StudentImageBusiness StuImaBO;
        private RequestBusiness ReBO;

        public ImageController()
        {
            ReBO = new RequestBusiness();
            StuImaBO = new StudentImageBusiness();
        }

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
                    FaceBusiness.SaveTrainingData(ImagePath, FaceID, StudentID);
                }
                catch (Exception e)
                {
                    ErrorList.Add(e.Message);
                }
            }
            TempData["Errors"] = ErrorList;
            //Cat image ra, cat face index ra, gui lai trang single
            return RedirectToAction("SingleStudent","Admin", new { StudentID = StudentID });
        }

        //
        [HttpPost]
        public ActionResult CreateRequestImage(FormCollection Form)
        {
            int StudentID = int.Parse(Form["StudentID"]);
            var request = new Request() { StudentID = StudentID, SentTime = DateTime.Now, IsAccepted = false };
            ReBO.Insert(request);

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
                    FaceBusiness.SaveRequestImage(ImagePath, FaceID, StudentID, request.RequestID);
                }
                catch (Exception e)
                {
                    ErrorList.Add(e.Message);
                }
            }
            TempData["Errors"] = ErrorList;
            //Cat image ra, cat face index ra, gui lai trang single
            return RedirectToAction("StudentImage", "Student", new { StudentID = StudentID });
        }
        
        [HttpPost]
        public ActionResult SaveImageMulti(ImageBindingModel model)
        {
            List<String> ErrorList = new List<String>();
            List<FaceAdded> FacesAdded = new List<FaceAdded>();

            foreach (var SingeImageModel in model.ImageModels)
            {
                //Lay file name, lay cac gia tri face va value
                String ImageLink = SingeImageModel.ImageLink;
                int[] FaceIndexs = SingeImageModel.FaceIndexs.ToArray();
                int[] UserIDs = SingeImageModel.StudentIDs.ToArray();

                String ImagePath = "";
                if (model.Folder.Equals("Resized"))
                {
                    ImagePath = Server.MapPath("~/Content/Temp/Resized/" + ImageLink);
                }
                else if (model.Folder.Equals("Log"))
                {
                    ImagePath = Server.MapPath("~/Content/Log/" + ImageLink);
                }

                if (FaceIndexs != null && UserIDs != null)
                {
                    try
                    {
                        //Lay danh sach, dua ra
                        FacesAdded.AddRange(FaceBusiness.SaveTrainingData(ImagePath, FaceIndexs, UserIDs));
                    }
                    catch (Exception e)
                    {
                        ErrorList.Add(e.Message);
                    }
                }

            }

            FacesAdded.OrderBy(fa => fa.StudentID);
            TempData["FacesAdded"] = FacesAdded;
            TempData["Errors"] = ErrorList;
            return Redirect(model.ReturnUrl);
        }

        public ActionResult DeleteRequestImage(int ImageID)
        {
            var TrainingImage = ReBO.FindReqImageByID(ImageID);
            String message = "";
            int imageRemaining = 0;
            if (TrainingImage != null)
            {
                ReBO.DeleteImage(TrainingImage);
                message = TrainingImage.ImageLink + " deleted.";
            }
            else
            {
                message = "Error. Image not exist in DB";
            }
            return Json(new { message = message, count = imageRemaining }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteTrainingImage(int ImageID)
        {
            var TrainingImage = StuImaBO.FindImageByID(ImageID);
            String message = "";
            int imageRemaining = 0;
            if (TrainingImage != null)
            {
                imageRemaining = TrainingImage.Student.StudentImages.Count - 1;
                StuImaBO.Delete(TrainingImage);
                message = TrainingImage.ImageLink + " deleted.";
            }
            else
            {
                message = "Error. Image not exist in DB";
            }
            return Json(new { message = message, count = imageRemaining }, JsonRequestBehavior.AllowGet);
        }

       
    }
}
