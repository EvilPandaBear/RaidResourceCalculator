using RaidResourceCalculator.Helpers;
using System;
using System.ComponentModel;
using System.Windows.Controls;
using System.Windows.Input;

namespace RaidResourceCalculator
{
    public class MenuItem : ObjectModel
    {
        public ICommand MenuItemSelected{ get; set; }
        private string menuText;

        public string MenuText
        {
            get { return menuText; }
            set
            {
                menuText = value;
                OnPropertyChanged(nameof(MenuText));
            }
        }

        private Page nextPage;

        public Page NextPage
        {
            get { return nextPage; }
            set
            {
                nextPage = value;
                OnPropertyChanged(nameof(NextPage));
            }
        }

        public MenuItem()
        {
            MenuItemSelected = new DefaultCommand(MenuItem_Execute,MenuItem_CanExecute);
        }

        private void MenuItem_Execute(object parameter)
        {
            PageSwitcher.Switcher.Switch(nextPage);
        }

        private bool MenuItem_CanExecute(object parameter)
        {
            return true;
        }
    }
}