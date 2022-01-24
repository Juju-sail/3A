%% Exemple 1

tempdens = importdata('tempdens');
x = tempdens(:,1);
y = tempdens(:,2);
% plot(x,y,'*')
title('Point de données');
xlabel('Temperature (°C)');
ylabel('Densité (t.m-3)');

P2 = polyfit(x,y,2) % creation du polynome de degre 2
format long; % + de chiffres significatifs
P2

y2 = polyval(P2,x) % pour avoir les valeurs du polynôme d’approximation de degré 2aux points de données

P3 = polyfit(x,y,3)
y3 = polyval(P3,x);

% plot(x,y,'*',x,y2,'X',x,y3)

resid2 = y-y2;
resid3 = y-y3;

Err2 = sum(resid2.^2)
Err3 = sum(resid3.^2)

ys = spline(x,y); % spline cubique interpolant y en fonction de x 
xi = 0:0.1:38; % pour tracer la spline avec suffisamment de points
ysplot = ppval(ys,xi);
plot(x,y,'*',xi,ysplot,x,y3); %  Comparaison  des  résultats  obtenus  par  interpolationsplines et approximation de degré 3

%% Exemple 2

annees = [1961:3:1982,1984];
annees = annees - 1960;
poissons = [1900,9500,21200,43300,80300,101600,154900,146300,154500];

%loglog(annees, poissons,'*')

u = log(annees);
v = log(poissons);
P = polyfit(u,v,1)
a = exp(P(2))
b = P(1)
anneeplot = [1:0.1:24]
poissonplot = a*anneeplot.^b;

figure
plot(anneeplot, poissonplot);
hold on
plot(annees, poissons,'*');

