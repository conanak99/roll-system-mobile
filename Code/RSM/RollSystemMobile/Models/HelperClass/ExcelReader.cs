using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Office.Interop.Excel;

namespace RollSystemMobile.Models.HelperClass
{
    public class ExcelReader
    {
        private static ExcelReader instance;
        private static Microsoft.Office.Interop.Excel.Application Application;
        private ExcelReader()
        {
            Application = new Microsoft.Office.Interop.Excel.Application();
        }

        public static ExcelReader GetInstance()
        {
            if (instance == null)
            {
                instance = new ExcelReader();
            }
            return instance;
        }

        public static void Dispose()
        {
            if (instance != null)
            {
                Application.Quit();
                instance = null;
            }
        }

        public List<String> ReadSheetNames(String FileName)
        {
            var Workbook = Application.Workbooks.Open(FileName);
            List<String> SheetNames = new List<string>();

            //Chay tu 1, not 0
            for (int i = 1; i < Workbook.Sheets.Count + 1; i++)
            {
                Worksheet Sheet = (Worksheet)Workbook.Sheets[i];
                SheetNames.Add(Sheet.Name);
            }

            return SheetNames;
        }

        public Worksheet GetWorkSheets(String SheetName, String FileName)
        {
            var Workbook = Application.Workbooks.Open(FileName);
            return (Worksheet)Workbook.Sheets[SheetName];
        }

        public object[,] GetCellValues(String SheetName, String FileName)
        {
            Worksheet ClassSheet = GetWorkSheets(SheetName, FileName);

            Range excelRange = ClassSheet.UsedRange;
            object[,] valueArray = (object[,])excelRange.get_Value(
                XlRangeValueDataType.xlRangeValueDefault);

            return valueArray;
        }

        //Bien A,B,C thanh 1,2,3
        public static int TextToNumber(string column)
        {
            return column
                .Select(c => c - 'A' + 1)
                .Aggregate((sum, next) => sum * 26 + next);
        }

        //Bien 1,2,3 thành A,B,C
        public static String NumberToText(int column)
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
    }
}
