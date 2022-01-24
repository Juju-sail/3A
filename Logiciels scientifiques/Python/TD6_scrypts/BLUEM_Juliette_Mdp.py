import string
import random


# Fonctions :
def choix(reponse, nb):
    if(reponse=="yes"):
        possibilites.append(nb)
        print("Utilisation de", transfo[nb])
    else:
        print("Pas d'usage de", transfo[nb])

# Bonus :
transfo = {1 : "minuscules", 2 : "majuscules", 3 : "chiffres", 4 : "ponctuaction"} # Pour plus de clarté lors de l'affichage

# Code :
minuscule = string.ascii_lowercase
majuscule = string.ascii_uppercase
chiffre = [0,1,2,3,4,5,6,7,8,9]
ponctuaction = string.punctuation

try :
    taille_mdp = int(input("Veuillez choisir la taille de votre mot de passe : ")) # Donner le choix à l'utilisateur pour taille du mdp
except :
    taille_mdp = 8
    print("Erreur, taille par defaut : 8")

mdp = ""

# Donner le choix à l'utilisateur pour min, maj, chiff, ponct :
possibilites = []

utilisateur1 = input("Voulez-vous des minuscules ? (yes/no) : ")
utilisateur2 = input("Voulez-vous des majuscules ? (yes/no) : ")
utilisateur3 = input("Voulez-vous des chiffres ? (yes/no) : ")
utilisateur4 = input("Voulez-vous de la ponctuation ? (yes/no) : ")

choix(utilisateur1, 1)
choix(utilisateur2, 2)
choix(utilisateur3, 3)
choix(utilisateur4, 4)

# Verrification pas de mdp sans carracteres
if(utilisateur1 == utilisateur2 == utilisateur3 == utilisateur4 != "yes"):
    print("PAS DE MDP VIDE SVP")
    quit()


# Definition du mdp :
for i in range(0,taille_mdp):
    id = random.choice(possibilites)
    if(id==1):
        mdp += random.choice(minuscule)
    if(id==2):
        mdp += random.choice(majuscule)
    if(id==3):
        mdp += str(random.choice(chiffre))
    if(id==4):
        mdp += random.choice(ponctuaction)

# Affichage du mdp :

print("Voici votre mot de passe élaboré selon vos choix :", mdp)