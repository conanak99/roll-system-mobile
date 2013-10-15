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

        public void Update(StudySession StuSes)
        {
            StudySession Session = base.GetList().FirstOrDefault(s => s.SessionID == StuSes.SessionID);

            Session.InstructorID = StuSes.InstructorID;

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
    }
}