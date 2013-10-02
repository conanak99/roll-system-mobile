using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace FaceRecAutomationTesting
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Automation Test.\n");
            Console.WriteLine("1. Detect an image for 1000 times, compare result.\n");
            Console.WriteLine("2. Use 4 different haar XML. Compare performance and accuracy.\n");

            //Run100Times();
            CompareHaarTimes();
            Console.ReadLine();
        }

        static void Run100Times()
        {
            FaceBO.SetXMLPath("HaarXML");
            Console.WriteLine("We choose a image with many face for testing. Enter the image path: ");
            String ImagePath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\Sample Images\More than 5\47693_634829683201925_1019415806_n.jpg";
            Console.WriteLine("Press Enter to begin: ");
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
            Console.WriteLine("The time to run 100 detecs is: " + TimeDiff.TotalMilliseconds/1000 + " seconds");

            bool DifferentResult = false;
            for (int i = 1; i < ResultList.Count; i++)
            {
                if (!ResultList.ElementAt(i).Equals(ResultList.ElementAt(i-1)))
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
            Console.WriteLine("We will test with a folder contain 100 images.\n");
            String FolderPath = @"C:\Users\Hoang\Documents\Visual Studio 2010\Projects\RollSystemMobile\FaceRecAutomationTesting\Sample Images";
            Console.WriteLine("Press Enter to begin: ");
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
                Console.WriteLine("Time to run 100 detecs is: " + TimeDiff.TotalMilliseconds / 1000 + " seconds");
                Console.WriteLine("Press enter to continue: ");
                Console.ReadLine();
            }

            
        }

    }
}
