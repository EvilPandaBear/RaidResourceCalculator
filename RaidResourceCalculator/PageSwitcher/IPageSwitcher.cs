using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Controls;

namespace PageSwitcher
{
    public interface IPageSwitcher
    {
        void Navigate(Page newPage);
        void Navigate(Page newPage, object state);
    }
}
