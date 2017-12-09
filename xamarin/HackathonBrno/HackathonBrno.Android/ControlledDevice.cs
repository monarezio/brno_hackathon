using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Android.App;
using Android.Content;
using Android.OS;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Newtonsoft.Json.Linq;

namespace HackathonBrno.Droid
{
    public class ControlledDevice
    {
        public struct Reading
        {
            public DateTime timestamp;
            public int percentage;
            public string type;

            public Reading(DateTime timestamp, int percentage, string type)
            {
                this.timestamp = timestamp;
                this.percentage = percentage;
                this.type = type;
            }

            public Reading(Object timestamp, Object percentage, Object type)
            {
                this.timestamp = DateTime.Parse(timestamp.ToString());
                float percentageTemp = 0;
                if(float.TryParse(percentage.ToString(), out percentageTemp)){
                    this.percentage = (int)percentageTemp;
                }
                else
                {
                    this.percentage = 0;
                }
                this.type = type.ToString();
            }
        }

        public string uniqueId;
        public List<Reading> readings;

        public Reading LatestReading()
        {
            DateTime latest = DateTime.MinValue;
            Reading result = new Reading(latest, 0, "");
            if (readings != null)
            {
                foreach(Reading reading in readings)
                {
                    if(reading.timestamp > latest)
                    {
                        latest = reading.timestamp;
                        result = reading;
                    }
                }
            }
            return result;
        }
    }
}