using System;

namespace Tutos
{
    class Program
    {
        public static Boolean IsPremier(int n)
        {
            int nbFact = 0;
            for (int i = 1; i < n; i++)
            {
                if(n%i == 0)
                {
                    nbFact++;
                }
            }
            if(nbFact == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        static void Main(string[] args)
        {
            // HEllo Nom
            string nom = Console.ReadLine();
            Console.WriteLine($"Hello {nom} !");
            Console.WriteLine("Hello " + nom + " !");

            // nb premiers
            int nb = int.Parse(Console.ReadLine());
            for (int i = 1; i < nb+1; i++)
            {
                if (IsPremier(i))
                {
                    Console.WriteLine(i + ";");
                }
            }

           
        }
    }
}
