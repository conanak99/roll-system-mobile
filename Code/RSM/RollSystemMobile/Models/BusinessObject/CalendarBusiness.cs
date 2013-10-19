using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using RollSystemMobile.Models.BindingModels;
using RollSystemMobile.Models.GoogleApi;
using RollSystemMobile.Models.HelperClass;

namespace RollSystemMobile.Models.BusinessObject
{
    public class CalendarBusiness
    {
        /// <summary>
        /// Create 
        /// </summary>
        public CalendarBusiness()
        {
        }

        public void SyncInstructorCalendar(int InstructorID)
        {
            Task.Factory.StartNew(() => SyncCalendar(InstructorID));
        }

        private void SyncCalendar(int InstructorID)
        {
            InstructorBusiness InsBO = new InstructorBusiness();
            Instructor Ins = InsBO.GetInstructorByID(InstructorID);

            //Neu chua co teken thi ko lam gi het
            if (Ins.ApiToken == null)
            {
                return;
            }

            SimpleLog.Info("Begin Sync Calendar for Instructor " + Ins.Fullname + ".");
            try
            {
                String RefreshToken = Ins.ApiToken;
                var WrapperAPI = new GoogleCalendarAPIWrapper(RefreshToken);

                //Tim toan bo lich cua instructor
                var Calendars = WrapperAPI.GetCalendarList();
                //Tim xem da co teaching calendar chua, chua co thi insert
                GoogleCalendar TeachingCalendar = Calendars.Items.SingleOrDefault(ca => ca.Summary.Equals("Teaching Calendar"));

                if (TeachingCalendar == null)
                {
                    TeachingCalendar = WrapperAPI.InsertCalendar("Teaching Calendar");
                }
                else
                {
                    //Clear nhung ngay trong tuong lai
                    WrapperAPI.ClearFutureDateCalendar(TeachingCalendar.ID);
                }

                //Bat dau lay event, ghi vao calendar.
                StudySessionBusiness StuSesBO = new StudySessionBusiness();
                //Chi lay nhung event trong tuong lai, tiet kiem dung luong
                List<Event> Events = StuSesBO.GetCalendarEvent(InstructorID).
                    Where(e => e.StartDate >= DateTime.Now).ToList();
                foreach (var Event in Events)
                {
                    WrapperAPI.InsertEvent(TeachingCalendar.ID, Event.title, Event.StartDate, Event.EndDate);
                }

                String Message = String.Format("Succesfull sync {0} events, from {1:dd-MM-yyyy} to {2:dd-MM-yyyy}",
                    Events.Count, Events.First().StartDate, Events.Last().StartDate);

                SimpleLog.Info(Message);
            }
            catch (Exception e)
            {
                SimpleLog.Error("Error while trying to sync.");
                SimpleLog.Error(e.Message);
            }
        }
       
    }
}