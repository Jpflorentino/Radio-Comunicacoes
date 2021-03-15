function [pontoReflexao, divergencia] = pontoReflexaoDivergencia(d,he,hr)
%%Reflex�o no solo (slide 23 e 24)

    r0 = 6370e3;
    Teta=rad2deg(atan(d/2*r0));

    d1 = r0*tan(Teta); 

    P1=(d1^3)-( (3/2)*(d*d1^2)); %%1 Parte da fun��o do ponto reflex�o
    P2=(0.5*(d^2)-r0*(he+hr))*d1; %%2 Parte da fun��o do ponto reflex�o
    P3=he*d*r0; %% 3 Parte da fun��o do ponto reflex�o

    pontoReflexao=P1+P2+P3;

    he_linha = he - ( (d1^2)/2*r0 );

    ai = rad2deg(atan(he_linha/d1)); %%Angulo de incidencia

    d2=d-d1;

    P1_d=2*d1*d2;
    P2_d=r0*d*sin(ai);


    divergencia = 1 / sqrt(1+(P1_d/P2_d));

end

