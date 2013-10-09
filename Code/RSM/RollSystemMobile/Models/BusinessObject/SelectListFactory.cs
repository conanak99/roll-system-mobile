using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RollSystemMobile.Models.BindingModels;

namespace RollSystemMobile.Models.BusinessObject
{
    public class SelectListFactory
    {
        private RSMEntities db;
        /// <summary>
        /// Create 
        /// </summary>
        public SelectListFactory()
        {
            db = new RSMEntities();
        }

        public SelectListFactory(RSMEntities DB)
        {
            db = DB;
        }

        public SelectList MakeSelectList<T>(String ValueField, String TextField) where T: class
        {
            return new SelectList(db.CreateObjectSet<T>(), ValueField, TextField);
        }

        public SelectList MakeSelectList<T>(String ValueField, String TextField, int SelectedID) where T : class
        {
            return new SelectList(db.CreateObjectSet<T>(), ValueField, TextField, SelectedID);
        }

        public SelectList MakeSemesterSelectList()
        {
            return new SelectList(db.Semesters.OrderByDescending(s => s.BeginDate), "SemesterID", "SemesterName");
        }

    }
}