using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;

namespace RaidResourceCalculator.Helpers
{
    public class UITools
    {
        public static T FindAncestor<T>(DependencyObject obj) where T : DependencyObject
        {
            while (obj != null)
            {
                T o = obj as T;
                if (o != null)
                    return o;
                obj = VisualTreeHelper.GetParent(obj);
            }
            return default(T);
        }
    }
}
