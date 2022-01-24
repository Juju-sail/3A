%% Nettoyage environnement
clear;
close all;
clc;

load donneesfeu.dat %Importation doc de données

%% Création variable pour chaque collones
annee = donneesfeu(:,1);
bosquet = donneesfeu(:,2);
boisement = donneesfeu(:,3);
herbe = donneesfeu(:,4);
agricole = donneesfeu(:,5);
ordures = donneesfeu(:,6);
autres = donneesfeu(:,7);

%% On fait un graph pour afficher le nb de feux de bosquet chaque annees
figure %nouvelle fenetre de figure
plot(annee,bosquet, "ro")
%Ajout d'une legende et d'un titre au graph
legend("bosquet")
title("nombre d'incendis de bosquets en fonction de l'année")
%Ajout labels aux axes
xlabel("années")
ylabel("nombres d'incendis")
axis([min(annee) max(annee) min(bosquet) max(bosquet)])%reglages axes 
%[(min(abscice) max(abscice) min(ordonée) max(ordonée)]

%% On va faire deux graphs differents pour afficher les feux de bosquets et de boisement
figure %nouvelle fenetre de figure
subplot(2,1,1); %creation du premier des deux 
x = annee; %données abcise
y1 = bosquet; %données ordonée
plot(x,y1, "ro") %affichage
title("bosquet") %titre
xlabel("annees") %nom axes x
ylabel("nb incendis") %nom axe y
axis([min(annee) max(annee) 0 max(max(bosquet), max(boisement))]) %reglages des axes (voir dessus)

subplot(2,1,2); %creation du deuxième (et mêmes types reglages)
y2 = boisement;
plot(x,y2,"b*")
title("boisement")
xlabel("annees")
ylabel("nb incendis")
axis([min(annee) max(annee) 0 max(max(bosquet), max(boisement))])

%% Histogram
figure %nouvelle fenetre de figure
histogram(bosquet,10) %creation d'un histogram a partir des données de bosquet. Il contiendra 10 "rectangles"
title("distribution des données de feux de bosquet") %titre de l'histogram

%% Bar
figure("position", [0 20 1900 600]) %nouvelle fenetre de figure(j'ai agrandis la fenetre pour mieux lire les données ([absciceAngleBasGauche ordonnéesAngleBasGauche absciceAngleHautDroit ordonnéeAngleHautDroit]) 
type = [bosquet, boisement, herbe, agricole, ordures, autres]; %creation matrice identique a donnéesfeu mais sans les années
bar(annee,type) %creation diagram en barres années en abscice et "type en ordonnées"
legend("bosquet", "boisement", "herbe", "agricole", "ordures", "autres") %legende
title("proportion d'incendis par type de végétation en fonction de l'année") %titre
xlabel("années") %axe x nom
ylabel("nb incendis")%axe y nom

%% Pie
figure %nouvelle fenetre de figure
pie(sum(type)) %creation du diag (je fais la somme des chaque colonne de ma matrice type de façon à avoir une proportion de chaque type d'incendis)
legend("bosquet", "boisement", "herbe", "agricole", "ordures", "autres") %legende
title("proportion d'incendis en fonction du type de végétation en pourcentage")%titre

%% Spirale
figure %nouvelle fenetre de figure
t = 0:pi/50:10*pi; %definition de t allant de 0 à 10pi (intervalle : tous les pi/50)
st = sin(t); %creation fonction sinus(t) appelé st
ct = cos(t); %creation fonction cosinus(t) appelé ct
plot3(st,ct,t) %creation graphique tridimentionnel avec le sinus, le cosinus et le t
title("spirale 3D")
xlabel("sin(t)")
ylabel("cos(t)")
zlabel("t")

%% Diagram de Bode
figure %nouvelle fenetre de figure
w0 = 3.3*10^-3; % Pulsation en rad/s
H = tf([1],[1/w0 1]); % Filtre
bode(H) %diag de Bode




