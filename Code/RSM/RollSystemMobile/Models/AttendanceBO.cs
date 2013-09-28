using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RollSystemMobile.Models
{
    public class AttendanceBO
    {
        public static void CreateAttendanceLog(List<RecognizerResult> RecognizerResults)
        {
            //Dua danh sach vao, loc ra nhung thang trung
            HashSet<int> StudentIDs = new HashSet<int>();
            foreach (var result in RecognizerResults)
            {
                foreach (var face in result.FaceList)
                {
                    StudentIDs.Add(face.StudentID);
                }
            }

            //Cuoi cung loc ra duoc toan bo nhung id trong hinh
        }
    }
}