function [potenciaTotal] = potenciaTotal(modelo, he, hr, d, freq, potenciaDireto, xe, k, Dv)

    lambda = comprimentoOnda(freq);
    r0 = 6370e3 * k;
    d = d*10^3;

    if (strcmp(modelo,'terra plana'))
        potenciaTotal = potenciaDireto + 20*log10(abs(2*sin((2*pi*he*hr)/(lambda*d))));
    else
        he_equi = he - xe^2 / 2 / r0;
        hr_equi = hr - (d - xe)^2 / 2 / r0;
        potenciaTotal = potenciaDireto + 10*log10(1+ Dv^2 - 2*Dv*cos((4*pi*he_equi*hr_equi)/(lambda*d)));
    end
end

