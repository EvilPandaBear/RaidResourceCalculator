using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading.Tasks;

namespace RaidResourceCalculator.Helpers
{
    public class JSONSerializer
    {
        public String Serialize<T>(T data)
        {
            using (var memStream = new MemoryStream())
            {
                var serialize = new DataContractJsonSerializer(typeof(T));
                serialize.WriteObject(memStream, data);
                memStream.Position = 0;

                using(var sReader = new StreamReader(memStream))
                {
                    String value = sReader.ReadToEnd();
                    sReader.Close();
                    memStream.Close();
                    return value;
                }
            }
        }

        public T Deserialize<T>(String json) where T : class
        {
            
            using (var memStream = new MemoryStream(Encoding.UTF8.GetBytes(json)))
            {
                var serialize = new DataContractJsonSerializer(typeof(T));
                T data = serialize.ReadObject(memStream) as T;
                memStream.Close();
                return data;
            }
            
        }
    }
}
