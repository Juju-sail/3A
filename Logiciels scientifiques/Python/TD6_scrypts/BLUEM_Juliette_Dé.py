import random

# Exercice 1 :

de = random.randint(1,6) # Le joueur lance le dé
faces = {}

# On crée un dictionnaire qui va permetre d'afficher la face du dé lancé :
faces[1] = " -------\n |     | \n |  o  |\n |     |\n -------"
faces[2] = " -------\n |    o| \n |     |\n |o    |\n -------"
faces[3] = " -------\n |o    | \n |  o  |\n |    o|\n -------"
faces[4] = " -------\n |o   o| \n |     |\n |o   o|\n -------"
faces[5] = " -------\n |o   o| \n |  o  |\n |o   o|\n -------"
faces[6] = " -------\n |o   o| \n |o   o|\n |o   o|\n -------"

# Tests :
# print(de)
print(faces[de])


