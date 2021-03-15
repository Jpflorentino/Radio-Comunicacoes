function [atenuacao_livre] = atenuacaoEspacoLivre(d, freq)

    lambda = comprimentoOnda(freq);
    atenuacao_livre = (lambda/(4*pi*d))^2;
    
end