﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;
using RollSystemMobile.Models.HelperClass;
using Emgu.CV;
using Emgu.CV.Structure;
using Emgu.Util;
using Emgu.CV.CvEnum;

namespace RollSystemMobile.Models.BusinessObject
{
    public class FaceBusiness
    {
        private static HaarCascade Haar;
        //Luc add, co the dung alt2
        //Luc detect, nen dung alt_tree neu can chinh xac cao, can nhieu van dung alt
        private static String HaarXML; //"haarcascade_frontalface_alt_tree.xml"
        private static double DETECT_SCALE = 1.1;
        private static int MIN_NEIGHBOR = 3;
        private static int MIN_SIZE = 20;
        private static String HAAR_XML_PATH;
        private static String TRAINING_FOLDER_PATH;

        private static int RESIZE_WIDTH;
        private static int RESIZE_HEIGHT;
        private static int RECOGNIZER_THREEHOLD;
        private static int TRAINING_DATA_SIZE = 100;

        //Initialize tu file config config
        public static void Initialize()
        {
            var Config = ConfigHelper.GetConfig();
            HaarXML = Config.HaarXMLFile;
            RESIZE_HEIGHT = Config.ResizedHeight;
            RESIZE_WIDTH = Config.ResizeWidth;
            RECOGNIZER_THREEHOLD = Config.Threehold;

            //Neu da initialize haar, initialize lai
            if (Haar != null)
            {
                Haar = new HaarCascade(HAAR_XML_PATH);
            }
        }

        public static void SetXMLPath(String FilePath)
        {
            HAAR_XML_PATH = FilePath + HaarXML;
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
                //Neu anh nho, ca 2 chieu < max thi ko can resize

                if (OldImage.Width < RESIZE_WIDTH && OldImage.Height < RESIZE_HEIGHT)
                {
                    OldImage.Save(NewPath);
                }
                else
                {
                    //Anh ngang resize chieu ngang
                    if (OldImage.Width > OldImage.Height)
                    {
                        OldImage.Resize(RESIZE_WIDTH, RESIZE_HEIGHT, INTER.CV_INTER_CUBIC, true).Save(NewPath);
                    }
                    else
                    {
                        //Anh doc resize chieu doc
                        OldImage.Resize(RESIZE_HEIGHT, RESIZE_WIDTH, INTER.CV_INTER_CUBIC, true).Save(NewPath);
                    }

                }
            }
        }

        public static void SaveTrainingData(string ImagePath, int FaceID, int StudentID)
        {
            //Ben ngoai ko check, ko save
            if (FaceID == -1)
            {
                return;
            }

            StudentImageBusiness StuImaBO = new StudentImageBusiness();

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

                if (StuImaBO.ImageExist(StudentID, FileName))
                {
                    throw new Exception(FileName);
                }
                else
                {
                    //Save file anh xuong
                    FaceImage.Save(TRAINING_FOLDER_PATH + "/" + FileName);
                    //Save xuong DB
                    StudentImage StuIma = new StudentImage() { StudentID = StudentID, ImageLink = FileName };
                    StuImaBO.Insert(StuIma);
                }
            }
            Image.Dispose();
        }

        public static void SaveRequestImage(string ImagePath, int FaceID, int StudentID, int RequestID)
        {
            //Ben ngoai ko check, ko save
            if (FaceID == -1)
            {
                return;
            }

            StudentImageBusiness StuImaBO = new StudentImageBusiness();
            RequestBusiness ReqBO = new RequestBusiness();

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

                if (StuImaBO.ImageExist(StudentID, FileName))
                {
                    throw new Exception(FileName);
                }
                else
                {
                    //Save file anh xuong
                    FaceImage.Save(TRAINING_FOLDER_PATH + "/" + FileName);
                    //Save xuong DB
                    RequestImage ReqImg = new RequestImage() { RequestID = RequestID, ImageLink = FileName };
                    ReqBO.InsertImage(ReqImg);
                }
            }
            Image.Dispose();
        }

        public static List<FaceAdded> SaveTrainingData(string ImagePath, int[] FaceIDs, int[] StudentIDs)
        {
            Image<Bgr, byte> Image = new Image<Bgr, byte>(ImagePath);
            List<FaceAdded> FacesAdded = new List<FaceAdded>();

            StudentImageBusiness StuImaBO = new StudentImageBusiness();
            using (Image<Gray, byte> GrayImage = Image.Clone().Convert<Gray, byte>())
            {
                var FacesDetected = GrayImage.DetectHaarCascade(Haar, DETECT_SCALE, MIN_NEIGHBOR,
                                0, new System.Drawing.Size(MIN_SIZE, MIN_SIZE))[0];
                foreach (int FaceID in FaceIDs)
                {
                    int StudentID = StudentIDs[FaceID];
                    //Neu ko phai unknow thi moi save, la unknown thi bo qua
                    if (StudentID != 0)
                    {
                        var Face = FacesDetected[FaceID];
                        Image<Bgr, byte> FaceImage = Image.Copy(Face.rect)
                                                      .Resize(TRAINING_DATA_SIZE, TRAINING_DATA_SIZE,
                                                      INTER.CV_INTER_CUBIC);

                        //Tao ten file
                        String ImageName = System.IO.Path.GetFileNameWithoutExtension(ImagePath);
                        String FileName = String.Format("{0}_face_{1}.jpg", ImageName, FaceID);

                        //Save anh, ghi xuong database
                        if (StuImaBO.ImageExist(StudentID, FileName))
                        {
                            throw new Exception(FileName);
                        }
                        else
                        {
                            //Save file anh xuong
                            FaceImage.Save(TRAINING_FOLDER_PATH + "/" + FileName);
                            //Save xuong DB
                            StudentImage StuIma = new StudentImage() { StudentID = StudentID, ImageLink = FileName };
                            StuImaBO.Insert(StuIma);
                            //Dua KQ tra ra
                            FacesAdded.Add(new FaceAdded() { FaceLink = FileName, StudentID = StudentID, ImageID = StuIma.ImageID });
                        }
                    }
                }
            }

            Image.Dispose();

            return FacesAdded;
        }


        private static FaceRecognizer CreateRollCallRecognizer(int RollCallID)
        {
            //Tu rollcall ID, tao face recognizer, train
            //FaceRecognizer FaceRec = new LBPHFaceRecognizer(1, 8, 8, 8, 75);
            FaceRecognizer FaceRec = new FisherFaceRecognizer(80, RECOGNIZER_THREEHOLD);

            List<int> StudentIDs = new List<int>();
            List<Image<Gray, byte>> StudentImages = new List<Image<Gray, byte>>();

            RollCallBusiness RollBO = new RollCallBusiness();
            //Load danh sach student cua roll call
            RollCall RollCall = RollBO.GetRollCallByID(RollCallID);
            foreach (var Student in RollCall.Students)
            {
                foreach (var Image in Student.StudentImages)
                {
                    try
                    {
                        //Load ID va anh de train cho bo recognizer
                        String TrainingImagePath = TRAINING_FOLDER_PATH + "/" + Image.ImageLink;
                        Image<Gray, byte> TrainingImage = new Image<Gray, byte>(TrainingImagePath);
                        StudentIDs.Add(Image.StudentID);
                        TrainingImage._EqualizeHist();
                        StudentImages.Add(TrainingImage);
                    }
                    catch
                    {
                    }
                }
            }

            if (StudentImages.Count == 0 || StudentIDs.Count == 0)
            {
                return null;
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
            Image<Bgr, byte> RawImage = new Image<Bgr, byte>(ImagePath);
            Image<Gray, byte> Image = RawImage.Clone().Convert<Gray, byte>();

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
                StudentBusiness StuBO = new StudentBusiness();
                var Student = StuBO.GetStudentByID(PR.Label);
                return Student.StudentCode + " - " + Student.FullName;

            }
        }


        public static List<RecognizerResult> RecognizeStudentForAttendance(int RollCallID, List<String> ImagePaths)
        {
            //Dua ID cua roll call, cac hinh da up, cho ra danh sach ket qua
            FaceRecognizer FaceRec = CreateRollCallRecognizer(RollCallID);
            List<RecognizerResult> Results = new List<RecognizerResult>();

            if (FaceRec == null)
            {
                return Results;
            }

            foreach (var ImagePath in ImagePaths)
            {
                RecognizerResult Result = RecognizeFromImage(FaceRec, ImagePath);
                Results.Add(Result);
            }

            //Dung xong nho dispose cho nhe bo nho
            FaceRec.Dispose();
            return Results;
        }

    }
}