using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RollSystemMobile.Models
{
    public class RecognizerResult
    {
        public String ImageLink { get; set; }
        public List<FaceRegion> FaceList { get; set; }

        public RecognizerResult()
        {
            FaceList = new List<FaceRegion>();
        }
    }

    public class FaceRegion
    {
        public int X { get; set; }
        public int Y { get; set; }
        public int Width { get; set; }
        public int Height { get; set; }
        public int StudentID { get; set; }
        public String StudentName { get; set; }


        //Can cac gia tri nay de ve len hinh
        public FaceRegion(int X, int Y, int Width, int Height)
        {
            this.X = X;
            this.Y = Y;
            this.Width = Width;
            this.Height = Height;
        }
    }
}