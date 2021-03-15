function [raio] = elipsoideFresnel(freq, d)
    %ELIPSOIDEFRESNEL Summary of this function goes here
    %   Detailed explanation goes here

    d = d * 10^3;
    x = 0:10:d;

    lambda = comprimentoOnda(freq);

    raio = sqrt(((x .* (d - x)) / d) * lambda);

end
