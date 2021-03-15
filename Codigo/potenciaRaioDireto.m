function [potenciaDireto] = potenciaRaioDireto(pe, ge, gr, atenuacao_livre, attenE, attenR)
    
    pe = 10*log10(pe);

    potenciaDireto = pe+ge+gr-atenuacao_livre-attenE-attenR;
    
end