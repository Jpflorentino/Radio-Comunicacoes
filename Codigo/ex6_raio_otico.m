clear all; close all; clc;

%% Dados

r0 = 6370; 
n0 = 1;
%calculo dos 'k' para as diferentes dn/dh
dn_dh = ones(1,60);
k = ones(1,length(dn_dh));

%% Calculos

i = 1;
for dn_dh = -400*10^-6 : 10*10^-6 : 100*10^-6
    k(i) = 1/(1+((r0/n0)*dn_dh));
    i=i+1;
end

y = ones(1,400);
x = ones(1,400);

%leg_in
% y1 = ones(1,400);
% x1 = ones(1,400);
% y2 = ones(1,400);
% x2 = ones(1,400);
% y3 = ones(1,400);
% x3 = ones(1,400);
h = 1; 
for n = 0:0.005:2
        y(h) = k(1)*r0*sin(deg2rad(90-n));
        x(h) = -1*k(1)*r0*cos(deg2rad(90-n));
        y1(h) = k(36)*r0*sin(deg2rad(90-n));
        x1(h) = k(36)*r0*cos(deg2rad(90-n));
        y2(h) = k(47)*r0*sin(deg2rad(90-n));
        x2(h) = k(47)*r0*cos(deg2rad(90-n));
        y3(h) = k(51)*r0*sin(deg2rad(90-n));
        x3(h) = k(51)*r0*cos(deg2rad(90-n));
        h=h+1;
end

%% Figura

plot(x,y-(k(1)*r0),'r'); 
hold on
plot(x,y-(k(36)*r0))
hold on 
plot(x,y-(k(47)*r0),'g');
hold on
plot(x,y-(k(51)*r0),'y');
hold on
%leg_end

for i=1:1:length(k)
    fact = 1;
    if k(i)<0
        fact = -1;
    end
    h=1;
    for n = 0:0.005:2
        y(h) = k(i)*r0*sin(deg2rad(90-n));
        x(h) = fact*k(i)*r0*cos(deg2rad(90-n));%x ? sempre positivo !!!!
        h=h+1;
    end
    if k(i)<0 && k(i)>-51 
         L(1) = plot(x,y-(k(i)*r0),'b');
    elseif k(i)== 1
        L(2) = plot(x,y-(k(i)*r0),'y');
    elseif k(i)<-51
        L(3) = plot(x,y-(k(i)*r0),'r');
    elseif(k(i)>1.3 && k(i)<1.4)
        L(4) = plot(x,y-(k(i)*r0),'g');   
    else
        L(5) = plot(x,y-(k(i)*r0),'k');
    end
    hold on;
end
hold off
axis([0 200 -1.5 2]);
xlabel('km');ylabel('Km');
title('Variação do raio de curvatura do raio optico com variacao do indice de refracao');
legend(L,{'dn/dh >0','k = 1','k = inf' , 'atmosfera standard k = 4/3','dn/dh <0'},'Location', 'NorthWest')
grid minor
