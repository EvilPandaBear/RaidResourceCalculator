using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace RaidResourceCalculator
{
    [DataContract]
    public class UserData : ObjectModel
    {
        private String name;
        [DataMember]
        public String Name
        {
            get { return name; }
            set {
                if (name != null || name != value)
                {
                    name = value;
                    OnPropertyChanged(nameof(Name));
                }
            }
        }

        private int flasksUsed;
        [DataMember]
        public int FlasksUsed
        {
            get { return flasksUsed; }
            set {
                if (flasksUsed != value)
                {
                    flasksUsed = value;
                    OnPropertyChanged(nameof(FlasksUsed));
                }
            }
        }

        private int feastsUsed;
        [DataMember]
        public int FeastsUsed
        {
            get { return feastsUsed; }
            set {
                if (feastsUsed != value)
                {
                    feastsUsed = value;
                    OnPropertyChanged(nameof(FeastsUsed));
                }
            }
        }

        private int flasksPaid;
        [DataMember]
        public int FlasksPaid
        {
            get { return flasksPaid; }
            set {
                if (flasksPaid != value)
                {
                    flasksPaid = value;
                    OnPropertyChanged(nameof(FlasksPaid));
                }
            }
        }

        private double feastMoneyPaid;
        [DataMember]
        public double FeastMoneyPaid
        {
            get { return feastMoneyPaid; }
            set {
                if (Math.Abs(feastMoneyPaid - value) >= 0.000001)
                {
                    feastMoneyPaid = value;
                    OnPropertyChanged(nameof(FeastMoneyPaid));
                }
            }
        }


        private int flaskBalance;
        [DataMember]
        public int FlaskBalance
        {
            get { return flaskBalance; }
            set {
                if (flaskBalance != value)
                {
                    flaskBalance = value;
                    OnPropertyChanged(nameof(FlaskBalance));
                }
            }
        }

        private double feastBalance;
        [DataMember]
        public double FeastBalance
        {
            get { return feastBalance; }
            set {
                if (Math.Abs(feastBalance - value) >= 0.000001)
                {
                    feastBalance = value;
                    OnPropertyChanged(nameof(FeastBalance));
                }
            }
        }


    }
}
