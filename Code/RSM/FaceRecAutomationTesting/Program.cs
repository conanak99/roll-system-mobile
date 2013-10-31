using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using RollSystemMobile.Models;
namespace FaceRecAutomationTesting
{
    class Program
    {
        static void Main(string[] args)
        {
           // FaceDetectionAutomation.RunTestAutomation();
           // FaceRecognitionAutomation.RunTestAutomation();

            FaceRecognitionMoreTest.RunTestAutomation();
            Console.ReadLine();
        }

      
    }
}

