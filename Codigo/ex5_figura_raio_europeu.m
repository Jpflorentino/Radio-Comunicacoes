clear ll
close all; 
clc;
%% Dados

dmax = 45;
d = 0:0.01:dmax;
f = 10;

%Altura das antenas
he = 100;
hr = 150;

%Coeficiente K
%dndh = -400;
%dndh = -157;
%dndh = -43;
dndh = 50;
K = parametroK(dndh);

%% Calculos

%Modelo da Terra a utilizar
[y_terra, scale] = modeloTerra('terra esferica europeu', dmax, K);

%Raio Direto
[y, m, b] = raioDiretoTerraPlana(he, hr, dmax);

%Elipsoide de Fresnel
raioElipsoide = elipsoideFresnel(f, dmax);
raioPositivo = y + raioElipsoide;
raioNegativo = y - raioElipsoide;

%Obstrucao elipsoide de Fresnel
yobstruido = raioNegativo - (y_terra + abs(scale));

if (find(yobstruido <= 0))
    elipsoide = 'Encontra-se obstruido.';
else
    elipsoide = 'Nao se encontra obstruido.';
end
%% Figura

figure(1)

hold on
plot(d,y)
plot(d, y_terra + abs(scale))
plot(d, raioNegativo,'k')
plot(d, raioPositivo,'k')
hold off
title(sprintf('Ligaçao para D_n / D_h = %i * 10^6 km^-^1',dndh))
legend('Raio Direto','Terra','Elipsoide Fresnel')
axis([0 dmax -200 300])
ylabel('Altura Relativa [m]')
xlabel('Distancia [km]')
grid minor