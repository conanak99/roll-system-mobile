﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace FaceRecAutomationTesting
{
    public class FaceDetectionAutomation
    {
        public static void RunTestAutomation()
        {
            Console.WriteLine("Face Detection Automation Test");
            Console.WriteLine("============================================================================");
            Console.WriteLine("1. Detect an image for 100 times, compare result.");
            Console.WriteLine("2. Use 4 different haar XML. Image resolution is small. Compare performance.");
            Console.WriteLine("3. Image resolution is big. Compare performance.");
            Console.WriteLine("4. Image resolution is big, resize before detecting. Compare performance.");
            Console.WriteLine("5. Check the accuracy of each haarXML with sample images");
            Console.WriteLine("6. Check the ratio of real face detection with sample images");
            Console.WriteLine("============================================================================");
            Console.Write("Enter option: ");
            int option = int.Parse(Console.ReadLine());
            switch (option)
            {
                case 1: Run100Times(); break;
                case 2: CompareHaarTimes(); break;
                case 3: CompareHaarTimesBigImage(); break;
                case 4: CompareHaarTimesBigImageResized(); break;
                case 5: CompareAccuracySingleImage(); break;
                case 6: CompareFacePostivieDetection(); break;
                default: Console.WriteLine("Good bye");
                    break;
            }
        }

        static void Run100Times()
        {
            FaceBO.SetXMLPath("HaarXML");
            Console.WriteLine("We choose a image with many face for testing.");
            String ImagePath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\Sample Images\More than 5\47693_634829683201925_1019415806_n.jpg";
            Console.Write("Press Enter to begin: ");
            Console.ReadLine();

            DateTime Start = DateTime.Now;
            List<RecognizerResult> ResultList = new List<RecognizerResult>();
            Console.WriteLine("Begin Running:");
            for (int i = 0; i < 100; i++)
            {
                var RecognizerResult = FaceBO.DetectFromImage(ImagePath);
                Console.WriteLine((i + 1) + " detect: ");
                Console.WriteLine(RecognizerResult.SimpleDetectResult());
                ResultList.Add(RecognizerResult);
            }

            TimeSpan TimeDiff = DateTime.Now - Start;
            Console.WriteLine("The time to run 100 detecs is: " + TimeDiff.TotalMilliseconds / 1000 + " seconds");

            bool DifferentResult = false;
            for (int i = 1; i < ResultList.Count; i++)
            {
                if (!ResultList.ElementAt(i).Equals(ResultList.ElementAt(i - 1)))
                {
                    DifferentResult = true;
                }
            }
            Console.WriteLine("The detect results are different: " + DifferentResult);
        }

        static void CompareHaarTimes()
        {
            FaceBO_HaarChangable.SetXMLPath("HaarXML");
            Console.WriteLine("For Face Detection. We have 4 haarXML file.\nWe will check the time to detect face with each file.");
            Console.WriteLine("We will test with a folder contain 100 images. Image Resolution is 750px x 500px.");
            String FolderPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\Sample Images";
            Console.Write("Press Enter to begin: ");
            Console.ReadLine();


            List<HaarType> HaarTypes = new List<HaarType>();
            HaarTypes.Add(HaarType.AltTree);
            HaarTypes.Add(HaarType.Alt1);
            HaarTypes.Add(HaarType.Alt2);
            HaarTypes.Add(HaarType.Default);

            foreach (var Type in HaarTypes)
            {
                FaceBO_HaarChangable.Haar = FaceBO_HaarChangable.CreateHaar(Type);
                Console.WriteLine("Begin testing for Haar " + Type + ":\n");
                DateTime Start = DateTime.Now;
                int index = 1;
                foreach (var FilePath in Directory.GetFiles(FolderPath, "*.jpg", SearchOption.TopDirectoryOnly))
                {
                    FaceBO_HaarChangable.DetectFromImage(FilePath);
                    Console.WriteLine("\tDetect " + index + " images.");
                    index++;
                }

                TimeSpan TimeDiff = DateTime.Now - Start;
                Console.WriteLine("Time to run 100 detecs is: " + TimeDiff.TotalMilliseconds / 1000 + " seconds");
                Console.Write("Press enter to continue: ");
                Console.ReadLine();
            }

        }

        static void CompareHaarTimesBigImage()
        {
            FaceBO_HaarChangable.SetXMLPath("HaarXML");
            Console.WriteLine("For Face Detection. We have 4 haarXML file.\nWe will check the time to detect face with each file.");
            Console.WriteLine("We will test with a folder contain 100 images. Image Resolution is 2200px x 1500px.");
            String FolderPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\Sample Images\Sample Images 2";
            Console.Write("Press Enter to begin: ");
            Console.ReadLine();


            List<HaarType> HaarTypes = new List<HaarType>();
            HaarTypes.Add(HaarType.AltTree);
            HaarTypes.Add(HaarType.Alt1);
            HaarTypes.Add(HaarType.Alt2);
            HaarTypes.Add(HaarType.Default);

            foreach (var Type in HaarTypes)
            {
                FaceBO_HaarChangable.Haar = FaceBO_HaarChangable.CreateHaar(Type);
                Console.WriteLine("Begin testing for Haar " + Type + ":\n");
                DateTime Start = DateTime.Now;
                int index = 1;
                foreach (var FilePath in Directory.GetFiles(FolderPath, "*.jpg"))
                {
                    FaceBO_HaarChangable.DetectFromImage(FilePath);
                    Console.WriteLine("\tDetect " + index + " images.");
                    index++;
                }

                TimeSpan TimeDiff = DateTime.Now - Start;
                Console.WriteLine("Time to run 100 detects is: " + TimeDiff.TotalMilliseconds / 1000 + " seconds");
                Console.Write("Press enter to continue: ");
                Console.ReadLine();
            }

        }

        static void CompareHaarTimesBigImageResized()
        {
            FaceBO_HaarChangable.SetXMLPath("HaarXML");
            Console.WriteLine("For Face Detection. We have 4 haarXML file.\nWe will check the time to detect face with each file.");
            Console.WriteLine("We will test with a folder contain 100 images. Image Resolution is 2200px x 1500px.");
            Console.WriteLine("The image will be resized to 1100px x 750px before detecting.");
            String FolderPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\Sample Images\Sample Images 2";
            Console.Write("Press Enter to begin: ");
            Console.ReadLine();


            List<HaarType> HaarTypes = new List<HaarType>();
            HaarTypes.Add(HaarType.AltTree);
            HaarTypes.Add(HaarType.Alt1);
            HaarTypes.Add(HaarType.Alt2);
            HaarTypes.Add(HaarType.Default);

            foreach (var Type in HaarTypes)
            {
                FaceBO_HaarChangable.Haar = FaceBO_HaarChangable.CreateHaar(Type);
                Console.WriteLine("Begin testing for Haar " + Type + ":\n");
                DateTime Start = DateTime.Now;
                int index = 1;
                foreach (var FilePath in Directory.GetFiles(FolderPath, "*.jpg"))
                {
                    FaceBO_HaarChangable.DetectFromImageWithResize(FilePath);
                    Console.WriteLine("\tDetect " + index + " images.");
                    index++;
                }

                TimeSpan TimeDiff = DateTime.Now - Start;
                Console.WriteLine("Time to run 100 detects is: " + TimeDiff.TotalMilliseconds / 1000 + " seconds");
                Console.Write("Press enter to continue: ");
                Console.ReadLine();
            }

        }

        //VD ten file 1 (1) thi se tra ra 1
        private static int GetResult(String FileName)
        {
            String NameWithoutEx = System.IO.Path.GetFileNameWithoutExtension(FileName);

            //Cat tu sau dau cach, vd 'Hoang (6)' thanh 'Hoang'
            int IndexOfSpace = NameWithoutEx.IndexOf(' ');
            if (IndexOfSpace == -1)
            {
                return int.Parse(NameWithoutEx);
            }
            else
            {
                return int.Parse(NameWithoutEx.Substring(0, IndexOfSpace));
            }
        }

        //So sanh do chinh xac, hit ma miss cua cac bo haar
        static void CompareAccuracySingleImage()
        {
            FaceBO_HaarChangable.SetXMLPath("HaarXML");
            Console.WriteLine("This time, we will check the accuraccy of detection.");
            Console.WriteLine("We will test with a folder contain 100 images.");
            String FolderPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\Sample Images";
            Console.Write("Press Enter to begin: ");
            Console.ReadLine();


            List<HaarType> HaarTypes = new List<HaarType>();
            HaarTypes.Add(HaarType.AltTree);
            HaarTypes.Add(HaarType.Alt1);
            HaarTypes.Add(HaarType.Alt2);
            HaarTypes.Add(HaarType.Default);

            int NumberOfFile = Directory.GetFiles(FolderPath, "*.jpg").Count();

            foreach (var Type in HaarTypes)
            {
                FaceBO_HaarChangable.Haar = FaceBO_HaarChangable.CreateHaar(Type);
                Console.WriteLine("Begin testing for Haar " + Type + ":\n");
                int index = 1;
                double Hit = 0;
                double MissingHit = 0;
                double OverHit = 0;
                int DetectFaceCount = 0;
                int TotalFace = 0;
                foreach (var FilePath in Directory.GetFiles(FolderPath, "*.jpg"))
                {
                    RecognizerResult result = FaceBO_HaarChangable.DetectFromImage(FilePath);
                    int FaceDetected = result.FaceList.Count;
                    int FaceInImage = GetResult(FilePath);

                    String Report = String.Format("\tDetect {0} image. Find {1}/{2} faces.",
                        index, FaceDetected, FaceInImage);
                    if (FaceDetected == FaceInImage)
                    {
                        Report += "(O)";
                        Hit++;
                    }
                    else
                    {
                        if (FaceDetected < FaceInImage)
                        {
                            MissingHit++;
                        }
                        else
                        {
                            OverHit++;
                        }
                        Report += "(X)";
                    }
                    Console.WriteLine(Report);
                    index++;
                    DetectFaceCount += FaceDetected;
                    TotalFace += FaceInImage;
                }

                Console.WriteLine(String.Format("Accuracy: {0}%. Missing: {1}%. Over Detect: {2}%.",
                    (Hit / NumberOfFile), (MissingHit / NumberOfFile), (OverHit / NumberOfFile)));
                Console.WriteLine(String.Format("Detected {0}/{1} faces", DetectFaceCount, TotalFace));

                Console.Write("Press enter to continue: ");
                Console.ReadLine();
            }

        }

        //So sanh xem dong hinh xuat ra co phai image hay ko
        static void CompareFacePostivieDetection()
        {
            FaceBO_HaarChangable_Extractable.SetXMLPath("HaarXML");
            Console.WriteLine("This time, we will check the detected face is a face or not.");
            Console.WriteLine("The extraction will be automated. But we must check by eyes.");
            String FolderPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\Sample Images";
            Console.Write("Press Enter to begin: ");
            Console.ReadLine();


            List<HaarType> HaarTypes = new List<HaarType>();
            HaarTypes.Add(HaarType.AltTree);
            HaarTypes.Add(HaarType.Alt1);
            HaarTypes.Add(HaarType.Alt2);
            HaarTypes.Add(HaarType.Default);

            int NumberOfFile = Directory.GetFiles(FolderPath, "*.jpg").Count();

            foreach (var Type in HaarTypes)
            {
                FaceBO_HaarChangable_Extractable.Haar = FaceBO_HaarChangable_Extractable.CreateHaar(Type);
                FaceBO_HaarChangable_Extractable.InitialImageList();
                FaceBO_HaarChangable_Extractable.EXTRACT_FOLDER_PATH = Type.ToString();
                Console.WriteLine("Begin testing for Haar " + Type + ":\n");

                int index = 1;
                foreach (var FilePath in Directory.GetFiles(FolderPath, "*.jpg", SearchOption.TopDirectoryOnly))
                {
                    FaceBO_HaarChangable_Extractable.DetectFromImage(FilePath);
                    Console.WriteLine("\tDetect " + index + " images.");
                    index++;
                }
                //Ghi xuong folder
                FaceBO_HaarChangable_Extractable.SaveImage();
                Console.WriteLine("Wrote images to folder: " + Type.ToString() + ".");
                Console.Write("Press enter to continue: ");
                Console.ReadLine();
            }


            Console.ReadLine();
        }


    }
}
