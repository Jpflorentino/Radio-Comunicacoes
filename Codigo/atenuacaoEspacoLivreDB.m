function [ a ] = atenuacaoEspacoLivreDB( d,f )

    a = 32.4 + 20 * log10(d) + 20*log10(f*10^3);

end