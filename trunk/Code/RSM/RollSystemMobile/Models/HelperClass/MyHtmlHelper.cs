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
    }
}
