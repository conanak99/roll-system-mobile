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
    public static class OtherHelper
    {
        //Bien A,B,C thanh 1,2,3
        public static int TextToNumber(this string column)
        {
            return column
                .Select(c => c - 'A' + 1)
                .Aggregate((sum, next) => sum * 26 + next);
        }

        //Bien 1,2,3 thành A,B,C
        public static String NumberToText(this int column)
        {
            string columnString = "";
            decimal columnNumber = column;
            while (columnNumber > 0)
            {
                decimal currentLetterNumber = (columnNumber - 1) % 26;
                char currentLetter = (char)(currentLetterNumber + 65);
                columnString = currentLetter + columnString;
                columnNumber = (columnNumber - (currentLetterNumber + 1)) / 26;
            }
            return columnString;
        }

        public static DateTime ParseStringToDateTime(this String Date)
        {
            return DateTime.ParseExact(Date, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture);
        }
        
    }
}
