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

        private static double DETECT_SCALE = 1.1;
        private static int MIN_NEIGHBOR = 3;
        private static int MIN_SIZE = 20;
        private static String HAAR_XML_PATH;
        private static String TRAINING_FOLDER_PATH;
        

        private static int RESIZE_WIDTH = 1100;
        private static int RESIZE_HEIGHT = 750;


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
            using (Image<Gray, byte> Image = new Image<Gray, byte>(ImagePath))
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

		        public static RecognizerResult DetectFromImageWithResize(string ImagePath)
        {
            RecognizerResult Result = new RecognizerResult();
            //Lay moi ten anh, ko lay toan bo duong dan
            Result.ImageLink = System.IO.Path.GetFileName(ImagePath);

            if (Haar == null)
            {
                Haar = CreateHaar(HaarType.AltTree);
            }

            //Chuyen anh trang den roi bat dau recognize, dung using de tu giai phong memories
            using (Image<Gray, byte> Image = new Image<Gray, byte>(ImagePath)
											.Resize(RESIZE_WIDTH, RESIZE_HEIGHT, INTER.CV_INTER_CUBIC, true))
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

       
    }
}