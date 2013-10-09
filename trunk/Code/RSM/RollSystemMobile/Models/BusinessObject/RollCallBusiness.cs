﻿using System;
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
    public class RollCallBusiness: GenericBusiness<RollCall>
    {

        private InstructorTeachingBusiness InsTeaBO;

        public RollCallBusiness()
        {
            InsTeaBO = new InstructorTeachingBusiness(this.RollSystemDB);
        }

        public RollCallBusiness(RSMEntities DB)
            : base(DB)
        {
            InsTeaBO = new InstructorTeachingBusiness(DB);
        }


        public List<RollCall> GetInstructorCurrentRollCalls(int InstructorID)
        {
            DateTime Today = DateTime.Now;

            return base.GetList().Where(r => r.InstructorTeachings.
                                       Any(inte => inte.InstructorID == InstructorID)
                                       && r.BeginDate <= Today && r.EndDate >= Today).ToList();
        }

        public RollCall GetRollCallByID(int ID)
        {
            return base.GetList().FirstOrDefault(r => r.RollCallID == ID);
        }



        public bool Delete(RollCall Rollcall)
        {
            foreach (var InstructorTeaching in Rollcall.InstructorTeachings.ToList())
            {
                InsTeaBO.Delete(InstructorTeaching);
            }

            foreach (var Student in Rollcall.Students.ToList())
            {
                Rollcall.Students.Remove(Student);
            }

            return base.Delete(Rollcall);
        }


        public bool ChangeRollCallInstructor(RollCall InRollCall, int NewInstructorID)
        {
            RollCall rollcall = InRollCall;
            var RollCallInstructorTeaching = InsTeaBO.GetByRollCallID(InRollCall.RollCallID);

            int CurrentInstructorID = RollCallInstructorTeaching.Last().InstructorID;
            //Neu co doi giao vien, doi gia tri field cu, them field moi
            if (NewInstructorID != CurrentInstructorID)
            {
                InstructorTeaching it = RollCallInstructorTeaching.Last(inte => inte.InstructorID == CurrentInstructorID);

                //Neu nhu doi giao vien sau start date thi ghi log
                //SAU NAY KO CHECK START DATE, CHECK BANG GIA TRI STATUS 0,1,2
                if (DateTime.Today > it.BeginDate)
                {
                    it.EndDate = DateTime.Today.AddDays(-1); //Ngay ket thuc la hom qua
                    
                    InstructorTeaching newIt = new InstructorTeaching();
                    newIt.InstructorID = NewInstructorID;
                    newIt.BeginDate = DateTime.Today;
                    newIt.EndDate = rollcall.EndDate;
                    newIt.RollCallID = rollcall.RollCallID;
                    InsTeaBO.Insert(newIt);
                }
                else
                {
                    //Neu truoc start date, chi doi bt
                    //Neu nhu doi ngay trong ngay, van goi ham nay
                    it.InstructorID = NewInstructorID;
                }
            }

            return Update(rollcall);
        }


        public bool Insert(RollCall InRollCall, int InstructorID)
        {
            SubjectBusiness SubBO = new SubjectBusiness(this.RollSystemDB);
            ClassBusiness ClassBO = new ClassBusiness(this.RollSystemDB);

            RollCall rollcall = InRollCall;
            //Set thoi gian EndTime, dua vao start time
            var rollSubject = SubBO.GetSubjectByID(InRollCall.SubjectID);
            rollcall.EndTime = rollcall.StartTime.Add(TimeSpan.FromMinutes(45 * rollSubject.NumberOfSlot));

            //VD: 20 slot se la 28 ngay. 15 slot la 21 ngay, 18 slot van 28 ngay
            int TotalDate = (int)Math.Ceiling((double)rollSubject.NumberOfSession / 5) * 7;
            //Tru 1 ngay de ket thuc vao chu nhat
            rollcall.EndDate = rollcall.BeginDate.AddDays(TotalDate).AddDays(-1);

            //Dua toan bo hoc sinh hien tai cua class vao
            var rollClass = ClassBO.GetClassByID(InRollCall.ClassID);
            foreach (var Student in rollClass.Students)
            {
                rollcall.Students.Add(Student);
            }

            // Them 1 truong vao bang instructor teaching
            InstructorTeaching it = new InstructorTeaching();
            it.InstructorID = InstructorID;
            it.BeginDate = rollcall.BeginDate;
            it.EndDate = rollcall.EndDate;
            rollcall.InstructorTeachings.Add(it);
            rollcall.Status = 0;

           return base.Insert(rollcall);
        }


        public List<String> ValidRollCall(RollCall InRollCall)
        {
            SubjectBusiness SubBO = new SubjectBusiness(this.RollSystemDB);
            ClassBusiness ClassBO = new ClassBusiness(this.RollSystemDB);
            List<string> ErrorList = new List<string>();

            var rollSubject = SubBO.GetSubjectByID(InRollCall.SubjectID);
            //Check may cai nhu gio hoc, giao vien dang day v...v trong nay
            if ((InRollCall.StartTime.ToString(@"hh\:mm") == "10:45:"
                || InRollCall.StartTime.ToString(@"hh\:mm") == "16:00") &&
            rollSubject.NumberOfSlot == 2)
            {
                ErrorList.Add("Mon nay 2 slot, gio nay ko phu hop");
            }

            //Check thu xem class cua roll call nay co dang hoc roll call nao ko


            //Check xem giao vien roll call nay co dang day roll call nao cung gio ko


            //Nho check luon, start date va end date cua roll call so voi semester
            return ErrorList;
        }





        public void CreateRollCallBook(int RollCallID, String FileName)
        {
            //Tao 1 roll call book rong
            ExcelPackage Package = CreateRollCallBookPackage(RollCallID);
            ExcelWriter.WriteExcelFile(Package, FileName);
            Package.Dispose();

        }

        public void CreateRollCallReport(int RollCallID, String FileName)
        {
            //Tao 1 roll call book rong
            ExcelPackage Package = CreateRollCallBookPackage(RollCallID);
            ExcelWorksheet Worksheet = Package.Workbook.Worksheets[1];

            //Bat dau dien info vao roll call book do
            RollCall RollCall = GetRollCallByID(RollCallID);
            var Students = RollCall.Students.ToList();

            AttendanceBusiness BO = new AttendanceBusiness();
            var AttendanceLogs = BO.GetRollCallAttendanceLog(RollCallID);

            for (int i = 0; i < 30; i++)
            {
                int RowIndex = 11 + i;
                if (i < Students.Count)
                {
                    Student CurrentStudent = Students.ElementAt(i);
                    //Moi hang la 1 sinh vien, cu co log thi danh dau
                    for (int logIndex = 0; logIndex < AttendanceLogs.Count; logIndex++)
                    {
                        var AttendanceLog = AttendanceLogs.ElementAt(logIndex);
                        if (AttendanceLog.StudentAttendances.
                            Any(sa => sa.StudentID == CurrentStudent.StudentID &&
                            sa.IsPresent == true))
                        {
                            //Danh dau chu X vao o
                            Worksheet.Cells[RowIndex, logIndex + 4].Value = "X";
                        }
                    }
                }
            }
            //Tinh so sinh vien di hoc
            Worksheet.Cells[41, 4, 41, 4 + AttendanceLogs.Count - 1].Formula = "COUNTIF(D11:D40,\"X\")";

            /*
            TimeSpan TotalDate = RollCall.EndDate - RollCall.BeginDate;
            int NumberOfSlot = (int)Math.Ceiling((double)TotalDate.Days/ 7) * 5; //1 tuan 7 ngay hoc 5 buoi
            */
            int NumberOfSlot = RollCall.Subject.NumberOfSession;
            int FinalColumnIndex = 4 + NumberOfSlot;

            //Tinh % di hoc cua moi SV
            String Formula = "COUNTIF(D11:" + ExcelReader.NumberToText(3 + NumberOfSlot) + "11, \"X\")/" + NumberOfSlot;
            Worksheet.Cells[11, FinalColumnIndex, 11 + Students.Count - 1, FinalColumnIndex].Formula = Formula;

            ExcelWriter.WriteExcelFile(Package, FileName);
            Package.Dispose();
        }

        private ExcelPackage CreateRollCallBookPackage(int RollCallID)
        {
            ExcelPackage Package = new ExcelPackage();
            RollCall RollCall = GetRollCallByID(RollCallID);
            String SheetName = RollCall.Class.ClassName + "_" + RollCall.Subject.ShortName;
            int NumberOfSlot = RollCall.Subject.NumberOfSession;

            ExcelWorksheet Worksheet = Package.Workbook.Worksheets.Add(SheetName);
            //Set chieu ngang cac cot
            Worksheet.Cells["A:XFD"].Style.Font.Name = "Arial";
            Worksheet.Column(1).Width = 4.5;
            Worksheet.Column(2).Width = 15.5;
            Worksheet.Column(3).Width = 27.5;
            Worksheet.Column(5).Width = 11.5;
            Worksheet.Column(6).Width = 4.5;



            Worksheet.Cells["E1"].Value = "Roll Call Book";
            Worksheet.Cells["E1"].Style.Font.Size = 18;
            Worksheet.Cells["E1"].Style.Font.Bold = true;

            Worksheet.Cells["E2"].Value = "Semester: ";
            Worksheet.Cells["E3"].Value = "Class: ";
            Worksheet.Cells["E4"].Value = "Subject: ";
            Worksheet.Cells["E5"].Value = "Session: ";
            Worksheet.Cells["E6"].Value = "Time: ";
            Worksheet.Cells["E7"].Value = "Date: ";
            Worksheet.Cells["E8"].Value = "Instructor: ";

            //Merge tu G toi K de show
            for (int i = 2; i <= 7; i++)
            {
                Worksheet.Cells["G" + i + ":K" + i].Merge = true;
            }
            Worksheet.Cells["G2"].Value = RollCall.Semester.SemesterName;
            Worksheet.Cells["G3"].Value = RollCall.Class.ClassName;
            Worksheet.Cells["G4"].Value = RollCall.Subject.ShortName;
            Worksheet.Cells["G5"].Value = NumberOfSlot;
            Worksheet.Cells["G6"].Value = String.Format("{0} - {1}",
                RollCall.StartTime.ToString(@"hh\:mm"), RollCall.EndTime.ToString(@"hh\:mm"));
            Worksheet.Cells["G7"].Value = String.Format("{0} to {1}",
                RollCall.BeginDate.ToString("dd-MM-yyyy"), RollCall.EndDate.ToString("dd-MM-yyyy"));
            Worksheet.Cells["G8"].Value = RollCall.InstructorTeachings.ToList().Last().Instructor.Fullname;

            //Set size cho cac ki tu con lai
            Worksheet.Cells["E2:K8"].Style.Font.Size = 12;
            Worksheet.Cells["E2:K8"].Style.Font.Bold = true;

            //Bat dau ghi tu o A10
            Worksheet.Cells["A10"].Value = "No.";
            Worksheet.Cells["B10"].Value = "Student Code";
            Worksheet.Cells["C10"].Value = "Student Name";

            //Ghi danh sach cac student, ten
            var Students = RollCall.Students.ToList();
            for (int i = 0; i < 30; i++)
            {
                int RowIndex = 11 + i;
                Worksheet.Cells["A" + RowIndex].Value = i + 1;
                if (i < Students.Count)
                {
                    Worksheet.Cells["B" + RowIndex].Value = Students.ElementAt(i).StudentCode;
                    Worksheet.Cells["B" + RowIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    Worksheet.Cells["C" + RowIndex].Value = Students.ElementAt(i).FullName;
                }
            }

            /*
            TimeSpan TotalDate = RollCall.EndDate - RollCall.BeginDate;
            int NumberOfSlot = (int)Math.Ceiling((double)TotalDate.Days /  7) * 5;  //1 tuan 7 ngay hoc 5 buoi
            */

           
            int FinalColumnIndex = 4 + NumberOfSlot;
            //Bat dau ke o tu Cell[4,10]


            //Bau dau ve khung
            for (int column = 1; column <= FinalColumnIndex; column++)
            {
                for (int row = 10; row <= 30 + 10 + 1; row++)
                {
                    Worksheet.Cells[row, column].Style.Border.BorderAround(ExcelBorderStyle.Thin, Color.Black);
                }
            }

            //Join 5 ngay lai thanh 1 tuan
            int WeekIndex = 1;
            for (int i = 4; i < FinalColumnIndex; i += 5)
            {
                Worksheet.Cells[10, i, 10, i + 4].Merge = true;
                Worksheet.Cells[10, i].Value = "Week " + WeekIndex;
                WeekIndex++;
            }

            //Set lai gia tri width cua cac cot diem danh
            for (int i = 4; i < FinalColumnIndex; i++)
            {
                Worksheet.Column(i).Width = 6;
            }
            Worksheet.Column(FinalColumnIndex).Width = 10;

            //Format header cua bang
            Worksheet.Cells[10, 1, 10, FinalColumnIndex].Style.Font.Bold = true;
            Worksheet.Cells[10, 1, 10, FinalColumnIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

            //Format ten hoc sinh
            Worksheet.Cells[11, 1, 11 + 30, FinalColumnIndex].Style.Font.Name = "Times New Roman";
            //Tao them hang cuoi
            Worksheet.Cells["A41:C41"].Merge = true;
            Worksheet.Cells["A41"].Value = "Total Present Student: ";
            Worksheet.Cells["A41"].Style.Font.Bold = true;
            Worksheet.Cells["A41"].Style.Font.Name = "Arial";
            Worksheet.Cells["A41"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

            //Tao them 1 hang Percent
            Worksheet.Cells[9, FinalColumnIndex].Value = "X = Present";
            Worksheet.Cells[9, FinalColumnIndex].Style.Font.Name = "Times New Roman";
            Worksheet.Cells[10, FinalColumnIndex].Value = "Percent";
            Worksheet.Cells[11, FinalColumnIndex, 31, FinalColumnIndex].Style.Numberformat.Format = "0.00%";
            return Package;
        }

    }
}