using System;
using System.Windows.Controls;
using PageSwitcher;

namespace RaidResourceCalculator
{
    public class Navigator : ObjectModel, IPageSwitcher
    {
        private Page newPage;

        public Page NewPage
        {
            get { return newPage; }
            set
            {
                if (newPage == null || value != newPage)
                {
                    newPage = value;
                    OnPropertyChanged(nameof(NewPage));
                }
            }
        }

        public void Navigate(Page newPage)
        {
            NewPage = newPage;
        }

        public void Navigate(Page newPage, object state)
        {
            NewPage = newPage;
            ISwitchable s = newPage as ISwitchable;

            if (s != null) s.UtilizeState(state);
            else throw new ArgumentException("NextPage is not ISwitchable - " + newPage.Name.ToString());
        }
    }
}