%% Exemple Ensuite pour observer les oscillations, et donc résoudre le système d’équations différentielles, 
%on utiliseles commandes suivantes (à écrire dans un script tp2.m, par exemple) :
%t sont générées automatiquement par Matlab (pas adaptatif)
t0    = 0.0 ; tf=100 ; w0=[0 ;0] ;
[t,w] = ode23 ('springb', [t0,tf],w0);%appel la fonction
plot(t,w( :,1),'*-') ;
grid on ;
xlabel('Temps, t, en secondes');
ylabel('Elongation du ressort, l, en metres');
title ('Simulation d un systeme masse-ressort') ;

%SPECIFICATION DU PAS DE TEMPS
tspan=0.0 :0.1 :100 ; w0=[0 ;0] ;
[t,w]=ode23 ('springb', tspan,w0); % kuta 2
plot(t,w( :,1),'*-') ; % traits pour évolutions * pour les points
grid on ;
xlabel('Temps, t, en secondes')
ylabel('Elongation du ressort, l, en metres') ;
title ('Simulation d un systeme masse-ressort') ;
help ode23

[t,w]=ode45 ('springb', tspan,w0);% kuta 4
hold on ;
plot(t,w( :,1),'r') ;
hold off ;

%Toujours chercher le meilleu rapport précision / temps de calcul
%Ici dans ce cas l'adaptatif nous donne le meilleur résultat car il
%n'utilise pas beaucoup de points et a une force précision. Nombre de pas
%dans Value 476x1 --> 476 pas

%% DECLARATION VARIABLE GLOBAL QUON VEUT FAIRE VARIER springg.m
tspan=[0,100] ; w0=[0 ;0] ;
global c ;
c = 1.4 ; % résolution du système original
[t,w]=ode23 ('springg', tspan,w0);
c = 2.5 ; % résolution du système modifié
[t1,w1]=ode23 ('springg', tspan,w0);
plot(t,w( :,1),t1,w1( :,1)) ; % comparaison des résultats
xlabel('Temps, t, en secondes')
ylabel('Elongation du ressort, l, en metres') ;
title ('Simulation d un systeme masse-ressort') ;

%% Exercice 1
%PAS ADAPTATIF
t0    = 0 ; tf=25 ; w0=[100 ;400] ;
[t,w] = ode23 ('voltb', [t0,tf],w0);%appel la fonction
plot(t,w( :,1),'*-',t,w( :,2),'*-') ;
grid on ;
xlabel('Temps, t, annees');
ylabel('Evolution population lapins / renards');
title ('Evolution population : Volterra - Pas fixe : 1') ;

%PAS FIXE
tspan=0:0.10 :25 ;
[t1,w] = ode23 ('voltb', tspan,w0);%appel la fonction
plot(t1,w( :,1),'*-',t1,w( :,2),'*-') ;
grid on ;
xlabel('Temps, t, annees');
ylabel('Evolution population lapins / renards');
title ('Evolution population : Volterra - Pas fixe : 0.10') ;

%% Exercice 2
clear
clc
h = 2.5;%m
v0 = 25;%m.s-1
teta = pi*15/180;%d°
t0    = 0 ; tf = 2 ; w0=[0;v0*cos(teta);h;v0*sin(teta)];
%[t1,w1] = ode23 ('tennisblift', [t0,tf],w0);%appel la fonction;
%[t2,w2] = ode23 ('tennisbair', [t0,tf],w0);%appel la fonction;
[t3,w3] = ode23 ('tennisbvide', [t0,tf],w0);%appel la fonction;
plot(t1,w1( :,3),'*-',t2,w2( :,3),'*-',t3,w3( :,3),'*-');

grid on ;
xlabel('Temps, t, secondes');
ylabel('Position z');
%legend("Lift","Air","Vide");
title ("Trajectoire d'une balle de tennins lors d'un lob dans le vide") ;


