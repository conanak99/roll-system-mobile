﻿using System;
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

        public bool Insert(StudySession StuSes)
        {
            RollCallBusiness RollBO = new RollCallBusiness();
            var rollCall = RollBO.GetRollCallByID(StuSes.RollCallID);

            int NumberOfSlot = rollCall.Subject.NumberOfSlot;

            //Set thoi gian
            StuSes.EndTime = StuSes.StartTime.
               Add(TimeSpan.FromMinutes(90 * NumberOfSlot)).
               Add(TimeSpan.FromMinutes(15 * (NumberOfSlot - 1)));

            return base.Insert(StuSes);
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

        public List<TimeSpan> FindAvaibleSessionTime(int RollCallID, DateTime SelectedDate)
        {
            RollCallBusiness RollBO = new RollCallBusiness(this.RollSystemDB);
            var rollCall = RollBO.GetRollCallByID(RollCallID);

            //Tao 1 danh sach cac thoi gian
            TimeSpan time1 = new TimeSpan(7, 00, 00);
            TimeSpan time2 = new TimeSpan(8, 45, 00);
            TimeSpan time3 = new TimeSpan(10, 30, 00);

            TimeSpan time4 = new TimeSpan(12, 30, 00);
            TimeSpan time5 = new TimeSpan(14, 15, 00);
            TimeSpan time6 = new TimeSpan(16, 00, 00);

            List<TimeSpan> TimeList = new List<TimeSpan>();
            TimeList.Add(time1);
            TimeList.Add(time2);
            TimeList.Add(time3);
            TimeList.Add(time4);
            TimeList.Add(time5);
            TimeList.Add(time6);
            //Loai bo dan
            //Loai bo theo mon
            if (rollCall.Subject.NumberOfSlot == 2)
            {
                TimeList.Remove(time3);
                TimeList.Remove(time6);
            }

            //Loai tiep nhung slot da hoc trong ngay cua lop
            foreach (var Time in rollCall.Class.StudySessions.
                Where(ss => ss.SessionDate == SelectedDate).Select(ss => ss.StartTime))
            {
                if (TimeList.Contains(Time))
                {
                    TimeList.Remove(Time);
                }
            }

            return TimeList;
        }
    }
}