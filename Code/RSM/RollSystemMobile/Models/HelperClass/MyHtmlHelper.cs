using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Web.Mvc.Html;
namespace RollSystemMobile.Models.HelperClass
{
    public static class MyHtmlHelper
    {
        public static string FormatDate(this HtmlHelper helper, DateTime Date)
        {
            return Date.ToString("dd-MM-yyyy");
        }

        public static string FormatTime(this HtmlHelper helper, TimeSpan Time)
        {
            return Time.ToString(@"hh\:mm");
        }

        public static MvcHtmlString MenuLink(this HtmlHelper htmlHelper, string linkText,
           string actionName, string controllerName)
        {
            string currentAction = htmlHelper.ViewContext.RouteData.GetRequiredString("action");
            string currentController = htmlHelper.ViewContext.RouteData.GetRequiredString("controller");
            if (actionName == currentAction && controllerName == currentController)
            {
                return htmlHelper.ActionLink(linkText, actionName, controllerName, null, new
                    {
                        @class = "current"
                    });
            }
            return htmlHelper.ActionLink(linkText, actionName, controllerName);
        }

        public static List<SelectListItem> TimeSelectList(this HtmlHelper htmlHelper, TimeSpan time)
        {
            List<SelectListItem> TimeList = new List<SelectListItem> 
       { 
           new SelectListItem { Text = "07:00", Value = "07:00" }, 
           new SelectListItem { Text = "08:45", Value = "08:45" },
           new SelectListItem { Text = "10:30", Value = "10:30" }, 
           new SelectListItem { Text = "12:30", Value = "12:30" }, 
           new SelectListItem { Text = "14:15", Value = "14:15" }, 
           new SelectListItem { Text = "16:00", Value = "16:00" },
           new SelectListItem { Text = "18:45", Value = "18:45" }
       };
            foreach (var item in TimeList)
            {
                if (item.Value.Equals(time.ToString(@"hh\:mm")))
                {
                    item.Selected = true;
                }
            }
            return TimeList;
        }

        public static List<SelectListItem> TimeSelectList(this HtmlHelper htmlHelper)
        {
            List<SelectListItem> TimeList = new List<SelectListItem> 
       { 
           new SelectListItem { Text = "7:00", Value = "7:00" }, 
           new SelectListItem { Text = "8:45", Value = "8:45" },
           new SelectListItem { Text = "10:30", Value = "10:30" }, 
           new SelectListItem { Text = "12:30", Value = "12:30" }, 
           new SelectListItem { Text = "14:15", Value = "14:15" }, 
           new SelectListItem { Text = "16:00", Value = "16:00" },
           new SelectListItem { Text = "18:45", Value = "18:45" }
       };

            return TimeList;
        }

    }



    public static class MyUrlHelper
    {
        public static string ResizedImage(this UrlHelper helper, String ImageLink)
        {
            return helper.Content("~/Content/Temp/Resized/") + ImageLink;
        }

        public static string TrainingImage(this UrlHelper helper, String ImageLink)
        {
            return helper.Content("~/Content/Training Data/") + ImageLink;
        }

        public static string LogImage(this UrlHelper helper, String ImageLink)
        {
            return helper.Content("~/Content/Log/") + ImageLink;
        }
    }
}
