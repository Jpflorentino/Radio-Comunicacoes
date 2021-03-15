close all; 
clc;

he=150;
hr=150;
freq=10;
d=1:0.1:45;

k=4/3;

%%
difTotal=ones(1,length(d));

for i=1:length(d)
    [ xe, divergencia ] = pontoEspecular('terra esferica', d(i), he , hr, k);
    [ faseRaio, difTotal(i) ] = difFase('terra plana',he,hr,d(i),freq, xe, k);
    fprintf('%i%%\n', round((i/length(d) * 100)));
end

%%
plot(d,difTotal);
xlabel('Distancia [Km]');
ylabel('Fase [rad]');
title('Comparaçao Terra Plana - Terra Esferica (Frequencia: 10 GHz)');
grid on