% Teste_ton_modele.m
% HG - 19/10/2018


% Saisissez vos valeurs numériques des paramètres du modèle du 1er ordre
% avec retard
M1 = idproc('P1D'); % Modèle du 1er ordre avec retard

M1.Kp= 0.77 ; % K
M1.Tp1= 140; % T
M1.Td= 42.7 ;  % tau

T=M1.Tp1;
tau=M1.Td;

load data0;

t=data0(1,:)';
y0=data0(2,:)';
y=y0-y0(3,1);  % Suppression du point d'équilibre initial
u=data0(3,:)';
Te=t(2)-t(1);
data=iddata(y,u,Te);

compare(data,M1)
title('Validation du modèle d''ordre 1')
shg
disp('T/tau=')
T/tau
