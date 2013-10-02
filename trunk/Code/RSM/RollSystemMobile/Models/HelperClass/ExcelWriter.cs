using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;
using OfficeOpenXml;
using System.Drawing;
using OfficeOpenXml.Style;

namespace RollSystemMobile.Models.HelperClass
{
    public class ExcelWriter
    {
        public static void WriteExcelFile(ExcelPackage Package, String FileName)
        {
            FileInfo NewFile = new FileInfo(FileName);
            if (NewFile.Exists)
            {
                NewFile.Delete();  // ensures we create a new workbook
                NewFile = new FileInfo(FileName);
            }
            Package.SaveAs(NewFile);
        }

        
    }
}
