using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;

namespace RollSystemMobile.Models.GoogleApi
{
    public class GoogleCalendarEventList
    {
        public List<GoogleCalendarEvent> Items { get; set; }
    }

    public class GoogleCalendarEvent
    {
        [JsonProperty("id")]
        public string ID { get; set; }

        public bool ShouldSerializeID()
        {
            return false;
        }

        [JsonProperty("summary")]
        public string Summary { get; set; }
        [JsonProperty("start")]
        public GoogleCalendarEventTime Start { get; set; }
        [JsonProperty("end")]
        public GoogleCalendarEventTime End { get; set; }
    }

    public class GoogleCalendarEventTime
    {
        private DateTime _datetime;

        [Newtonsoft.Json.JsonIgnore]
        public String TimeZone
        {
            get
            {
                return "Asia/Saigon";
            }
        
        }

        [JsonProperty("dateTime")]
        public string Datetime
        {
            get
            {
                return _datetime.ToString("yyyy-MM-dd'T'HH:mm:ss+07:00");
            }
        }

        public GoogleCalendarEventTime(DateTime Datetime)
        {
            _datetime = Datetime;
        }

        public DateTime GetTime()
        {
            return _datetime;
        }
    }

    public class GoogleCalendarList
    {
        public List<GoogleCalendar> Items { get; set; }
    }
    public class GoogleCalendar
    {

        public string ID { get; set; }
        public string Summary { get; set; }
        public string TimeZone { get; set; }
    }

    public class GoogleTokenData
    {
        public string Access_Token { get; set; }
        public string Refresh_Token { get; set; }
        public string Expires_In { get; set; }
        public string Token_Type { get; set; }
    }
}
