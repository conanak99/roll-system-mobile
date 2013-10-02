using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Emgu.CV;
using Emgu.CV.Structure;
using Emgu.Util;
using Emgu.CV.CvEnum;

namespace FaceRecAutomationTesting
{

    public class FaceBO_HaarChangable
    {
        public static HaarCascade Haar;
        //Luc add, co the dung alt2
        //Luc detect, nen dung alt_tree neu can chinh xac cao, can nhieu van dung alt2
        private static String HaarXML = "haarcascade_frontalface_alt_tree.xml"; //"haarcascade_frontalface_alt2.xml"
        private static double DETECT_SCALE = 1.1;
        private static int MIN_NEIGHBOR = 3;
        private static int MIN_SIZE = 20;
        private static String HAAR_XML_PATH;
        private static String TRAINING_FOLDER_PATH;

        private static int RESIZE_WIDTH = 1300;
        private static int RESIZE_HEIGHT = 800;


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
                Haar = CreateHaar(HaarType.AltTree);
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
                //Neu anh nho, 1 trong 2 chieu < max thi ko can resize
                if (OldImage.Width < RESIZE_WIDTH || OldImage.Height < RESIZE_HEIGHT)
                {
                    OldImage.Save(NewPath);
                }
                else
                {
                    OldImage.Resize(RESIZE_WIDTH, RESIZE_HEIGHT, INTER.CV_INTER_CUBIC, true).Save(NewPath);
                }
            }
        }


        public static HaarCascade CreateHaar(HaarType HaarType)
        {
            switch (HaarType)
            {
                case HaarType.Alt1:
                    return new HaarCascade(HAAR_XML_PATH + "/haarcascade_frontalface_alt.xml");
                    break;
                case HaarType.Alt2:
                    return new HaarCascade(HAAR_XML_PATH + "/haarcascade_frontalface_alt2.xml");
                    break;
                case HaarType.AltTree:
                    String Path = HAAR_XML_PATH + "/haarcascade_frontalface_alt_tree.xml";
                    return new HaarCascade(HAAR_XML_PATH + "/haarcascade_frontalface_alt_tree.xml");
                    break;
                case HaarType.Default:
                    return new HaarCascade(HAAR_XML_PATH + "/haarcascade_frontalface_default.xml");
                    break;
                default:
                    break;
            }
            return null;
        }

        /*
        public static void SaveTrainingData(string ImagePath, int FaceID, int StudentID)
        {
            //O ngoai ko check, ko save
            if (FaceID == -1)
            {
                return;
            }

            RSMEntities db = new RSMEntities();

            Image<Bgr, byte> Image = new Image<Bgr, byte>(ImagePath);
            using (Image<Gray, byte> GrayImage = Image.Clone().Convert<Gray, byte>())
            {
                var FacesDetected = GrayImage.DetectHaarCascade(Haar, DETECT_SCALE, MIN_NEIGHBOR,
                                    0, new System.Drawing.Size(MIN_SIZE, MIN_SIZE))[0];
                Image<Bgr, byte> FaceImage = Image.Copy(FacesDetected[FaceID].rect)
                                             .Resize(TRAINING_DATA_SIZE, TRAINING_DATA_SIZE,
                                             INTER.CV_INTER_CUBIC); ;

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
            RSMEntities db = new RSMEntities();
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


        private static FaceRecognizer CreateRollCallRecognizer(int RollCallID)
        {
            //Tu rollcall ID, tao face recognizer, train
            FaceRecognizer FaceRec = new LBPHFaceRecognizer(1, 8, 8, 8, 75);

            List<int> StudentIDs = new List<int>();
            List<Image<Gray, byte>> StudentImages = new List<Image<Gray, byte>>();

            using (RSMEntities _db = new RSMEntities())
            {
                //Load danh sach student cua roll call
                RollCall RollCall = _db.RollCalls.First(roll => roll.RollCallID == RollCallID);
                foreach (var Student in RollCall.Students)
                {
                    foreach (var Image in Student.StudentImages)
                    {
                        //Load ID va anh de train cho bo recognizer
                        StudentIDs.Add(Image.StudentID);
                        String TrainingImagePath = TRAINING_FOLDER_PATH + "/" + Image.ImageLink;
                        Image<Gray, byte> TrainingImage = new Image<Gray, byte>(TrainingImagePath);

                        TrainingImage._EqualizeHist();
                        StudentImages.Add(TrainingImage);

                    }
                }
            }

            FaceRec.Train(StudentImages.ToArray(), StudentIDs.ToArray());

            return FaceRec;
        }

        private static RecognizerResult RecognizeFromImage(FaceRecognizer FaceRec, String ImagePath)
        {
            RecognizerResult Result = new RecognizerResult();
            //Lay moi ten anh, ko lay toan bo duong dan
            Result.ImageLink = System.IO.Path.GetFileName(ImagePath);

            //Dua anh vao, dua ket qua ra
            if (Haar == null)
            {
                Haar = new HaarCascade(HAAR_XML_PATH);
            }

            //Chuyen anh trang den roi bat dau recognize
            Image<Gray, byte> Image = new Image<Gray, byte>(ImagePath);

            var FacesDetected = Image.DetectHaarCascade(Haar, DETECT_SCALE, MIN_NEIGHBOR,
                                0, new System.Drawing.Size(MIN_SIZE, MIN_SIZE))[0];
            foreach (var Face in FacesDetected)
            {
                FaceRegion FaceReg = new FaceRegion(Face.rect.X, Face.rect.Y,
                                Face.rect.Width, Face.rect.Height);

                //Nhan dien face la cua ai.
                Image<Gray, byte> FaceImage = Image.Copy(Face.rect).Resize(TRAINING_DATA_SIZE,
                                              TRAINING_DATA_SIZE, INTER.CV_INTER_CUBIC);
                FaceImage._EqualizeHist();
                FaceRecognizer.PredictionResult PR = FaceRec.Predict(FaceImage);
                FaceReg.StudentID = PR.Label;
                FaceReg.StudentName = GetUserName(PR);
                Result.FaceList.Add(FaceReg);
            }
            return Result;
        }

        private static string GetUserName(FaceRecognizer.PredictionResult PR)
        {
            if (PR.Label == -1)
            {
                return "Unknown";
            }
            else
            {
                using (RSMEntities _db = new RSMEntities())
                {
                    var Student = _db.Students.First(s => s.StudentID == PR.Label);
                    return Student.StudentCode + " - " + Student.FullName;
                }
            }
        }


        public static List<RecognizerResult> RecognizeStudentForAttendance(int RollCallID, List<String> ImagePaths)
        {
            //Dua ID cua roll call, cac hinh da up, cho ra danh sach ket qua
            FaceRecognizer FaceRec = CreateRollCallRecognizer(RollCallID);
            List<RecognizerResult> Results = new List<RecognizerResult>();

            foreach (var ImagePath in ImagePaths)
            {
                RecognizerResult Result = RecognizeFromImage(FaceRec, ImagePath);
                Results.Add(Result);
            }

            //Dung xong nho dispose cho nhe bo nho
            FaceRec.Dispose();
            return Results;
        }
        */
    }
}