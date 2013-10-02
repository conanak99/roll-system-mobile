using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class AttendanceBO
    {
        private RSMEntities _db;

        public AttendanceBO()
        {
            _db = new RSMEntities();
        }

        public AttendanceLog WriteAttendanceAutoLog(int RollCallID, List<RecognizerResult> RecognizerResults)
        {
            AttendanceLog Log = null;
            //Tim xem da co log auto cho hom nay chua
            Log = _db.AttendanceLogs.FirstOrDefault(log => log.TypeID == 1
                && log.LogDate == DateTime.Today && log.RollCallID == RollCallID);
            bool LogExist = true;
            if (Log == null)
            {
                Log = new AttendanceLog() {
                    RollCallID = RollCallID,
                    LogDate = DateTime.Today,
                    TypeID = 1 
                };

                LogExist = false;
            }

            //Dua danh sach nhan vao, loc ra ID nhung sinh vien co mat
            HashSet<int> StudentIDs = new HashSet<int>();
            foreach (var result in RecognizerResults)
            {
                foreach (var face in result.FaceList)
                {
                    //ID phai khac -1, moi tinh la nhan duoc
                    if (face.StudentID != -1)
                    {
                        StudentIDs.Add(face.StudentID);
                    }
                }

                //Save hinh cho log, neu hinh da trung thi ko save
                if (!Log.LogImages.Any(image => image.ImageLink.Equals(result.ImageLink)))
                {
                    LogImage LogImg = new LogImage() { ImageLink = result.ImageLink };
                    Log.LogImages.Add(LogImg); 
                }
            }

            //Bat dau danh dau attendance
            foreach (int StudentID in StudentIDs)
            {
                //Neu student chua duoc danh dau trong log moi add vao.
                if (!Log.StudentAttendances.Any(attendace => attendace.StudentID == StudentID))
                {
                    StudentAttendance Attendance = new StudentAttendance()
                    {
                        StudentID = StudentID,
                        IsPresent = true
                    };
                    Log.StudentAttendances.Add(Attendance);
                }
            }

            //Neu log chua co thi them vao, da co thi edit lai
            if (LogExist)
            {
                _db.AttendanceLogs.ApplyCurrentValues(Log);
            }
            else
            {
                _db.AttendanceLogs.AddObject(Log);
            }
            _db.SaveChanges();

            //Tra Log ra de show
            return Log;
        }


        public AttendanceLog WriteAttendanceManualLog(int RollCallID, DateTime Date, List<SingleAttendanceCheck> AttendanceChecks)
        {
            AttendanceLog Log = null;
            //Tim xem da co log manual cho ngay du vao chua
            Log = _db.AttendanceLogs.FirstOrDefault(log => log.TypeID == 2
                && log.LogDate == Date && log.RollCallID == RollCallID);
            bool LogExist = true;
            if (Log == null)
            {
                Log = new AttendanceLog()
                {
                    RollCallID = RollCallID,
                    LogDate = Date,
                    TypeID = 2
                };
                LogExist = false;
            }

            //Bat dau danh dau attendance
            foreach (var AttendanceCheck in AttendanceChecks)
            {
                //Neu student xuat hien trong log moi add vao.
                StudentAttendance Attendance = Log.StudentAttendances.FirstOrDefault(attendace => attendace.StudentID == AttendanceCheck.StudentID);
                if (Attendance == null)
                {
                    Attendance = new StudentAttendance()
                    {
                        StudentID = AttendanceCheck.StudentID,
                        Note = AttendanceCheck.Note,
                        IsPresent = AttendanceCheck.IsPresent
                    };
                    Log.StudentAttendances.Add(Attendance);
                }
                else
                {
                    //Neu da co roi thi chi sua present
                    Attendance.Note = AttendanceCheck.Note;
                    Attendance.IsPresent = AttendanceCheck.IsPresent;
                }
            }

            //Neu log chua co thi them vao, da co thi edit lai
            if (LogExist)
            {
                _db.AttendanceLogs.ApplyCurrentValues(Log);
            }
            else
            {
                _db.AttendanceLogs.AddObject(Log);
            }
            _db.SaveChanges();

            //Tra Log ra de show
            return Log;
        }


        //Ham nay dung hien log attendace hom nay trong tab Auto Attendace trang instructor
        public AttendanceLog GetCurrentAttendanceLog(int RollCallID)
        {
            AttendanceLog Log = null;
            //Tim xem da co uu tien tim log manual
            Log = _db.AttendanceLogs.FirstOrDefault(log => log.TypeID == 2
                && log.LogDate == DateTime.Today && log.RollCallID == RollCallID);
            if (Log == null)
            {
                //Ko co log manual thi tim log auto
                Log = _db.AttendanceLogs.FirstOrDefault(log => log.TypeID == 1
                && log.LogDate == DateTime.Today && log.RollCallID == RollCallID);
            }

            //Neu van ko co log thi xem nhu bang null
            return Log;
        }

        public AttendanceLog GetAttendanceLogAtDate(int RollCallID, DateTime Date)
        {
            AttendanceLog Log = null;
            //Tim xem da co uu tien tim log manual
            Log = _db.AttendanceLogs.FirstOrDefault(log => log.TypeID == 2
                && log.LogDate == Date && log.RollCallID == RollCallID);
            if (Log == null)
            {
                //Ko co log manual thi tim log auto
                Log = _db.AttendanceLogs.FirstOrDefault(log => log.TypeID == 1
                && log.LogDate == Date && log.RollCallID == RollCallID);
            }

            //Neu van ko co log thi xem nhu bang null
            return Log;
        }

        public List<AttendanceLog> GetRollCallAttendanceLog(int RollCallID)
        {
            RollCall RollCall = _db.RollCalls.FirstOrDefault(roll => roll.RollCallID == RollCallID);
            var Dates = RollCall.AttendanceLogs.OrderBy(roll => roll.LogDate).Select(roll => roll.LogDate).Distinct();
            List<AttendanceLog> AttendanceLogs = new List<AttendanceLog>();
            foreach (DateTime Date in Dates)
            {
                AttendanceLog Log = GetAttendanceLogAtDate(RollCall.RollCallID, Date);
                AttendanceLogs.Add(Log);
            }

            return AttendanceLogs;
        }



    }
}