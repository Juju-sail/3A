%Bluem Juliette
%3A, 2i
%5 octobre 2020
%Dans ce TP, nous allons travailler sur de la modification de couleurs
%d'une image. 

%Nettoyage environnement :
clear;
close all;
clc;
%% Introduction
im = imread('Image_banc_gris.jpg'); %On lis l'image
s_gris = size(im)%On trouve sa taille
imshow(im)%On affiche l'image

imc=imread("Image_chili.jpg");
s_couleur = size(imc)

%% Application 1 :
imref = imread("Image_banc.jpg"); %On lit l'image de reference
figure
imshow(imref)%On l'affiche
s = size(imref) %On affiche la taille de l'image

%On passe de Couleur à Gris

d=double(imref); %On convertis l'image en double (étape 1 pour passer de la couleur aux autres types de d'images)
Rouge = d(:,:,1); %La première des 3 matrices est pour le rouge
Vert = d(:,:,2); %la deuxième pour le vert
Bleu = d(:,:,3);%la troisième pour le bleu
figure
imshow(d)%Affiche image en mode double
imng=0.299*Rouge+0.587*Vert+0.114*Bleu; %On applique les coef pour passer en niveaux de gris
iimng = uint8(imng);
figure
imshow(iimng)%on affiche cette images retouchée
sng=size(imng)%taille image en niv de gris

%On passe de Gris à N&B

imnb = [0 0]; %Initialisation matrice pour image n&b
%Algo pour conversion
seuil=125;%Indication du seuil (si il est plus faible, on aura plus de pixels blancs sinon plus de noirs
for i = 1:size(imng,1) %parcours dim1 de image en niv de gris
    for j= 1:size(imng,2) %parcours dim2
        if(imng(i,j)>=seuil) %si le pixel est superieur au seuil
            imnb(i,j)=255;%alors on met un pixel noir
        else %sinon
            imnb(i,j)=0; %un pixel blanc
        end
    end
end
figure
imshow(imnb) %affiche image n&b

%% Appliation 2 :
impc = imread("Image_PoorContrast.jpg"); %importation img mauvais contrastres
figure
imshow(impc) %affichage image
dpc = double(impc);%conversion en double de la matrice
maxpc = max([max(dpc(:,:,1)) max(dpc(:,:,2)) max(dpc(:,:,3))]) %maximum de la matrice 3D
minpc = min([min(dpc(:,:,1)) min(dpc(:,:,2)) min(dpc(:,:,3))]) %min mat 3D
%reglage manuel des seuils (bas et haut):
lower = 60; 
upper = 180;
%Algo pour reglage contrastes
for k = 1:size(impc,3)
    for i=1:size(impc,1) 
        for j=1:size(impc,2) %On parcours la matrice (en 3 dimensions)
            if impc(i,j,k)<=lower %si le pixel est en dessous de la veuleur du seuil bas
                impc(i,j,k)=0; %on dit qu'il vaut 0
            else
                if impc(i,j,k)>=upper %si il est superieur a la valeur du seuil haut
                    impc(i,j,k)=255;%on dit qu'il vaut 255
                else
                impc(i,j,k)=255/(upper-lower)*(impc(i,j,k) - lower); %Sinon, on l'étend de façon linéaire
                end
            end
        end
    end
end
figure %sur une nouvelle figure,
imshow(impc) %on affiche l'image retouchée
