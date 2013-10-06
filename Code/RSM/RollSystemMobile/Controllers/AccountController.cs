using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using RollSystemMobile.Models;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Controllers
{
    public class AccountController : Controller
    {
        //
        // GET: /Account/

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
                    User user = db.Users.FirstOrDefault(u => u.Username.Equals(model.Username)
                                                        && u.Password.Equals(model.Password)
                                                        && u.IsActive == true);
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
                                    Action = "StudentList";
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
    }
}
