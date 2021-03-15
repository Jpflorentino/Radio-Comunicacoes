function [lambda] = comprimentoOnda(freq)
    %COMPRIMENTOONDA Summary of this function goes here
    %   Detailed explanation goes here
    c = 3 * 10^8;
    lambda = c / (freq * 10^9);

end
