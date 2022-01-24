clear;
clc;
close all;

%% Etape 1
load codepostal.dat;

a=decode(codepostal);
function [traducted] = decode(matriceDonnees) %Creation fonction retournant une matrice "traduite" du code barre
    compteur = 0;
    for i = 1:length(matriceDonnees) %Création d'un vecteur crypté avec des barres et des points uniquement
        if matriceDonnees(1,i)== 73
            crypted(1,i)='I';
        else crypted(1,i) = '.';
        end
        if i==6:5:51 %Traduction du vecteur vers nb correspondants (étude de chaques cas)
            compteur=compteur+1;
            if crypted(1,i-4)=='I'  && crypted(1,i-3)=='I'
                traducted(1,compteur)=0;
            elseif crypted(1,i-1)=='I'  && crypted(1,i)=='I'
                traducted(1,compteur)=1;
            elseif crypted(1,i-2)=='I'  && crypted(1,i)=='I'
                traducted(1,compteur)=2;
            elseif crypted(1,i-2)=='I'  && crypted(1,i-1)=='I'
                traducted(1,compteur)=3;
            elseif crypted(1,i-3)=='I'  && crypted(1,i)=='I'
                traducted(1,compteur)=4;
            elseif crypted(1,i-3)=='I'  && crypted(1,i-1)=='I'
                traducted(1,compteur)=5;
            elseif crypted(1,i-3)=='I'  && crypted(1,i-2)=='I'
                traducted(1,compteur)=6;
            elseif crypted(1,i-4)=='I'  && crypted(1,i)=='I'
                traducted(1,compteur)=7;
            elseif crypted(1,i-4)=='I'  && crypted(1,i-1)=='I'
                traducted(1,compteur)=8;
            elseif crypted(1,i-4)=='I'  && crypted(1,i-2)=='I'
                traducted(1,compteur)=9;
            end
        end
    end
end
