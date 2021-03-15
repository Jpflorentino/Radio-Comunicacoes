function [atten_e , atten_r] = atenuacaoGuiasDB(Ce, Cr, attenE, attenR)
    %Ce comprimento emissao metros
    %Cr comprimento recessao metros

    CeMetros = Ce/1000;
    CrMetros = Cr/1000;

    atten_e = CeMetros * attenE;
    atten_r = CrMetros * attenR;

end
