using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;
using OfficeOpenXml;
using System.Drawing;
using OfficeOpenXml.Style;
using RollSystemMobile.Models.HelperClass;
namespace RollSystemMobile.Models.BusinessObject
{
    public class SemesterBusiness : GenericBusiness<Semester>
    {
        public SemesterBusiness()
        {

        }
        public SemesterBusiness(RSMEntities DB)
            : base(DB)
        {

        }
        public bool Insert(Semester smt,String begindate)
        {
          
            Semester semester = smt;
            String[] tmp = begindate.Split('-');
            String bgd = tmp[1] + "-" + tmp[0] + "-" + tmp[2];
            semester.BeginDate = Convert.ToDateTime(bgd);
            TimeSpan duration = new TimeSpan(120, 0, 0, 0);
            semester.EndDate = semester.BeginDate.Add(duration);
            return base.Insert(semester);
        }

        public bool Update(Semester Insmt,String begindate)
        {
            Semester smt = GetSemesterByID(Insmt.SemesterID);
            smt.SemesterName = Insmt.SemesterName;
            String[] tmp = begindate.Split('-');
            String bgd = tmp[1] + "-" + tmp[0] + "-" + tmp[2];
            smt.BeginDate = Convert.ToDateTime(bgd);
            TimeSpan duration = new TimeSpan(120, 0, 0, 0);
            smt.EndDate = Insmt.BeginDate.Add(duration);
            base.Detach(smt);
            return base.Update(smt);
        }

        public Semester GetSemesterByID(int id)
        {
            return base.GetList().SingleOrDefault(c => c.SemesterID == id);
        }
        public void CreateFailStudentReport(int id, String FileName)
        {

            //Tao 1 roll call book rong
            ExcelPackage Package = new ExcelPackage();

            ExcelWorksheet GeneralWorksheet = CreateGeneralWorksheet(id);
            Package.Workbook.Worksheets.Add(GeneralWorksheet.Name, GeneralWorksheet);


            RollCallBusiness rc = new RollCallBusiness();
            SubjectBusiness sub = new SubjectBusiness();
            List<RollCall> rollcalls = new List<RollCall>();
            rollcalls = rc.GetList().Where(r => r.SemesterID == id).ToList();
            List<Subject> subjectlist = new List<Subject>();

            foreach (var rollcall in rollcalls)
            {
                AttendanceBusiness BO = new AttendanceBusiness();
                var AttendanceLogs = BO.GetRollCallAttendanceLog(rollcall.RollCallID);

                int NumberOfSlot = rollcall.StudySessions.Count;
                var Students = rollcall.Students;
                List<int> subj = new List<int>();

                for (int i = 0; i < Students.Count; i++)
                {
                    int RowIndex = 7 + i;
                    Student CurrentStudent = Students.ElementAt(i);

                    double AbsentSession = CurrentStudent.
                            StudentAttendances.Count(sa => AttendanceLogs.Select(a => a.LogID)
                            .Contains(sa.AttendanceLog.LogID) && !sa.IsPresent);

                    double AbsentRate = AbsentSession / NumberOfSlot * 100;
                    //Neu nghi qua 20%
                    if (AbsentRate > 20)
                    {
                        bool checkfailsubject = subj.Exists(r => r == rollcall.SubjectID);
                        if (!checkfailsubject)
                        {
                            subj.Add(rollcall.SubjectID);
                            var subject = sub.GetSubjectByID(rollcall.SubjectID);
                            subjectlist.Add(subject);
                        }
                    }
                }
            }

            foreach (var subject in subjectlist)
            {
                //Tao detail sheet
                ExcelWorksheet RollWorkSheet = CreateDetailWorksheet(subject.SubjectID, id);
                Package.Workbook.Worksheets.Add(RollWorkSheet.Name, RollWorkSheet);
            }
            ExcelWriter.WriteExcelFile(Package, FileName);
            Package.Dispose();
        }
        private ExcelWorksheet CreateGeneralWorksheet(int id)
        {

            ExcelWorksheet GeneralWorksheet = new ExcelPackage().Workbook.Worksheets.Add("General Report");
            GeneralWorksheet.Cells["A:XFD"].Style.Font.Name = "Arial";
            GeneralWorksheet.Cells["C2"].Value = "Fail Student List Report";
            GeneralWorksheet.Cells["C2"].Style.Font.Size = 18;
            GeneralWorksheet.Cells["C2"].Style.Font.Bold = true;

            //get value semester, student, subject
            SemesterBusiness sem = new SemesterBusiness();
            SubjectBusiness sub = new SubjectBusiness();
            String semestername = sem.GetSemesterByID(id).SemesterName;
            String begindate = sem.GetSemesterByID(id).BeginDate.ToString("dd-MM-yyyy");
            String enddate = sem.GetSemesterByID(id).EndDate.ToString("dd-MM-yyyy");

            RollCallBusiness rc = new RollCallBusiness();
            List<RollCall> rollcalls = new List<RollCall>();

            int numsub = 0;
            int numstu = 0;
            int numfstu = 0;

            rollcalls = rc.GetList().Where(r => r.SemesterID == id).ToList();
            List<int> subid = new List<int>();
            List<int> stuid = new List<int>();
            List<int> fstuid = new List<int>();


            // list num student absent for each subject
            List<int> numabsent = new List<int>();

            // list check subject list have student relearn.
            List<int> subj = new List<int>();
            List<Subject> subjectlist = new List<Subject>();


            foreach (var rollcall in rollcalls)
            {
                // check subject is exit in list
                bool checksub = subid.Exists(r => r == rollcall.SubjectID);
                if (!checksub)
                {
                    subid.Add(rollcall.SubjectID);
                    numsub++;
                }

                List<Student> students = new List<Student>();
                students = rollcall.Students.ToList();
                foreach (var student in students)
                {
                    bool checkstu = stuid.Exists(r => r == student.StudentID);
                    if (!checkstu)
                    {
                        stuid.Add(student.StudentID);
                        numstu++;
                    }
                }

                AttendanceBusiness BO = new AttendanceBusiness();
                var AttendanceLogs = BO.GetRollCallAttendanceLog(rollcall.RollCallID);

                int NumberOfSlot = rollcall.StudySessions.Count;
                var Students = rollcall.Students;

                for (int i = 0; i < Students.Count; i++)
                {
                    int RowIndex = 7 + i;
                    Student CurrentStudent = Students.ElementAt(i);

                    double AbsentSession = CurrentStudent.
                            StudentAttendances.Count(sa => AttendanceLogs.Select(a => a.LogID)
                            .Contains(sa.AttendanceLog.LogID) && !sa.IsPresent);

                    double AbsentRate = AbsentSession / NumberOfSlot * 100;
                    //Neu nghi qua 20%
                    if (AbsentRate > 20)
                    {
                        bool checkfstu = fstuid.Exists(r => r == CurrentStudent.StudentID);
                        if (!checkfstu)
                        {
                            fstuid.Add(CurrentStudent.StudentID);
                            numfstu++;
                        }
                        bool checkfailsubject = subj.Exists(r => r == rollcall.SubjectID);
                        if (!checkfailsubject)
                        {
                            subj.Add(rollcall.SubjectID);
                            var subject = sub.GetSubjectByID(rollcall.SubjectID);
                            subjectlist.Add(subject);
                        }
                        numabsent.Add(rollcall.SubjectID);
                    }
                }
            }

            //write file
            GeneralWorksheet.Cells["C2:D2"].Merge = true;
            GeneralWorksheet.Cells["C2:D2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

            GeneralWorksheet.Cells["C3"].Value = "Semester ";
            GeneralWorksheet.Cells["C4"].Value = "Time ";
            GeneralWorksheet.Cells["C5"].Value = "Total subject";
            GeneralWorksheet.Cells["C6"].Value = "Total student";
            GeneralWorksheet.Cells["C7"].Value = "Total fail student";

            GeneralWorksheet.Cells["C3:C7"].Style.Font.Size = 12;
            GeneralWorksheet.Cells["C3:C7"].Style.Font.Bold = true;

            GeneralWorksheet.Cells["D3"].Value = semestername;
            GeneralWorksheet.Cells["D4"].Value = "From " + begindate + " to " + enddate;
            GeneralWorksheet.Cells["D5"].Value = numsub;
            GeneralWorksheet.Cells["D6"].Value = numstu;
            GeneralWorksheet.Cells["D7"].Value = numfstu;

            GeneralWorksheet.Cells["B9"].Value = "No.";
            GeneralWorksheet.Cells["C9"].Value = "Subject";
            GeneralWorksheet.Cells["D9"].Value = "Number of fail student";
            GeneralWorksheet.Cells["B9:D9"].Style.Font.Size = 12;
            GeneralWorksheet.Cells["B9:D9"].Style.Font.Bold = true;

            var subjects = subjectlist;
            for (int i = 0; i < subjects.Count(); i++)
            {
                int RowIndex = 10 + i;
                GeneralWorksheet.Cells["B" + RowIndex].Value = i + 1;
                GeneralWorksheet.Cells["C" + RowIndex].Value = subjects.ElementAt(i).FullName;
                GeneralWorksheet.Cells["D" + RowIndex].Value = numabsent.Count(r => r == subjects.ElementAt(i).SubjectID);
            }

            //set border table
            for (int column = 2; column <= 4; column++)
            {
                for (int row = 9; row <= 9 + subjects.Count(); row++)
                {
                    GeneralWorksheet.Cells[row, column].Style.Border.BorderAround(ExcelBorderStyle.Thin, Color.Black);
                }
            }
            //set height , width
            GeneralWorksheet.Cells["C2:D2"].Merge = true;
            GeneralWorksheet.Cells["C2:D2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

            GeneralWorksheet.Column(2).Width = 8;
            GeneralWorksheet.Column(3).Width = 30;
            GeneralWorksheet.Column(4).Width = 30;

            return GeneralWorksheet;
        }
        private ExcelWorksheet CreateDetailWorksheet(int subjectID, int semesterID)
        {
            SubjectBusiness SuBO = new SubjectBusiness();
            String subshortname = SuBO.GetSubjectByID(subjectID).ShortName;
            ExcelWorksheet DetailWorkSheet = new ExcelPackage().Workbook.Worksheets.Add(subshortname);

            //get value semester, student, subject
            SemesterBusiness sem = new SemesterBusiness();
            SubjectBusiness sub = new SubjectBusiness();
            String semestername = sem.GetSemesterByID(semesterID).SemesterName;
            String subjectname = sub.GetSubjectByID(subjectID).FullName;
            
            // get student list absent > 20%
            RollCallBusiness RoBO = new RollCallBusiness();
            AttendanceBusiness BO = new AttendanceBusiness();
            List<Student> students = new List<Student>();
            List<RollCall> rollcalls = RoBO.GetList().Where(r => r.SubjectID == subjectID && r.SemesterID == semesterID).ToList();
            List<int> studentID = new List<int>();

            foreach (var rollcall in rollcalls)
            {
                var AttendanceLogs = BO.GetRollCallAttendanceLog(rollcall.RollCallID);

                int NumberOfSlot = rollcall.StudySessions.Count;
                var Students = rollcall.Students;

                for (int i = 0; i < Students.Count; i++)
                {
                    int RowIndex = 7 + i;
                    Student CurrentStudent = Students.ElementAt(i);

                    double AbsentSession = CurrentStudent.
                            StudentAttendances.Count(sa => AttendanceLogs.Select(a => a.LogID)
                            .Contains(sa.AttendanceLog.LogID) && !sa.IsPresent);

                    double AbsentRate = AbsentSession / NumberOfSlot * 100;
                    //Neu nghi qua 20%
                    if (AbsentRate > 20)
                    {
                        // check student is exist in list
                        bool checkstuexit = studentID.Exists(r => r == CurrentStudent.StudentID);
                        if (!checkstuexit)
                        {
                            studentID.Add(CurrentStudent.StudentID);
                            students.Add(CurrentStudent);

                        }
                    }
                }
            }
            //write file
            DetailWorkSheet.Cells["A:XFD"].Style.Font.Name = "Arial";
            DetailWorkSheet.Cells["C2"].Value = "Fail Student List Report";
            DetailWorkSheet.Cells["C2"].Style.Font.Size = 18;
            DetailWorkSheet.Cells["C2"].Style.Font.Bold = true;

            //semester detail
            DetailWorkSheet.Cells["C3"].Value = "Semester";
            DetailWorkSheet.Cells["C4"].Value = "Subject";
            
            DetailWorkSheet.Cells["C3:C4"].Style.Font.Size = 12;
            DetailWorkSheet.Cells["C3:C4"].Style.Font.Bold = true;

            DetailWorkSheet.Cells["D3"].Value = semestername;
            DetailWorkSheet.Cells["D4"].Value = subjectname;


            //title table
            DetailWorkSheet.Cells["B6"].Value = "No.";
            DetailWorkSheet.Cells["C6"].Value = "Student Name";
            DetailWorkSheet.Cells["D6"].Value = "Student Code";
            DetailWorkSheet.Cells["E6"].Value = "Class";
            DetailWorkSheet.Cells["B6:E6"].Style.Font.Size = 12;
            DetailWorkSheet.Cells["B6:E6"].Style.Font.Bold = true;

            //body table
            var studentlist = students;
            for (int i = 0; i < studentlist.Count(); i++)
            {
                int RowIndex = 7 + i;
                DetailWorkSheet.Cells["B" + RowIndex].Value = i + 1;
                DetailWorkSheet.Cells["C" + RowIndex].Value = studentlist.ElementAt(i).FullName;
                DetailWorkSheet.Cells["D" + RowIndex].Value = studentlist.ElementAt(i).StudentCode;
                DetailWorkSheet.Cells["E" + RowIndex].Value = studentlist.ElementAt(i).Class.ClassName;
            }
            //set border table
            for (int column = 2; column <= 5; column++)
            {
                for (int row = 6; row <= 6 + studentlist.Count(); row++)
                {
                    DetailWorkSheet.Cells[row, column].Style.Border.BorderAround(ExcelBorderStyle.Thin, Color.Black);
                }
            }
            //set height , width
            DetailWorkSheet.Cells["C2:D2"].Merge = true;
            DetailWorkSheet.Cells["C2:D2"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
            DetailWorkSheet.Column(2).Width = 5;
            DetailWorkSheet.Column(3).Width = 25;
            DetailWorkSheet.Column(4).Width = 25;
            DetailWorkSheet.Column(5).Width = 12;
            return DetailWorkSheet;
        }
    }
}