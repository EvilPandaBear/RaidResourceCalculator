using RaidResourceCalculator.Helpers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RaidResourceCalculator.ViewModels
{
    public class OverviewViewModel : ObjectModel
    {
        public const String FileLocation = "OverviewData.json";

        public List<UserData> UserData { get; set; }

        public OverviewViewModel()
        {
            LoadCurrentData();
        }

        private async void LoadCurrentData()
        {
            using (var fileStream = new FileStream(FileLocation, FileMode.OpenOrCreate,FileAccess.Read))
            using (var reader = new StreamReader(fileStream))
            {
                var fileText = await reader.ReadToEndAsync();
                JSONSerializer serializer = new JSONSerializer();
                UserData = serializer.Deserialize<List<UserData>>(fileText);
                OnPropertyChanged(nameof(UserData));
            }
        }
    }
}
