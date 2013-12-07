using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OfficeOpenXml;
using System.Drawing;
using OfficeOpenXml.Style;
using RollSystemMobile.Models.BindingModels;
using RollSystemMobile.Models.HelperClass;
namespace RollSystemMobile.Models.BusinessObject
{
    public class StudentBusiness : GenericBusiness<Student>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public StudentBusiness()
        {

        }
        public StudentBusiness(RSMEntities DB)
            : base(DB)
        {

        }
        public List<Student> GetAllStudents()
        {
            return base.GetList();
        }

        public List<Student> GetActiveStudents()
        {
            return base.GetList().Where(c => c.IsActive).ToList();
        }

        public List<Student> GetStudentInClass(int ClassID)
        {
            return base.GetList().Where(s => s.ClassID == ClassID && s.IsActive).ToList();
        }

        public Student GetStudentByID(int StudentID)
        {
            return base.GetList().SingleOrDefault(s => s.StudentID == StudentID);
        }

        public List<Student> GetStudentsNotInRollCall(int RollCallID)
        {
            return base.GetList().Where(s => !s.RollCalls.Any(d => d.RollCallID == RollCallID)).
                OrderBy(s => s.StudentID).ToList();
        }

        public Student GetStudentByUserID(int UserID)
        {
            return base.FindSingle(st => st.UserID == UserID);
        }
        public List<RollCall> GetRollCallsOfStudent(int StudentID)
        {
            var stu = base.GetList().SingleOrDefault(s => s.StudentID == StudentID);
            return stu.RollCalls.ToList();
        }

        public void CreateStudentReport(int StudentID, int SemesterID, String FileName)
        {

            //Tao 1 roll call book rong
            ExcelPackage Package = new ExcelPackage();

            ExcelWorksheet GeneralWorksheet = CreateGeneralWorksheet(StudentID, SemesterID);
            Package.Workbook.Worksheets.Add(GeneralWorksheet.Name, GeneralWorksheet);

            var stu = new StudentBusiness().GetStudentByID(StudentID);
            var rollcalls = stu.RollCalls.Where(rc => rc.SemesterID == SemesterID).ToList();
            foreach(var rollcall in rollcalls)
            {
                //Tao sheet
                ExcelWorksheet RollWorkSheet = CreateDetailWorksheet(StudentID, rollcall.RollCallID);
                Package.Workbook.Worksheets.Add(RollWorkSheet.Name, RollWorkSheet);
            }
            
            ExcelWriter.WriteExcelFile(Package, FileName);
            Package.Dispose();
        }


        private ExcelWorksheet CreateGeneralWorksheet(int StudentID, int SemesterID)
        {
            ExcelWorksheet GeneralWorksheet = new ExcelPackage().Workbook.Worksheets.Add("General Report");
            Student stu = GetStudentByID(StudentID);
            String studentName = stu.FullName;
            String studentCode = stu.StudentCode;
            String cls = stu.Class.ClassName;
            int studentID = stu.StudentID;
            SemesterBusiness sem = new SemesterBusiness();
            String semesterName = sem.GetSemesterByID(SemesterID).SemesterName;

            GeneralWorksheet.Cells["A:XFD"].Style.Font.Name = "Arial";
            GeneralWorksheet.Cells["C2"].Value = "Attendance Report";
            GeneralWorksheet.Cells["C2"].Style.Font.Size = 18;
            GeneralWorksheet.Cells["C2"].Style.Font.Bold = true;

            //semester detail
            GeneralWorksheet.Cells["C3"].Value = "Student Name";
            GeneralWorksheet.Cells["C4"].Value = "Student Code";
            GeneralWorksheet.Cells["C5"].Value = "Class";
            GeneralWorksheet.Cells["C6"].Value = "Semester";

            GeneralWorksheet.Cells["C3:C6"].Style.Font.Size = 12;
            GeneralWorksheet.Cells["C3:C6"].Style.Font.Bold = true;

            GeneralWorksheet.Cells["D3"].Value = studentName;
            GeneralWorksheet.Cells["D4"].Value = studentCode;
            GeneralWorksheet.Cells["D5"].Value = cls;
            GeneralWorksheet.Cells["D6"].Value = semesterName;

            //title table
            GeneralWorksheet.Cells["B8"].Value = "No.";
            GeneralWorksheet.Cells["C8"].Value = "Subject";
            GeneralWorksheet.Cells["D8"].Value = "Date";
            GeneralWorksheet.Cells["E8"].Value = "Absent Rate";
            GeneralWorksheet.Cells["F8"].Value = "Note";
            GeneralWorksheet.Cells["B8:F8"].Style.Font.Size = 12;
            GeneralWorksheet.Cells["B8:F8"].Style.Font.Bold = true;

            var rollcalls = stu.RollCalls.Where(rc => rc.SemesterID == SemesterID).ToList();
            RollSystemMobile.Models.BusinessObject.AttendanceBusiness AttendBO = new RollSystemMobile.Models.BusinessObject.AttendanceBusiness();
            for (int i = 0; i < rollcalls.Count(); i++)
            {
                int RowIndex = 9 + i;
                GeneralWorksheet.Cells["B" + RowIndex].Value = i + 1;
                GeneralWorksheet.Cells["C" + RowIndex].Value = rollcalls.ElementAt(i).Subject.FullName;
                GeneralWorksheet.Cells["D" + RowIndex].Value = "From "+rollcalls.ElementAt(i).BeginDate.ToString("dd-MM-yyyy") + " to " + rollcalls.ElementAt(i).EndDate.ToString("dd-MM-yyyy");
                //Dien thong tin
                double Percent = AttendBO.GetStudentAbsentRate(studentID, rollcalls.ElementAt(i).RollCallID);
                GeneralWorksheet.Cells["E" + RowIndex].Value = String.Format("{0:0}%", Percent);
                GeneralWorksheet.Cells["E" + RowIndex].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                if (Percent > 20)
                {
                    GeneralWorksheet.Cells["F" + RowIndex].Value = "Cam thi";
                    GeneralWorksheet.Cells["B"+i+":F"+i].Style.Font.Color.SetColor(Color.Red);
                }
            }
            
            //set border table
            for (int column = 2; column <= 6; column++)
            {
                for (int row = 8; row <= 8 + rollcalls.Count(); row++)
                {
                    GeneralWorksheet.Cells[row, column].Style.Border.BorderAround(ExcelBorderStyle.Thin, Color.Black);
                }
            }
            //set height , width
            GeneralWorksheet.Cells["C2:D2"].Merge = true;
            GeneralWorksheet.Cells["C2:D2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
            GeneralWorksheet.Column(2).Width = 5;
            GeneralWorksheet.Column(3).Width = 30;
            GeneralWorksheet.Column(4).Width = 30;
            GeneralWorksheet.Column(5).Width = 16;
            return GeneralWorksheet;
        }

        private ExcelWorksheet CreateDetailWorksheet(int StudentID, int RollCallID)
        {
            RollCallBusiness RollBO = new RollCallBusiness();

            var rollCall = RollBO.GetRollCallByID(RollCallID);

            StudentBusiness StuBO = new StudentBusiness();

            var student = StuBO.GetStudentByID(StudentID);

            AttendanceBusiness AttenBO = new AttendanceBusiness();
            List<AttendanceLog> RollCallLogs = AttenBO.GetRollCallAttendanceLog(RollCallID);
            var StudentAttendances = student.StudentAttendances.Where(sa => sa.AttendanceLog.RollCallID == RollCallID
                && RollCallLogs.Select(r => r.LogID).Contains(sa.LogID))
                .OrderBy(sa => sa.AttendanceLog.LogDate).ToList();

            ExcelWorksheet DetailWorkSheet = new ExcelPackage().
                Workbook.Worksheets.Add(rollCall.Subject.ShortName + "_" + rollCall.BeginDate.ToString("dd-MM-yyyy"));

            int Absent = StudentAttendances.Count(sa => !sa.IsPresent);
               double AbsentRate = (double)Absent / rollCall.StudySessions.Count * 100;

               DetailWorkSheet.Cells["A:XFD"].Style.Font.Name = "Arial";
            DetailWorkSheet.Cells["C2"].Value = "Attendance Report Detail";
            DetailWorkSheet.Cells["C2"].Style.Font.Size = 18;
            DetailWorkSheet.Cells["C2"].Style.Font.Bold = true;

            //student detail
            DetailWorkSheet.Cells["C3"].Value = "Subject";
            DetailWorkSheet.Cells["C4"].Value = "Date";
            DetailWorkSheet.Cells["C5"].Value = "Instructor";
            DetailWorkSheet.Cells["C6"].Value = "Total Session";
            DetailWorkSheet.Cells["C7"].Value = "Completed Session";
            DetailWorkSheet.Cells["C8"].Value = "Absent";
            DetailWorkSheet.Cells["C9"].Value = "Absent Rate";

            DetailWorkSheet.Cells["C3:C9"].Style.Font.Size = 12;
            DetailWorkSheet.Cells["C3:C9"].Style.Font.Bold = true;

            DetailWorkSheet.Cells["D3"].Value = rollCall.Subject.FullName;
            DetailWorkSheet.Cells["D4"].Value = "From " + rollCall.BeginDate.ToString("dd-MM-yyyy") + " to " + rollCall.EndDate.ToString("dd-MM-yyyy");
            DetailWorkSheet.Cells["D5"].Value = rollCall.Instructor.Fullname;
            DetailWorkSheet.Cells["D6"].Value = rollCall.Subject.NumberOfSession;
            DetailWorkSheet.Cells["D7"].Value = StudentAttendances.Count();
            DetailWorkSheet.Cells["D8"].Value = Absent;
            DetailWorkSheet.Cells["D9"].Value = String.Format("{0:0}%", AbsentRate);

            DetailWorkSheet.Cells["D6:D9"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;

            //title table
            DetailWorkSheet.Cells["B11"].Value = "No.";
            DetailWorkSheet.Cells["C11"].Value = "Date";
            DetailWorkSheet.Cells["D11"].Value = "Present";
            DetailWorkSheet.Cells["E11"].Value = "Note";
            DetailWorkSheet.Cells["B11:E11"].Style.Font.Size = 12;
            DetailWorkSheet.Cells["B11:E11"].Style.Font.Bold = true;

            
            for (int i = 0; i < StudentAttendances.Count(); i++)
            {
                int RowIndex = 12 + i;
                DetailWorkSheet.Cells["B" + RowIndex].Value = i + 1;
                DetailWorkSheet.Cells["C" + RowIndex].Value = StudentAttendances.ElementAt(i).AttendanceLog.LogDate.ToString("dd-MM-yyyy");
                if(StudentAttendances.ElementAt(i).IsPresent)
                {
                    DetailWorkSheet.Cells["D" + RowIndex].Value = "Present";
                }else
                {
                    DetailWorkSheet.Cells["D" + RowIndex].Value = "Absent";
                    DetailWorkSheet.Cells["D" + RowIndex].Style.Font.Bold = true;
                }
                DetailWorkSheet.Cells["E" + RowIndex].Value = StudentAttendances.ElementAt(i).Note;
            }
            //set border table
            for (int column = 2; column <= 5; column++)
            {
                for (int row = 11; row <= 11 + StudentAttendances.Count(); row++)
                {
                    DetailWorkSheet.Cells[row, column].Style.Border.BorderAround(ExcelBorderStyle.Thin, Color.Black);
                }
            }
            //set height , width
            DetailWorkSheet.Cells["C2:D2"].Merge = true;
            DetailWorkSheet.Cells["C2:D2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
            DetailWorkSheet.Column(2).Width = 5;
            DetailWorkSheet.Column(3).Width = 30;
            DetailWorkSheet.Column(4).Width = 30;
            DetailWorkSheet.Column(5).Width = 20;
            return DetailWorkSheet;
        }
    }
}