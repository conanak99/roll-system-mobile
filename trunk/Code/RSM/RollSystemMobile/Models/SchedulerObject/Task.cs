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
            //Tim nhung roll call co ngay bat dau bang hom nay, active
            var RollToActive = RollBO.GetList().Where(roll => roll.BeginDate.Equals(DateTime.Today));
            foreach (var rollCall in RollToActive)
            {
                //Status bang 2 la activa, o status nay ko duoc sua gi het, chi duoc doi lich
                rollCall.Status = 2;
                RollBO.UpdateExist(rollCall);
                SimpleLog.Info("Roll Call " + rollCall.RollCallID + " Activated");
            }
            

            var RollToInactive = RollBO.GetList().Where(roll => roll.EndDate.Equals(DateTime.Today));
            foreach (var rollCall in RollToInactive)
            {
                //Status bang 2 la activa, o status nay ko duoc sua gi het, chi duoc doi lich
                rollCall.Status = 3;
                RollBO.UpdateExist(rollCall);
                SimpleLog.Info("Roll Call " + rollCall.RollCallID + " Inactivated");
            }

        }
    }

}
