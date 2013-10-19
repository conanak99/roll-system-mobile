using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;

namespace RollSystemMobile.Models.GoogleApi
{
    public class GoogleCalendarAPIWrapper
    {
        private static String ClientID = "92785110315.apps.googleusercontent.com";
        private static String ClientSecret = "oPh2XsGJt-2JQqoxZaZFIVGR";

        public String RedirectUri { get; set; }
        public String RefreshToken { get; set; } 
        public String AccessToken { get; set; }

        public GoogleCalendarAPIWrapper()
        {

        }

        public GoogleCalendarAPIWrapper(String RefreshToken)
        {
            this.RefreshToken = RefreshToken;
            this.AccessToken = GetAccessToken(RefreshToken);
        }

        public String GetAuthUrl()
        {
            String AuthUrl = @"https://accounts.google.com/o/oauth2/auth?scope={0}&redirect_uri={1}&response_type=code&client_id={2}&access_type=offline&approval_prompt=force";
            String Scope = @"https://www.googleapis.com/auth/calendar";
            if (RedirectUri == null)
            {
                RedirectUri = @"http://localhost";
            }

            String FinalAuthUrl = String.Format(AuthUrl, Scope, RedirectUri, ClientID);
            return FinalAuthUrl;
        }

        public String GetRefreshToken(String AuthorizedCode)
        {
            string Url = "https://accounts.google.com/o/oauth2/token";

            if (RedirectUri == null)
            {
                RedirectUri = @"http://localhost";
            }

            string Grant_type = "authorization_code";
            string Data = "code={0}&client_id={1}&client_secret={2}&redirect_uri={3}&grant_type={4}";
            String Param = String.Format(Data, AuthorizedCode, ClientID, ClientSecret, RedirectUri, Grant_type);

            String Result = WebUtils.HttpPostResult(Url, Param, WebUtils.ContentType.Form);

            GoogleTokenData TokenData = JsonConvert.DeserializeObject<GoogleTokenData>(Result);
            return TokenData.Refresh_Token;
        }

        public String GetAccessToken(String RefreshToken)
        {
            string Url = "https://accounts.google.com/o/oauth2/token";
            string Grant_type = "refresh_token";
            string Data = "refresh_token={0}&client_id={1}&client_secret={2}&grant_type={3}";
            String Param = String.Format(Data, RefreshToken, ClientID, ClientSecret, Grant_type);

            String Result = WebUtils.HttpPostResult(Url, Param, WebUtils.ContentType.Form);
            GoogleTokenData TokenData = JsonConvert.DeserializeObject<GoogleTokenData>(Result);
            return TokenData.Access_Token;
        }

        public GoogleCalendarList GetCalendarList()
        {
            String Url = @"https://www.googleapis.com/calendar/v3/users/me/calendarList";
            Url = AddKey(Url);
            Url += "&fields=items(id,summary,timeZone)";

            String Result = WebUtils.HttpGetResult(Url , AccessToken);
            return JsonConvert.DeserializeObject<GoogleCalendarList>(Result);
        }

        public GoogleCalendar InsertCalendar(String CalendarName)
        {
            String Url = @"https://www.googleapis.com/calendar/v3/calendars";
            Url = AddKey(Url);

            var sendObject = new { summary = CalendarName};
            String Param = JsonConvert.SerializeObject(sendObject);

            String Result = WebUtils.HttpPostResult(Url, AccessToken, Param, WebUtils.ContentType.Json);

            return JsonConvert.DeserializeObject<GoogleCalendar>(Result);
        }

        public void ClearCalendar(String CalendarID)
        {
            //Xoa trong calendar
            var Events = GetEventList(CalendarID);
            foreach (var Event in Events.Items)
            {
                DeleteEvent(CalendarID, Event.ID);
            }
        }

        //Chi xoa nhung ngat tuong lai, qua khu ko xoa
        public void ClearFutureDateCalendar(String CalendarID)
        {
            //Xoa trong calendar
            var Events = GetEventList(CalendarID);
            foreach (var Event in Events.Items)
            {
                if (Event.Start.GetTime() >= DateTime.Now)
                {
                    DeleteEvent(CalendarID, Event.ID);
                }
            }
        }

        public GoogleCalendarEventList GetEventList(string CalendarID)
        {
            String Url = "https://www.googleapis.com/calendar/v3/calendars/{0}/events";
            Url = AddKey(Url);
            Url = String.Format(Url, CalendarID);
            Url += "&fields=items(id, summary, start/dateTime, end/dateTime)";

            String Result = WebUtils.HttpGetResult(Url, AccessToken);
            return JsonConvert.DeserializeObject<GoogleCalendarEventList>(Result);
        }

        public GoogleCalendarEvent InsertEvent(String CalendarID, String EventSummary, DateTime StartTime, DateTime EndTime)
        {
            String Url = "https://www.googleapis.com/calendar/v3/calendars/{0}/events";
            Url = AddKey(Url);
            Url = String.Format(Url, CalendarID);


            GoogleCalendarEvent GoEvent = new GoogleCalendarEvent();
            GoogleCalendarEventTime Start = new GoogleCalendarEventTime(StartTime);
            GoogleCalendarEventTime End = new GoogleCalendarEventTime(EndTime);
            GoEvent.Summary = EventSummary;
            GoEvent.Start = Start;
            GoEvent.End = End;

            String Param = JsonConvert.SerializeObject(GoEvent);
            String Result = WebUtils.HttpPostResult(Url, AccessToken, Param, WebUtils.ContentType.Json);

            return JsonConvert.DeserializeObject<GoogleCalendarEvent>(Result);
        }

        public void DeleteEvent(String CalendarID, String EventID)
        {
            String Url = "https://www.googleapis.com/calendar/v3/calendars/{0}/events/{1}";
            Url = AddKey(Url);
            Url = String.Format(Url, CalendarID, EventID);

            WebUtils.HttpDeleteResult(Url, AccessToken);
        }

        private static String AddKey(String Url)
        {
            return String.Format("{0}?key={1}", Url, ClientID);
        }
    }
}
