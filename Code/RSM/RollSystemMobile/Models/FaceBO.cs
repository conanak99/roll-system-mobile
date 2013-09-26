using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Emgu.CV;
using Emgu.CV.Structure;
using Emgu.Util;
using Emgu.CV.CvEnum;

namespace RollSystemMobile.Models
{
    public class FaceBO
    {
        private static HaarCascade Haar;
        private static double DETECT_SCALE = 1.1;
        private static int MIN_NEIGHBOR = 3;
        private static int MIN_SIZE = 20;
        private static String HAAR_XML_PATH;
        private static String TRAINING_FOLDER_PATH;

        private static int RESIZE_WIDTH = 1200;
        private static int RESIZE_HEIGHT = 650;
        private static int TRAINING_DATA_SIZE = 100;
        private static FaceRecognizer FaceRec;

        public static void SetXMLPath(String FilePath)
        {
            HAAR_XML_PATH = FilePath;
        }

        public static void SetTrainingFolderPath(String FolderPath)
        {
            TRAINING_FOLDER_PATH = FolderPath;
        }

        public static RecognizerResult DetectFromImage(string ImagePath)
        {
            RecognizerResult Result = new RecognizerResult();
            //Lay moi ten anh, ko lay toan bo duong dan
            Result.ImageLink = System.IO.Path.GetFileName(ImagePath);

            if (Haar == null)
            {
                Haar = new HaarCascade(HAAR_XML_PATH);
            }

            //Chuyen anh trang den roi bat dau recognize, dung using de tu giai phong memories
            using (Image<Gray, byte> Image = new Image<Bgr, byte>(ImagePath).Convert<Gray, byte>())
            {
                var FacesDetected = Image.DetectHaarCascade(Haar, DETECT_SCALE, MIN_NEIGHBOR,
                                    0, new System.Drawing.Size(MIN_SIZE, MIN_SIZE))[0];
                foreach (var Face in FacesDetected)
                {
                    FaceRegion FaceReg = new FaceRegion(Face.rect.X, Face.rect.Y,
                                    Face.rect.Width, Face.rect.Height);
                    Result.FaceList.Add(FaceReg);
                }

            }

            return Result;
        }


        //Resize lai anh
        public static void ResizeImage(string OldPath, string NewPath)
        {
            using (Image<Bgr, byte> OldImage = new Image<Bgr, byte>(OldPath))
            {
                OldImage.Resize(RESIZE_WIDTH, RESIZE_HEIGHT, INTER.CV_INTER_CUBIC, true).Save(NewPath);
            }
        }

        public static void SaveTrainingData(string ImagePath, int FaceID, int StudentID)
        {
            //O ngoai ko check, ko save
            if (FaceID == -1)
            {
                return;
            }


            RSMEntities db = DataContext.db;

            Image<Bgr, byte> Image = new Image<Bgr, byte>(ImagePath);
            using (Image<Gray, byte> GrayImage = Image.Clone().Convert<Gray, byte>())
            {
                var FacesDetected = GrayImage.DetectHaarCascade(Haar, DETECT_SCALE, MIN_NEIGHBOR,
                                    0, new System.Drawing.Size(MIN_SIZE, MIN_SIZE))[0];
                Image<Bgr, byte> FaceImage = Image.Copy(FacesDetected[FaceID].rect)
                                             .Resize(TRAINING_DATA_SIZE, TRAINING_DATA_SIZE,
                                             INTER.CV_INTER_CUBIC);;

                //Tao ten file
                String ImageName = System.IO.Path.GetFileNameWithoutExtension(ImagePath);
                String FileName = String.Format("{0}_face_{1}.jpg", ImageName, FaceID);

                FaceImage.Save(TRAINING_FOLDER_PATH + "/" + FileName);

                StudentImage StuIma = new StudentImage();
                StuIma.StudentID = StudentID;
                StuIma.ImageLink = FileName;
                db.StudentImages.AddObject(StuIma);
                db.SaveChanges();
            }
            Image.Dispose();
        }

        public static void SaveTrainingData(string ImagePath, int[] FaceIDs, int[] StudentIDs)
        {
            RSMEntities db = DataContext.db;


            Image<Gray, byte> Image = new Image<Bgr, byte>(ImagePath).Convert<Gray, byte>();

            var FacesDetected = Image.DetectHaarCascade(Haar, DETECT_SCALE, MIN_NEIGHBOR,
                                0, new System.Drawing.Size(MIN_SIZE, MIN_SIZE))[0];
            foreach (int FaceID in FaceIDs)
            {
                //Neu ko phai unknow thi moi save, la unknow thi bo qua
                if (StudentIDs[FaceID] != -1)
                {
                    var Face = FacesDetected[FaceID];
                    Image<Gray, byte> FaceImage = Image.Copy(Face.rect).Resize(TRAINING_DATA_SIZE, TRAINING_DATA_SIZE, INTER.CV_INTER_CUBIC);
                    FaceImage._EqualizeHist();

                    //Tao ten file
                    String ImageName = System.IO.Path.GetFileNameWithoutExtension(ImagePath);
                    String FileName = String.Format("{0}_face_{1}.jpg", ImageName, FaceID);

                    FaceImage.Save(TRAINING_FOLDER_PATH + FileName);

                    ////Luu gia tri ten file, userid xuong db
                    //TrainingData TraDa = new TrainingData();
                    //TraDa.UserID = StudentIDs[FaceID];
                    //TraDa.ImageLink = FileName;
                    //db.TrainingDatas.AddObject(TraDa);
                }
                
            }
            db.SaveChanges();
        }
    }
}