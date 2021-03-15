function [faseRaio, difTotal] = difFase(modelo,he,hr,d,freq, xe, k)

    d = d * 10^3;
    r0 = 6370e3 * k;
    lambda = comprimentoOnda(freq);
    faseRaioTerraPlana = (4*pi*hr*he)/(lambda*d);
    heEq = he - xe^2/(2*r0);
    hrEq = hr - (d-xe)^2 /(2*r0);
    faseRaioTerraEsferica = (4*pi*hrEq*heEq)/(lambda*d);

    difTotal=faseRaioTerraPlana-faseRaioTerraEsferica;
    
    
    voltas= difTotal/2/pi;
    difTotal= difTotal - floor(voltas)*2*pi;
    
    if(strcmp(modelo,'terra plana'))
        voltas= faseRaioTerraPlana/2/pi;
        faseRaio= faseRaioTerraPlana - floor(voltas)*2*pi;
    else
        voltas= faseRaioTerraEsferica/2/pi;
        faseRaio= faseRaioTerraEsferica - floor(voltas)*2*pi;
    end
end

