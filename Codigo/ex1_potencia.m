close all;
clc;

%% Terra Plana e Terra Esferica
Pt = 10;

he = 40;
hr = 1:0.5:150; 

%Frequencias de emissao em GHz
%freq = 1;
%freq = 10;
%freq = 30;
freq = 60;

%Distancia de ligacao
d = 45; %[km]

lambda = comprimentoOnda(freq);

%Rendimento da Antena
rd_a = 50; 

%Diametro do Prato da antena
dp_a = 1;

%Atmosfera Standard
k = 4/3;

ga = ganho(dp_a, rd_a, freq);
ga_db = ganhoDB(dp_a, rd_a, freq);

Pr_p = zeros(0,length(hr));
Pr_e = zeros(0,length(hr));

potenciaDireto = raioDireto(Pt,ga_db,ga_db,freq,d);

for i = 1:length(hr)
    %Potencia Terra Plana
    Pr_p(i) = potenciaTotal('terra plana', he, hr(i), d, freq, potenciaDireto, 0, 0, 0);
    
    %Potencia Terra Esférica
    [xe , Dv] = pontoEspecular('terra esferica', d, he, hr(i), k);
    
    Pr_e(i) = potenciaTotal('terra esferica', he, hr(i), d, freq, potenciaDireto, xe, k, Dv);
    
    %Loadbar
    fprintf('%i%%\n', round((i/length(hr) * 100)));
    
    %Debug section
    if(~isreal(Dv)) 
        disp('ERROR: DV NOT REAL')
    end
end

%%Figuras
figure(1)
subplot(2,1,1)
plot(hr,Pr_p)
axis([0 150 -60 100])
ylabel('Potencia Recebida [dBw]')
xlabel('Altura da Antena receçao [m] - Terra plana')
grid on

subplot(2,1,2)
plot(hr,Pr_e)
axis([0 150 -60 100])
ylabel('Potencia Recebida [dBw]')
xlabel('Altura da Antena receçao [m] - Terra esférica')
grid on