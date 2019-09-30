﻿using RaidResourceCalculator.ViewModels;
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

namespace RaidResourceCalculator.Pages
{
    /// <summary>
    /// Interaction logic for Overview.xaml
    /// </summary>
    public partial class Overview : Page
    {
        private readonly OverviewViewModel viewModel = new OverviewViewModel();
        public Overview()
        {
            InitializeComponent();
            ShowsNavigationUI = false;
            DataContext = viewModel;
        }
    }
}
