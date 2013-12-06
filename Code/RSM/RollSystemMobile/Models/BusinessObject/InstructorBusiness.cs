using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OfficeOpenXml;
using System.Drawing;
using OfficeOpenXml.Style;
using RollSystemMobile.Models.HelperClass;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class InstructorBusiness: GenericBusiness<Instructor>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public InstructorBusiness()
        {
            
        }
        public InstructorBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }

        public List<Instructor> GetAllInstructor()
        {
            return base.GetList().ToList();
        }

        public void Update(Instructor Ins, List<int> SubjectTypeIDs)
        {
            var FoundIns = GetInstructorByID(Ins.InstructorID);

            //Xoa toan bo subjectID cu
            FoundIns.Fullname = Ins.Fullname;
            FoundIns.Email = Ins.Email;
            FoundIns.Phone = Ins.Phone;
            FoundIns.SubjectTypes.Clear();

            foreach (var SubjectTypeID in SubjectTypeIDs)
            {
                FoundIns.SubjectTypes.Add(GetSubjectTypeByID(SubjectTypeID));
            }
            base.RollSystemDB.SaveChanges();
        }

        public void Insert(Instructor Ins, List<int> SubjectTypeIDs)
        {
            Ins.IsActive = true;
            foreach (var SubjectTypeID in SubjectTypeIDs)
            {
                Ins.SubjectTypes.Add(GetSubjectTypeByID(SubjectTypeID));
            }
            base.Insert(Ins);
        }

        private SubjectType GetSubjectTypeByID(int TypeID)
        {
            return base.RollSystemDB.SubjectTypes.FirstOrDefault(st => st.TypeID == TypeID);
        }

        public List<Instructor> GetActiveInstructor()
        {
            return base.GetList().Where(i => i.IsActive).ToList();
        }

        public List<Instructor> GetInstructorOfRollCall(int RollCallID)
        {
            RollCallBusiness RollBO = new RollCallBusiness();
            var rollCall = RollBO.GetRollCallByID(RollCallID);
            return rollCall.Subject.SubjectType.Instructors.ToList();
        }

        public Instructor GetInstructorByID(int ID)
        {
            return base.GetList().FirstOrDefault(i => i.InstructorID == ID);
        }

        public Instructor GetInstructorByUserID(int ID)
        {
            return base.GetList().FirstOrDefault(i => i.UserID == ID);
        }


        public void CreateSessionReport(int InstructorID, DateTime SelectedTime, String FilePath)
        {
            ExcelPackage Package = new ExcelPackage();
            ExcelWorksheet Worksheet = Package.Workbook.Worksheets.Add("Session Report");

            var Ins = GetInstructorByID(InstructorID);

            Worksheet.Column(3).Width = 18;
            Worksheet.Column(4).Width = 24;
            Worksheet.Column(6).Width = 12.5;

            Worksheet.Cells["C2:D2"].Merge = true;
            Worksheet.Cells["C2"].Value = "Session Report";
            Worksheet.Cells["C2"].Style.Font.Size = 18;
            Worksheet.Cells["C2"].Style.Font.Bold = true;

            //Thong tin report - label
            Worksheet.Cells["C3"].Value = "Instructor";
            Worksheet.Cells["C4"].Value = "Year";
            Worksheet.Cells["C5"].Value = "Month";

            Worksheet.Cells["C3:C5"].Style.Font.Size = 12;
            Worksheet.Cells["C3:C5"].Style.Font.Bold = true;

            //Thong tin report
            Worksheet.Cells["D3"].Value = Ins.Fullname;
            Worksheet.Cells["D4"].Value = SelectedTime.Year;
            Worksheet.Cells["D5"].Value = SelectedTime.ToString("MMMM");
            Worksheet.Cells["D3:D5"].Style.Font.Size = 12;
            Worksheet.Cells["D3:D5"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;

            //title table
            Worksheet.Cells["C7"].Value = "Date";
            Worksheet.Cells["D7"].Value = "Class";
            Worksheet.Cells["E7"].Value = "Slot";
            Worksheet.Cells["F7"].Value = "Total Slot";
            Worksheet.Cells["C7:F7"].Style.Font.Size = 12;
            Worksheet.Cells["C7:F7"].Style.Fill.PatternType = ExcelFillStyle.Solid;
            Worksheet.Cells["C7:F7"].Style.Fill.BackgroundColor.SetColor(Color.Gray);
            Worksheet.Cells["C7:F7"].Style.Font.Bold = true;

            //Lay nhung study session trong thang truoc va thang nay
            var LastMonthSessions = Ins.StudySessions.Where(ss => ss.SessionDate.Month == (SelectedTime.Month - 1)
                                && ss.SessionDate.Day > 15
                                && ss.SessionDate.Year == SelectedTime.Year).ToList();

            var ThisMonthSessions = Ins.StudySessions.Where(ss => ss.SessionDate.Month == SelectedTime.Month
                                && ss.SessionDate.Day <= 15
                                && ss.SessionDate.Year == SelectedTime.Year).ToList();

            //Nhap 2 gia tri lai voi nhau
            LastMonthSessions.AddRange(ThisMonthSessions);
            var TeachingDates = LastMonthSessions.OrderBy(ss => ss.SessionDate).Select(ss => ss.SessionDate).Distinct().ToList();

            //Bat dau in ra cac ngay day hoc
            int RowIndex = 7;
            int TotalSlots = 0;
            for (int i = 0; i < TeachingDates.Count; i++)
            {
                RowIndex++;
                var TeachingDate = TeachingDates.ElementAt(i);
                Worksheet.Cells["C" + RowIndex].Value = TeachingDate.ToString("dd/MM/yyyy");
                Worksheet.Cells["C" + RowIndex + ":F" + RowIndex].Style.Font.Bold = true;

                var SessionsAtDate = LastMonthSessions.Where(ss => ss.SessionDate == TeachingDate).ToList();
                int TotalSlotInDate = 0;
                for (int k = 0; k < SessionsAtDate.Count; k++)
                {
                    RowIndex++;
                    var SessionAtDate = SessionsAtDate.ElementAt(k);
                    Worksheet.Cells["D" + RowIndex].Value = SessionAtDate.Class.ClassName.Trim()
                                                            + " - " + SessionAtDate.RollCall.Subject.ShortName;
                    Worksheet.Cells["E" + RowIndex].Value = SessionAtDate.RollCall.Subject.NumberOfSlot;

                    Worksheet.Cells["D" + RowIndex + ":E" + RowIndex].Style.Font.Size = 9;

                    TotalSlotInDate += SessionAtDate.RollCall.Subject.NumberOfSlot;
                    if (k == SessionsAtDate.Count - 1)
                    {
                        Worksheet.Cells["F" + (RowIndex - k - 1)].Value = TotalSlotInDate;
                        TotalSlots += TotalSlotInDate;
                    }
                }
            }

            //Viet total
            RowIndex++;
            Worksheet.Cells["C" + RowIndex].Value = "Total Slots";
            Worksheet.Cells["F" + RowIndex].Value = TotalSlots;
            Worksheet.Cells["C" + RowIndex + ":F" + RowIndex].Style.Font.Bold = true;

            //set border table
            for (int Column = 3; Column <= 6; Column++)
            {
                for (int Row = 7; Row <= RowIndex; Row++)
                {
                    Worksheet.Cells[Row, Column].Style.Border.BorderAround(ExcelBorderStyle.Thin, Color.Black);
                }
            }

            Worksheet.Cells["A:XFD"].Style.Font.Name = "Arial";
            ExcelWriter.WriteExcelFile(Package, FilePath);
            Package.Dispose();
        }

    }
}