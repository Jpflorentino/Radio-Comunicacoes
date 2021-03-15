function [Dif_Te_Tp, Dif_Percentagem, Dif_fase] = terraEsfericaPlana(d, he, hr, freq)


    %Dif_Te_Tp = Compara��o de Terra Plana-Esf�rica em metros
    %Dif_Per = Compara��o de Terra Plana-Esf�rica em percentagem

    d = d*10^3;
    d_eq = d/2;
    r0 = 6370e3;

    he_equi = he - ( (d_eq^2)/(2*r0) );
    hr_equi = hr - ( (d_eq^2)/(2*r0) );


    Delta_Tp = ( (2*he*hr) / d);  %Resultado tem de ser metros
    Delta_Te = ( (2*he_equi*hr_equi) / d);  %Resultado tem de ser em  metros


    Dif_Te_Tp = Delta_Tp-Delta_Te;

    Dif_Percentagem = Delta_Te_Tp / Delta_Tp;

    Dif_fase = (((2*pi)/(comprimentoOnda(freq)))*((d^4)/(r0*d)))*(((-1)/(2*r0))+(he/(d_eq^2))-(hr/(d_eq^2)));
end

