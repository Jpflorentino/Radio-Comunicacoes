close all; 
clc;

%% Atenuacao do Oxigenio e Vapor de Agua em funçao da temperatura
d=45;
f=10;
pressao=1013;
humidade=80;
temperatura=-100:1:100;
Aoxi=ones(1,length(temperatura));
Ava=ones(1,length(temperatura));
for i=1:length(temperatura)
    [Aoxi(i), Ava(i)]=atenuacaoOxigenioVaporAgua(f,pressao,temperatura(i),humidade,d);
end

figure(4)
hold on
plot(temperatura, Aoxi);
plot(temperatura, Ava);
xlabel('Temperatura [ºC]');
ylabel('Atenuacao [dB]');
legend('Atenuacao Oxigenio', 'Atenuacao Vapor de Agua');
title('Atenuacao do Oxigenio e Vapor de Agua (Frequencia 10GHz)');
hold off


%% Atenuacao do Oxigenio e Vapor de Agua em funçao humidade

d=45;
f=10;
pressao=1013;
humidade=0:1:100;
temperatura=25;
Aoxi=ones(1,length(humidade));
Ava=ones(1,length(humidade));
for i=1:length(humidade)
    [Aoxi(i), Ava(i)]=atenuacaoOxigenioVaporAgua(f,pressao,temperatura,humidade(i),d);
end

figure(5)
hold on
plot(humidade, Aoxi);
plot(humidade, Ava);
xlabel('Humidade [%]');
ylabel('Atenuacao [dB]');
legend('Atenuacao Oxigenio', 'Atenuacao Vapor de Agua');
title('Atenuacao do Oxigenio e Vapor de Agua (Frequencia 10GHz)');
hold off


%% Atenuacao provocada pela Chuva em funçao precentagem
d=50;
f=10;

percentagem=0.00001:0.001:1;
Achuvapm=ones(1,length(percentagem));
Achuva=ones(1,length(percentagem));
for i=1:length(percentagem)
[ Achuva(i), Achuvapm(i)] = atenuacaoChuva(f,'K',percentagem(i),'horizontal',d, percentagem(i));
end

figure(6)
semilogy(percentagem,Achuva, percentagem,Achuvapm);
xlabel('Percentagem [%]');
ylabel('Atenuacao [dB]');
legend('Anual', 'Pior Mes');
title('Atenuacao provocada pela Chuva (Frequencia 10GHz)');

