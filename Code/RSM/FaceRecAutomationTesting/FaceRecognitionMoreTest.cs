using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using Emgu.CV;
using Emgu.CV.Structure;
using Emgu.Util;
using Emgu.CV.CvEnum;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;

namespace FaceRecAutomationTesting
{
    public class FaceRecognitionMoreTest
    {
        public static void RunTestAutomation()
        {
            FaceBusinessForMoreTest.Initialize();
            FaceBusinessForMoreTest.SetXMLPath(@"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\RollSystemMobile");
            FaceBusinessForMoreTest.SetTrainingFolderPath(@"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\RollSystemMobile\Content\Training Data");

            Console.WriteLine("Face Recognition More Automation Test");
            Console.WriteLine("============================================================================");
            Console.WriteLine("1. Find the required number of images to recognize all the student present.");
            Console.WriteLine("2. With the number of images acsending, find the number of student detected.");
            Console.WriteLine("============================================================================");

            Console.Write("Enter option: ");
            int option = int.Parse(Console.ReadLine());
            switch (option)
            {
                case 1: FindRequiredImageNumber(); break;
                case 2: FindAvarageStudentDetected(); break;
                default: Console.WriteLine("Good bye");
                    break;
            }

        }

        //Tim xem can bao nhiu hinh thi nhan dien du SV
        static void FindRequiredImageNumber()
        {
            Random random = new Random();

            //Set cac gia tri
            int TestRollCallID = 1;
            int StudentPresent = 20;
            String TestImageFolderPath = "";

            //Tao BO
            RollCall roll = new RollCallBusiness().GetRollCallByID(TestRollCallID);
            AttendanceBusiness AttenBO = new AttendanceBusiness();

            //Tao 1 mang luu ket qua
            List<MoreTestSingleResult> FinalResults = new List<MoreTestSingleResult>();

            //Doc toan bo anh trong folder
            List<String> ImageFiles = Directory.GetFiles(TestImageFolderPath, "*.jpg", SearchOption.TopDirectoryOnly).ToList();

            //Chay test 10000 lan
            for (int i = 0; i < 10000; i++)
            {
                List<RollSystemMobile.Models.RecognizerResult> Results = new List<RollSystemMobile.Models.RecognizerResult>();
                int StudentDetected = 0;

                //Sao chep ra mot mang rieng
                List<String> ImageFilesClones = ImageFiles.Select(file => file.Clone().ToString()).ToList();
                List<String> FileUsed = new List<string>();

                while (StudentDetected < StudentPresent)
                {
                    //Lay 1 phan tu ra khoi mang clone
                    int Position = random.Next(ImageFilesClones.Count);
                    String FilePath = ImageFilesClones.ElementAt(Position);
                    ImageFilesClones.Remove(FilePath);
                    FileUsed.Add(FilePath);

                    var Result = FaceBusinessForMoreTest.RecognizeStudentForAttendance(TestRollCallID, FilePath);
                    Results.Add(Result);

                    StudentDetected = AttenBO.GetStudentIDList(Results).Count;
                }
                MoreTestSingleResult SingleResult = new MoreTestSingleResult();
                SingleResult.FileUsed = FileUsed;
                SingleResult.RunCount = FileUsed.Count;
                SingleResult.StudentDetected = StudentDetected;
                FinalResults.Add(SingleResult);
            }

            FinalResults = FinalResults.OrderBy(rs => rs.RunCount).ToList();
            MoreTestSingleResult MinResult = FinalResults.First();
            Console.WriteLine("Minimum image required: " + MinResult.RunCount);
            Console.Write("File Used: ");
            foreach (var FilePath in MinResult.FileUsed)
            {
                Console.WriteLine(Path.GetFileNameWithoutExtension(FilePath) + "|");
            }
            Console.WriteLine();

            MoreTestSingleResult MaxResult = FinalResults.Last();
            Console.WriteLine("Maximum image required: " + MaxResult.RunCount);
            Console.Write("File Used: ");
            foreach (var FilePath in MaxResult.FileUsed)
            {
                Console.WriteLine(Path.GetFileNameWithoutExtension(FilePath) + "|");
            }
            Console.WriteLine();

            double AvgRun = FinalResults.Average(r => r.RunCount);
            Console.WriteLine("Avarage image required: " + AvgRun);

        }

        //So luong hinh tang dan, tinh so luong SV detected dc
        static void FindAvarageStudentDetected()
        {
            Random random = new Random();

            //Set cac gia tri
            int TestRollCallID = 1;
            String TestImageFolderPath = "";

            //Tao BO
            RollCall roll = new RollCallBusiness().GetRollCallByID(TestRollCallID);
            AttendanceBusiness AttenBO = new AttendanceBusiness();

            //Tao 1 mang luu ket qua
            List<MoreTestSingleResult> FinalResults = new List<MoreTestSingleResult>();

            //Doc toan bo anh trong folder
            List<String> ImageFiles = Directory.GetFiles(TestImageFolderPath, "*.jpg", SearchOption.TopDirectoryOnly).ToList();

            //So luong hinh tang dan, tu 5 toi max
            for (int i = 5; i < ImageFiles.Count; i +=2)
            {
                //Chay 1000 lan
                for (int j = 0; j < 1000; j++)
                {
                    List<RollSystemMobile.Models.RecognizerResult> Results = new List<RollSystemMobile.Models.RecognizerResult>();
                    //Sao chep ra mot mang rieng
                    List<String> ImageFilesClones = ImageFiles.Select(file => file.Clone().ToString()).ToList();
                    List<String> FileUsed = new List<string>();

                    //Lay random i hinh, set result
                    for (int k = 0; k < i; k++)
                    {
                        //Lay 1 phan tu ra khoi mang clone
                        int Position = random.Next(ImageFilesClones.Count);
                        String FilePath = ImageFilesClones.ElementAt(Position);
                        ImageFilesClones.Remove(FilePath);
                        FileUsed.Add(FilePath);

                        var Result = FaceBusinessForMoreTest.RecognizeStudentForAttendance(TestRollCallID, FilePath);
                        Results.Add(Result);
                    }
                    MoreTestSingleResult SingleResult = new MoreTestSingleResult();
                    SingleResult.FileUsed = FileUsed;
                    SingleResult.RunCount = FileUsed.Count;
                    SingleResult.StudentDetected = AttenBO.GetStudentIDList(Results).Count;
                    FinalResults.Add(SingleResult);
                } 
            }


            //Bat dau tinh, voi so luong hinh tang dan, trung binh nhan dien dc bao nhieu hs
            for (int i = 5; i < ImageFiles.Count; i += 2)
            {
                Console.WriteLine("Number of image used: " + i);
                double AvgStudentDetected = FinalResults.Where(r => r.RunCount == i).Average(r => r.StudentDetected);
                Console.WriteLine("Average Student Detected: " + AvgStudentDetected);
            }

        }

    }
}
