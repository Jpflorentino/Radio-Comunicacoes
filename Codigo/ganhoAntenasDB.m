function [geDB, grDB] = ganhoAntenasDB (Dpr,Dpe,RendimentoR,RendimentoE,freq )
    % Dpr / Dpe diametro do prato de rececao e emissao
    % Rr / Re rendimento da antena de rececao e emissao 
    grDB = ganhoDB(Dpr, RendimentoR, freq);
    geDB = ganhoDB(Dpe, RendimentoE, freq);
end