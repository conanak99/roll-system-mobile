using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models;
using RollSystemMobile.Models.ViewModels;

namespace RollSystemMobile.Controllers
{
    [Authorize(Roles = "Instructor")]
    public class InstructorController : Controller
    {
        //
        // GET: /Instructor/

        private RSMEntities _db = new RSMEntities();

        public ActionResult Index()
        {
            //Tim instructor da dang nhạp vao
            string Username = this.HttpContext.User.Identity.Name;
            User User = _db.Users.First(u => u.Username.Equals(Username));
            Instructor AuthorizedInstructor = _db.Instructors.First(i => i.UserID == User.UserID);



            //Nhung mon ma instructor nay dang day
            DateTime Today = DateTime.Now;
            var RollCalls = _db.RollCalls.Where(r => r.InstructorTeachings.
                                       Any(inte => inte.InstructorID == AuthorizedInstructor.InstructorID)
                                       && r.StartDate < Today && r.EndDate > Today);
            //Mon dang day vao thoi diem dang nhap
            RollCall CurrentRollCall = null;

            if (RollCalls.Count() > 0)
            {
                TimeSpan CurrentTime = DateTime.Now.TimeOfDay;
                CurrentRollCall = RollCalls.FirstOrDefault(r => r.StartTime < CurrentTime && r.EndTime > CurrentTime);
            }

            InstructorViewModel model = new InstructorViewModel();
            model.AuthorizedInstructor = AuthorizedInstructor;
            model.CurrentRollCall = CurrentRollCall;
            model.TeachingRollCall = RollCalls;

            return View(model);
        }

    }
}
