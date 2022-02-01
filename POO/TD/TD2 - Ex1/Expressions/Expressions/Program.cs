using System;

namespace Expressions
{
    class Program
    {
        static void Main(string[] args)
        {
            //Somme s = new Somme(10, 23);
            //Console.WriteLine(s.Calcul());

            IExpression s1 = new Somme(new Valeur(10), new Valeur(23));
            Console.WriteLine(s1.Calcul());

            // 10 + (54 + 23)
            IExpression s2 = new Somme(new Valeur(10), new Somme(new Valeur(54), new Valeur(23)));
            Console.WriteLine(s2.Calcul());

            // 10 * (54 + 23)
            IExpression s3 = new Multiplication(new Valeur(10), new Somme(new Valeur(54), new Valeur(23)));
            Console.WriteLine(s3.Calcul());
        }
    }

    interface IExpression
    {
        double Calcul();
    }

    /*
    class Somme : IExpression
    {
        private readonly double _a, _b;

        public Somme(double a, double b)
        {
            _a = a;
            _b = b;
        }

        public double Calcul()
        {
            return _a + _b;
        }
    }
    */
    
    class Valeur : IExpression
    {
        private readonly double _v;

        public Valeur(double v)
        {
            _v = v;
        }

        public double Calcul()
        {
            return _v;
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

        public double Calcul()
        {
            return _a.Calcul() + _b.Calcul();
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

        public double Calcul()
        {
            return _a.Calcul() - _b.Calcul();
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

        public double Calcul()
        {
            return _a.Calcul() * _b.Calcul();
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

        public double Calcul()
        {
            return _a.Calcul() / _b.Calcul();
        }
    }
}
