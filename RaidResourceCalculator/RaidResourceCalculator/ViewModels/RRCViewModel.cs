using RaidResourceCalculator.Pages;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace RaidResourceCalculator
{
    public class RRCViewModel
    {
        public List<MenuItem> MenuItems { get; set; }
        public Navigator Navigator { get; set; }
        public RRCViewModel()
        {
            Navigator = new Navigator();
            InitMenuItems();
        }

        private void InitMenuItems()
        {
            MenuItems = new List<MenuItem>()
            {
                new MenuItem(){MenuText="Show Data", NextPage=new Overview()},
                new MenuItem(){MenuText="Import", NextPage=new Import()},
                new MenuItem(){MenuText="Export", NextPage=new Export()},
                new MenuItem(){MenuText="Upload", NextPage=new Upload()},
                new MenuItem(){MenuText="Preferences", NextPage=new Preferences()}
            };
        }

    }
}
