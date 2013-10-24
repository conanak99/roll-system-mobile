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
            var YesterdaySession = StuSesBO.GetInstructorYesterdaySession(InstructorID);
            if (TodaySession == null && YesterdaySession == null)
            {
                return null;
            }
            else
            {

                var TodayRollCall = TodaySession.Select(s => s.RollCall).ToList();
                foreach (var RollCall in TodayRollCall)
                {
                    StudySession TdSes = TodaySession.FirstOrDefault(ss => ss.RollCallID == RollCall.RollCallID);
                    //Set lai thoi gian
                    RollCall.StartTime = TdSes.StartTime;
                    RollCall.EndTime = TdSes.EndTime;
                }

                //Nhung mon hom qua co nhung hom nay ko co
                foreach (var RollCall in YesterdaySession.Select(s => s.RollCall).ToList())
                {
                    if (TodayRollCall == null)
                    {
                        TodayRollCall = new List<RollCall>();
                    }
                    if (!TodayRollCall.Any(roll => roll.RollCallID == RollCall.RollCallID))
                    {
                        RollCall.StartTime = new TimeSpan(0, 0, 0);
                        RollCall.EndTime = new TimeSpan(0, 0, 0);
                        TodayRollCall.Add(RollCall);
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
                if (item.StartTime == InRollCall.StartTime && InRollCall.BeginDate <= InRollCall.BeginDate && InRollCall.BeginDate <= item.EndDate)
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
            ExcelPackage Package = new ExcelPackage();
            ExcelWorksheet RollCallWorksheet = FilledRollCallWorksheet(RollCallID);
            ExcelWorksheet ExamListWorksheet = FilledExamListWorksheet(RollCallID);

            Package.Workbook.Worksheets.Add(RollCallWorksheet.Name, RollCallWorksheet);
            Package.Workbook.Worksheets.Add(ExamListWorksheet.Name, ExamListWorksheet);

            ExcelWriter.WriteExcelFile(Package, FileName);
            Package.Dispose();
        }

        //Lam may cai: Tim RollCall nam trong khoang ngay bao nhieu, toi bao nhieu
        //Xuat ra danh sach SV du thi, so diem danh, ket qua present

        private ExcelWorksheet CreateRollCallWorksheet(int RollCallID)
        {

            RollCall RollCall = GetRollCallByID(RollCallID);
            String SheetName = RollCall.Class.ClassName + "_" + RollCall.Subject.ShortName;
            

            ExcelWorksheet RollCallWorksheet = new ExcelPackage().Workbook.Worksheets.Add(SheetName);

            //Set chieu ngang cac cot
            RollCallWorksheet.Cells["A:XFD"].Style.Font.Name = "Arial";
            RollCallWorksheet.Column(1).Width = 4.5;
            RollCallWorksheet.Column(2).Width = 15.5;
            RollCallWorksheet.Column(3).Width = 27.5;
            RollCallWorksheet.Column(5).Width = 11.5;
            RollCallWorksheet.Column(6).Width = 4.5;



            RollCallWorksheet.Cells["E1"].Value = "Roll Call Book";
            RollCallWorksheet.Cells["E1"].Style.Font.Size = 18;
            RollCallWorksheet.Cells["E1"].Style.Font.Bold = true;

            RollCallWorksheet.Cells["E2"].Value = "Semester: ";
            RollCallWorksheet.Cells["E3"].Value = "Class: ";
            RollCallWorksheet.Cells["E4"].Value = "Subject: ";
            RollCallWorksheet.Cells["E5"].Value = "Session: ";
            RollCallWorksheet.Cells["E6"].Value = "Time: ";
            RollCallWorksheet.Cells["E7"].Value = "Date: ";
            RollCallWorksheet.Cells["E8"].Value = "Instructor: ";

            //Merge tu G toi K de show
            for (int i = 2; i <= 7; i++)
            {
                RollCallWorksheet.Cells["G" + i + ":K" + i].Merge = true;
            }
            RollCallWorksheet.Cells["G2"].Value = RollCall.Semester.SemesterName;
            RollCallWorksheet.Cells["G3"].Value = RollCall.Class.ClassName;
            RollCallWorksheet.Cells["G4"].Value = RollCall.Subject.ShortName;
            RollCallWorksheet.Cells["G5"].Value = RollCall.StudySessions.Count;
            RollCallWorksheet.Cells["G5"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
            RollCallWorksheet.Cells["G6"].Value = String.Format("{0} - {1}",
                RollCall.StartTime.ToString(@"hh\:mm"), RollCall.EndTime.ToString(@"hh\:mm"));
            RollCallWorksheet.Cells["G7"].Value = String.Format("{0} to {1}",
                RollCall.BeginDate.ToString("dd-MM-yyyy"), RollCall.EndDate.ToString("dd-MM-yyyy"));
            RollCallWorksheet.Cells["G8"].Value = RollCall.Instructor.Fullname;

            //Set size cho cac ki tu con lai
            RollCallWorksheet.Cells["E2:K8"].Style.Font.Size = 12;
            RollCallWorksheet.Cells["E2:K8"].Style.Font.Bold = true;

            //Bat dau ghi tu o A10
            RollCallWorksheet.Cells["A10"].Value = "No.";
            RollCallWorksheet.Cells["B10"].Value = "Student Code";
            RollCallWorksheet.Cells["C10"].Value = "Student Name";

            //Ghi danh sach cac student, ten
            var Students = RollCall.Students.ToList();
            for (int i = 0; i < 30; i++)
            {
                int RowIndex = 11 + i;
                RollCallWorksheet.Cells["A" + RowIndex].Value = i + 1;
                if (i < Students.Count)
                {
                    RollCallWorksheet.Cells["B" + RowIndex].Value = Students.ElementAt(i).StudentCode;
                    RollCallWorksheet.Cells["B" + RowIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    RollCallWorksheet.Cells["C" + RowIndex].Value = Students.ElementAt(i).FullName;
                }
            }


            //Lam tron number of slot, vd 17,18 thanh 20
            int NumberOfSlot = RollCall.StudySessions.Count;
            NumberOfSlot = (int)Math.Ceiling((double)NumberOfSlot / 5) * 5;
            int FinalColumnIndex = 4 + NumberOfSlot;

            //Bau dau ve khung
            for (int column = 1; column <= FinalColumnIndex; column++)
            {
                for (int row = 10; row <= 30 + 10 + 1; row++)
                {
                    RollCallWorksheet.Cells[row, column].Style.Border.BorderAround(ExcelBorderStyle.Thin, Color.Black);
                }
            }

            //Join 5 ngay lai thanh 1 tuan
            int WeekIndex = 1;
            for (int i = 4; i < FinalColumnIndex; i += 5)
            {
                RollCallWorksheet.Cells[10, i, 10, i + 4].Merge = true;
                RollCallWorksheet.Cells[10, i].Value = "Week " + WeekIndex;
                WeekIndex++;
            }

            //Set lai gia tri width cua cac cot diem danh
            for (int i = 4; i < FinalColumnIndex; i++)
            {
                RollCallWorksheet.Column(i).Width = 6;
            }
            RollCallWorksheet.Column(FinalColumnIndex).Width = 10;

            //Format header cua bang
            RollCallWorksheet.Cells[10, 1, 10, FinalColumnIndex].Style.Font.Bold = true;
            RollCallWorksheet.Cells[10, 1, 10, FinalColumnIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

            //Format ten hoc sinh
            RollCallWorksheet.Cells[11, 1, 11 + 30, FinalColumnIndex].Style.Font.Name = "Times New Roman";
            //Tao them hang cuoi
            RollCallWorksheet.Cells["A41:C41"].Merge = true;
            RollCallWorksheet.Cells["A41"].Value = "Total Present Student: ";
            RollCallWorksheet.Cells["A41"].Style.Font.Bold = true;
            RollCallWorksheet.Cells["A41"].Style.Font.Name = "Arial";
            RollCallWorksheet.Cells["A41"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

            //Tao them 1 hang Percent
            RollCallWorksheet.Cells[9, FinalColumnIndex].Value = "X = Present";
            RollCallWorksheet.Cells[9, FinalColumnIndex].Style.Font.Name = "Times New Roman";
            RollCallWorksheet.Cells[10, FinalColumnIndex].Value = "Percent";
            RollCallWorksheet.Cells[11, FinalColumnIndex, 31, FinalColumnIndex].Style.Numberformat.Format = "0.00%";

            return RollCallWorksheet;
        }

        private ExcelWorksheet FilledRollCallWorksheet(int RollCallID)
        {
            ExcelWorksheet RollCallWorksheet = CreateRollCallWorksheet(RollCallID);
            //Bat dau dien info vao roll call book do
            RollCall RollCall = GetRollCallByID(RollCallID);
            var Students = RollCall.Students.ToList();

            AttendanceBusiness BO = new AttendanceBusiness();
            var AttendanceLogs = BO.GetRollCallAttendanceLog(RollCallID);

            int NumberOfSlot = RollCall.StudySessions.Count; //RollCall.Subject.NumberOfSession;
            //Lam tron number of slot, vd 17,18 thanh 20
            NumberOfSlot = (int)Math.Ceiling((double)NumberOfSlot / 5) * 5;
            int FinalColumnIndex = 4 + NumberOfSlot;


            for (int i = 0; i < 30; i++)
            {
                int RowIndex = 11 + i;
                if (i < Students.Count)
                {
                    Student CurrentStudent = Students.ElementAt(i);
                    double PresentSession = 0;
                    //Moi hang la 1 sinh vien, cu co log thi danh dau
                    for (int logIndex = 0; logIndex < AttendanceLogs.Count; logIndex++)
                    {
                        var AttendanceLog = AttendanceLogs.ElementAt(logIndex);
                        if (AttendanceLog.StudentAttendances.
                            Any(sa => sa.StudentID == CurrentStudent.StudentID &&
                            sa.IsPresent == true))
                        {
                            //Danh dau chu X vao o
                            RollCallWorksheet.Cells[RowIndex, logIndex + 4].Value = "X";
                            PresentSession++;
                        }
                    }
                    double AttendanceRate = PresentSession / RollCall.StudySessions.Count * 100;
                    RollCallWorksheet.Cells[RowIndex, FinalColumnIndex].Value =
                        String.Format("{0:00.00}%", AttendanceRate);
                }
            }
            //Tinh so sinh vien di hoc
            RollCallWorksheet.Cells[41, 4, 41, 4 + AttendanceLogs.Count - 1].Formula = "COUNTIF(D11:D40,\"X\")";

            return RollCallWorksheet;
        }

        private ExcelWorksheet CreateExamListWorksheet(int RollCallID)
        {
            RollCall RollCall = GetRollCallByID(RollCallID);
            String SheetName = RollCall.Class.ClassName + "_" + RollCall.Subject.ShortName;
            int NumberOfSlot = RollCall.StudySessions.Count; //RollCall.Subject.NumberOfSession;

            //Them Tag danh sach du thi
            ExcelWorksheet ExamListWorksheet = new ExcelPackage().Workbook.Worksheets.Add(SheetName + " - Final Exam");
            //Set chieu ngang cac cot
            ExamListWorksheet.Column(1).Width = 4.5;
            ExamListWorksheet.Column(2).Width = 15.5;
            ExamListWorksheet.Column(3).Width = 25;
            ExamListWorksheet.Column(4).Width = 15.5;
            ExamListWorksheet.Column(5).Width = 10;
            ExamListWorksheet.Column(6).Width = 20;

            //Viet roll call info
            ExamListWorksheet.Cells["A:XFD"].Style.Font.Name = "Arial";
            ExamListWorksheet.Cells["C1"].Value = "Final Exam Student List";
            ExamListWorksheet.Cells["C1"].Style.Font.Size = 18;
            ExamListWorksheet.Cells["C1"].Style.Font.Bold = true;

            ExamListWorksheet.Cells["C2"].Value = "Semester: ";
            ExamListWorksheet.Cells["C3"].Value = "Class: ";
            ExamListWorksheet.Cells["C4"].Value = "Subject: ";

            ExamListWorksheet.Cells["D2"].Value = RollCall.Semester.SemesterName;
            ExamListWorksheet.Cells["D3"].Value = RollCall.Class.ClassName;
            ExamListWorksheet.Cells["D4"].Value = RollCall.Subject.ShortName;

            //Set size cho cac ki tu con lai
            ExamListWorksheet.Cells["C2:D4"].Style.Font.Size = 12;
            ExamListWorksheet.Cells["C2:D4"].Style.Font.Bold = true;

            //Ghi tu A6
            //Bat dau ghi tu o A6
            ExamListWorksheet.Cells["A6"].Value = "No.";
            ExamListWorksheet.Cells["B6"].Value = "Student Code";
            ExamListWorksheet.Cells["C6"].Value = "Student Name";
            ExamListWorksheet.Cells["D6"].Value = "Birthdate";
            ExamListWorksheet.Cells["E6"].Value = "Class";
            ExamListWorksheet.Cells["F6"].Value = "Note";


            //Format Table Header
            ExamListWorksheet.Row(6).Height = 38;
            ExamListWorksheet.Cells["A6:F6"].Style.Font.Bold = true;
            ExamListWorksheet.Cells["A6:F6"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
            ExamListWorksheet.Cells["A6:F6"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;

            //Ghi danh sach cac student, ten
            var Students = RollCall.Students.ToList();
            for (int i = 0; i < Students.Count; i++)
            {
                int RowIndex = 7 + i;
                ExamListWorksheet.Cells["A" + RowIndex].Value = i + 1;
                if (i < Students.Count)
                {
                    ExamListWorksheet.Cells["B" + RowIndex].Value = Students.ElementAt(i).StudentCode;
                    ExamListWorksheet.Cells["C" + RowIndex].Value = Students.ElementAt(i).FullName;
                    ExamListWorksheet.Cells["D" + RowIndex].Value = Students.ElementAt(i).Birthdate.ToString("dd/MM/yyyy");
                    ExamListWorksheet.Cells["E" + RowIndex].Value = Students.ElementAt(i).Class.ClassName;
                    ExamListWorksheet.Cells["F" + RowIndex].Value = "";

                    ExamListWorksheet.Cells["A" + RowIndex + ":F" + RowIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    ExamListWorksheet.Cells["A" + RowIndex + ":F" + RowIndex].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                    ExamListWorksheet.Cells["A" + RowIndex + ":F" + RowIndex].Style.Font.Name = "Times New Roman";
                    ExamListWorksheet.Cells["C" + RowIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                }
                ExamListWorksheet.Row(RowIndex).Height = 25.5;
            }

            for (int column = 1; column <= 6; column++)
            {
                for (int row = 6; row <= 6 + Students.Count; row++)
                {
                    ExamListWorksheet.Cells[row, column].Style.Border.BorderAround(ExcelBorderStyle.Thin, Color.Black);
                }
            }

            return ExamListWorksheet;
        }

        private ExcelWorksheet FilledExamListWorksheet(int RollCallID)
        {
            ExcelWorksheet ExamListWorksheet = CreateExamListWorksheet(RollCallID);

            //Bat dau sua doi info trong cai exam list
            RollCall RollCall = GetRollCallByID(RollCallID);
            AttendanceBusiness BO = new AttendanceBusiness();
            var AttendanceLogs = BO.GetRollCallAttendanceLog(RollCallID);

            int NumberOfSlot = RollCall.StudySessions.Count;
            var Students = RollCall.Students;

            for (int i = 0; i < Students.Count; i++)
            {
                int RowIndex = 7 + i;
                Student CurrentStudent = Students.ElementAt(i);

                double AbsentSession = Students.ElementAt(i).
                        StudentAttendances.Count(sa => AttendanceLogs.Select(rc => rc.LogID)
                        .Contains(sa.AttendanceLog.LogID) && !sa.IsPresent);

                double AbsentRate = AbsentSession / NumberOfSlot * 100;
                //Neu nghi qua 20%
                if (AbsentRate > 20)
                {
                    ExamListWorksheet.Cells[RowIndex, 1, RowIndex, 5].Style.Font.Color.SetColor(Color.Red);
                    ExamListWorksheet.Cells[RowIndex, 1, RowIndex, 5].Style.Font.Strike = true;
                    ExamListWorksheet.Cells[RowIndex, 6].Value = String.Format("Absent Rate: {0:00}%", AbsentRate);
                }
            }


            return ExamListWorksheet;
        }

        public ExcelPackage CreateRollCallBookPackage(int RollCallID)
        {
            ExcelPackage Package = new ExcelPackage();
            
            ExcelWorksheet RollCallWorksheet = CreateRollCallWorksheet(RollCallID);
            ExcelWorksheet ExamListWorksheet = CreateExamListWorksheet(RollCallID);
            Package.Workbook.Worksheets.Add(RollCallWorksheet.Name, RollCallWorksheet);
            Package.Workbook.Worksheets.Add(ExamListWorksheet.Name, ExamListWorksheet);

            return Package;
        }

    }
}