function [ganhoDB]= ganhoDB(Dp,R,freq)
    % R rendimento da antena em percentagem
    % Area Real slide 5 materia 3
    % Dp diametro do prato da antena
    n = R/100;
    lambda = comprimentoOnda(freq);
    Area_real = pi*(Dp/2)^2;
    Area_efetiva = Area_real * n;
    ganho = Area_efetiva * 4 * pi / (lambda)^2;
    ganhoDB = 10*log10(ganho);
end