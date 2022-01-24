# Lire le fichier
# split chaque ligne par tilde
# Faire liste de liste

# creer un dictionnaire {nb : [homme, phrase], nb : [homme, phrase], ...}

# creer nb aleat pour choisir un truc du dico et afficher dico[nb]

import random

my_citations = open("quotes.txt", "r")
tab = []
nb_line = 0
nombres = []
dico = {}



for line in my_citations:
    reference = line.split("~")
    tab.append(reference)
    nb_line += 1

for i in range(0, nb_line):
    nombres.append(i)
    dico[i] = tab[i]

choix = random.choice(nombres)

print("Citation :", dico[choix][0], "De", dico[choix][1])