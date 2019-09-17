using PageSwitcher;
using RaidResourceCalculator.Helpers;
using RaidResourceCalculator.Pages;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace RaidResourceCalculator
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class RRCalculator : Window
    {
        private readonly RRCViewModel viewModel = new RRCViewModel();
        public RRCalculator()
        {
            InitializeComponent();
            DataContext = viewModel;
            Switcher.pageSwitcher = viewModel.Navigator;
            Switcher.Switch(new Overview());

            MenuList.Loaded += MenuList_Loaded;
            MenuList.PreviewMouseLeftButtonDown += MenuList_PreviewMouseLeftButtonDown;
            MenuList.PreviewKeyDown += MenuList_PreviewKeyDown;
        }

        private void MenuList_Loaded(object sender, RoutedEventArgs e)
        {
            MenuList.ItemContainerGenerator.ContainerFromIndex(0).SetValue(ListBoxItem.IsSelectedProperty, true);
        }

        private void MenuList_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            e.Handled = true;
        }

        private void MenuList_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            ListBoxItem lbItem = UITools.FindAncestor<ListBoxItem>(e.OriginalSource as DependencyObject) as ListBoxItem;
            bool isListBoxItem = lbItem != null;
            bool isButtonClicked = UITools.FindAncestor<Button>(e.OriginalSource as DependencyObject) is Button;
            if (isListBoxItem)
            {
                if (isButtonClicked) lbItem.SetValue(ListBoxItem.IsSelectedProperty, true);
                else e.Handled = true;
            }
        }

    }
}
