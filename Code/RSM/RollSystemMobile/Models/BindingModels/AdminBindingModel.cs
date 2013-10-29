using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Mvc;
using System.Web.Security;

namespace RollSystemMobile.Models.BindingModels
{
    public class ImageBindingModel
    {
        public List<SingleImageBindingModel> ImageModels { get; set; }
        public String ReturnUrl { get; set; }
        public String Folder { get; set; }
    }

    public class SingleImageBindingModel
    {
        public String ImageLink { get; set; }
        public List<int> FaceIndexs { get; set; }
        public List<int> StudentIDs { get; set; }
    }
}