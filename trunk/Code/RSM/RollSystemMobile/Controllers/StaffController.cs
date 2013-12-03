using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using Excel = Microsoft.Office.Interop.Excel;
using System.Data.OleDb;
using System.Data;
using RollSystemMobile.Models;
using System.Data.SqlClient;
namespace RollSystemMobile.Controllers
{
    public class StaffController : Controller
    {
        private RSMEntities _db = new RSMEntities();
        //
        // GET: /Staff/

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Import(int? numCls, int? numStu)
        {
            ViewBag.NumCls = numCls;
            ViewBag.NumStu = numStu;
            return View();
        }
        public FilePathResult Download()
        {
            string fileName = "File_Import_Template.xls";
            string path = AppDomain.CurrentDomain.BaseDirectory + "Content/Files/";
            return File(path + fileName, "file/xls", fileName);
        }
        [HttpPost]
        public ActionResult ImportExcel(HttpPostedFileBase file)
        {

            int clsCount = 0;
            int stuCount = 0;
            if (Request.Files["FileUpload"].ContentLength > 0)
            {
                string fileExtension =
                                     System.IO.Path.GetExtension(Request.Files["FileUpload"].FileName);

                if (fileExtension == ".xls" || fileExtension == ".xlsx")
                {

                    // Create a folder in App_Data named ExcelFiles because you need to save the file temporarily location and getting data from there. 
                    string fileLocation = string.Format("{0}/{1}", Server.MapPath("~/Content/Temp"),
                                                                                       Request.Files["FileUpload"].FileName);

                    if (System.IO.File.Exists(fileLocation))
                        System.IO.File.Delete(fileLocation);

                    Request.Files["FileUpload"].SaveAs(fileLocation);
                    string excelConnectionString = string.Empty;

                    excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileLocation + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    //connection String for xls file format.
                    if (fileExtension == ".xls")
                    {
                        excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileLocation + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                    }
                    //connection String for xlsx file format.
                    else if (fileExtension == ".xlsx")
                    {

                        excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileLocation + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    }



                    //Create Connection to Excel work book and add oledb namespace
                    OleDbConnection excelConnection = new OleDbConnection(excelConnectionString);
                    excelConnection.Open();
                    DataTable dt = new DataTable();

                    dt = excelConnection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                    if (dt == null)
                    {
                        return null;
                    }

                    String[] excelSheets = new String[dt.Rows.Count];
                    int t = 0;
                    //excel data saves in temp file here.
                    foreach (DataRow row in dt.Rows)
                    {
                        excelSheets[t] = row["TABLE_NAME"].ToString();
                        t++;
                    }
                    OleDbConnection excelConnection1 = new OleDbConnection(excelConnectionString);
                    DataSet ds = new DataSet();

                    string query = string.Format("Select * from [{0}]", excelSheets[0]);
                    using (OleDbDataAdapter dataAdapter = new OleDbDataAdapter(query, excelConnection1))
                    {
                        dataAdapter.Fill(ds);
                    }
                    Class dbclass;
                    Student dbStudent;
                    String tmp;
                    int majorID;
                    int classID;
                    String value;
                    // insert tung dong cua file
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        //insert class
                        dbclass = new Class();
                        //lay gia tri majorid dua tren majorshorname
                        tmp = ds.Tables[0].Rows[i]["Major"].ToString();
                        majorID = _db.Majors.SingleOrDefault(m => m.ShortName == tmp).MajorID;
                        //check class da duoc ton tai trong database
                        dbclass.MajorID = majorID;
                        dbclass.ClassName = ds.Tables[0].Rows[i]["ClassName"].ToString();
                        value = dbclass.ClassName;
                        dbclass.IsActive = true;
                        bool isExist = _db.Classes.AsEnumerable().Any(row => row.ClassName == value);
                        if (isExist == false)
                        {
                            _db.Classes.AddObject(dbclass);
                            _db.SaveChanges();
                            clsCount++;
                        }
                        //insert student

                        tmp = ds.Tables[0].Rows[i]["ClassName"].ToString();
                        classID = _db.Classes.SingleOrDefault(c => c.ClassName == tmp).ClassID;
                        dbStudent = new Student();
                        dbStudent.ClassID = classID;
                        dbStudent.FullName = ds.Tables[0].Rows[i]["FullName"].ToString();
                        dbStudent.StudentCode = ds.Tables[0].Rows[i]["StudentCode"].ToString();
                        dbStudent.Birthdate = DateTime.Parse(ds.Tables[0].Rows[i]["Birthdate"].ToString());
                        dbStudent.CitizenID = ds.Tables[0].Rows[i]["CitizenID"].ToString();
                        dbStudent.IsActive = true;
                        value = dbStudent.StudentCode;
                        bool test = _db.Students.AsEnumerable().Any(d => d.StudentCode == value);
                        if (test == false)
                        {
                            _db.Students.AddObject(dbStudent);
                            _db.SaveChanges();
                            stuCount++;
                        }
                    }

                    ds.Dispose();
                    excelConnection.Close();
                }

                else
                {
                    
                }
            }
            return RedirectToAction("Import",new {numCls = clsCount,numStu = stuCount});

        }
    }
}
