using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;

namespace RollSystemMobile.Models.GoogleApi
{
    public class WebUtils
    {
        public enum ContentType
        {
            Form, Json
        }

        public static string HttpGetResult(String Url, String AccessToken)
        {
            var request = WebRequest.Create(Url) as HttpWebRequest;
            request.Headers.Add("Accept-Charset", "utf-8");
            request.KeepAlive = true;
            request.Method = "GET";
            request.Headers.Add("Authorization", "Bearer " + AccessToken);
            
            WebResponse response = request.GetResponse();
            var stream = new StreamReader(response.GetResponseStream());

            String Result = stream.ReadToEnd();
            stream.Close();
            response.Close();

            return Result;
        }

        public static string HttpDeleteResult(String Url, String AccessToken)
        {
            var request = WebRequest.Create(Url) as HttpWebRequest;
            request.Headers.Add("Accept-Charset", "utf-8");
            request.Method = "DELETE";
            request.Headers.Add("Authorization", "Bearer " + AccessToken);
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = 0;

            WebResponse response = request.GetResponse();
            var stream = new StreamReader(response.GetResponseStream());

            String Result = stream.ReadToEnd();
            stream.Close();
            response.Close();

            return Result;
        }

        public static string HttpPostResult(String Url, String Param,  ContentType Type)
        {
            HttpWebRequest request = HttpWebRequest.Create(Url) as HttpWebRequest;
            string Result = null;
            request.Method = "POST";
            request.KeepAlive = true;
            if (Type == ContentType.Form)
            {
                request.ContentType = "application/x-www-form-urlencoded";
            }
            else
            {
                request.ContentType = "application/json";
            }
            request.ContentLength = Param.Length;

            var bs = Encoding.UTF8.GetBytes(Param);
            using (Stream reqStream = request.GetRequestStream())
            {
                reqStream.Write(bs, 0, bs.Length);
            }

            using (WebResponse response = request.GetResponse())
            {
                var sr = new StreamReader(response.GetResponseStream());
                Result = sr.ReadToEnd();
                sr.Close();
            }

            return Result;
        }

        public static string HttpPostResult(String Url, String AccessToken, String param, ContentType Type)
        {
            HttpWebRequest request = HttpWebRequest.Create(Url) as HttpWebRequest;
            string Result = null;
            request.Method = "POST";
            request.KeepAlive = true;
            if (Type == ContentType.Form)
            {
                request.ContentType = "application/x-www-form-urlencoded";
            }
            else
            {
                request.ContentType = "application/json";
            }
            request.Headers.Add("Authorization", "OAuth " + AccessToken);
            request.ContentLength = param.Length;

            var bs = Encoding.UTF8.GetBytes(param);
            using (Stream reqStream = request.GetRequestStream())
            {
                reqStream.Write(bs, 0, bs.Length);
            }

            using (WebResponse response = request.GetResponse())
            {
                var sr = new StreamReader(response.GetResponseStream());
                Result = sr.ReadToEnd();
                sr.Close();
            }

            return Result;
        }
    }
}
