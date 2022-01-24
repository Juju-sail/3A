using System;

namespace TD2
{
    class Program
    {
        static void Main(string[] args)
        {
            Somme s = new Somme(new Valeur(10), new Valeur(25));
            Console.WriteLine($"Somme de {s.Nb1} et {s.Nb2} de : {s.Calcul()}");

            Difference d = new Difference(new Valeur(10), new Valeur(25));
            Console.WriteLine($"Difference de {s.Nb1} et {s.Nb2} de : {s.Calcul()}");

            Multiplication m = new Multiplication(new Valeur(10), new Valeur(25));
            Console.WriteLine($"Multiplication de {s.Nb1} et {s.Nb2} de : {s.Calcul()}");

        }

        interface IExpression { 
            double Calcul(); 
        }

        class Valeur : IExpression
        {
            private double _nb;

            public Valeur(double nb)
            {
                _nb = nb;
            }

            public double Calcul()
            {
                return _nb;
            }

            
        }

        class Somme : IExpression
        {
            private readonly IExpression _nb1, _nb2;

            public Somme(IExpression nb1, IExpression nb2)
            {
                _nb1 = nb1;
                _nb2 = nb2;
            }

            public double Calcul()
            {
                return _nb1.Calcul() + _nb2.Calcul();
            }

            public double Nb1
            {
                get { return _nb1.Calcul(); }
            }

            public double Nb2
            {
                get { return _nb2.Calcul(); }
            }


        }


        class Difference : IExpression
        {
            private readonly IExpression _nb1, _nb2;

            public Difference(IExpression nb1, IExpression nb2)
            {
                _nb1 = nb1;
                _nb2 = nb2;
            }

            public double Calcul()
            {
                return _nb1.Calcul() - _nb2.Calcul();
            }

            public double Nb1
            {
                get { return _nb1.Calcul(); }
            }

            public double Nb2
            {
                get { return _nb2.Calcul(); }
            }


        }


        class Multiplication : IExpression
        {
            private readonly IExpression _nb1, _nb2;

            public Multiplication(IExpression nb1, IExpression nb2)
            {
                _nb1 = nb1;
                _nb2 = nb2;
            }

            public double Calcul()
            {
                return _nb1.Calcul() * _nb2.Calcul();
            }

            public double Nb1
            {
                get { return _nb1.Calcul(); }
            }

            public double Nb2
            {
                get { return _nb2.Calcul(); }
            }


        }




    }
}
