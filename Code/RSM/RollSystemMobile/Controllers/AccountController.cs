﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BindingModels;
using RollSystemMobile.Models.BusinessObject;

namespace RollSystemMobile.Controllers
{
    public class AccountController : Controller
    {
        //
        // GET: /Account/
        private AccountBusiness AccBO;
        private StaffBusiness StaffBO;
        private InstructorBusiness InsBO;
        private StudentBusiness StuBO;

        public AccountController()
        {
            RSMEntities db = new RSMEntities();
            AccBO = new AccountBusiness(db);
            StaffBO = new StaffBusiness(db);
            InsBO = new InstructorBusiness(db);
            StuBO = new StudentBusiness(db);
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(LoginModelView model)
        {
            if (ModelState.IsValid)
            {
                using (RSMEntities db = new RSMEntities())
                {

                    //Tim user active trong database
                    User user = AccBO.CheckLogin(model.Username, model.Password);
                    if (user != null)
                    {
                        //Thuc hien dang nhap
                        FormsAuthentication.SetAuthCookie(model.Username, false);

                        //Redirect toi trang da goi
                        String returnUrl = model.ReturnUrl;
                        if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1
                            && returnUrl.StartsWith("/") && !returnUrl.StartsWith("//")
                            && !returnUrl.StartsWith("/\\"))
                        {
                            return Redirect(returnUrl);
                        }
                        else
                        {
                            String Role = user.Role.RoleName;
                            String Action = "";
                            switch (Role)
                            {
                                case "Instructor":
                                    Action = "RollCallList";
                                    break;
                                case "Staff":
                                    Action = "Index";
                                    Role = "RollCall";
                                    break;
                                case "Admin":
                                    Action = "Index";
                                    break;
                                case "Student":
                                default:
                                    Action = "Index";
                                    break;
                            }
                            return RedirectToAction(Action, Role);
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("Error", "Invalid username or password.");
                    }

                }
            }
            return View(model);
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }

        public ActionResult ChangeStatus(int UserID, bool NewStatus, String ReturnUrl)
        {
            AccBO.ChangeStatus(UserID, NewStatus);
            return RedirectToAction(ReturnUrl,"Admin");
        }

        public ActionResult CreateStaffAccount(int StaffID)
        {
            var staff = StaffBO.GetStaffByID(StaffID);
            if (staff.User == null)
            {
                var user = AccBO.CreateUser(staff.Fullname);
                user.RoleID = 2;
                staff.User = user;
                StaffBO.UpdateExist(staff);
            }
            return RedirectToAction("StaffAccountList", "Admin");
        }

        public ActionResult CreateInstructorAccount(int InstructorID)
        {
            var instructor = InsBO.GetInstructorByID(InstructorID);
            if (instructor.User == null)
            {
                var user = AccBO.CreateUser(instructor.Fullname);
                user.RoleID = 4;
                instructor.User = user;
                InsBO.UpdateExist(instructor);
            }
            return RedirectToAction("InstructorAccountList", "Admin");
        }

        public ActionResult CreateStudentAccount(int StudentID)
        {
            var student = StuBO.GetStudentByID(StudentID);
            if (student.User == null)
            {
                var user = AccBO.CreateUser(student.FullName);
                user.RoleID = 3;
                student.User = user;
                StuBO.UpdateExist(student);
            }
            return RedirectToAction("StudentAccountList", "Admin");
        }

        public ActionResult ProcessStaffAccount(String action, IEnumerable<int>  selectedID)
        {

            foreach (int StaffID in selectedID)
            {
                var staff = StaffBO.GetStaffByID(StaffID);
                switch (action)
                {
                    case "Active":
                        if (staff.User != null)
                        {
                            AccBO.ChangeStatus(staff.UserID.Value, true);
                        }
                        break;
                    case "Inactive":
                        if (staff.User != null)
                        {
                            AccBO.ChangeStatus(staff.UserID.Value, false);
                        }
                        break;
                    case "Create":
                        if (staff.User == null)
                        {
                            var user = AccBO.CreateUser(staff.Fullname);
                            user.RoleID = 2;
                            staff.User = user;
                            StaffBO.UpdateExist(staff);
                        }
                        break;
                    default:
                        break;
                }
            }

            return RedirectToAction("StaffAccountList", "Admin");
        }

        public ActionResult ProcessInstructorAccount(String action, IEnumerable<int> selectedID)
        {

            foreach (int InstructorID in selectedID)
            {
                var instructor = InsBO.GetInstructorByID(InstructorID);
                switch (action)
                {
                    case "Active":
                        if (instructor.User != null)
                        {
                            AccBO.ChangeStatus(instructor.UserID.Value, true);
                        }
                        break;
                    case "Inactive":
                        if (instructor.User != null)
                        {
                            AccBO.ChangeStatus(instructor.UserID.Value, false);
                        }
                        break;
                    case "Create":
                        if (instructor.User == null)
                        {
                            var user = AccBO.CreateUser(instructor.Fullname);
                            user.RoleID = 4;
                            instructor.User = user;
                            InsBO.UpdateExist(instructor);
                        }
                        break;
                    default:
                        break;
                }
            }

            return RedirectToAction("InstructorAccountList", "Admin");
        }

        public ActionResult ProcessStudentAccount(String action, IEnumerable<int> selectedID)
        {

            foreach (int StudentID in selectedID)
            {
                var student = StuBO.GetStudentByID(StudentID);
                switch (action)
                {
                    case "Active":
                        if (student.User != null)
                        {
                            AccBO.ChangeStatus(student.UserID.Value, true);
                        }
                        break;
                    case "Inactive":
                        if (student.User != null)
                        {
                            AccBO.ChangeStatus(student.UserID.Value, false);
                        }
                        break;
                    case "Create":
                        if (student.User == null)
                        {
                            var user = AccBO.CreateUser(student.FullName);
                            user.RoleID = 3;
                            student.User = user;
                            StuBO.UpdateExist(student);
                        }
                        break;
                    default:
                        break;
                }
            }

            return RedirectToAction("InstructorAccountList", "Admin");
        }
    }
}
