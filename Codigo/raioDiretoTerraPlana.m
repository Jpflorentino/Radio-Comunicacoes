function [y, m, b] = raioDiretoTerraPlana(he, hr, d)
    %RAIODIRETO Summary of this function goes here
    % d = dist�ncia recebida em metros
    % he = altura da antena de Emissao
    % hr = altura da antena de Rece��o
    %   Detailed explanation goes here

    d = d * 10^3;
    x = 0:10:d;

    m = (hr - he) / d;
    b = he;

    y = m .* x + b;
end
