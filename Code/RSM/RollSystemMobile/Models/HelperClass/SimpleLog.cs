using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace RollSystemMobile.Models.HelperClass
{
    public static class SimpleLog
    {
        private static String LogFolder;
        private static String FileName = "RSMLog.txt";

        public static void SetLogFolder(String InLogFolder)
        {
            LogFolder = InLogFolder;
        }

        private static void Write(String Message)
        {
            String FilePath = LogFolder + "/" + FileName;

            if (!File.Exists(FilePath))
            {
                // Create a file to write to. 
                using (StreamWriter sw = File.CreateText(FilePath))
                {
                    String Prefix = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt: ");
                    sw.WriteLine(Prefix + Message);
                }
            }
            else
            {
                using (StreamWriter sw = File.AppendText(FilePath))
                {
                    String Prefix = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt: ");
                    sw.WriteLine(Prefix + Message);
                }
            }
        }

        public static void Info(String Message)
        {
            Write("INFO: " + Message);
        }

        public static void Error(String Message)
        {
            Write("ERROR: " + Message);
        }

        public static List<String> GetErrors()
        {
            String FilePath = LogFolder + "/" + FileName;
            var Lines = File.ReadAllLines(FilePath, Encoding.UTF8);
            return Lines.Where(l => l.Contains("Error:")).ToList();
        }
    }
}
