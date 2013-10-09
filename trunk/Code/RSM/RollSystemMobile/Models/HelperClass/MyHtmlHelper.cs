using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
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
