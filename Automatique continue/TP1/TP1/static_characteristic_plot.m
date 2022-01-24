% Static_characteristic.m
% HG - 15/10/2019

load data_staircase;

t=data0(1,:)';
y=data0(2,:)';
u=data0(3,:)';
Te=t(2)-t(1);
n=1/Te;

figure(1)

title('Staircase response')
plot(t/60,y,t/60,u,'LineWidth',2)
xlabel('Time in mn')
legend('Temperature in °C','Heating power %')
grid
title('Staircase response')
set(gca,'FontSize',14,'FontName','helvetica');

% Point d'équilibre pour u=0%
U0=u(1);
Y0=y(1);

% Point d'équilibre pour u=25%
U25=u(600*n);
Y25=y(600*n);

% Point d'équilibre pour u=50%
U50=u(1200*n);
Y50=y(1200*n);

% Point d'équilibre pour u=75%
U75=u(1800*n);
Y75=y(1800*n);

% Point d'équilibre pour u=100%
U100=u(2400*n);
Y100=y(2400*n);

Y=[Y0 Y25 Y50 Y75 Y100]
U=[U0 U25 U50 U75 U100]

figure(2)

title('Caractéristique statique du TCLab kit')
plot(U,Y,'xr-','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10)
xlabel('Puissance de chauffe en %')
ylabel('Température en °C')
grid
set(gca,'FontSize',14,'FontName','helvetica');
