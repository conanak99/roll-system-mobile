using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using System.Net;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading.Tasks;
using Excel = Microsoft.Office.Interop.Excel;
using System.Data.OleDb;
using System.Data;
using RollSystemMobile.Models;
namespace RollSystemMobile.Controllers
{
    public class StaffController : Controller
    {
        //
        // GET: /Staff/

        public ActionResult Index()
        {
            return View();
        }
        //class layout
        public ActionResult Class()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ImportExcelFileToDatabase(HttpPostedFileBase file)
        {

            if (Request.Files["FileUpload"].ContentLength > 0)
            {
                string fileExtension =          
                                     System.IO.Path.GetExtension(Request.Files["FileUpload"].FileName);

                if (fileExtension == ".xls" || fileExtension == ".xlsx")
                {

// Create a folder in App_Data named ExcelFiles because you need to save the file temporarily location and getting data from there. 
                    string fileLocation =string.Format("{0}/{1}",Server.MapPath("~/Content/Temp"),    
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
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        
                        Default1Controller  model = new Default1Controller();
                        model.ClassID = ds.Tables[0].Rows[i]["ClassID"].ToString();
                        model.MajorID = ds.Tables[0].Rows[i]["MajorID"].ToString();
                        model.ClassName = ds.Tables[0].Rows[i]["ClassName"].ToString();
                        model.IsActive = ds.Tables[0].Rows[i]["IsActive"].ToString();
            
                        
// SAVE THE DATA INTO DATABASE HERE. I HAVE USED WEB API HERE TO SAVE THE DATA. 
// YOU CAN USE YOUR OWN PROCESS TO SAVE.
                      
                    }
                    ViewBag.message = "Information saved successfully.";
                }

                else
                {
                    ModelState.AddModelError("", "Plese select Excel File.");
                }
            }
            return View();
        }
    }
}
