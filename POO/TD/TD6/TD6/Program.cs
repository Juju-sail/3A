using System;
using System.Collections;
using System.IO;
using System.Linq;

namespace TD6
{
    class Program
    {
        static void Main(string[] args)
        {
            /* Tests Première partie :
            Shell c1 = new Shell(@"D:\juliette\Downloads");
            Shell c2 = new Shell(Directory.GetCurrentDirectory());
            
            c1.Enfant(@"D:\juliette\Downloads\TD2 - Ex1");
            c1.Liste();
            c1.Parent();
            c1.Liste();
            Console.WriteLine($"taille : {c1.Taille()} Go");
            */

            // Boucle :
            int action = 0;
            Console.WriteLine("Choisir un repertoire dans lequel travailler");
            Shell s = new Shell(Console.ReadLine());
            while (action < 4)
            {
                Console.WriteLine("Veuillez choisir une action : ");
                Console.WriteLine(" 0 - Lister les elements du repertoire");
                Console.WriteLine(" 1 - Afficher la taille du repertoire");
                Console.WriteLine(" 2 - Retourner en arrière");
                Console.WriteLine(" 3 - Avancer vers ...");
                Console.WriteLine(" 4 - Quitter");
                try
                {
                    action = int.Parse(Console.ReadLine());
                    if (action == 0)
                    {
                        s.Liste();
                    }
                    else if (action == 1)
                    {
                        Console.WriteLine(s.Taille() + "Go");
                    }
                    else if (action == 2)
                    {
                        s.Parent();
                    }
                    else if (action == 3)
                    {
                        Console.WriteLine("Veuillez choisir le repertoire enfant");
                        s.Enfant(Console.ReadLine());
                    }
                    else if (action == 4)
                    {
                        // Do nothing, ça va quitter car fin du while
                    }
                    else
                    {
                        Console.WriteLine("Veuillez choisir une action");
                    }
                }
                catch
                {
                    Console.WriteLine("Veuillez rentrer un chemin valide");
                }
            }
            
            
        }
    }

    class Shell
    {
        private String _chemin;

        public Shell(String chemin)
        {
            _chemin = chemin;
        }

        public String chemin
        {
            get => _chemin;
            set
            {
                _chemin = chemin;
            }
        }

        public void Liste()
        {
            // Afficher emplacement
            
            Console.WriteLine($"Emplacement : {_chemin}");

            // Afficher Dossiers
            var directories = from dir in
                Directory.EnumerateDirectories(_chemin)
                    select dir;
            
            Console.WriteLine("\nRepertoires : ");
            foreach (var dir in directories)
            {
                Console.WriteLine("{0}", dir.Substring(dir.LastIndexOf("\\") + 1));
            }

            //Afficher Fichiers
            DirectoryInfo curDir = new DirectoryInfo(_chemin);
            FileInfo[] files = curDir.GetFiles();
            Console.WriteLine("\nFichiers : ");
            foreach (FileInfo file in files)
            {
                Console.WriteLine($"{file.Name} _ {file.CreationTime}");
            }
        }

        public void Enfant(String nom)
        {
            foreach(var enfant in Directory.EnumerateDirectories(_chemin))
            {
                if(enfant == nom)
                {
                    _chemin = nom;
                }
            }
        }


        public void Parent()
        {
            _chemin = Directory.GetParent(_chemin).ToString();
        }

        public double Taille()
        {
            DirectoryInfo curDir = new DirectoryInfo(_chemin);
            FileInfo[] files = curDir.GetFiles();

            double taille = 0;
            taille += Taille(curDir);
            
            taille /= 1024; // byte à ko
            taille /= 1024; // ko à Mo
            taille /= 1024; // Mo à Go

            

            return taille;
        }

        public double Taille(DirectoryInfo myDir)
        {
            double size = 0;

            FileInfo[] files = myDir.GetFiles();

            foreach (FileInfo file in files)
            {
                size += file.Length;
            }
            foreach (DirectoryInfo enfant in myDir.GetDirectories())
            {
                size += Taille(enfant);
            }
            return size;
        }
        
    }
}
