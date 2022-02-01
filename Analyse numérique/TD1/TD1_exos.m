clear;
close all;

%Exercice 1)
etalonnage = importdata('etalonnage.txt');
mesuree = etalonnage(:,1);
reelle = etalonnage(:,2);

%approximation polynomiale
C5=polyfit(mesuree,reelle,5);
format long;
precision = 0.5:0.01:2.47;
y5 = polyval(C5,precision);
%interpolation avec polynome de degré 5
%=> meme resultat que Lagrange et Newton

%approximation lineaire
C6=polyfit(mesuree,reelle,1);
format long;
y6 = polyval(C6,mesuree);

%spline
yspline = spline(mesuree, reelle);
splineplot = ppval(yspline, precision);

plot(mesuree, reelle, '*');
hold on;
plot(precision, y5);
plot(mesuree, y6);
plot(precision, splineplot);
legend('Valeurs de base','Polynome degré 5','Linéaire','Spline');
xlabel('Valeur mesurée');
ylabel('Valeur réelle');
title('Exercice 1');

%calcul fiabilité des méthodes
%resid5 = reelle-y5;
residlin = reelle-y6;
%residspline = reelle-splineplot;
%SSE5 = sum(resid5.^2);
SSELIN = sum(residlin.^2);
%SSESPLINE = sum(residspline.^2);
%=> on ne peut pas calculer l'erreur, car calculable qu'aux points de
%données, mais on sait que pour l'interpolation l'erreur au point de donnée
%est nulle => ca ne sert donc qu'à l'approximation

%Exercice 2
%1)
altitude = [0 100 200 300 400 500 600 700 800 900 1000];
pression = [1013 1001 989 977 965 959 942 932 921 902 894];

c = polyfit(altitude, pression, 1);
a = c(2);
k = c(1);

altiplot = 0:1:1000;
pressionplot = a*exp(-k.^altiplot);

figure;
plot(altitude, pression,'*');
hold on;
plot(altiplot, pressionplot);
xlabel('Altitude (m)');
ylabel('Pression (mbar)');
title('Exercice 2');
