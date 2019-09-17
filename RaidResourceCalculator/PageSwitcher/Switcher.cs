using System;
using System.Windows.Controls;

namespace PageSwitcher
{
    public static class Switcher
    {
        public static IPageSwitcher pageSwitcher;
        public static void Switch(Page newPage)
        {
            pageSwitcher.Navigate(newPage);
        }

        public static void Switch(Page newPage, object state)
        {
            pageSwitcher.Navigate(newPage, state);
        }
    }
}
