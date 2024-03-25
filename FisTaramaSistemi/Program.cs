using System;
using System.IO;
using System.Net;
using System.Xml.Linq;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace KAIZEN
{
    class Program
    {
        static void Main(string[] args)
        {
            // Google Drive'dan dosyayı indirme URL'si
            string url = "https://drive.google.com/uc?export=download&id=1J_S-JZ7RCk9qHXAzVm_Y-OUoxe5D9MnR";

            // Dosyayı indirme ve kaydetme
            string tempFilePath = Path.GetTempFileName(); // Geçici bir dosya oluştur
            using (WebClient client = new WebClient())
            {
                client.DownloadFile(url, tempFilePath);
            }

            // İndirilen dosyayı okuma
            string json = File.ReadAllText(tempFilePath);

            JArray jArray = JArray.Parse(json);

            foreach (JObject item in jArray)
            {
                string description = item["description"].ToString();
                JArray vertices = (JArray)item["boundingPoly"]["vertices"];

                int minY = Int32.MaxValue;
                int maxY = Int32.MinValue;
                foreach (JObject vertex in vertices)
                {
                    int y = (int)vertex["y"];
                    if (y < minY)
                        minY = y;
                    if (y > maxY)
                        maxY = y;
                }

                
                Console.WriteLine(description);
            }

            // Geçici dosyayı temizleme
            File.Delete(tempFilePath);
        }
    }
}
