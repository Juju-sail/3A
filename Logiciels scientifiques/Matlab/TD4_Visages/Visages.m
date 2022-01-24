clear;
clc;
close all;

%% Chargement de la base et centrage des visages
load YaleFaces.mat;

xmoy = mean(X_train,2); %équivaut à xmoy = sum(X_train,2)/size(X_train,2);

X_c = X_train - xmoy; %centrage

figure
for i=1:9
    subplot(3,3,i)
    convertir(X_train,i) %appel fonction convertir (en bas de la page)
end

figure
for i=1:9
    subplot(3,3,i)
    convertir(X_c,i) %appel fonction convertir (en bas de la page)
end


%% Calcul des vecteurs caractéristiques
[U, S, V] = svd(X_c,0); %On utilise la fonction matlab svd sur la matrice centrée (type 0)

for i=1:90
    P(i)=S(i,i)*S(i,i); % On met le caré des valeur diag de S dans P
end
Q = P/sum(P(:)); % On prend le pourcentage de chaque valeur par rapport à la somme totale du vecteur
testPourcentageSomme = sum(Q(:)) % Test pour voir si on a bien des pourcentages (doit être égal à 1)

figure
plot(1:90,cumsum(Q(:)),"r-") % On affiche sur l'axe x : K, et sur y : la somme cumulée des valeurs de Q (pourcentages)
title("courbe de la somme cumulée des valeurs propres en pourcentage");
xlabel("K (sans unité)");
ylabel("pourcentage cumulé (en %)");
rep = "si K=11, on a une bonne restitution"

%% Projection dans le sous-espace des visages
xR = reconstruction(X_train,U,xmoy,11,1); % Appel de notre fonction avec K = 11 et nb =1

d=1;
p=90;
nb=1;
for i = d:4096
    %er = X_train(:,nb)- reconstruction(X_train,U,xmoy,11,nb);
    %er = sum(er.*er);
    
end
%er = sqrt(er);
% Je n'ai aucune idée de ce que fais p dans x et x reconstruite... 
% Je ne comprend pas nonplus pourquoi au final, mon erreur est en 1*90 et
% pas 1*1 alors que je travaille bien sur une seule image (nb) et pas sur
% toutes...

figure("position", [0 20 1900 600])
for i=1:9
    subplot(2,9,i)
    convertir(X_c,i) %appel fonction convertir (en bas de la page)
    a = reconstruction(X_train,U,xmoy,90,i);
    subplot(2,9,i+9)
    convertir(a,i)
end
% On voit que, avec K = 11, la reconstruction de visage est plutot efficasse
% Si K =2, il fait des erreurs de reconstruction !
% Si K=90, les images reconstruites sont plus belles, moins pixelisées

%% Fonctions
function [] = convertir(X,c)
    j=1;
    m=zeros(64,64);
    for i=1:64:size(X(:,c),1)
        m(:,j) = X(i:(i+63),c);
        j=j+1;
    end
    imshow(mat2gray(m))
end

function [xR] = reconstruction(Xt,U,xmoy,K,nb) 
% Nous utilisons notre matrice BDD, notre matrice de vecteurs carracteristiques, notre image moyenne
%On choisi un K qui va nous donner une precision, et un nombre qui va permetre le choix d'image à reconstruire dans Xt
    x = Xt(:,nb); % On prend une seule image de Xt
    z = U(:,1:K)' * (Xt-xmoy); % Calcul du projeté de l'image x
    xR = xmoy + U(:,1:K)*z; % Image reconstruite de x
end

