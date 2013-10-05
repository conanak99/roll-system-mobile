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
        private static List<string> NameList;

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
            //TestPerformanceSmall();
            TestAccuracy(4);
            TestAccuracy(6);
            TestAccuracy(8);
            TestAccuracy(10);
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

            var FilePaths = Directory.GetFiles(TrainingDataFolderPath, "*.jpg", SearchOption.TopDirectoryOnly);
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
            foreach (var FilePath in Directory.GetFiles(TestDataFolderPath, "*.jpg", SearchOption.TopDirectoryOnly))
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

        private static void TestAccuracy(int NumberOfTrainingImage)
        {
            //Khoi tao 9 bo face recognizer
            FaceRecognizers = new List<FaceRecognizer>();
            FaceRecognizers.Add(new EigenFaceRecognizer(80, 2000));
            FaceRecognizers.Add(new EigenFaceRecognizer(80, 3500));
            //Can't recognize unknown
            FaceRecognizers.Add(new EigenFaceRecognizer(80, 8000));

            FaceRecognizers.Add(new FisherFaceRecognizer(80, 500));
            FaceRecognizers.Add(new FisherFaceRecognizer(80, 1000));
            //Can't recognize unknown
            FaceRecognizers.Add(new FisherFaceRecognizer(80, 2500));

            FaceRecognizers.Add(new LBPHFaceRecognizer(1, 8, 8, 9, 50));
            FaceRecognizers.Add(new LBPHFaceRecognizer(1, 8, 8, 9, 100));
            //Can't recognize unknown
            FaceRecognizers.Add(new LBPHFaceRecognizer(1, 8, 8, 9, 250));

            List<TestSingleResult> Results = new List<TestSingleResult>();


            Console.WriteLine("This time we will check the accuracy of the 3 algorithm.");
            Console.Write("Press Enter to continue: ");
            Console.ReadLine();
            NameList = new string[] { "Bao", "Dung", "Hoa", "Hoang", "Minh", "Sen" }.ToList();

            String TrainingDataPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\Training Datas";

            List<Image<Gray, byte>> TrainingImageList = new List<Image<Gray, byte>>();
            List<int> IDList = new List<int>();

            Console.WriteLine("Begin Training Face Recognizer");
            foreach (var FilePath in Directory.GetFiles(TrainingDataPath, "*.jpg", SearchOption.TopDirectoryOnly))
            {
                foreach (var PersonName in NameList)
                {
                    String ImageName = GetResult(FilePath);
                    int ID = NameList.IndexOf(ImageName);
                    if (ID != -1 && ImageName.Equals(PersonName) && IDList.Count(num => num == ID) < NumberOfTrainingImage)
                    {
                        Image<Gray, byte> Image = new Image<Gray, byte>(FilePath);
                        Image._EqualizeHist();
                        TrainingImageList.Add(Image);

                        IDList.Add(ID);
                    }
                }
            }

            foreach (var FaceRec in FaceRecognizers)
            {
                FaceRec.Train(TrainingImageList.ToArray(), IDList.ToArray());
            }

            Console.WriteLine(TrainingImageList.Count + " images loaded.");
            Console.Write("Press Enter to continue: ");
            Console.ReadLine();

            Console.WriteLine("Begin Testing Recognition:");
            String TestDataPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\TestData";
            int imageRecognized = 1;
            foreach (var FilePath in Directory.GetFiles(TestDataPath, "*.jpg", SearchOption.TopDirectoryOnly))
            {
                //Load hinh tu duong dan
                Image<Gray, byte> Face = new Image<Gray, byte>(FilePath);
                Face._EqualizeHist();

                //Lay result tu ten file
                TestSingleResult TestResult = new TestSingleResult();
                TestResult.Result = GetResult(FilePath);

                //Lay 9 ket qua tu eigen face, set vao object
                //Lay 9 properties cua result, tuong ung voi 9 bo face recognizer
                var Properties = TestResult.GetType().GetProperties();
                for (int i = 0; i < FaceRecognizers.Count; i++)
                {
                    FaceRecognizer.PredictionResult PR = FaceRecognizers.ElementAt(i).Predict(Face);
                    String NameFound = PR.Label == -1 ? "Unknown" : NameList.ElementAt(PR.Label);
                    Properties[i].SetValue(TestResult, NameFound, null);
                }
                //Dua result da tim dc vao danh sach, sau nay tinh tiep
                Results.Add(TestResult);
                Console.WriteLine(imageRecognized + " images recognized");
                imageRecognized++;
            }

            Console.Write("Completed. Enter path to export report: ");
            String ReportPath = Console.ReadLine();

            String MixedFilePath = ReportPath + "Mixed.txt";
            String MixedResultString = GetResultString(Results);
            System.IO.File.WriteAllText(MixedFilePath, MixedResultString, Encoding.UTF8);

            String KnownFilePath = ReportPath + "Known.txt";
            String KnownResultString = GetResultString(Results.Where(result => !result.Result.Equals("Unknown")).ToList());
            System.IO.File.WriteAllText(KnownFilePath, KnownResultString, Encoding.UTF8);

            String UnknownFilePath = ReportPath + "Unknown.txt";
            String UnknownResultString = GetResultString(Results.Where(result => result.Result.Equals("Unknown")).ToList());
            System.IO.File.WriteAllText(UnknownFilePath, UnknownResultString, Encoding.UTF8);
            Console.Write("Done");
        }

        private static String GenerateHeaderLine(int Length)
        {
            StringBuilder Result = new StringBuilder("");
            for (int i = 0; i < Length; i++)
            {
                Result.Append('=');
            }
            return Result.ToString();
        }

        private static String GetResultString(List<TestSingleResult> Results)
        {
            int Total = Results.Count;
            StringBuilder Result = new StringBuilder("");
            //Tao Header
            Result.AppendLine(GenerateHeaderLine(120));
            Result.Append(String.Format("|{0,-10}|{1,-11}|{2,-11}|{3,-11}|{4,-11}|{5,-11}|{6,-11}|{7,-11}|{8,-11}|{9,-11}|\n",
                "Result", "Eigen 2k", "Eigen 3k5", "Eigen 5k",
                "Fisher 500", "Fisher 1k", "Fisher 1k5",
                "LBPH 50", "LPBH 100", "LPBH 150"));
            Result.AppendLine(GenerateHeaderLine(120));

            //Tao ra cac hang
            foreach (TestSingleResult SingleResult in Results)
            {
                Result.AppendLine(SingleResult.ToString());
            }

            //Tao footer gach duoi
            Result.AppendLine(GenerateHeaderLine(120));


            //Tinh toan cac gia tri va phan tram, tao them 2 rows, 1 row dem, 1 row %
            //Tinh so luot doan trung tren tong so luot
            List<int> HitList = new List<int>();
            HitList.Add(Results.Count(result => result.Result.Equals(result.Eigen_2000_Result)));
            HitList.Add(Results.Count(result => result.Result.Equals(result.Eigen_3500_Result)));
            HitList.Add(Results.Count(result => result.Result.Equals(result.Eigen_5000_Result)));

            HitList.Add(Results.Count(result => result.Result.Equals(result.Fisher_500_Result)));
            HitList.Add(Results.Count(result => result.Result.Equals(result.Fisher_1000_Result)));
            HitList.Add(Results.Count(result => result.Result.Equals(result.Fisher_1500_Result)));

            HitList.Add(Results.Count(result => result.Result.Equals(result.LPBH_50_Result)));
            HitList.Add(Results.Count(result => result.Result.Equals(result.LPBH_100_Result)));
            HitList.Add(Results.Count(result => result.Result.Equals(result.LPBH_150_Result)));

            //Tao 1 row chua cac gia tri tren
            Result.Append(String.Format("|{0,-10}|", "Hit"));
            foreach (int Hit in HitList)
            {
                Result.Append(String.Format("{0,-11}|", Hit + "/" + Total));
            }
            Result.AppendLine();
            //Tao footer gach duoi
            Result.AppendLine(GenerateHeaderLine(120));

            //Tinh toan % doan trung
            //Tao 1 row chua cac gia tri tren
            Result.Append(String.Format("|{0,-10}|", "Percent"));
            foreach (int Hit in HitList)
            {
                double Percent = Convert.ToDouble(Hit) / Total * 100;
                String PercentString = String.Format("{0:0.00}%", Percent);
                Result.Append(String.Format("{0,-11}|", PercentString));
            }
            Result.AppendLine();
            //Tao footer gach duoi
            Result.AppendLine(GenerateHeaderLine(120));

            return Result.ToString();
        }


        private static String GetResult(String FileName)
        {
            String NameWithoutEx = System.IO.Path.GetFileNameWithoutExtension(FileName);

            //Cat tu sau dau cach, vd 'Hoang (6)' thanh 'Hoang'
            int IndexOfSpace = NameWithoutEx.IndexOf(' ');
            if (IndexOfSpace == -1)
            {
                return NameWithoutEx;
            }
            else
            {
                return NameWithoutEx.Substring(0, IndexOfSpace);
            }
        }
    }
}
