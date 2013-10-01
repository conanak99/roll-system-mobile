using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models
{
    public class RollCallBO
    {
        private RSMEntities db;

        public RollCallBO()
        {
            db = new RSMEntities();
        }

        public void InsertRollCall(RollCall InRollCall)
        {
            db.RollCalls.AddObject(InRollCall);
            db.SaveChanges();
        }

        public void UpdateRollCall(RollCall InRollCall)
        {
            db.RollCalls.Attach(InRollCall);
            db.ObjectStateManager.ChangeObjectState(InRollCall, System.Data.EntityState.Modified);
            db.SaveChanges();
        }

        public RollCall ChangeRollCallInstructor(RollCall InRollCall, int NewInstructorID)
        {
            RollCall rollcall = InRollCall;
            var RollCallInstructorTeaching = db.InstructorTeachings.
                Where(it => it.RollCallID == InRollCall.RollCallID).ToList();

            int CurrentInstructorID = RollCallInstructorTeaching.Last().InstructorID;
            //Neu co doi giao vien, doi gia tri field cu, them field moi
            if (NewInstructorID != CurrentInstructorID)
            {
                InstructorTeaching it = RollCallInstructorTeaching.Last(inte => inte.InstructorID == CurrentInstructorID);

                //Neu nhu doi giao vien sau start date thi ghi log
                //SAU NAY KO CHECK START DATE, CHECK BANG GIA TRI STATUS 0,1,2
                if (DateTime.Today > it.BeginDate)
                {
                    it.EndDate = DateTime.Today.AddDays(-1); //Ngay ket thuc la hom qua
                    
                    InstructorTeaching newIt = new InstructorTeaching();
                    newIt.InstructorID = NewInstructorID;
                    newIt.BeginDate = DateTime.Today;
                    newIt.EndDate = rollcall.EndDate;
                    newIt.RollCallID = rollcall.RollCallID;
                    db.InstructorTeachings.AddObject(newIt);
                }
                else
                {
                    //Neu truoc start date, chi doi bt
                    it.InstructorID = NewInstructorID;
                }

            }

            return rollcall;
        }


        public RollCall FillRollCallInfo(RollCall InRollCall, int InstructorID)
        {
            RollCall rollcall = InRollCall;
            //Set thoi gian EndTime, dua vao start time
            var rollSubject = db.Subjects.First(s => s.SubjectID == rollcall.SubjectID);
            rollcall.EndTime = rollcall.StartTime.Add(TimeSpan.FromMinutes(45 * rollSubject.NumberOfSlot));

            //Dua toan bo hoc sinh hien tai cua class vao
            var rollClass = db.Classes.First(c => c.ClassID == rollcall.ClassID);
            foreach (var Student in rollClass.Students)
            {
                rollcall.Students.Add(Student);
            }

            // Them 1 truong vao bang instructor teaching
            InstructorTeaching it = new InstructorTeaching();
            it.InstructorID = InstructorID;
            it.BeginDate = rollcall.BeginDate;
            it.EndDate = rollcall.EndDate;
            rollcall.InstructorTeachings.Add(it);
            rollcall.Status = 0;

            return rollcall;

        }


        public List<String> ValidRollCall(RollCall InRollCall)
        {
            List<string> ErrorList = new List<string>();

            var rollSubject = db.Subjects.First(s => s.SubjectID == InRollCall.SubjectID);
            //Check may cai nhu gio hoc, giao vien dang day v...v trong nay
            if ((InRollCall.StartTime.ToString(@"hh\:mm") == "10:45:"
                || InRollCall.StartTime.ToString(@"hh\:mm") == "16:00") &&
            rollSubject.NumberOfSlot == 2)
            {
                ErrorList.Add("Mon nay 2 slot, gio nay ko phu hop");
            }

            //Check thu xem class cua roll call nay co dang hoc roll call nao ko


            //Check xem giao vien roll call nay co dang day roll call nao cung gio ko


            //Nho check luon, start date va end date cua roll call so voi semester
            return ErrorList;
        }
    }
}