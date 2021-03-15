function [ge,gr] = ganhoAntenas (Dpr,Dpe,RendimentoR,RendimentoE,freq )
    % Dpr / Dpe diametro do prato de rececao e emissao
    % Rr / Re rendimento da antena de rececao e emissao 
    gr = ganho(Dpr, RendimentoR, freq);
    ge = ganho(Dpe, RendimentoE, freq);
end