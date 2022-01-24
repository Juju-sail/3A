using System;
using System.Collections.Generic;

namespace TD1
{
    class program
    {
        static void Main(string[] args)
        {
            Point p = new Point();
            p.Affiche();
            p.Deplace(15, 8.5);
            p.Affiche();
            p.Deplace(3.5, 21.5);
            p.Affiche();

            Cercle c = new Cercle();
            c.Affiche();
            c.Deplace(8, 9);
            c.Affiche();
            c.Echelle(3);
            c.Affiche();

            Segment s = new Segment();
            s.Affiche();
            s.Deplace(4, 6);
            s.Affiche();

            Polygone poly = new Polygone(5);
            poly.Affiche();


            Console.WriteLine("##################################################");

            Compte c1 = new Compte(100);
            Console.WriteLine($"c1 : {c1.Solde}");

            
            c1.Credit(10);
            Console.WriteLine($"c1 : {c1.Solde}");

            c1.Debit(300);
            Console.WriteLine($"c1 : {c1.Solde}");

            c1.Debit(80);
            Console.WriteLine($"c1 : {c1.Solde}");
            

            CompteDecouvert c2 = new CompteDecouvert(400, 200);
            Console.WriteLine($"c2 : {c2.Solde}");

            Transaction(c2, c1, 150);
            Console.WriteLine($"c1 : {c1.Solde}");
            Console.WriteLine($"c2 : {c2.Solde}");

            Transaction(c2, c1, 300);
            Console.WriteLine($"c1 : {c1.Solde}");
            Console.WriteLine($"c2 : {c2.Solde}");


            static bool Transaction(ICompte source, ICompte cible, int montant)
            {
                if (source.Debit(montant))
                {
                    cible.Credit(montant);
                    return true;
                }

                return false;
            }
        }
    }

    class Point
    {
        private double _x;
        private double _y;

        public void Affiche()
        {
            Console.WriteLine("x = " + _x + "; y = " + _y);
        }
        public void Deplace(double dx, double dy)
        {
            _x += dx;
            _y += dy;
        }
    }

    class Cercle
    {
        private Point _point = new Point();
        private double _rayon = 1;

        public double get_rayon()
        {
            return _rayon;
        }

        public void Echelle(double e)
        {
            _rayon *= e;
        }

        public void Deplace(double dx, double dy)
        {
            _point.Deplace(dx, dy);
        }

        public void Affiche()
        {
            Console.WriteLine("CERCLE");
            _point.Affiche();
            Console.WriteLine("rayon = " + _rayon);
        }
    }

    class Segment
    {
        private Point _a = new Point();
        private Point _b = new Point();

        public void Affiche()
        {
            Console.WriteLine("SEGMENT");
            _a.Affiche();
            _b.Affiche();
        }

        public void Deplace(double dx, double dy)
        {
            _a.Deplace(dx, dy);
            _b.Deplace(dx, dy);
        }
    }

    class Polygone
    {
        private int taille = 3;
        private List<Point> mesPoints = new List<Point>();

        public Polygone(int lataille)
        {
            taille = lataille;
            for (int i = 0; i < taille; i++)
            {
                Point point = new Point();
                mesPoints.Add(point);
            }
        }

        public void Affiche()
        {
            Console.WriteLine("POLYGONE(" + taille + ")");
            for (int i = 0; i < taille; i++)
            {
                mesPoints[i].Affiche();
            }
        }
    }

    class Compte : ICompte
    {
        private int _solde;

        public Compte(int solde)
        {
            _solde = solde;
        }

        public int Solde
        {
            get { return _solde; }
        }

        public void Credit(int montant)
        {
            _solde += montant;
        }

        public bool Debit(int montant)
        {
            if (_solde >= montant)
            {
                _solde -= montant;
                return true;
            }

            return false;
        }
    }

    class CompteDecouvert : ICompte
    {
        private readonly int _decouvert;

        private int _solde;

        public CompteDecouvert(int decouvert, int solde)
        {
            _decouvert = decouvert;
            _solde = solde;
        }

        public int Solde
        {
            get { return _solde; }
        }

        public void Credit(int montant)
        {
            _solde += montant;
        }

        public bool Debit(int montant)
        {
            if ((_solde + _decouvert) >= montant)
            {
                _solde -= montant;
                return true;
            }

            return false;
        }
    }

    interface ICompte
    {
        void Credit(int montant);

        bool Debit(int montant);
    }
}

