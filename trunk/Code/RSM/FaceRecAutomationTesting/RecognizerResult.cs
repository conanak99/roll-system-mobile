using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FaceRecAutomationTesting
{
    public class RecognizerResult
    {
        public String ImageLink { get; set; }
        public List<FaceRegion> FaceList { get; set; }

        public RecognizerResult()
        {
            FaceList = new List<FaceRegion>();
        }

        public String SimpleDetectResult()
        {
            String Result = "Found " + FaceList.Count + " face(s)\n";
            foreach (var FaceRegion in FaceList)
            {
                Result += String.Format("\tX={0}. Y={1}. Width={2}. Height={3}.\n", FaceRegion.X, FaceRegion.Y, FaceRegion.Width, FaceRegion.Height);
            }
            return Result;
        }

        public override bool Equals(Object obj)
        {
            // If parameter is null return false.
            if (obj == null)
            {
                return false;
            }

            // If parameter cannot be cast to Point return false.
            RecognizerResult Result = (RecognizerResult)obj;
            if (Result == null)
            {
                return false;
            }

            // Return true if the fields match:
            bool equal = true;
            if (FaceList.Count != Result.FaceList.Count)
            {
                equal = false;
            }
            for (int i = 0; i < FaceList.Count; i++)
            {
                if (!FaceList.ElementAt(i).Equals(Result.FaceList.ElementAt(i)))
                {
                    equal = false;
                }
            }

            return equal;
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

        public override bool Equals(Object obj)
        {
            // If parameter is null return false.
            if (obj == null)
            {
                return false;
            }

            // If parameter cannot be cast to Point return false.
            FaceRegion Face = (FaceRegion)obj;
            if (Face == null)
            {
                return false;
            }

            // Return true if the fields match:
            return (X == Face.X) && (Y == Face.Y) && (Width == Face.Width) && (Height == Face.Height)
                && (StudentID == Face.StudentID);
        }
    }
}