using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Office.Interop.Excel;
using FluentScheduler;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BusinessObject;
using RollSystemMobile.Models.HelperClass;
using System.IO;

namespace RollSystemMobile.Schedule
{
    public class MyRegistry : Registry
    {
        public MyRegistry()
        {
            //Active RollCall moi 12:00 sang
            Schedule<ActiveRollCallTask>().ToRunEvery(1).Days().At(1, 0);
            Schedule<ClearTempFolderTask>().ToRunEvery(1).Days().At(1, 0);
        } 
    }

    public static class TempPathHolder
    {
        public static String TempPath { get; set; }
    }

    public class ClearTempFolderTask : ITask
    {
        public void Execute()
        {
            //Clean thu muc temp
            string[] filePaths = Directory.GetFiles(TempPathHolder.TempPath);
            foreach (string filePath in filePaths)
                File.Delete(filePath);
            SimpleLog.Info(filePaths.Count() + " files in Temp Folder deleted.");


            filePaths = Directory.GetFiles(TempPathHolder.TempPath + "Resized/");
            foreach (string filePath in filePaths)
                File.Delete(filePath);
            SimpleLog.Info(filePaths.Count() + " files in Resized Folder deleted.");
        }
    }



    public class ActiveRollCallTask : ITask
    {
        public void Execute()
        {
            RollCallBusiness RollBO = new RollCallBusiness();
            RollBO.SetRollCallStatus();
        }
    }

    public class SyncCalendar : ITask
    {
        public void Execute()
        {
            InstructorBusiness InsBO = new InstructorBusiness();
            CalendarBusiness CalenBO = new CalendarBusiness();
            //Tim nhung instructor co API Token
            List<Instructor> InstructorsWithAPI = InsBO.Find(ins => ins.ApiToken != null);

            foreach (var Instructor in InstructorsWithAPI)
            {
                CalenBO.SyncInstructorCalendar(Instructor.InstructorID);
            }

            SimpleLog.Info("Calendar for " + InstructorsWithAPI.Count + " instructors synced.");
        }
    }
}
