function [y_terra, scale] = modeloTerra(modelo, d, k)
    d = d * 10^3;
    x = 0:10:d;
    r0 = 6370e3*k;
    if (strcmp(modelo,'terra plana'))
        y_terra = zeros(size(x));
        scale = 0;
    elseif (strcmp(modelo,'terra esferica europeu'))
        y_terra = -(x - d./2).^2 ./ (2.*r0);
        scale = -(0 - d./2).^2 ./ (2.*r0);
    elseif (strcmp(modelo,'terra esferica americano'))
        y_terra = -(x.^2)./(2.*r0);
        scale = -(0.^2)./(2.*r0);
    end

end
