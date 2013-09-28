using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RollSystemMobile.Models
{
    public class AttendanceBO
    {
        private RSMEntities _db;

        public AttendanceBO()
        {
            _db = new RSMEntities();
        }

        public AttendanceLog WriteAttendanceLog(int RollCallID, List<RecognizerResult> RecognizerResults)
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

        //Ham nay dung hien log attendace trong tab Auto Attendace trang instructor
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
    }
}