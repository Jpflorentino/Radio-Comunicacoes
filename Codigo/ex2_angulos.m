close all; 
clc;

%% Dados

he = 40;
hr = 150;
d = 1:0.01:45;

%Atmosfera Standard
k = 4/3;


%% Calculo dos angulos de fogo
angulof_e_plana = zeros(0,length(d));
angulof_r_plana = zeros(0,length(d));

angulof_e_esferica = zeros(0,length(d));
angulof_r_esferica = zeros(0,length(d));

for i = 1:length(d)
 [angulof_e_plana(i), angulof_r_plana(i)] = angulosFogo('terra plana',he,hr,d(i),k);
 [angulof_e_esferica(i), angulof_r_esferica(i)] = angulosFogo('terra esferica',he,hr,d(i),k);
 fprintf('%i%%\n', round((i/length(d) * 100)));
end


figure(1)
plot(d,angulof_e_plana,d,angulof_r_plana)
title('Angulo de fogo em funao da distancia - Terra plana')
legend('Angulo fogo emissor','Angulo fogo recetor')
%axis([0 45 -90 90])
ylabel('Angulo de Fogo [º]')
xlabel('Distancia de Transmissao [km]')
grid minor

figure(2)
plot(d,angulof_e_esferica,d,-1.*angulof_r_esferica)
title('Angulo de fogo em funçao da distancia - Terra esferica')
legend('Angulo fogo emissor','Angulo fogo recetor')
%axis([0 45 -90 90])
ylabel('Angulo de Fogo [º]')
xlabel('Distancia de Transmissao [km] - Terra esferica')
grid minor