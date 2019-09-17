using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace RaidResourceCalculator.Models
{
    [DataContract]
    public class FullInformation : ObjectModel
    {
        private DateTime timeStamp;
        [DataMember]
        public DateTime TimeStamp
        {
            get { return timeStamp; }
            set {
                if (timeStamp == null || timeStamp != value)
                {
                    timeStamp = value;
                    OnPropertyChanged(nameof(TimeStamp));
                }
            }
        }

        private double feastCost;
        [DataMember]
        public double FeastCost
        {
            get { return feastCost; }
            set {
                if (Math.Abs(feastCost - value)<=0.0000001)
                {
                    feastCost = value;
                    OnPropertyChanged(nameof(FeastCost));
                }
            }
        }

        private List<UserData> users;
        [DataMember]
        public List<UserData> Users
        {
            get { return users; }
            set
            {
                if (users == null || users != value)
                {
                    users = value;
                    OnPropertyChanged(nameof(Users));
                }
            }
        }


    }
}
