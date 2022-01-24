using System;

namespace Expressions
{
    class Program
    {
        static void Main(string[] args)
        {
            // 10 * (54 + 23)
            IExpression e1 = new Multiplication(new Valeur(10), new Somme(new Valeur(54), new Valeur(23)));
            double r1;
            if (e1.Calcul(out r1)) Console.WriteLine(r1); else Console.WriteLine("Echec");

            // 10 / (23 - 23)
            IExpression e2 = new Division(new Valeur(10), new Différence(new Valeur(23), new Valeur(23)));
            double r2;
            if (e2.Calcul(out r2)) Console.WriteLine(r2); else Console.WriteLine("Echec");

            // 123 + (10 / (23 - 23))
            IExpression e3 = new Somme(new Valeur(10), 
                new Division(new Valeur(10), new Différence(new Valeur(23), new Valeur(23))));
            double r3;
            if (e3.Calcul(out r3)) Console.WriteLine(r3); else Console.WriteLine("Echec");
        }
    }

    interface IExpression
    {
        // out : passage par référence, uniquement en écriture
        bool Calcul(out double resultat);
    }
        
    class Valeur : IExpression
    {
        private readonly double _v;

        public Valeur(double v)
        {
            _v = v;
        }

        public bool Calcul(out double resultat)
        {
            resultat = _v;
            return true;
        }
    }

    class Somme : IExpression
    {
        private readonly IExpression _a, _b;

        public Somme(IExpression a, IExpression b)
        {
            _a = a;
            _b = b;
        }

        public bool Calcul(out double resultat)
        {
            double ra, rb;

            if (_a.Calcul(out ra) && _b.Calcul(out rb)) // ra et rb sont écrits
            {
                resultat = ra + rb;
                return true;
            }
            else
            {
                resultat = 0; // Arbitraire
                return false;
            }
        }
    }

    class Différence : IExpression
    {
        private readonly IExpression _a, _b;

        public Différence(IExpression a, IExpression b)
        {
            _a = a;
            _b = b;
        }

        public bool Calcul(out double resultat)
        {
            double ra, rb;

            if (_a.Calcul(out ra) && _b.Calcul(out rb)) // ra et rb sont écrits
            {
                resultat = ra - rb;
                return true;
            }
            else
            {
                resultat = 0; // Arbitraire
                return false;
            }
        }
    }

    class Multiplication : IExpression
    {
        private readonly IExpression _a, _b;

        public Multiplication(IExpression a, IExpression b)
        {
            _a = a;
            _b = b;
        }

        public bool Calcul(out double resultat)
        {
            double ra, rb;

            if (_a.Calcul(out ra) && _b.Calcul(out rb)) // ra et rb sont écrits
            {
                resultat = ra * rb;
                return true;
            }
            else
            {
                resultat = 0; // Arbitraire
                return false;
            }
        }
    }

    class Division : IExpression
    {
        private readonly IExpression _a, _b;

        public Division(IExpression a, IExpression b)
        {
            _a = a;
            _b = b;
        }

        public bool Calcul(out double resultat)
        {
            double ra, rb;

            if (_a.Calcul(out ra) && _b.Calcul(out rb)  // ra et rb sont écrits
                && rb != 0.0) // Test de non division par zéro
            {
                resultat = ra / rb;
                return true;
            }
            else
            {
                resultat = 0; // Arbitraire
                return false;
            }
        }
    }
}
