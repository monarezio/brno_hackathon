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

namespace HackathonBrno.Droid
{
    [Activity(Label = "SortLayout")]
    public class SortLayout : Activity
    {
        ListView listSort;
        List<ControlledDevice> controlledDevices = new List<ControlledDevice>();
        protected override void OnCreate(Bundle savedInstanceState)
        {
            base.OnCreate(savedInstanceState);
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
            listSort = FindViewById<ListView>(Resource.Id.listSort);
            foreach(ControlledDevice controlledDevice in controlledDevices)
            {
                 
            }
        }

        class ReadingResponse
        {
            List<ControlledDevice> devices = new List<ControlledDevice>();
        }
    }
}