using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace RollSystemMobile.Models.BusinessObject
{
    public class StudySessionBusiness : GenericBusiness<StudySession>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public StudySessionBusiness()
        {

        }
        public StudySessionBusiness(RSMEntities DB)
            : base(DB)
        {

        }

        public List<StudySession> GetRollCallStudySessions(int RollCallID)
        {
            return base.GetList().Where(ss => ss.RollCallID == RollCallID).
                OrderBy(ss => ss.SessionDate).ToList();
        }

        public List<StudySession> GetCurrentTeachingSessions(int InstructorID)
        {
            return base.GetList().Where(ss => ss.SessionDate == DateTime.Today
                && ss.InstructorID == InstructorID).ToList();

        }

        public List<RollCall> GetCurrentRollCall(int InstructorID)
        {
            return base.GetList().Where(ss => ss.SessionDate == DateTime.Today
                && ss.InstructorID == InstructorID).
                Select(ss => ss.RollCall).Distinct().ToList();
        }

        public StudySession GetSessionByID(int ID)
        {
            return base.GetList().FirstOrDefault(ss => ss.SessionID == ID);
        }

        public bool Insert(StudySession Session)
        {
            RollCallBusiness RollBO = new RollCallBusiness();
            var rollCall = RollBO.GetRollCallByID(Session.RollCallID);

            int NumberOfSlot = rollCall.Subject.NumberOfSlot;

            //Set thoi gian
            Session.EndTime = Session.StartTime.
               Add(TimeSpan.FromMinutes(90 * NumberOfSlot)).
               Add(TimeSpan.FromMinutes(15 * (NumberOfSlot - 1)));

            var SameTimeSessions = base.GetList().Where(
                s => (Session.StartTime >= s.StartTime && Session.StartTime <= s.EndTime)
                || (Session.EndTime >= s.StartTime && Session.EndTime <= s.EndTime)).
                Where(s => Session.SessionDate == s.SessionDate && Session.SessionID != s.SessionID);

            var SameTimeSesion = SameTimeSessions.FirstOrDefault(s => s.InstructorID == Session.InstructorID);

            //Xet tiep xem gio doi co trung. (Xet trung gio, trung giao vien hoac trung lop
            if (SameTimeSesion != null)
            {
                //Bao la giao vien da day
                String Request = String.Format("Request: {0} teach class {1} at {2} - {3} on {4}",
                    Session.Instructor.Fullname, Session.Class.ClassName,
                    Session.StartTime.ToString(@"hh\:mm"),
                    Session.EndTime.ToString(@"hh\:mm"),
                    Session.SessionDate.ToString("dd-MM-yyyy"));

                String Error = String.Format("Error: Instructor {0} is teaching class {1} at {2} - {3} on {4}.",
                    SameTimeSesion.Instructor.Fullname, SameTimeSesion.Class.ClassName,
                    SameTimeSesion.StartTime.ToString(@"hh\:mm"),
                    SameTimeSesion.EndTime.ToString(@"hh\:mm"),
                    SameTimeSesion.SessionDate.ToString("dd-MM-yyyy"));
                throw new Exception(Request + "\n" + Error);
            }
            else
            {
                SameTimeSesion = SameTimeSessions.FirstOrDefault(s => s.ClassID == Session.ClassID);
                if (SameTimeSesion != null)
                {
                    String Request = String.Format("Request: Class {0} learn {1} at {2} - {3} on {4}",
                    Session.Class.ClassName, Session.RollCall.Subject.FullName,
                    Session.StartTime.ToString(@"hh\:mm"),
                    Session.EndTime.ToString(@"hh\:mm"),
                    Session.SessionDate.ToString("dd-MM-yyyy"));

                    //Bao la lop nay da hoc
                    String Error = String.Format("Error: Class {0} is learning {1} at {2} - {3} on {4}",
                    SameTimeSesion.Class.ClassName, SameTimeSesion.RollCall.Subject.FullName,
                    SameTimeSesion.StartTime.ToString(@"hh\:mm"),
                    SameTimeSesion.EndTime.ToString(@"hh\:mm"),
                    SameTimeSesion.SessionDate.ToString("dd-MM-yyyy"));
                    throw new Exception(Request + "\n" + Error);
                }
                else
                {
                    return base.Insert(Session);
                }
            }
        }

        public void Update(StudySession StuSes)
        {
            StudySession Session = base.GetList().FirstOrDefault(s => s.SessionID == StuSes.SessionID);

            Session.InstructorID = StuSes.InstructorID;
            Session.Note = StuSes.Note;

            int NumberOfSlot = Session.RollCall.Subject.NumberOfSlot;

            if ((StuSes.StartTime.ToString(@"hh\:mm") == "10:30"
                || StuSes.StartTime.ToString(@"hh\:mm") == "16:00") &&
                NumberOfSlot == 2)
            {
                throw new Exception("2 slot subject can't start at 10:30 or 16:00.");
            }

            Session.StartTime = StuSes.StartTime;
            Session.EndTime = Session.StartTime.
                Add(TimeSpan.FromMinutes(90 * NumberOfSlot)).
                Add(TimeSpan.FromMinutes(15 * (NumberOfSlot - 1)));
            Session.SessionDate = StuSes.SessionDate;



            var SameTimeSessions = base.GetList().Where(
                s => (Session.StartTime >= s.StartTime && Session.StartTime <= s.EndTime)
                || (Session.EndTime >= s.StartTime && Session.EndTime <= s.EndTime)).
                Where(s => Session.SessionDate == s.SessionDate && Session.SessionID != s.SessionID);

            var SameTimeSesion = SameTimeSessions.FirstOrDefault(s => s.InstructorID == Session.InstructorID);

            //Xet tiep xem gio doi co trung. (Xet trung gio, trung giao vien hoac trung lop
            if (SameTimeSesion != null)
            {
                //Bao la giao vien da day
                String Request = String.Format("Request: {0} teach class {1} at {2} - {3} on {4}",
                    Session.Instructor.Fullname, Session.Class.ClassName,
                    Session.StartTime.ToString(@"hh\:mm"),
                    Session.EndTime.ToString(@"hh\:mm"),
                    Session.SessionDate.ToString("dd-MM-yyyy"));

                String Error = String.Format("Error: Instructor {0} is teaching class {1} at {2} - {3} on {4}.",
                    SameTimeSesion.Instructor.Fullname, SameTimeSesion.Class.ClassName,
                    SameTimeSesion.StartTime.ToString(@"hh\:mm"),
                    SameTimeSesion.EndTime.ToString(@"hh\:mm"),
                    SameTimeSesion.SessionDate.ToString("dd-MM-yyyy"));
                throw new Exception(Request + "\n" + Error);
            }
            else
            {
                SameTimeSesion = SameTimeSessions.FirstOrDefault(s => s.ClassID == Session.ClassID);
                if (SameTimeSesion != null)
                {
                    String Request = String.Format("Request: Class {0} learn {1} at {2} - {3} on {4}",
                    Session.Class.ClassName, Session.RollCall.Subject.FullName,
                    Session.StartTime.ToString(@"hh\:mm"),
                    Session.EndTime.ToString(@"hh\:mm"),
                    Session.SessionDate.ToString("dd-MM-yyyy"));

                    //Bao la lop nay da hoc
                    String Error = String.Format("Error: Class {0} is learning {1} at {2} - {3} on {4}",
                    SameTimeSesion.Class.ClassName, SameTimeSesion.RollCall.Subject.FullName,
                    SameTimeSesion.StartTime.ToString(@"hh\:mm"),
                    SameTimeSesion.EndTime.ToString(@"hh\:mm"),
                    SameTimeSesion.SessionDate.ToString("dd-MM-yyyy"));
                    throw new Exception(Request + "\n" + Error);
                }
                else
                {
                    base.Detach(Session);
                    base.Update(Session);
                }
            }
        }

        /// <summary>
        /// Lấy thời gian rảnh trong ngày. Chỉ tính constrains, ko tính constrain giáo viên
        /// </summary>
        /// <param name="RollCallID"></param>
        /// <param name="FromDate"></param>
        /// <param name="ToDate"></param>
        /// <returns></returns>
        public List<TimeSpan> FindAvaibleSessionTime(int RollCallID, DateTime FromDate, DateTime ToDate)
        {
            RollCallBusiness RollBO = new RollCallBusiness(this.RollSystemDB);
            var rollCall = RollBO.GetRollCallByID(RollCallID);

            //Tao 1 danh sach cac thoi gian rarnh
            List<TimeSpan> TimeList = AllAvailableTime(rollCall.Subject.NumberOfSlot);
            //Loai tiep nhung slot trong khoang thoi gian dc chon
            for (DateTime SelectedDate = FromDate; SelectedDate <= ToDate; SelectedDate = SelectedDate.AddDays(1))
            {
                foreach (var Time in rollCall.Class.StudySessions.
                Where(ss => ss.SessionDate == SelectedDate).Select(ss => ss.StartTime))
                {
                    if (TimeList.Contains(Time))
                    {
                        TimeList.Remove(Time);
                    }
                }
            }

            return TimeList;
        }

        public List<TimeSpan> AllAvailableTime(int NumberOfSlot)
        {
            //Tao 1 danh sach cac thoi gian
            TimeSpan time1 = new TimeSpan(7, 00, 00);
            TimeSpan time2 = new TimeSpan(8, 45, 00);
            TimeSpan time3 = new TimeSpan(10, 30, 00);

            TimeSpan time4 = new TimeSpan(12, 30, 00);
            TimeSpan time5 = new TimeSpan(14, 15, 00);
            TimeSpan time6 = new TimeSpan(16, 00, 00);

            TimeSpan time7 = new TimeSpan(18, 30, 00);
            TimeSpan time8 = new TimeSpan(19, 00, 00);

            List<TimeSpan> TimeList = new List<TimeSpan>();
            TimeList.Add(time1);
            TimeList.Add(time2);
            TimeList.Add(time3);
            TimeList.Add(time4);
            TimeList.Add(time5);
            TimeList.Add(time6);
            TimeList.Add(time7);
            TimeList.Add(time8);

            //Neu 2 slot thi bo 10:30 va 16:00
            if (NumberOfSlot == 2)
            {
                TimeList.Remove(time3);
                TimeList.Remove(time6);
            }

            return TimeList;
        }

        /// <summary>
        /// Lấy thời gian rảnh trong ngày. 
        /// Tính cả constrains giáo viên, dùng khi đổi time của session
        /// </summary>
        /// <param name="RollCallID"></param>
        /// <param name="FromDate"></param>
        /// <param name="ToDate"></param>
        /// <returns></returns>
        public List<TimeSpan> FindAvaibleSessionTime(int RollCallID, DateTime SelectedDate)
        {
            RollCallBusiness RollBO = new RollCallBusiness(this.RollSystemDB);
            var rollCall = RollBO.GetRollCallByID(RollCallID);

            //Tao 1 danh sach cac thoi gian rarnh
            List<TimeSpan> TimeList = AllAvailableTime(rollCall.Subject.NumberOfSlot);

            //Loai tiep nhung slot trong khoang thoi gian dc chon
            foreach (var Time in rollCall.Class.StudySessions.
            Where(ss => ss.SessionDate == SelectedDate).Select(ss => ss.StartTime))
            {
                if (TimeList.Contains(Time))
                {
                    TimeList.Remove(Time);
                }
            }

            foreach (var Time in rollCall.Instructor.StudySessions.
            Where(ss => ss.SessionDate == SelectedDate).Select(ss => ss.StartTime))
            {
                if (TimeList.Contains(Time))
                {
                    TimeList.Remove(Time);
                }
            }

            return TimeList;
        }



        public List<Instructor> GetAvaibleInstructor(int RollCallID, TimeSpan SelectedTime, DateTime FromDate, DateTime ToDate)
        {
            InstructorBusiness InsBO = new InstructorBusiness();
            //Lay nhung giao vien ko ban day vao ngay, gio
            var AllInstructors = InsBO.GetInstructorOfRollCall(RollCallID).ToList();

            for (DateTime SelectedDate = FromDate; SelectedDate <= ToDate; SelectedDate = SelectedDate.AddDays(1))
            {
                var BusyInstructors = AllInstructors.Where(ins => ins.StudySessions.Any(ss =>
                    ss.StartTime == SelectedTime && ss.SessionDate == SelectedDate)).ToList();

                foreach (var Ins in BusyInstructors)
                {
                    AllInstructors.Remove(Ins);
                }
            }
            return AllInstructors;
        }

        public void ChangeInstructor(int RollCallID, int InstructorID, String Note, DateTime FromDate, DateTime ToDate)
        {
            RollCallBusiness RollBO = new RollCallBusiness(this.RollSystemDB);
            var rollCall = RollBO.GetRollCallByID(RollCallID);

            foreach (var StudySession in rollCall.StudySessions.ToList())
            {
                if (StudySession.SessionDate >= FromDate && StudySession.SessionDate <= ToDate)
                {
                    StudySession.InstructorID = InstructorID;
                    StudySession.Note = Note;
                    base.Detach(StudySession);
                    base.Update(StudySession);
                }
            }
        }
    }
}