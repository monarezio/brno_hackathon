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
using Firebase;
using Firebase.Database.Query;
using System.Threading.Tasks;
using System.Net;
using System.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Android.Graphics;

namespace HackathonBrno.Droid
{
    [Activity(Label = "SortLayout")]
    public class SortLayout : Activity
    {
        public LinearLayout linearSort;
        public float threshold = 50;
        List<ControlledDevice> controlledDevices = new List<ControlledDevice>();

        Color red = new Color(237, 26, 40);
        protected override void OnCreate(Bundle savedInstanceState)
        {
            base.OnCreate(savedInstanceState);
            this.SetContentView(Resource.Layout.SortLayout);
            GetFirebaseData();
            CreateList();
        }

        void GetFirebaseData(bool ascending = true)
        {
            controlledDevices.Clear();

            var request = WebRequest.CreateHttp("https://smart-trash-78dcb.firebaseio.com/reading.json");
            request.Method = "GET";
            var response = request.GetResponse();

            var json = (new StreamReader(response.GetResponseStream())).ReadToEnd();
            var values = JsonConvert.DeserializeObject<Dictionary<Object, Object>>(json);

            foreach (string s in values.Keys)
            {
                ControlledDevice controlledDevice = new ControlledDevice()
                {
                    uniqueId = s
                };
                string type = values[s].GetType().ToString();
                JObject jObject = (JObject)values[s];
                foreach(JProperty child in jObject.Children())
                {
                    ControlledDevice.Reading reading = new ControlledDevice.Reading(jObject[child.Name]["timestamp"],
                        jObject[child.Name]["percentage"], jObject[child.Name]["type"]);
                    controlledDevice.readings.Add(reading);
                }
                controlledDevices.Add(controlledDevice);
            }
        }
        

        void CreateList()
        {
            controlledDevices.Sort((a, b) => b.LatestReading().percentage - a.LatestReading().percentage);
            linearSort = FindViewById<LinearLayout>(Resource.Id.linearSort);
            foreach(ControlledDevice controlledDevice in controlledDevices)
            {
                LinearLayout deviceHorizontal = new LinearLayout(this)
                {
                    Orientation = Orientation.Horizontal
                };
                LinearLayout deviceVertical = new LinearLayout(this)
                {
                    Orientation = Orientation.Vertical
                };
                deviceVertical.SetPadding(30, 20, 30, 20);
                deviceVertical.Click += OnClickDevice;
                deviceVertical.Tag = controlledDevice.uniqueId;
                //Device Name
                TextView deviceName = new TextView(this){
                    TextSize = 24,
                    Text = controlledDevice.uniqueId
                };

                deviceVertical.AddView(deviceName);

                //Latest Percentage
                int percent = controlledDevice.LatestReading().percentage;
                TextView latestPercentage = new TextView(this)
                {
                    TextSize = 30,
                    TextAlignment = TextAlignment.ViewEnd,
                    Text = percent.ToString()
                };

                if(percent < threshold)
                {
                    deviceName.SetTextColor(red);
                    latestPercentage.SetTextColor(red);
                }

                //Last Update
                TextView lastUpdate = new TextView(this)
                {
                    Text = controlledDevice.LatestReading().timestamp.ToString()
                };

                deviceVertical.AddView(lastUpdate);

                deviceHorizontal.AddView(deviceVertical);
                deviceHorizontal.AddView(latestPercentage);

                linearSort.AddView(deviceHorizontal);
            }
        }

        void OnClickDevice(object a, EventArgs b)
        {
            LinearLayout linearLayout = (LinearLayout)a;
            string uniqueId = linearLayout.Tag.ToString();
            ControlledDevice device = controlledDevices.Find(x => x.uniqueId == uniqueId);

            Console.WriteLine(device);
        }
    }
}