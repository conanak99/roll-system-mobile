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
    public class RollCallBusiness : GenericBusiness<RollCall>
    {

        public RollCallBusiness()
        {

        }

        public RollCallBusiness(RSMEntities DB)
            : base(DB)
        {

        }


        public List<RollCall> GetInstructorCurrentRollCalls(int InstructorID)
        {
            DateTime Today = DateTime.Now;
            StudySessionBusiness StuSesBO = new StudySessionBusiness(this.RollSystemDB);


            var TodaySession = StuSesBO.GetInstructorCurrentSession(InstructorID);
            if (TodaySession == null)
            {
                return null;
            }
            else
            {
                var TodayRollCall = StuSesBO.GetInstructorFutureSession(InstructorID).Select(s => s.RollCall).Distinct().ToList();
                foreach (var RollCall in TodayRollCall)
                {
                    StudySession TdSes = TodaySession.FirstOrDefault(ss => ss.RollCallID == RollCall.RollCallID);
                    //Set lai thoi gian
                    if (TdSes != null)
                    {
                        RollCall.StartTime = TdSes.StartTime;
                        RollCall.EndTime = TdSes.EndTime;
                    }
                    else
                    {
                        //Neu ngay hom nay ko day, set thoi gian bang 0
                        RollCall.StartTime = new TimeSpan(0, 0, 0);
                        RollCall.EndTime = new TimeSpan(0, 0, 0);
                    }
                    
                }
                return TodayRollCall.OrderBy(r => r.StartTime).ToList();
            }
        }


        public List<RollCall> GetInstructorFutureRollCalls(int InstructorID)
        {
            DateTime Today = DateTime.Now;
            StudySessionBusiness StuSesBO = new StudySessionBusiness(this.RollSystemDB);

            var TodaySession = StuSesBO.GetInstructorFutureSession(InstructorID);
            return TodaySession.Select(ss => ss.RollCall).Distinct().ToList();

        }

        public RollCall GetRollCallByID(int ID)
        {
            return base.GetList().FirstOrDefault(r => r.RollCallID == ID);
        }



        public bool Delete(RollCall Rollcall)
        {
            foreach (var Session in Rollcall.StudySessions.ToList())
            {
                Rollcall.StudySessions.Remove(Session);
            }

            foreach (var Student in Rollcall.Students.ToList())
            {
                Rollcall.Students.Remove(Student);
            }

            return base.Delete(Rollcall);
        }

        public bool Update(RollCall InRollCall)
        {
            StudySessionBusiness StuSesBO = new StudySessionBusiness(this.RollSystemDB);
            //Ko cho sua lop, chi cho sua instructor, thoi gian, ngay thang
            RollCall rollCall = GetRollCallByID(InRollCall.RollCallID);

            //Doi giao vien va thoi gian
            rollCall.InstructorID = InRollCall.InstructorID;
            rollCall.StartTime = InRollCall.StartTime;
            rollCall.EndTime = rollCall.StartTime.
                Add(TimeSpan.FromMinutes(90 * rollCall.Subject.NumberOfSlot)).
                Add(TimeSpan.FromMinutes(15 * (rollCall.Subject.NumberOfSlot - 1)));

            //Doi ngay thang
            rollCall.BeginDate = InRollCall.BeginDate;
            //VD: 20 slot se la 28 ngay. 15 slot la 21 ngay, 18 slot van 28 ngay
            int TotalDate = (int)Math.Ceiling((double)rollCall.Subject.NumberOfSession / 5) * 7;
            //Tru 1 ngay de ket thuc vao chu nhat
            rollCall.EndDate = rollCall.BeginDate.AddDays(TotalDate).AddDays(-1);


            //Xoa het studysesion cu
            foreach (var Session in rollCall.StudySessions.ToList())
            {
                rollCall.StudySessions.Remove(Session);
                StuSesBO.Delete(Session);
            }

            //Them studysession moi
            DateTime SessionDate = rollCall.BeginDate;
            for (int i = 0; i < rollCall.Subject.NumberOfSession; i++)
            {
                StudySession StuSes = new StudySession()
                {
                    InstructorID = rollCall.InstructorID,
                    ClassID = rollCall.ClassID,
                    StartTime = rollCall.StartTime,
                    EndTime = rollCall.EndTime,
                    SessionDate = SessionDate
                };
                rollCall.StudySessions.Add(StuSes);
                do
                {
                    SessionDate = SessionDate.AddDays(1);
                } while (SessionDate.DayOfWeek == DayOfWeek.Saturday || SessionDate.DayOfWeek == DayOfWeek.Sunday);
            }
            base.Detach(rollCall);
            return base.Update(rollCall);
        }




        public bool Insert(RollCall InRollCall)
        {
            SubjectBusiness SubBO = new SubjectBusiness(this.RollSystemDB);
            ClassBusiness ClassBO = new ClassBusiness(this.RollSystemDB);

            RollCall rollcall = InRollCall;
            //Set thoi gian EndTime, dua vao start time
            var rollSubject = SubBO.GetSubjectByID(InRollCall.SubjectID);
            rollcall.EndTime = rollcall.StartTime.
                Add(TimeSpan.FromMinutes(90 * rollSubject.NumberOfSlot)).
                Add(TimeSpan.FromMinutes(15 * (rollSubject.NumberOfSlot - 1)));

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

            //Tao cac studying session cua roll call nay
            DateTime SessionDate = rollcall.BeginDate;
            for (int i = 0; i < rollSubject.NumberOfSession; i++)
            {
                StudySession StuSes = new StudySession()
                    {
                        InstructorID = InRollCall.InstructorID,
                        ClassID = rollcall.ClassID,
                        StartTime = rollcall.StartTime,
                        EndTime = rollcall.EndTime,
                        SessionDate = SessionDate
                    };
                rollcall.StudySessions.Add(StuSes);
                do
                {
                    SessionDate = SessionDate.AddDays(1);
                } while (SessionDate.DayOfWeek == DayOfWeek.Saturday || SessionDate.DayOfWeek == DayOfWeek.Sunday);
            }

            return base.Insert(rollcall);
        }


        public List<String> ValidRollCall(RollCall InRollCall, TimeSpan? otherTime)
        {
            SubjectBusiness SubBO = new SubjectBusiness(this.RollSystemDB);
            ClassBusiness ClassBO = new ClassBusiness(this.RollSystemDB);
            RollCallBusiness RcBO = new RollCallBusiness(this.RollSystemDB);
            List<string> ErrorList = new List<string>();

            var rollSubject = SubBO.GetSubjectByID(InRollCall.SubjectID);
            //Check may cai nhu gio hoc, giao vien dang day v...v trong nay
            if ((InRollCall.StartTime.ToString(@"hh\:mm") == "10:30"
                || InRollCall.StartTime.ToString(@"hh\:mm") == "16:00") &&
            rollSubject.NumberOfSlot == 2)
            {
                ErrorList.Add("Mon nay 2 slot, gio nay ko phu hop");
            }

            //Check thu xem class cua roll call nay co dang hoc roll call nao ko
            List<RollCall> ClassRcList = RcBO.GetList().Where(r => r.ClassID == InRollCall.ClassID).ToList();
            Boolean Classflag = true;
            foreach (var item in ClassRcList)
            {
                if (otherTime.ToString() != "")
                {
                    InRollCall.StartTime = TimeSpan.Parse(otherTime.ToString());
                }
                if (item.StartTime == InRollCall.StartTime  && InRollCall.BeginDate <= InRollCall.BeginDate && InRollCall.BeginDate <= item.EndDate)
                {
                    Classflag = false;
                }
            }
            if (Classflag == false)
            {
                ErrorList.Add("class");
            }
            //Check xem giao vien roll call nay co dang day roll call nao cung gio ko
            Boolean Insflag = true;
            List<RollCall> InsRcList = RcBO.GetList().Where(r => r.InstructorID == InRollCall.InstructorID).ToList();
            foreach (var item in InsRcList)
            {   
                if (item.StartTime == otherTime && item.BeginDate < InRollCall.BeginDate && InRollCall.BeginDate < item.EndDate)
                {
                    Insflag = false;
                }
            }
            if (Insflag == false)
            {
                ErrorList.Add("instructor");
            }

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

            int NumberOfSlot = RollCall.StudySessions.Count; //RollCall.Subject.NumberOfSession;
            //Lam tron number of slot, vd 17,18 thanh 20
            NumberOfSlot = (int)Math.Ceiling((double)NumberOfSlot / 5) * 5;
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
            int NumberOfSlot = RollCall.StudySessions.Count; //RollCall.Subject.NumberOfSession;

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
            Worksheet.Cells["G5"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
            Worksheet.Cells["G6"].Value = String.Format("{0} - {1}",
                RollCall.StartTime.ToString(@"hh\:mm"), RollCall.EndTime.ToString(@"hh\:mm"));
            Worksheet.Cells["G7"].Value = String.Format("{0} to {1}",
                RollCall.BeginDate.ToString("dd-MM-yyyy"), RollCall.EndDate.ToString("dd-MM-yyyy"));
            Worksheet.Cells["G8"].Value = RollCall.Instructor.Fullname;

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

            //Lam tron number of slot, vd 17,18 thanh 20
            NumberOfSlot = (int)Math.Ceiling((double)NumberOfSlot / 5) * 5;


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