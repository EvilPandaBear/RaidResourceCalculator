using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace RaidResourceCalculator.Helpers
{
    public class DefaultCommand : ICommand
    {
        public delegate void ICommandOnExecute(object parameter);
        public delegate bool ICOmmandOnCanExecute(object parameter);

        private ICommandOnExecute execute;
        private ICOmmandOnCanExecute canExecute;

        public DefaultCommand(ICommandOnExecute onExecuteMethod, ICOmmandOnCanExecute onCanExecuteMethod)
        {
            execute = onExecuteMethod;
            canExecute = onCanExecuteMethod;
        }

        public event EventHandler CanExecuteChanged
        {
            add { CommandManager.RequerySuggested += value; }
            remove { CommandManager.RequerySuggested -= value; }
        }

        public bool CanExecute(object parameter)
        {
            return canExecute.Invoke(parameter);
        }

        public void Execute(object parameter)
        {
            execute.Invoke(parameter);
        }
    }
}
