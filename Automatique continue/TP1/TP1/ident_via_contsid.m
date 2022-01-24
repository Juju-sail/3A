% ident_via_contsid
% 20/10/2018
% Programme qui estime les paramètres de modèles du 1er et 2nd ordre à
% partir d'un essai indiciel en boucle ouverte de la maquette de régulation
% de température

% Télécharger auparavant la boîte à outils depuis
% www.cran.univ-lorraine.fr
% et ajouter le repertoire CONTSID7_3 au chemin d'accés de Matlab (setpath)

clear;
close all;
clc

load data0

t=data0(1,:)';
y0=data0(2,:)';
y=y0-y0(3,1);  % Suppression du point d'équilibre initial
u=data0(3,:)';
Te=t(2)-t(1);
data=iddata(y,u,Te);

idplot(data)
disp('press a key to continue')
pause

type_modele = idproc('P1D'); % Modèle du 1er ordre avec retard
M1=procsrivc(data,type_modele)
K=M1.Kp;
T=M1.Tp1;
tau=M1.Td;

disp('T/tau=')
T/tau

type_modele = idproc('P2D'); % Modèle du 2e ordre avec retard
M2=procsrivc(data,type_modele)
KM2=M2.Kp;
T1=M2.Tp1;
T2=M2.Tp2;
tauM2=M2.Td;

shg
figure
subplot(2,1,1)
compare(data,M1)
title('Validation of the first-order model plus delay')
grid
subplot(2,1,2)
compare(data,M2)
title('Validation of the second-order model plus delay')
grid