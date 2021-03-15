close all
clear
clc

%%Calculos
%Variaveis
he = 100;
hr = 200;
d = 50; %KM passa para metros
x = 0:100:d * 10^3;
freq = 30; %1,10,30,60
%modelo = 'terra plana'; 
modelo = 'terra esferica europeu'; 
%modelo = 'terra esferica americano';
Dpr = 200; %Metros passa para KM 
Dpe = 200; %Metros passa para KM 
RendimentoR = 50; %valor passado em percentagem
RendimentoE = 50; %valor passado em percentagem
Ce = 50; %Metros passa para KM 
Cr = 50; %Metros passa para KM 
attenE = 44.3;
attenR = 44.3;
pe = 1;%Potencia emitida
pressao = 1013;
temperatura = 25; %Graus
humidade = 80; %Percentagem
zona = 'K'; %'H'
percentagem = 0.005; %0.001<p<1
polarizacao = 'horizontal'; %'vertical'
pm = 0.01; %0.05 
terreno = 'agua'; %'terreno'

%Modelo da Terra a utilizar
[y_terra, scale] = modeloTerra(modelo, d);

%Raio Direto
[y, m, b] = raioDiretoTerraPlana(he, hr, d);

%Elipsoide de Fresnel
raioElipsoide = elipsoideFresnel(freq, d);
raioPositivo = y + raioElipsoide;
raioNegativo = y - raioElipsoide;

%Obstrucao elipsoide de Fresnel
yobstruido = raioNegativo - (y_terra + abs(scale));

if (find(yobstruido <= 0))
    elipsoide = 'Encontra-se obstruido.';
else
    elipsoide = 'Nao se encontra obstruido.';
end

%Apresentar o resultado
fprintf('Obstrucao Elipsoide: %s \n', elipsoide)

%Ganho das antenas 
[ge,gr] = ganhoAntenas (Dpr,Dpe,RendimentoR,RendimentoE,freq );
[geDB,grDB] = ganhoAntenasDB (Dpr,Dpe,RendimentoR,RendimentoE,freq );
fprintf('Ganho da antena emissora: %.4d \n', ge)
fprintf('Ganho da antena recetora: %.4d \n', gr)
fprintf('Ganho da antena emissora DB: %.4d \n', geDB)
fprintf('Ganho da antena recetora DB: %.4d \n', grDB)

%Atenuacao das guias 
[atten_e , atten_r] = atenuacaoGuiasDB(Ce, Cr, attenE, attenR);
fprintf('Atenuacao da guia emissora: %.4d \n', atten_e)
fprintf('Atenuacao da guia recetora: %.4d \n', atten_r)

%Atenuacao espaco livre
atenuacao_livre = atenuacaoEspacoLivre(d, freq);
fprintf('Atenuacao em espaco livre: %.4d \n', atenuacao_livre)

%Calculo das tangentes
[tangenteE, tangenteR] = tangentes(d,he,hr);
tangenteEMedia = sum(tangenteE)/length(x);%Calculamos a media para obter apenas um valor 
tangenteRMedia = sum(tangenteR)/length(x);%Calculamos a media para obter apenas um valor
fprintf('Media Tangente de Emissao: %.4d \n', tangenteEMedia)
fprintf('Media Tangente de Rececao: %.4d \n', tangenteRMedia)

%Calculo dos respetivos angulos de fogo
[anguloFogoE, anguloFogoR] = angulosFogo(modelo, he, hr, d);
fprintf('Angulo de Fogo de Emissao: %.4d \n', anguloFogoE)
fprintf('Angulo de Fogo de Rececao: %.4d \n', anguloFogoR)

%Calculo do ponto de reflexao e fator de divergencia
[pontoReflexao, divergencia] = pontoReflexaoDivergencia(d,he,hr);
fprintf('Ponto de reflexao: %.4d \n', pontoReflexao)
fprintf('Ponto de divergencia: %d \n', divergencia)

%Diferenca de fase
[faseRaio, difTotal] = difFase(modelo,he,hr,d,freq);
fprintf('Fase do Raio: %.4d \n', faseRaio)
fprintf('Diferenca de fase total: %d \n', difTotal)

%Calculo da potencia recebida Terra Plana / Terra Esferica
atenuacao_livre = atenuacaoEspacoLivre(d, freq);
potenciaDiretoDB = potenciaRaioDireto(pe, geDB, grDB, atenuacao_livre, attenE, attenR);
potenciaTotal = potenciaTotal(modelo, he, hr, d, freq, potenciaDiretoDB);
fprintf('Atenuacao Espaco Livre: %.4d \n', atenuacao_livre)
fprintf('Potencia Raio Direto DB: %.4d \n', potenciaDiretoDB)
fprintf('Potencia Total Recebida: %.4d \n', potenciaTotal)

%Calculo da atenuacao Vapor Agua e Oxigenio
[AtenuacaoVaporAgua, AtenuacaoOxi] = atenuacaoOxigenioVaporAgua(freq, pressao, temperatura, humidade, d);
fprintf('Atenuacao Vapor Agua: %.4d \n', AtenuacaoVaporAgua)
fprintf('Atenuacao Oxigenio: %.4d \n', AtenuacaoOxi)

%Calculo da atenuacao Chuva
[atenuacaoChuva, atenuacaoChuvaPercentagem] = atenuacaoChuva(freq, zona, percentagem, polarizacao, d, pm);
fprintf('Atenuacao Chuva: %.4d \n', atenuacaoChuva)
fprintf('Atenuacao Chuva Percentagem: %.4d \n', atenuacaoChuvaPercentagem)

%Atenuacao por difracao
difracao = difracao(polarizacao, he, hr, d, freq, terreno);
fprintf('Atenuacao por difracao: %.4d \n', difracao)

%%Representacoes
figure(1)
hold on
axis([-10*10^3 d*10^3+10*10^3 0 hr+100])

%Representacao antenas
line([0 0], [0 he]);
line([d*10^3 d*10^3], [0 hr]);
%Representacao Terra
plot(x, y_terra + abs(scale));
%Raio direto
plot(x, y, 'blue');
%Elipsoide de Fresnel
plot(x, raioPositivo, 'red');
plot(x, raioNegativo, 'red');
%Tangentes 
plot(x, tangenteE + abs(scale), 'green');
plot(x, tangenteR + abs(scale), 'green');

hold off
if(strcmp(modelo,'terra plana'))
    title('Terra plana')
else
    title('Terra esferica')
end
xlabel('Distancia [Km]')
ylabel('Altura [m]')
grid on
