using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using Emgu.CV;
using Emgu.CV.Structure;
using Emgu.Util;
using Emgu.CV.CvEnum;

namespace FaceRecAutomationTesting
{
    public class FaceRecognitionAutomation
    {
        private static List<FaceRecognizer> FaceRecognizers;

        public static void RunTestAutomation()
        {
            Console.WriteLine("Hello World");
            Console.WriteLine("Face Recognition Automation Test");
            Console.WriteLine("============================================================================");
            Console.WriteLine("1. Load a recognizer with 250 images, 25 labels. Test performance of checking.");
            Console.WriteLine("2. Load a recognizer with 600 images, 30 labels. Test performance of checking.");
            Console.WriteLine("3. Test the accuracy of 3 face recognizer algorithm. Each with 3 different threehold.");
            Console.WriteLine("============================================================================");

            //TestPerformanceBig();
            TestPerformanceSmall();
        }


        private static void TestPerformanceBig()
        {
            //Khoi tao 9 bo face recognizer
            Console.WriteLine("We will load a dumb training data with 600 images.");
            Console.Write("Press Enter to begin: ");
            Console.ReadLine();
            FaceRecognizers = new List<FaceRecognizer>();
            FaceRecognizers.Add(new EigenFaceRecognizer(80, 2000));
            FaceRecognizers.Add(new EigenFaceRecognizer(80, 3500));
            FaceRecognizers.Add(new EigenFaceRecognizer(80, 5000));

            FaceRecognizers.Add(new FisherFaceRecognizer(80, 500));
            FaceRecognizers.Add(new FisherFaceRecognizer(80, 1000));
            FaceRecognizers.Add(new FisherFaceRecognizer(80, 1500));

            FaceRecognizers.Add(new LBPHFaceRecognizer(1, 8, 8, 9, 50));
            FaceRecognizers.Add(new LBPHFaceRecognizer(1, 8, 8, 9, 100));
            FaceRecognizers.Add(new LBPHFaceRecognizer(1, 8, 8, 9, 150));


            String TrainingDataFolderPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\Training Datas\DumbTrainingData";
            //Bat dau tinh thoi gian add 600 tam hinh vao bo nho
            DateTime Start = DateTime.Now;

            List<Image<Gray, byte>> ImageList = new List<Image<Gray, byte>>();
            List<int> IDList = new List<int>();

            var FilePaths = Directory.GetFiles(TrainingDataFolderPath, "*.jpg");
            foreach (var FilePath in FilePaths)
            {
                Image<Gray, byte> Image = new Image<Gray, byte>(FilePath);
                Image._EqualizeHist();
                ImageList.Add(Image);
                Console.WriteLine("\tLoad Images: " + FilePath);
                int ID = int.Parse(Path.GetFileNameWithoutExtension(FilePath)) / 20 + 1;
                IDList.Add(ID);
            }
            TimeSpan TimeDiff = DateTime.Now - Start;
            Console.WriteLine("Time to load 600 images to memory is: " + TimeDiff.TotalMilliseconds / 1000 + " seconds");

            
            Console.WriteLine("Now we will begin to train our face recognizer");
            Console.Write("Press Enter to continue: ");
            Console.ReadLine();
            Start = DateTime.Now;
            Image<Gray, byte>[] ImageArray = ImageList.ToArray();
            int[] IDArray = IDList.ToArray();
            int i = 1;
            foreach (var FaceRec in FaceRecognizers)
            {
                FaceRec.Train(ImageArray, IDArray);
                Console.WriteLine(i + " Recognizers Trained.");
                i++;
            }
            TimeDiff = DateTime.Now - Start;
            Console.WriteLine("Time to trains 9 recognizer is: " + TimeDiff.TotalMilliseconds / 1000 + " seconds");

            Console.WriteLine("Now we will test the recognizer performance. With a folder of 400 faces");
            Console.Write("Press Enter to continue: ");
            Console.ReadLine();

            String TestDataFolderPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\TestData\Dump TestData";

            Console.WriteLine("Creating the list of test image");
            List<Image<Gray, byte>> TestImageList = new List<Image<Gray, byte>>();
            foreach (var FilePath in Directory.GetFiles(TestDataFolderPath, "*.jpg"))
            {
                Image<Gray, byte> Image = new Image<Gray, byte>(FilePath);
                Image._EqualizeHist();
                TestImageList.Add(Image);
            }

            foreach (var FaceRec in FaceRecognizers)
            {
                Console.WriteLine("Begin test with face recognizer: " + FaceRec.GetType().ToString());
                Start = DateTime.Now;
                i = 1;
                foreach (var Image in TestImageList)
                {
                    FaceRec.Predict(Image);
                    Console.WriteLine("\tRecognized " + i + " images.");
                    i++;
                }
                TimeDiff = DateTime.Now - Start;
                Console.WriteLine("Time to recognize 200 images is: " + TimeDiff.TotalMilliseconds / 1000 + " seconds");
                Console.Write("Press Enter to continue: ");
                Console.ReadLine();
            }

        }

        private static void TestPerformanceSmall()
        {
            //Khoi tao 9 bo face recognizer
            Console.WriteLine("We will load a dumb training data with 250 images.");
            Console.Write("Press Enter to begin: ");
            Console.ReadLine();
            FaceRecognizers = new List<FaceRecognizer>();
            FaceRecognizers.Add(new EigenFaceRecognizer(80, 2000));
            FaceRecognizers.Add(new EigenFaceRecognizer(80, 3500));
            FaceRecognizers.Add(new EigenFaceRecognizer(80, 5000));

            FaceRecognizers.Add(new FisherFaceRecognizer(80, 500));
            FaceRecognizers.Add(new FisherFaceRecognizer(80, 1000));
            FaceRecognizers.Add(new FisherFaceRecognizer(80, 1500));

            FaceRecognizers.Add(new LBPHFaceRecognizer(1, 8, 8, 9, 50));
            FaceRecognizers.Add(new LBPHFaceRecognizer(1, 8, 8, 9, 100));
            FaceRecognizers.Add(new LBPHFaceRecognizer(1, 8, 8, 9, 150));


            String TrainingDataFolderPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\Training Datas\DumbTrainingDataSmall";
            //Bat dau tinh thoi gian add 600 tam hinh vao bo nho
            DateTime Start = DateTime.Now;

            List<Image<Gray, byte>> ImageList = new List<Image<Gray, byte>>();
            List<int> IDList = new List<int>();

            var FilePaths = Directory.GetFiles(TrainingDataFolderPath, "*.jpg");
            foreach (var FilePath in FilePaths)
            {
                Image<Gray, byte> Image = new Image<Gray, byte>(FilePath);
                Image._EqualizeHist();
                ImageList.Add(Image);
                Console.WriteLine("\tLoad Images: " + FilePath);
                int ID = int.Parse(Path.GetFileNameWithoutExtension(FilePath)) / 10 + 1;
                IDList.Add(ID);
            }
            TimeSpan TimeDiff = DateTime.Now - Start;
            Console.WriteLine("Time to load 250 images to memory is: " + TimeDiff.TotalMilliseconds / 1000 + " seconds");


            Console.WriteLine("Now we will begin to train our face recognizer");
            Console.Write("Press Enter to continue: ");
            Console.ReadLine();
            Start = DateTime.Now;
            Image<Gray, byte>[] ImageArray = ImageList.ToArray();
            int[] IDArray = IDList.ToArray();
            int i = 1;
            foreach (var FaceRec in FaceRecognizers)
            {
                FaceRec.Train(ImageArray, IDArray);
                Console.WriteLine(i + " Recognizers Trained.");
                i++;
            }
            TimeDiff = DateTime.Now - Start;
            Console.WriteLine("Time to trains 9 recognizer is: " + TimeDiff.TotalMilliseconds / 1000 + " seconds");

            Console.WriteLine("Now we will test the recognizer performance. With a folder of 400 faces");
            Console.Write("Press Enter to continue: ");
            Console.ReadLine();

            String TestDataFolderPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\TestData\Dump TestData";

            Console.WriteLine("Creating the list of test image");
            List<Image<Gray, byte>> TestImageList = new List<Image<Gray, byte>>();
            foreach (var FilePath in Directory.GetFiles(TestDataFolderPath, "*.jpg"))
            {
                Image<Gray, byte> Image = new Image<Gray, byte>(FilePath);
                Image._EqualizeHist();
                TestImageList.Add(Image);
            }

            foreach (var FaceRec in FaceRecognizers)
            {
                Console.WriteLine("Begin test with face recognizer: " + FaceRec.GetType().ToString());
                Start = DateTime.Now;
                i = 1;
                foreach (var Image in TestImageList)
                {
                    FaceRec.Predict(Image);
                    Console.WriteLine("\tRecognized " + i + " images.");
                    i++;
                }
                TimeDiff = DateTime.Now - Start;
                Console.WriteLine("Time to recognize 200 images is: " + TimeDiff.TotalMilliseconds / 1000 + " seconds");
                Console.Write("Press Enter to continue: ");
                Console.ReadLine();
            }

        }

        private static void TestAccuracy()
        {

        }
    }
}
