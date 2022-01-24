using System;

namespace TD3
{
    class Program
    {
        static void Main(string[] args)
        {
           Console.WriteLine("##########ARBRES LECTURE##########");
            
            ArbreSomme as7 = new ArbreSomme(7);
            ArbreSomme as6 = new ArbreSomme(6);
            ArbreSomme as3 = new ArbreSomme(3, as6, as7);
            ArbreSomme as5 = new ArbreSomme(5);
            ArbreSomme as4 = new ArbreSomme(4);
            ArbreSomme as2 = new ArbreSomme(2, as4, as5);
            ArbreSomme as1 = new ArbreSomme(1, as2, as3);

            Action<int> lect = lecture;

            Console.WriteLine("Prefixe");
            as1.Prefixe(lect);
            Console.WriteLine("Infixe");
            as1.Infixe(lect);
            Console.WriteLine("Sufixe");
            as1.Sufixe(lect);

            
            Console.WriteLine("##########ARBRES SOMME##########");


            Console.WriteLine($"avant calcul : {as1.somme}");
            as1.Infixe(as1.Somme);
            Console.WriteLine($"apres calcul : {as1.somme}");

        }

        public static void lecture<T>(T emplacement)
        {
            Console.WriteLine(emplacement);
        }


        public class Arbre<T>
        {
            // Attributs d'un arbre
            private Arbre<T> _gauche;
            private Arbre<T> _droit;
            private T _ici;

            
            // Get pour _ici
            public T ici
            {
                get => _ici;
            }
           
            // Constructeurs arbre
            public Arbre(T valeur, Arbre<T> gauche, Arbre<T> droit) // noeuds
            {
                _ici = valeur;
                _gauche = gauche;
                _droit = droit;
            }
            public Arbre(T valeur) // feuilles
            {
                _ici = valeur;
                _gauche = null;
                _droit = null;
            }

            public Arbre() // par defaut
            {
                _ici = default(T);
                _gauche = null;
                _droit = null;
            }
            

            // Méthode de parcours d'arbres
            public void Prefixe(Action<T> action)
            {
                action(this.ici);
                if(_gauche != null) _gauche.Prefixe(action);
                if(_droit != null) _droit.Prefixe(action);
                
            }

            public void Infixe(Action<T> action)
            {
                if (_gauche != null) _gauche.Infixe(action);
                action(this.ici);
                if (_droit != null) _droit.Infixe(action);
            }

            public void Sufixe(Action<T> action)
            {
                if (_gauche != null) _gauche.Sufixe(action);
                if (_droit != null) _droit.Sufixe(action);
                action(this.ici);
            }

        }

        public class ArbreSomme : Arbre<int>
        {
            // Attribut propre à ArbreSomme
            private int _somme;

            // Constructeurs (base() : heritage)
            public ArbreSomme(int valeur, Arbre<int> gauche, Arbre<int> droit) : base(valeur, gauche, droit) // noeuds
            {
                _somme = 0;
            }
            public ArbreSomme(int valeur) : base(valeur) // feuilles
            {
                _somme = 0;
            }

            public ArbreSomme() : base() // par defaut
            {
                _somme = 0;
            }

            // Gets et Sets
            public int somme
            {
                get => _somme;
                set => _somme = value;
            }

            // Action Somme
            public void Somme(int ici)
            {
                _somme += ici;
            }

        }
    }
}
