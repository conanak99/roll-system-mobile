using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class StudentImageBusiness: GenericBusiness<StudentImage>
    {
        /// <summary>
        /// Create 
        /// </summary>
        public StudentImageBusiness()
        {
            
        }
        public StudentImageBusiness(RSMEntities DB)
            : base(DB)
        {
            
        }

        public StudentImage FindImageByID(int ID)
        {
            return base.GetList().FirstOrDefault(im => im.ImageID == ID);
        }

        public bool ImageExist(int StudentID, String FileName)
        {
            return base.GetList().Any(sa => sa.StudentID == StudentID && sa.ImageLink.Equals(FileName));
        }

    }
}