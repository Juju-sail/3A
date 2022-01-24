% Stellar Motion
% Instructions are in the task pane to the left. Complete and submit each task one at a time.
% 
% Do not edit. This code loads the data and defines measurement parameters.
load starData
nObs = size(spectra,1)
lambdaStart = 630.02
lambdaDelta = 0.14

%Task 1
lambdaEnd = lambdaStart + (nObs-1)*lambdaDelta %on utilise une formule pour avoir le dernier lambda
lambda = (lambdaStart:lambdaDelta:lambdaEnd) %On forme un vecteur avec tous les valeurs de lambda
lambda = lambda' %On en fait un vecteur colonne

%Task 2 & 7
s = spectra(:,4) %On garde que la 4ème colonne de spectra

%Task 3
loglog(lambda, s,".-") %graph log de s(intensité) en fonction de lambda(long d'onde)
xlabel("Wavelength") %nom axe x
ylabel("Intensity") %nom axe y

%Task 4
[sHa idx] = min(s) %trouve minimum (et sa position) de intensité s
lambdaHa= lambda(idx) %Determine la long d'onde lambda de cette intensité s

%Task 5
hold on %laisse le graph actif
loglog(lambdaHa, sHa, "rs", "MarkerSize",8) % marquer le min en rouge

%Task 6
z=lambdaHa/656.28-1 %calcul redshift 
speed = 299792.458 *z %et sa vitesse

%Further Practice
%le but de cet exercice était de creer un slider dans le script de la task2.
%je n'ai pas retrouvé cette option dans ma version logicielle de Matlab

