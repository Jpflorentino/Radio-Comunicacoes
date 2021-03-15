function[k]=parametroK(variacao_n)
%output - k -factor
%input - variacao_n - indice de refracao em funcao da altura 

    r0=6370; %km
    variacao_n= variacao_n*10^-6; %km-1
    n0=1;
    k=1/(1+(r0/n0)*variacao_n);
    
end