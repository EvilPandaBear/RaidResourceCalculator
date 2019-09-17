using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RaidResourceCalculator.Helpers
{
    public class FileHelper
    {
        public static String ReadFile(String path)
        {
            String text = null;
            try
            {
                text = File.ReadAllText(path);
            }catch(Exception exc)
            {
                Console.WriteLine(exc.Message);
            }
            return text;
        }

        public static String[] ReadStringLines(String path)
        {
            String[] lines = null;
            try
            {
                lines = File.ReadAllLines(path);
            }catch(Exception exc)
            {
                Console.WriteLine(exc.Message);
            }
            return lines;
        }

        public static void WriteToFile(String path, String text)
        {
            File.WriteAllText(path, text);
        }
    }
}
