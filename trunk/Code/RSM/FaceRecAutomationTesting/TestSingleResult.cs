using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FaceRecAutomationTesting
{
    public class TestSingleResult
    {
        public String Eigen_2000_Result { get; set; }
        public String Eigen_3500_Result { get; set; }
        public String Eigen_5000_Result { get; set; }
        public String Fisher_500_Result { get; set; }
        public String Fisher_1000_Result { get; set; }
        public String Fisher_1500_Result { get; set; }
        public String LPBH_50_Result { get; set; }
        public String LPBH_100_Result { get; set; }
        public String LPBH_150_Result { get; set; }
        public String Result { get; set; }

        //Moi single result se duoc bieu dien la 1 row
        public override string ToString()
        {
            //Thang nao giong result co dau (O), khac result (X)
            String Row = String.Format("|{0,-10}|", Result);
            var Properties = this.GetType().GetProperties();

            //Chay het cac gia tri khac, sau do cong vao chuoi
            foreach (var Property in Properties)
            {
                if (!Property.Name.Equals("Result"))
                {
                    Row += CreateCell(Property.GetValue(this, null).ToString());
                }
            }
            return Row;
        }

        private string CreateCell(String CellValue)
        {
            //Dung tra O, sai tra X
            if (CellValue.Equals(Result))
            {
                return String.Format("{0,-8}(O)|", CellValue);
            }
            else
            {
                return String.Format("{0,-8}(X)|", CellValue);
            }
	{
		 
	}
        }
    }

    public class MoreTestSingleResult
    {
        public List<String> FileUsed { get; set; }
        public int RunCount { get; set; }
        public int StudentDetected { get; set; }
    }
}
